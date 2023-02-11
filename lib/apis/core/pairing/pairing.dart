import 'dart:async';
import 'dart:convert';

import 'package:event/event.dart';
import 'package:wallet_connect_flutter_v2/apis/auth_api/stores/generic_store.dart';
import 'package:wallet_connect_flutter_v2/apis/auth_api/stores/i_generic_store.dart';
import 'package:wallet_connect_flutter_v2/apis/core/crypto/crypto_models.dart';
import 'package:wallet_connect_flutter_v2/apis/core/i_core.dart';
import 'package:wallet_connect_flutter_v2/apis/core/pairing/i_pairing.dart';
import 'package:wallet_connect_flutter_v2/apis/core/pairing/i_pairing_store.dart';
import 'package:wallet_connect_flutter_v2/apis/models/uri_parse_result.dart';
import 'package:wallet_connect_flutter_v2/apis/core/pairing/utils/pairing_models.dart';
import 'package:wallet_connect_flutter_v2/apis/core/pairing/pairing_store.dart';
import 'package:wallet_connect_flutter_v2/apis/core/pairing/utils/pairing_utils.dart';
import 'package:wallet_connect_flutter_v2/apis/core/relay_client/relay_client_models.dart';
import 'package:wallet_connect_flutter_v2/apis/models/json_rpc_error.dart';
import 'package:wallet_connect_flutter_v2/apis/models/json_rpc_request.dart';
import 'package:wallet_connect_flutter_v2/apis/models/json_rpc_response.dart';
import 'package:wallet_connect_flutter_v2/apis/models/basic_models.dart';
import 'package:wallet_connect_flutter_v2/apis/utils/constants.dart';
import 'package:wallet_connect_flutter_v2/apis/utils/errors.dart';
import 'package:wallet_connect_flutter_v2/apis/utils/method_constants.dart';
import 'package:wallet_connect_flutter_v2/apis/utils/wallet_connect_utils.dart';

class Pairing implements IPairing {
  bool _initialized = false;

  @override
  final Event<PairingEvent> onPairingPing = Event<PairingEvent>();
  @override
  final Event<PairingInvalidEvent> onPairingInvalid =
      Event<PairingInvalidEvent>();
  @override
  final Event<PairingEvent> onPairingDelete = Event<PairingEvent>();
  @override
  final Event<PairingEvent> onPairingExpire = Event<PairingEvent>();

  /// Stores all the pending requests
  Map<int, Completer> pendingRequests = {};

  ICore core;
  IPairingStore? pairings;

  /// Stores the public key of Type 1 Envelopes for a topic
  /// Once a receiver public key has been used, it is removed from the store
  /// Thus, this store works under the assumption that a public key will only be used once
  late IGenericStore<String> topicToReceiverPublicKey;

  Pairing(
    this.core, {
    this.pairings,
  });

  @override
  Future<void> init() async {
    if (_initialized) {
      return;
    }

    _registerRelayEvents();
    _registerExpirerEvents();

    pairings ??= PairingStore(core);
    topicToReceiverPublicKey = GenericStore(
      core: core,
      context: 'topicToReceiverPublicKey',
      version: '1.0',
      toJsonString: (String value) {
        return value;
      },
      fromJsonString: (String value) {
        return value;
      },
    );

    await core.expirer.init();

    Future.wait([
      pairings!.init(),
      topicToReceiverPublicKey.init(),
    ]);

    await _cleanup();

    _initialized = true;
  }

  @override
  Future<CreateResponse> create({
    List<List<String>> methods = const [],
  }) async {
    _checkInitialized();
    final String symKey = core.crypto.getUtils().generateRandomBytes32();
    final String topic = await core.crypto.setSymKey(symKey);
    final int expiry = WalletConnectUtils.calculateExpiry(
      WalletConnectConstants.FIVE_MINUTES,
    );
    final Relay relay = Relay(WalletConnectConstants.RELAYER_DEFAULT_PROTOCOL);
    final PairingInfo pairing = PairingInfo(
      topic: topic,
      expiry: expiry,
      relay: relay,
      active: false,
    );
    final Uri uri = WalletConnectUtils.formatUri(
      protocol: core.protocol,
      version: core.version,
      topic: topic,
      symKey: symKey,
      relay: relay,
      methods: methods,
    );
    await pairings!.set(topic, pairing);
    await core.relayClient.subscribe(topic: topic);
    await core.expirer.set(topic, expiry);

    return CreateResponse(
      topic: topic,
      uri: uri,
    );
  }

  @override
  Future<PairingInfo> pair({
    required Uri uri,
    bool activatePairing = false,
  }) async {
    _checkInitialized();

    // print(uri.queryParameters);
    final int expiry = WalletConnectUtils.calculateExpiry(
      WalletConnectConstants.FIVE_MINUTES,
    );
    final URIParseResult parsedUri = WalletConnectUtils.parseUri(uri);
    final String topic = parsedUri.topic;
    final Relay relay = parsedUri.relay;
    final String symKey = parsedUri.symKey;
    final PairingInfo pairing = PairingInfo(
      topic: topic,
      expiry: expiry,
      relay: relay,
      active: false,
    );

    try {
      PairingUtils.validateMethods(
        parsedUri.methods,
        routerMapRequest.values.toList(),
      );
    } on WCError catch (e) {
      // Tell people that the pairing is invalid
      onPairingInvalid.broadcast(
        PairingInvalidEvent(
          message: e.message,
        ),
      );

      // Delete the pairing: "publish internally with reason"
      // await _deletePairing(
      //   topic,
      //   false,
      // );

      rethrow;
    }

    await pairings!.set(topic, pairing);
    await core.crypto.setSymKey(symKey, overrideTopic: topic);
    await core.relayClient.subscribe(topic: topic);
    await core.expirer.set(topic, expiry);

    if (activatePairing) {
      await activate(topic: topic);
    }

    return pairing;
  }

  @override
  Future<void> activate({required String topic}) async {
    _checkInitialized();
    final int expiry = WalletConnectUtils.calculateExpiry(
      WalletConnectConstants.THIRTY_DAYS,
    );
    await pairings!.update(
      topic,
      expiry: expiry,
      active: true,
    );
    await core.expirer.set(topic, expiry);
  }

  @override
  void register({
    required String method,
    required Function(String, JsonRpcRequest) function,
    required ProtocolType type,
  }) {
    if (routerMapRequest.containsKey(method)) {
      throw WCError(
        code: -1,
        message: 'Method already exists',
      );
    }

    routerMapRequest[method] = RegisteredFunction(
      method: method,
      function: function,
      type: type,
    );
  }

  @override
  Future<void> setReceiverPublicKey({
    required String topic,
    required String publicKey,
    int? expiry,
  }) async {
    _checkInitialized();
    await topicToReceiverPublicKey.set(topic, publicKey);
    await core.expirer.set(
      publicKey,
      WalletConnectUtils.calculateExpiry(
        expiry ?? WalletConnectConstants.FIVE_MINUTES,
      ),
    );
  }

  @override
  Future<void> updateExpiry({
    required String topic,
    required int expiry,
  }) async {
    _checkInitialized();
    await pairings!.update(
      topic,
      expiry: expiry,
    );
  }

  @override
  Future<void> updateMetadata({
    required String topic,
    required PairingMetadata metadata,
  }) async {
    _checkInitialized();
    await pairings!.update(
      topic,
      metadata: metadata,
    );
  }

  @override
  List<PairingInfo> getPairings() {
    return pairings!.getAll();
  }

  @override
  Future<void> ping({required String topic}) async {
    _checkInitialized();

    _isValidPing(topic);

    if (pairings!.has(topic)) {
      try {
        final bool response = await sendRequest(
          topic,
          MethodConstants.WC_PAIRING_PING,
          {},
        );
        onPairingPing.broadcast(
          PairingEvent(
            topic: topic,
          ),
        );
      } on JsonRpcError catch (e) {
        onPairingPing.broadcast(
          PairingEvent(
            topic: topic,
            error: e,
          ),
        );
      }
    }
  }

  @override
  Future<void> disconnect({required String topic}) async {
    _checkInitialized();

    _isValidDisconnect(topic);
    if (pairings!.has(topic)) {
      try {
        await sendRequest(
          topic,
          MethodConstants.WC_PAIRING_DELETE,
          Errors.getSdkError(Errors.USER_DISCONNECTED).toJson(),
        );
        await pairings!.delete(topic);
        onPairingDelete.broadcast(
          PairingEvent(
            topic: topic,
          ),
        );
      } on JsonRpcError catch (e) {
        onPairingDelete.broadcast(
          PairingEvent(
            topic: topic,
            error: e,
          ),
        );
      }
    }
  }

  @override
  IPairingStore getStore() {
    return pairings!;
  }

  // RELAY COMMUNICATION HELPERS

  Future sendRequest(
    String topic,
    String method,
    Map<String, dynamic> params, {
    int? id,
    int? ttl,
    EncodeOptions? encodeOptions,
  }) async {
    final Map<String, dynamic> payload = PairingUtils.formatJsonRpcRequest(
      method,
      params,
      id: id,
    );
    final JsonRpcRequest request = JsonRpcRequest.fromJson(payload);
    final String message = await core.crypto.encode(
      topic,
      payload,
      options: encodeOptions,
    );
    RpcOptions opts = MethodConstants.RPC_OPTS[method]!['req']!;
    if (ttl != null) {
      opts = opts.copyWith(ttl: ttl);
    }
    await core.history.set(
      topic,
      request,
    );
    // print('sent request');
    await core.relayClient.publish(
      topic: topic,
      message: message,
      ttl: opts.ttl,
      tag: opts.tag,
    );
    final Completer completer = Completer.sync();
    pendingRequests[payload['id']] = completer;

    // Get the result from the completer, if it's an error, throw it
    final result = await completer.future;
    if (result is JsonRpcError) {
      throw result;
    }

    return result;
  }

  Future<void> sendResult(
    int id,
    String topic,
    String method,
    dynamic result, {
    EncodeOptions? encodeOptions,
  }) async {
    // print('sending result');
    final Map<String, dynamic> payload = PairingUtils.formatJsonRpcResponse(
      id,
      result,
    );
    final String message = await core.crypto.encode(
      topic,
      payload,
      options: encodeOptions,
    );
    // final JsonRpcRecord? record = core.history.get(id);
    // if (record == null) {
    //   return;
    // }
    final RpcOptions opts = MethodConstants.RPC_OPTS[method]!['res']!;
    await core.relayClient.publish(
      topic: topic,
      message: message,
      ttl: opts.ttl,
      tag: opts.tag,
    );
    // await core.history.resolve(payload);
  }

  Future<void> sendError(
    int id,
    String topic,
    String method,
    JsonRpcError error, {
    EncodeOptions? encodeOptions,
  }) async {
    final Map<String, dynamic> payload = PairingUtils.formatJsonRpcError(
      id,
      error,
    );
    final String message = await core.crypto.encode(
      topic,
      payload,
      options: encodeOptions,
    );
    final RpcOptions opts = MethodConstants.RPC_OPTS.containsKey(method)
        ? MethodConstants.RPC_OPTS[method]!['res']!
        : MethodConstants
            .RPC_OPTS[MethodConstants.UNREGISTERED_METHOD]!['res']!;
    await core.relayClient.publish(
      topic: topic,
      message: message,
      ttl: opts.ttl,
      tag: opts.tag,
    );
    await core.history.resolve(payload);
  }

  Future<void> _deletePairing(String topic, bool expirerHasDeleted) async {
    await core.relayClient.unsubscribe(topic: topic);
    await Future.wait([
      pairings!.delete(topic),
      core.crypto.deleteSymKey(topic),
      expirerHasDeleted ? Future.value(null) : core.expirer.delete(topic),
    ]);
  }

  Future<void> _cleanup() async {
    final List<PairingInfo> expiredPairings = getPairings()
        .where(
          (PairingInfo info) => WalletConnectUtils.isExpired(info.expiry),
        )
        .toList();
    expiredPairings.map(
      (PairingInfo e) async => await pairings!.delete(e.topic),
    );

    // Cleanup all of the expired receiver public keys
    final List<String> expiredReceiverPublicKeys = topicToReceiverPublicKey
        .getAll()
        .where((key) => WalletConnectUtils.isExpired(core.expirer.get(key)))
        .toList();
    expiredReceiverPublicKeys.map(
      (String key) async => await topicToReceiverPublicKey.delete(key),
    );
  }

  void _checkInitialized() {
    if (!_initialized) {
      throw Errors.getInternalError(Errors.NOT_INITIALIZED);
    }
  }

  /// ---- Relay Event Router ---- ///

  Map<String, RegisteredFunction> routerMapRequest = {};
  // Map<String, Function> routerMapResponse = {};

  void _registerRelayEvents() {
    core.relayClient.onRelayClientMessage.subscribe(_onMessageEvent);

    register(
      method: MethodConstants.WC_PAIRING_PING,
      function: _onPairingPingRequest,
      type: ProtocolType.Pair,
    );
    register(
      method: MethodConstants.WC_PAIRING_DELETE,
      function: _onPairingDeleteRequest,
      type: ProtocolType.Pair,
    );
  }

  void _onMessageEvent(MessageEvent? event) async {
    if (event == null) {
      return;
    }

    // If we have a reciever public key for the topic, use it
    String? receiverPublicKey = topicToReceiverPublicKey.get(event.topic);
    // If there was a public key, delete it. One use.
    if (receiverPublicKey != null) {
      await topicToReceiverPublicKey.delete(event.topic);
    }

    // Decode the message
    String payloadString = await core.crypto.decode(
      event.topic,
      event.message,
      options: DecodeOptions(
        receiverPublicKey: receiverPublicKey,
      ),
    );
    Map<String, dynamic> data = jsonDecode(payloadString);

    // If it's an rpc request, handle it
    // print(data);
    if (data.containsKey('method')) {
      final request = JsonRpcRequest.fromJson(data);
      if (routerMapRequest.containsKey(request.method)) {
        routerMapRequest[request.method]!.function(event.topic, request);
      } else {
        _onUnkownRpcMethodRequest(event.topic, request);
      }
    }
    // Otherwise handle it as a response
    else if (data.containsKey('result')) {
      final response = JsonRpcResponse.fromJson(data);
      final JsonRpcRecord? record = core.history.get(response.id);
      if (record == null) {
        return;
      }

      // print('got here');
      if (pendingRequests.containsKey(response.id)) {
        pendingRequests.remove(response.id)!.complete(response.result);
      }

      // if (routerMapRequest.containsKey(record.method)) {
      //   routerMapRequest[record.method]!(event.topic, response);
      // } else {
      //   _onUnkownRpcMethodResponse(record.method);
      // }
    } else if (data.containsKey('error')) {
      final err = JsonRpcError.fromJson(data['error']);
      pendingRequests.remove(data['id'])!.completeError(err);
    }
  }

  Future<void> _onPairingPingRequest(
    String topic,
    JsonRpcRequest request,
  ) async {
    final int id = request.id;
    try {
      // print('ping req');
      _isValidPing(topic);
      await sendResult(
        id,
        topic,
        request.method,
        true,
      );
      onPairingPing.broadcast(
        PairingEvent(
          id: id,
          topic: topic,
        ),
      );
    } on JsonRpcError catch (e) {
      // print(e);
      await sendError(
        id,
        topic,
        request.method,
        e,
      );
    }
  }

  Future<void> _onPairingDeleteRequest(
    String topic,
    JsonRpcRequest request,
  ) async {
    // print('delete');
    final int id = request.id;
    try {
      _isValidDisconnect(topic);
      await sendResult(
        id,
        topic,
        request.method,
        true,
      );
      await pairings!.delete(topic);
      onPairingDelete.broadcast(
        PairingEvent(
          id: id,
          topic: topic,
        ),
      );
    } on JsonRpcError catch (e) {
      await sendError(
        id,
        topic,
        request.method,
        e,
      );
    }
  }

  Future<void> _onUnkownRpcMethodRequest(
    String topic,
    JsonRpcRequest request,
  ) async {
    final int id = request.id;
    final String method = request.method;
    try {
      if (routerMapRequest.containsKey(method)) {
        return;
      }
      final String message = Errors.getSdkError(
        Errors.WC_METHOD_UNSUPPORTED,
        context: method,
      ).message;
      await sendError(
        id,
        topic,
        request.method,
        JsonRpcError.methodNotFound(message),
      );
    } on JsonRpcError catch (e) {
      await sendError(id, topic, request.method, e);
    }
  }

  Future<void> _onPairingPingResponse(
      String topic, JsonRpcResponse response) async {
    final int id = response.id;

    if (!response.result is JsonRpcError) {
      onPairingPing.broadcast(
        PairingEvent(
          id: id,
          topic: topic,
        ),
      );
    } else {
      onPairingPing.broadcast(
        PairingEvent(
          id: id,
          topic: topic,
          error: response.result,
        ),
      );
    }
  }

  void _onUnkownRpcMethodResponse(String method) {
    if (routerMapRequest.containsKey(method)) {
      return;
    }
  }

  /// ---- Expirer Events ---- ///

  void _registerExpirerEvents() {
    core.expirer.expired.subscribe(_onExpired);
  }

  Future<void> _onExpired(ExpirationEvent? event) async {
    if (event == null) {
      return;
    }

    if (pairings!.has(event.target)) {
      // Clean up the pairing
      await _deletePairing(event.target, true);
      onPairingExpire.broadcast(
        PairingEvent(
          topic: event.target,
        ),
      );
    }
  }

  /// ---- Validators ---- ///

  void _isValidPing(String topic) {
    _isValidPairingTopic(topic);
  }

  void _isValidDisconnect(String topic) {
    _isValidPairingTopic(topic);
  }

  void _isValidPairingTopic(String topic) {
    if (!pairings!.has(topic)) {
      String message = Errors.getInternalError(
        Errors.NO_MATCHING_KEY,
        context: "pairing topic doesn't exist: $topic",
      ).message;
      throw JsonRpcError.invalidParams(message);
    }
    if (WalletConnectUtils.isExpired(pairings!.get(topic)!.expiry)) {
      String message = Errors.getInternalError(
        Errors.EXPIRED,
        context: "pairing topic: $topic",
      ).message;
      throw JsonRpcError.invalidParams(message);
    }
  }
}

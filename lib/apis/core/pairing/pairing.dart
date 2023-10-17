import 'dart:async';
import 'dart:convert';

import 'package:event/event.dart';
import 'package:walletconnect_flutter_v2/apis/core/pairing/i_json_rpc_history.dart';
import 'package:walletconnect_flutter_v2/apis/core/store/i_generic_store.dart';
import 'package:walletconnect_flutter_v2/apis/core/crypto/crypto_models.dart';
import 'package:walletconnect_flutter_v2/apis/core/i_core.dart';
import 'package:walletconnect_flutter_v2/apis/core/pairing/i_pairing.dart';
import 'package:walletconnect_flutter_v2/apis/core/pairing/i_pairing_store.dart';
import 'package:walletconnect_flutter_v2/apis/models/uri_parse_result.dart';
import 'package:walletconnect_flutter_v2/apis/core/pairing/utils/pairing_models.dart';
import 'package:walletconnect_flutter_v2/apis/core/pairing/utils/json_rpc_utils.dart';
import 'package:walletconnect_flutter_v2/apis/core/relay_client/relay_client_models.dart';
import 'package:walletconnect_flutter_v2/apis/models/json_rpc_error.dart';
import 'package:walletconnect_flutter_v2/apis/models/json_rpc_request.dart';
import 'package:walletconnect_flutter_v2/apis/models/json_rpc_response.dart';
import 'package:walletconnect_flutter_v2/apis/models/basic_models.dart';
import 'package:walletconnect_flutter_v2/apis/utils/constants.dart';
import 'package:walletconnect_flutter_v2/apis/utils/errors.dart';
import 'package:walletconnect_flutter_v2/apis/utils/method_constants.dart';
import 'package:walletconnect_flutter_v2/apis/utils/walletconnect_utils.dart';

class PendingRequestResponse {
  Completer completer;
  dynamic response;
  JsonRpcError? error;

  PendingRequestResponse({
    required this.completer,
    this.response,
    this.error,
  });
}

class Pairing implements IPairing {
  bool _initialized = false;

  @override
  final Event<PairingEvent> onPairingCreate = Event<PairingEvent>();
  @override
  final Event<PairingActivateEvent> onPairingActivate =
      Event<PairingActivateEvent>();
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
  Map<int, PendingRequestResponse> pendingRequests = {};

  final ICore core;
  final IPairingStore pairings;
  final IJsonRpcHistory history;

  /// Stores the public key of Type 1 Envelopes for a topic
  /// Once a receiver public key has been used, it is removed from the store
  /// Thus, this store works under the assumption that a public key will only be used once
  final IGenericStore<ReceiverPublicKey> topicToReceiverPublicKey;

  Pairing({
    required this.core,
    required this.pairings,
    required this.history,
    required this.topicToReceiverPublicKey,
  });

  @override
  Future<void> init() async {
    if (_initialized) {
      return;
    }

    _registerRelayEvents();
    _registerExpirerEvents();
    _registerheartbeatSubscription();

    await core.expirer.init();
    await pairings.init();
    await history.init();
    await topicToReceiverPublicKey.init();

    await _cleanup();

    await _resubscribeAll();

    _initialized = true;
  }

  @override
  Future<void> checkAndExpire() async {
    for (var pairing in getPairings()) {
      await core.expirer.checkAndExpire(pairing.topic);
    }
  }

  @override
  Future<CreateResponse> create({List<List<String>>? methods}) async {
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

    onPairingCreate.broadcast(
      PairingEvent(
        topic: topic,
      ),
    );

    await pairings.set(topic, pairing);
    await core.relayClient.subscribe(topic: topic);
    await core.expirer.set(topic, expiry);

    return CreateResponse(
      topic: topic,
      uri: uri,
      pairingInfo: pairing,
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
    if (parsedUri.version != URIVersion.v2) {
      throw Errors.getInternalError(
        Errors.MISSING_OR_INVALID,
        context: 'URI is not WalletConnect version 2 URI',
      );
    }

    final String topic = parsedUri.topic;
    final Relay relay = parsedUri.v2Data!.relay;
    final String symKey = parsedUri.v2Data!.symKey;
    final PairingInfo pairing = PairingInfo(
      topic: topic,
      expiry: expiry,
      relay: relay,
      active: false,
    );

    try {
      JsonRpcUtils.validateMethods(
        parsedUri.v2Data!.methods,
        routerMapRequest.values.toList(),
      );
    } on WalletConnectError catch (e) {
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

    await pairings.set(topic, pairing);
    await core.crypto.setSymKey(symKey, overrideTopic: topic);
    await core.relayClient.subscribe(topic: topic);
    await core.expirer.set(topic, expiry);

    onPairingCreate.broadcast(
      PairingEvent(
        topic: topic,
      ),
    );

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
    // print('Activating pairing with topic: $topic');

    onPairingActivate.broadcast(
      PairingActivateEvent(
        topic: topic,
        expiry: expiry,
      ),
    );

    await pairings.update(
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
      throw const WalletConnectError(
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
    await topicToReceiverPublicKey.set(
      topic,
      ReceiverPublicKey(
        topic: topic,
        publicKey: publicKey,
        expiry: WalletConnectUtils.calculateExpiry(
          expiry ?? WalletConnectConstants.FIVE_MINUTES,
        ),
      ),
    );
  }

  @override
  Future<void> updateExpiry({
    required String topic,
    required int expiry,
  }) async {
    _checkInitialized();

    // Validate the expiry is less than 30 days
    if (expiry >
        WalletConnectUtils.calculateExpiry(
          WalletConnectConstants.THIRTY_DAYS,
        )) {
      throw const WalletConnectError(
        code: -1,
        message: 'Expiry cannot be more than 30 days away',
      );
    }

    await pairings.update(
      topic,
      expiry: expiry,
    );
    await core.expirer.set(
      topic,
      expiry,
    );
  }

  @override
  Future<void> updateMetadata({
    required String topic,
    required PairingMetadata metadata,
  }) async {
    _checkInitialized();
    await pairings.update(
      topic,
      metadata: metadata,
    );
  }

  @override
  List<PairingInfo> getPairings() {
    return pairings.getAll();
  }

  @override
  PairingInfo? getPairing({required String topic}) {
    return pairings.get(topic);
  }

  @override
  Future<void> ping({required String topic}) async {
    _checkInitialized();

    await _isValidPing(topic);

    if (pairings.has(topic)) {
      // try {
      final bool _ = await sendRequest(
        topic,
        MethodConstants.WC_PAIRING_PING,
        {},
      );
    }
  }

  @override
  Future<void> disconnect({required String topic}) async {
    _checkInitialized();

    await _isValidDisconnect(topic);
    if (pairings.has(topic)) {
      // Send the request to delete the pairing, we don't care if it fails
      try {
        sendRequest(
          topic,
          MethodConstants.WC_PAIRING_DELETE,
          Errors.getSdkError(Errors.USER_DISCONNECTED).toJson(),
        );
      } catch (_) {}

      // Delete the pairing
      await pairings.delete(topic);

      onPairingDelete.broadcast(
        PairingEvent(
          topic: topic,
        ),
      );
    }
  }

  @override
  IPairingStore getStore() {
    return pairings;
  }

  @override
  Future<void> isValidPairingTopic({required String topic}) async {
    if (!pairings.has(topic)) {
      throw Errors.getInternalError(
        Errors.NO_MATCHING_KEY,
        context: "pairing topic doesn't exist: $topic",
      );
    }

    if (await core.expirer.checkAndExpire(topic)) {
      throw Errors.getInternalError(
        Errors.EXPIRED,
        context: 'pairing topic: $topic',
      );
    }
  }

  // RELAY COMMUNICATION HELPERS

  @override
  Future sendRequest(
    String topic,
    String method,
    dynamic params, {
    int? id,
    int? ttl,
    EncodeOptions? encodeOptions,
  }) async {
    core.logger.t(
      'pairing sendResult, id: $id topic: $topic, method: $method, params: $params, ttl: $ttl',
    );

    final Map<String, dynamic> payload = JsonRpcUtils.formatJsonRpcRequest(
      method,
      params,
      id: id,
    );
    // print('sending request: $payload');

    final String? message = await core.crypto.encode(
      topic,
      payload,
      options: encodeOptions,
    );

    if (message == null) {
      return;
    }

    RpcOptions opts = MethodConstants.RPC_OPTS[method]!['req']!;
    if (ttl != null) {
      opts = opts.copyWith(ttl: ttl);
    }

    // print('adding payload to pending requests: ${payload['id']}');
    final PendingRequestResponse resp = PendingRequestResponse(
      completer: Completer(),
    );
    resp.completer.future.catchError((_) {
      // Catch the error so that it won't throw an uncaught error
      // print('inner caught error: $err');
    });
    pendingRequests[payload['id']] = resp;
    // print('sent request');
    await core.relayClient.publish(
      topic: topic,
      message: message,
      ttl: opts.ttl,
      tag: opts.tag,
    );

    // Get the result from the completer, if it's an error, throw it
    try {
      // print('checking error');
      if (resp.error != null) {
        throw resp.error!;
      }

      // print('checking if completed');
      if (resp.completer.isCompleted) {
        return resp.response;
      }

      // print('waiting for response');
      return await resp.completer.future;
    } catch (e) {
      // print('caught error: $e');
      rethrow;
    }
  }

  @override
  Future<void> sendResult(
    int id,
    String topic,
    String method,
    dynamic result, {
    EncodeOptions? encodeOptions,
  }) async {
    core.logger.t(
      'pairing sendResult, id: $id topic: $topic, method: $method, result: $result',
    );
    final Map<String, dynamic> payload =
        JsonRpcUtils.formatJsonRpcResponse<dynamic>(
      id,
      result,
    );
    final String? message = await core.crypto.encode(
      topic,
      payload,
      options: encodeOptions,
    );

    if (message == null) {
      return;
    }

    final RpcOptions opts = MethodConstants.RPC_OPTS[method]!['res']!;
    await core.relayClient.publish(
      topic: topic,
      message: message,
      ttl: opts.ttl,
      tag: opts.tag,
    );
  }

  @override
  Future<void> sendError(
    int id,
    String topic,
    String method,
    JsonRpcError error, {
    EncodeOptions? encodeOptions,
  }) async {
    core.logger.t(
      'pairing sendError, id: $id topic: $topic, method: $method, error: $error',
    );

    final Map<String, dynamic> payload = JsonRpcUtils.formatJsonRpcError(
      id,
      error,
    );
    final String? message = await core.crypto.encode(
      topic,
      payload,
      options: encodeOptions,
    );

    if (message == null) {
      return;
    }

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
  }

  /// ---- Private Helpers ---- ///

  Future<void> _resubscribeAll() async {
    // If the relay is not active, stop here
    if (!core.relayClient.isConnected) {
      return;
    }

    // Resubscribe to all active pairings
    final List<PairingInfo> activePairings = pairings.getAll();
    for (final PairingInfo pairing in activePairings) {
      if (pairing.active) {
        // print('Resubscribing to topic: ${pairing.topic}');
        await core.relayClient.subscribe(topic: pairing.topic);
      }
    }
  }

  Future<void> _deletePairing(String topic, bool expirerHasDeleted) async {
    await core.relayClient.unsubscribe(topic: topic);
    await pairings.delete(topic);
    await core.crypto.deleteSymKey(topic);
    if (expirerHasDeleted) {
      await core.expirer.delete(topic);
    }
  }

  Future<void> _cleanup() async {
    final List<PairingInfo> expiredPairings = getPairings()
        .where(
          (PairingInfo info) => WalletConnectUtils.isExpired(info.expiry),
        )
        .toList();
    for (final PairingInfo pairing in expiredPairings) {
      // print('deleting expired pairing: ${pairing.topic}');
      await _deletePairing(pairing.topic, true);
    }

    // Cleanup all history records
    final List<JsonRpcRecord> expiredHistory = history
        .getAll()
        .where(
          (record) => WalletConnectUtils.isExpired(record.expiry ?? -1),
        )
        .toList();
    // Loop through the expired records and delete them
    for (final JsonRpcRecord record in expiredHistory) {
      // print('deleting expired history record: ${record.id}');
      await history.delete(record.id.toString());
    }

    // Cleanup all of the expired receiver public keys
    final List<ReceiverPublicKey> expiredReceiverPublicKeys =
        topicToReceiverPublicKey
            .getAll()
            .where((receiver) => WalletConnectUtils.isExpired(receiver.expiry))
            .toList();
    // Loop through the expired receiver public keys and delete them
    for (final ReceiverPublicKey receiver in expiredReceiverPublicKeys) {
      // print('deleting expired receiver public key: $receiver');
      await topicToReceiverPublicKey.delete(receiver.topic);
    }
  }

  void _checkInitialized() {
    if (!_initialized) {
      throw Errors.getInternalError(Errors.NOT_INITIALIZED);
    }
  }

  /// ---- Relay Event Router ---- ///

  Map<String, RegisteredFunction> routerMapRequest = {};

  void _registerRelayEvents() {
    core.relayClient.onRelayClientConnect.subscribe(_onRelayConnect);
    core.relayClient.onRelayClientMessage.subscribe(_onMessageEvent);

    register(
      method: MethodConstants.WC_PAIRING_PING,
      function: _onPairingPingRequest,
      type: ProtocolType.pair,
    );
    register(
      method: MethodConstants.WC_PAIRING_DELETE,
      function: _onPairingDeleteRequest,
      type: ProtocolType.pair,
    );
  }

  Future<void> _onRelayConnect(EventArgs? args) async {
    // print('Pairing: Relay connected');
    await _resubscribeAll();
  }

  void _onMessageEvent(MessageEvent? event) async {
    if (event == null) {
      return;
    }

    // If we have a reciever public key for the topic, use it
    ReceiverPublicKey? receiverPublicKey =
        topicToReceiverPublicKey.get(event.topic);
    // If there was a public key, delete it. One use.
    if (receiverPublicKey != null) {
      await topicToReceiverPublicKey.delete(event.topic);
    }

    // Decode the message
    String? payloadString = await core.crypto.decode(
      event.topic,
      event.message,
      options: DecodeOptions(
        receiverPublicKey: receiverPublicKey?.publicKey,
      ),
    );

    if (payloadString == null) {
      return;
    }
    // print(payloadString);

    Map<String, dynamic> data = jsonDecode(payloadString);
    core.logger.i('Pairing _onMessageEvent, Received data: $data');

    // If it's an rpc request, handle it
    // print('Pairing: Received data: $data');
    if (data.containsKey('method')) {
      final request = JsonRpcRequest.fromJson(data);
      if (routerMapRequest.containsKey(request.method)) {
        routerMapRequest[request.method]!.function(event.topic, request);
      } else {
        _onUnkownRpcMethodRequest(event.topic, request);
      }
    }
    // Otherwise handle it as a response
    else {
      final response = JsonRpcResponse.fromJson(data);

      // Only handle the response if we have a record of the request
      // final JsonRpcRecord? record = history.get(response.id.toString());
      // // print(record);
      // if (record == null) {
      //   return;
      // }

      // print(
      //   'pendingRequests: ${pendingRequests.keys} has ${response.id} is ${pendingRequests.containsKey(response.id)}',
      // );
      if (pendingRequests.containsKey(response.id)) {
        if (response.error != null) {
          pendingRequests[response.id]!.error = response.error;
          pendingRequests[response.id]!
              .completer
              .completeError(response.error!);
        } else {
          // print(
          //   'completing: ${response.result}',
          // );
          pendingRequests[response.id]!.response = response.result;
          pendingRequests[response.id]!.completer.complete(response.result);
        }
      }
    }
  }

  Future<void> _onPairingPingRequest(
    String topic,
    JsonRpcRequest request,
  ) async {
    final int id = request.id;
    try {
      // print('ping req');
      await _isValidPing(topic);
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
      await _isValidDisconnect(topic);
      await sendResult(
        id,
        topic,
        request.method,
        true,
      );
      await pairings.delete(topic);
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

  /// ---- Expirer Events ---- ///

  void _registerExpirerEvents() {
    core.expirer.onExpire.subscribe(_onExpired);
  }

  void _registerheartbeatSubscription() {
    core.heartbeat.onPulse.subscribe(_heartbeatSubscription);
  }

  Future<void> _onExpired(ExpirationEvent? event) async {
    if (event == null) {
      return;
    }

    if (pairings.has(event.target)) {
      // Clean up the pairing
      await _deletePairing(event.target, true);
      onPairingExpire.broadcast(
        PairingEvent(
          topic: event.target,
        ),
      );
    }
  }

  void _heartbeatSubscription(EventArgs? args) async {
    core.logger.i('Pairing heartbeat received');
    await checkAndExpire();
  }

  /// ---- Validators ---- ///

  Future<void> _isValidPing(String topic) async {
    await isValidPairingTopic(topic: topic);
  }

  Future<void> _isValidDisconnect(String topic) async {
    await isValidPairingTopic(topic: topic);
  }
}

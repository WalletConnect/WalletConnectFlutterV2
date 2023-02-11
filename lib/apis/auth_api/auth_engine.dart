import 'dart:async';
import 'dart:convert';

import 'package:event/event.dart';
import 'package:wallet_connect_flutter_v2/apis/auth_api/i_auth_engine.dart';
import 'package:wallet_connect_flutter_v2/apis/auth_api/models/auth_client_events.dart';
import 'package:wallet_connect_flutter_v2/apis/auth_api/models/auth_client_models.dart';
import 'package:wallet_connect_flutter_v2/apis/auth_api/models/json_rpc_models.dart';
import 'package:wallet_connect_flutter_v2/apis/auth_api/stores/generic_store.dart';
import 'package:wallet_connect_flutter_v2/apis/auth_api/stores/i_generic_store.dart';
import 'package:wallet_connect_flutter_v2/apis/auth_api/utils/address_utils.dart';
import 'package:wallet_connect_flutter_v2/apis/auth_api/utils/auth_api_validators.dart';
import 'package:wallet_connect_flutter_v2/apis/auth_api/utils/auth_constants.dart';
import 'package:wallet_connect_flutter_v2/apis/auth_api/utils/auth_signature.dart';
import 'package:wallet_connect_flutter_v2/apis/core/crypto/crypto_models.dart';
import 'package:wallet_connect_flutter_v2/apis/core/i_core.dart';
import 'package:wallet_connect_flutter_v2/apis/core/pairing/utils/pairing_models.dart';
import 'package:wallet_connect_flutter_v2/apis/core/pairing/utils/pairing_utils.dart';
import 'package:wallet_connect_flutter_v2/apis/core/relay_client/relay_client_models.dart';
import 'package:wallet_connect_flutter_v2/apis/models/basic_models.dart';
import 'package:wallet_connect_flutter_v2/apis/models/json_rpc_error.dart';
import 'package:wallet_connect_flutter_v2/apis/models/json_rpc_request.dart';
import 'package:wallet_connect_flutter_v2/apis/utils/constants.dart';
import 'package:wallet_connect_flutter_v2/apis/utils/errors.dart';
import 'package:wallet_connect_flutter_v2/apis/utils/method_constants.dart';
import 'package:wallet_connect_flutter_v2/apis/utils/wallet_connect_utils.dart';

class AuthEngine implements IAuthEngine {
  bool _initialized = false;

  @override
  final Event<AuthRequest> onAuthRequest = Event();
  @override
  final Event<AuthResponse> onAuthResponse = Event();

  @override
  final ICore core;
  @override
  final PairingMetadata metadata;
  @override
  late IGenericStore<AuthPublicKey> authKeys;
  @override
  late IGenericStore<String> pairingTopics;
  @override
  late IGenericStore<PendingAuthRequest> authRequests;
  @override
  late IGenericStore<StoredCacao> completeRequests;

  List<AuthRequestCompleter> pendingAuthRequests = [];

  AuthEngine({
    required this.core,
    required this.metadata,
    required this.authKeys,
    required this.pairingTopics,
    required this.authRequests,
    required this.completeRequests,
  });

  @override
  Future<void> init() async {
    if (_initialized) {
      return;
    }

    await core.pairing.init();
    await authKeys.init();
    await pairingTopics.init();
    await authRequests.init();
    await completeRequests.init();

    _registerRelayClientFunctions();

    _initialized = true;
  }

  @override
  Future<AuthRequestResponse> requestAuth({
    required AuthRequestParams params,
    String? pairingTopic,
  }) async {
    _checkInitialized();

    AuthApiValidators.isValidRequest(params);

    final bool hasKnownPairing =
        pairingTopic != null && core.pairing.getStore().has(pairingTopic);

    final Relay relay = Relay(
      WalletConnectConstants.RELAYER_DEFAULT_PROTOCOL,
    );

    final int expiry = WalletConnectUtils.calculateExpiry(
      params.expiry ?? WalletConnectConstants.FIVE_MINUTES,
    );
    final String publicKey = await core.crypto.generateKeyPair();
    final String responseTopic = core.crypto.getUtils().hashKey(publicKey);

    WcAuthRequestRequest request = WcAuthRequestRequest(
      payloadParams: AuthPayloadParams(
        type: params.type ?? CacaoHeader.EIP4361,
        chainId: params.chainId,
        statement: params.statement,
        aud: params.aud,
        domain: params.domain,
        version: '1',
        nonce: params.nonce,
        iat: DateTime.now().toIso8601String(),
      ),
      requester: ConnectionMetadata(
        publicKey: publicKey,
        metadata: metadata,
      ),
    );

    late int id;
    Completer<AuthResponse> completer = Completer.sync();
    Uri? uri;

    if (hasKnownPairing) {
      id = PairingUtils.payloadId();
      _requestAuthResponseHandler(
        pairingTopic: pairingTopic,
        responseTopic: responseTopic,
        request: request,
        id: id,
        expiry: expiry,
        completer: completer,
      );
    } else {
      final String symKey = core.crypto.getUtils().generateRandomBytes32();
      final String pairingTopic = await core.crypto.setSymKey(symKey);

      final PairingInfo pairing = PairingInfo(
        topic: pairingTopic,
        expiry: expiry,
        relay: relay,
        active: false,
      );
      await core.pairing.getStore().set(pairingTopic, pairing);

      _setExpiry(pairingTopic, expiry);

      await authKeys.set(
        AuthConstants.AUTH_CLIENT_PUBLIC_KEY_NAME,
        AuthPublicKey(publicKey: publicKey),
      );

      await pairingTopics.set(
        responseTopic,
        pairingTopic,
      );

      await core.relayClient.subscribe(topic: pairingTopic);
      await core.relayClient.subscribe(topic: responseTopic);

      id = PairingUtils.payloadId();
      _requestAuthResponseHandler(
        pairingTopic: pairingTopic,
        responseTopic: responseTopic,
        request: request,
        id: id,
        expiry: expiry,
        completer: completer,
      );

      uri = WalletConnectUtils.formatUri(
        protocol: core.protocol,
        version: core.version,
        topic: pairingTopic,
        symKey: symKey,
        relay: relay,
        methods: [],
      );
    }

    return AuthRequestResponse(
      id: id,
      completer: completer,
      uri: uri,
    );
  }

  Future<void> _requestAuthResponseHandler({
    required String pairingTopic,
    required String responseTopic,
    required WcAuthRequestRequest request,
    required int id,
    required int expiry,
    required Completer<AuthResponse> completer,
  }) async {
    Map<String, dynamic>? resp;
    try {
      resp = await core.pairing.sendRequest(
        pairingTopic,
        MethodConstants.WC_AUTH_REQUEST,
        request.toJson(),
        id: id,
        ttl: expiry,
      );
    } on JsonRpcError catch (e) {
      final resp = AuthResponse(
        id: id,
        topic: responseTopic,
        jsonRpcError: e,
      );
      onAuthResponse.broadcast(resp);
      completer.complete(resp);
      return;
    }

    core.pairing.activate(topic: pairingTopic);

    final Cacao cacao = Cacao.fromJson(resp!);
    final CacaoSignature sig = cacao.s;
    final CacaoPayload payload = cacao.p;
    await completeRequests.set(
      id.toString(),
      StoredCacao.fromCacao(
        cacao,
        id.toString(),
      ),
    );

    final String reconstructed = formatMessage(
      iss: payload.iss,
      cacaoPayload: payload,
    );

    final String walletAddress = AddressUtils.getDidAddress(payload.iss);
    final String chainId = AddressUtils.getDidChainId(payload.iss);

    if (walletAddress.isEmpty) {
      throw Errors.getSdkError(
        Errors.MISSING_OR_INVALID,
        context: 'authResponse walletAddress is empty',
      );
    }
    if (chainId.isEmpty) {
      throw Errors.getSdkError(
        Errors.MISSING_OR_INVALID,
        context: 'authResponse chainId is empty',
      );
    }

    final bool isValid = await AuthSignature.verifySignature(
      walletAddress,
      reconstructed,
      sig,
      chainId,
      core.projectId,
    );

    if (!isValid) {
      final resp = AuthResponse(
        id: id,
        topic: responseTopic,
        error: WCErrorResponse(
          code: -1,
          message: 'Invalid signature',
        ),
      );
      onAuthResponse.broadcast(resp);
      completer.complete(resp);
    } else {
      final resp = AuthResponse(
        id: id,
        topic: responseTopic,
        result: cacao,
      );
      onAuthResponse.broadcast(resp);
      completer.complete(resp);
    }
  }

  @override
  Future<void> respond({
    required int id,
    required String iss,
    CacaoSignature? signature,
    WCErrorResponse? error,
  }) async {
    _checkInitialized();

    Map<int, PendingAuthRequest> pendingRequests = getPendingRequests();
    AuthApiValidators.isValidRespond(
      id: id,
      pendingRequests: pendingRequests,
      signature: signature,
      error: error,
    );

    final PendingAuthRequest pendingRequest = pendingRequests[id]!;
    final String receiverPublicKey = pendingRequest.metadata.publicKey;
    final String senderPublicKey = await core.crypto.generateKeyPair();
    final String responseTopic = core.crypto.getUtils().hashKey(
          receiverPublicKey,
        );
    final EncodeOptions encodeOpts = EncodeOptions(
      type: EncodeOptions.TYPE_1,
      receiverPublicKey: receiverPublicKey,
      senderPublicKey: senderPublicKey,
    );

    if (error != null) {
      await core.pairing.sendError(
        id,
        responseTopic,
        MethodConstants.WC_AUTH_REQUEST,
        JsonRpcError.serverError(error.message),
        encodeOptions: encodeOpts,
      );
    } else {
      final Cacao cacao = Cacao(
        h: CacaoHeader(),
        p: CacaoPayload.fromRequestPayload(
          pendingRequest.cacaoPayload,
          iss,
        ),
        s: signature!,
      );

      await core.pairing.sendResult(
        id,
        responseTopic,
        MethodConstants.WC_AUTH_REQUEST,
        cacao.toJson(),
        encodeOptions: encodeOpts,
      );

      await completeRequests.set(
        id.toString(),
        StoredCacao.fromCacao(
          cacao,
          id.toString(),
        ),
      );
    }
  }

  @override
  Map<int, PendingAuthRequest> getPendingRequests() {
    Map<int, PendingAuthRequest> pendingRequests = {};
    authRequests.getAll().forEach((key) {
      pendingRequests[key.id] = key;
    });
    return pendingRequests;
  }

  @override
  String formatMessage({
    required String iss,
    required CacaoPayload cacaoPayload,
  }) {
    final header =
        '${cacaoPayload.domain} wants you to sign in with your Ethereum account';
    final walletAddress = AddressUtils.getDidAddress(iss);
    final uri = 'URI: ${cacaoPayload.aud}';
    final version = 'Version: ${cacaoPayload.version}';
    final chainId = 'Chain ID: ${AddressUtils.getDidChainId(iss)}';
    final nonce = 'Nonce: ${cacaoPayload.nonce}';
    final issuedAt = 'Issued At: ${cacaoPayload.iat}';
    final resources = cacaoPayload.resources != null &&
            cacaoPayload.resources!.isNotEmpty
        ? 'Resources:\n${cacaoPayload.resources!.map((resource) => '- $resource').join('\n')}'
        : null;

    final message = [
      header,
      walletAddress,
      '',
      cacaoPayload.statement,
      '',
      uri,
      version,
      chainId,
      nonce,
      issuedAt,
      resources,
    ].where((element) => element != null).join('\n');

    return message;
  }

  /// ---- PRIVATE HELPERS ---- ///

  void _checkInitialized() {
    if (!_initialized) {
      throw Errors.getInternalError(Errors.NOT_INITIALIZED);
    }
  }

  Future<void> _setExpiry(String topic, int expiry) async {
    if (core.pairing.getStore().has(topic)) {
      await core.pairing.updateExpiry(topic: topic, expiry: expiry);
    }
    await core.expirer.set(topic, expiry);
  }

  /// ---- Relay Events ---- ///

  void _registerRelayClientFunctions() {
    core.pairing.register(
      method: MethodConstants.WC_AUTH_REQUEST,
      function: _onAuthRequest,
      type: ProtocolType.Auth,
    );
  }

  void _onAuthRequest(
    String topic,
    JsonRpcRequest payload,
  ) async {
    try {
      final request = WcAuthRequestRequest.fromJson(payload.params);

      final CacaoRequestPayload cacaoPayload =
          CacaoRequestPayload.fromPayloadParams(
        payload.params,
      );

      authRequests.set(
        payload.id.toString(),
        PendingAuthRequest(
          id: payload.id,
          metadata: request.requester,
          cacaoPayload: cacaoPayload,
        ),
      );

      onAuthRequest.broadcast(
        AuthRequest(
          id: payload.id,
          topic: topic,
          requester: request.requester,
          payloadParams: request.payloadParams,
        ),
      );
    } on WCError catch (err) {
      await core.pairing.sendError(
        payload.id,
        topic,
        payload.method,
        JsonRpcError.invalidParams(
          err.message,
        ),
      );
    }
  }
}

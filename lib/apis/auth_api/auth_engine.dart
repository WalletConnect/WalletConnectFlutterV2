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
import 'package:wallet_connect_flutter_v2/apis/core/i_core.dart';
import 'package:wallet_connect_flutter_v2/apis/core/pairing/utils/pairing_models.dart';
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
  late IGenericStore<PendingRequest> authRequests;
  @override
  late IGenericStore<StoredCacao> completeRequests;

  AuthEngine({
    required this.core,
    required this.metadata,
  }) {
    authKeys = GenericStore(
      core,
      'authKeys',
      '2.0',
      (AuthPublicKey value) {
        return jsonEncode(value.toJson());
      },
      (String value) {
        return AuthPublicKey.fromJson(jsonDecode(value));
      },
    );
    pairingTopics = GenericStore(
      core,
      'authPairingTopics',
      '2.0',
      (String value) {
        return value;
      },
      (String value) {
        return value;
      },
    );
    authRequests = GenericStore(
      core,
      'authRequests',
      '2.0',
      (PendingRequest value) {
        return jsonEncode(value.toJson());
      },
      (String value) {
        return PendingRequest.fromJson(jsonDecode(value));
      },
    );
    completeRequests = GenericStore(
      core,
      'completedRequests',
      '2.0',
      (StoredCacao value) {
        return jsonEncode(value.toJson());
      },
      (String value) {
        return StoredCacao.fromJson(jsonDecode(value));
      },
    );
  }

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
    required String topic,
    required AuthRequestParams params,
  }) async {
    _checkInitialized();

    AuthApiValidators.isValidRequest(params);

    final bool hasKnownPairing = core.pairing.getStore().has(topic);

    final Relay relay = Relay(
      WalletConnectConstants.RELAYER_DEFAULT_PROTOCOL,
    );

    final int expiry = WalletConnectUtils.calculateExpiry(
      params.expiry ?? WalletConnectConstants.FIVE_MINUTES,
    );
    final String publicKey = await core.crypto.generateKeyPair();

    if (hasKnownPairing) {
      final PairingInfo knownPairing = core.pairing.getStore().get(topic)!;

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

      await core.pairing.sendRequest(
        topic,
        MethodConstants.WC_AUTH_REQUEST,
        request.toJson(),
        ttl: expiry,
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
    }

    // const hasKnownPairing =
    //   Boolean(opts?.topic) &&
    //   this.client.core.pairing.pairings
    //     .getAll({ active: true })
    //     .some((pairing) => pairing.topic === opts?.topic);

    // const relay = { protocol: RELAYER_DEFAULT_PROTOCOL };

    // const expiry = calcExpiry(params.expiry || FIVE_MINUTES);
    // const publicKey = await this.client.core.crypto.generateKeyPair();

    // if (hasKnownPairing) {
    //   const knownPairing = this.client.core.pairing.pairings
    //     .getAll({ active: true })
    //     .find((pairing) => pairing.topic === opts?.topic);

    //   if (!knownPairing)
    //     throw new Error(`Could not find pairing for provided topic ${opts?.topic}`);

    //   // Send request to existing pairing
    //   await this.sendRequest(
    //     knownPairing.topic,
    //     "wc_authRequest",
    //     {
    //       payloadParams: {
    //         type: type ?? "eip4361",
    //         chainId,
    //         statement,
    //         aud,
    //         domain,
    //         version: "1",
    //         nonce,
    //         iat: new Date().toISOString(),
    //       },
    //       requester: { publicKey, metadata: this.client.metadata },
    //     },
    //     {},
    //     params.expiry,
    //   );

    //   this.client.logger.debug("sent request to existing pairing");
    // }

    // const symKey = generateRandomBytes32();

    // const pairingTopic = await this.client.core.crypto.setSymKey(symKey);

    // // Preparing pairing URI
    // const pairing = { topic: pairingTopic, expiry, relay, active: false };
    // await this.client.core.pairing.pairings.set(pairingTopic, pairing);

    // this.client.logger.debug("Generated new pairing", pairing);

    // this.setExpiry(pairingTopic, expiry);

    // this.client.authKeys.set(AUTH_CLIENT_PUBLIC_KEY_NAME, { publicKey });

    // const responseTopic = hashKey(publicKey);

    // await this.client.pairingTopics.set(responseTopic, { pairingTopic });

    // // Subscribe to the pairing topic (for pings)
    // await this.client.core.relayer.subscribe(pairingTopic);
    // // Subscribe to auth_response topic
    // await this.client.core.relayer.subscribe(responseTopic);

    // this.client.logger.debug("sending request to potential pairing");

    // // SPEC: A encrypts reuqest with symKey S
    // // SPEC: A publishes encrypted request to topic
    // const id = await this.sendRequest(
    //   pairingTopic,
    //   "wc_authRequest",
    //   {
    //     payloadParams: {
    //       type: type ?? "eip4361",
    //       chainId,
    //       statement,
    //       aud,
    //       domain,
    //       version: "1",
    //       nonce,
    //       iat: new Date().toISOString(),
    //     },
    //     requester: { publicKey, metadata: this.client.metadata },
    //   },
    //   {},
    //   params.expiry,
    // );

    // this.client.logger.debug("sent request to potential pairing");

    // const uri = formatUri({
    //   protocol: this.client.protocol,
    //   version: this.client.core.version,
    //   topic: pairingTopic,
    //   symKey,
    //   relay,
    // });

    // return { uri, id };

    return AuthRequestResponse(uri: Uri.parse(params.aud), id: -1);
  }

  @override
  Future<bool> respond({
    required int id,
    required String iss,
    CacaoSignature? signature,
    WCErrorResponse? error,
  }) async {
    _checkInitialized();

    return true;

    //   this.isInitialized();

    //   if (!isValidRespond(respondParams, this.client.requests)) {
    //     throw new Error("Invalid response");
    //   }

    //   const pendingRequest = getPendingRequest(this.client.requests, respondParams.id);

    //   const receiverPublicKey = pendingRequest.requester.publicKey;
    //   const senderPublicKey = await this.client.core.crypto.generateKeyPair();
    //   const responseTopic = hashKey(receiverPublicKey);
    //   const encodeOpts = {
    //     type: TYPE_1,
    //     receiverPublicKey,
    //     senderPublicKey,
    //   };

    //   if ("error" in respondParams) {
    //     await this.sendError(pendingRequest.id, responseTopic, respondParams, encodeOpts);
    //     return;
    //   }

    //   const cacao: AuthEngineTypes.Cacao = {
    //     h: {
    //       t: "eip4361",
    //     },
    //     p: {
    //       ...pendingRequest.cacaoPayload,
    //       iss,
    //     },
    //     s: respondParams.signature,
    //   };

    //   const id = await this.sendResult<"wc_authRequest">(
    //     pendingRequest.id,
    //     responseTopic,
    //     cacao,
    //     encodeOpts,
    //   );

    //   await this.client.requests.set(id, { id, ...cacao });
    // }
  }

  @override
  Map<int, PendingRequest> getPendingRequests() {
    Map<int, PendingRequest> pendingRequests = {};
    authRequests.getAll().forEach((key) {
      pendingRequests[key.id] = key;
    });
    return pendingRequests;
  }

  @override
  String formatMessage({
    required String iss,
    required CacaoPayload cacao,
  }) {
    final header =
        '${cacao.domain} wants you to sign in with your Ethereum account';
    final walletAddress = AddressUtils.getDidAddress(iss);
    final uri = 'URI: ${cacao.aud}';
    final version = 'Version: ${cacao.version}';
    final chainId = 'Chain ID: ${AddressUtils.getDidChainId(iss)}';
    final nonce = 'Nonce: ${cacao.nonce}';
    final issuedAt = 'Issued At: ${cacao.iat}';
    final resources = cacao.resources != null && cacao.resources!.isNotEmpty
        ? 'Resources:\n${cacao.resources!.map((resource) => '- $resource').join('\n')}'
        : null;

    final message = [
      header,
      walletAddress,
      '',
      cacao.statement,
      '',
      uri,
      version,
      chainId,
      nonce,
      issuedAt,
      resources,
    ].where((element) => element != null).join('\n');

    return message;

    // const version = `Version: ${cacao.version}`;
    // const chainId = `Chain ID: ${getDidChainId(iss)}`;
    // const nonce = `Nonce: ${cacao.nonce}`;
    // const issuedAt = `Issued At: ${cacao.iat}`;
    // const resources =
    //   cacao.resources && cacao.resources.length > 0
    //     ? `Resources:\n${cacao.resources.map((resource) => `- ${resource}`).join("\n")}`
    //     : undefined;

    // const message = [
    //   header,
    //   walletAddress,
    //   ``,
    //   statement,
    //   ``,
    //   uri,
    //   version,
    //   chainId,
    //   nonce,
    //   issuedAt,
    //   resources,
    // ]
    //   .filter((val) => val !== undefined && val !== null) // remove unnecessary empty lines
    //   .join("\n");
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
        PendingRequest(
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

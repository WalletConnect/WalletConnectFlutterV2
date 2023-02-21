import 'dart:convert';

import 'package:event/event.dart';
import 'package:walletconnect_flutter_v2/apis/auth_api/auth_engine.dart';
import 'package:walletconnect_flutter_v2/apis/auth_api/i_auth_client.dart';
import 'package:walletconnect_flutter_v2/apis/auth_api/i_auth_engine.dart';
import 'package:walletconnect_flutter_v2/apis/auth_api/models/auth_client_events.dart';
import 'package:walletconnect_flutter_v2/apis/core/store/generic_store.dart';
import 'package:walletconnect_flutter_v2/apis/core/store/i_generic_store.dart';
import 'package:walletconnect_flutter_v2/apis/auth_api/models/auth_client_models.dart';
import 'package:walletconnect_flutter_v2/apis/auth_api/utils/auth_constants.dart';
import 'package:walletconnect_flutter_v2/apis/core/i_core.dart';
import 'package:walletconnect_flutter_v2/apis/models/basic_models.dart';
import 'package:walletconnect_flutter_v2/apis/core/pairing/utils/pairing_models.dart';

class AuthClient implements IAuthClient {
  bool _initialized = false;

  @override
  String get protocol => 'wc';

  @override
  int get version => 2;

  @override
  Event<AuthRequest> get onAuthRequest => engine.onAuthRequest;
  @override
  Event<AuthResponse> get onAuthResponse => engine.onAuthResponse;

  @override
  ICore get core => engine.core;
  @override
  PairingMetadata get metadata => engine.metadata;
  @override
  IGenericStore<AuthPublicKey> get authKeys => engine.authKeys;
  @override
  IGenericStore<String> get pairingTopics => engine.pairingTopics;
  @override
  IGenericStore<PendingAuthRequest> get authRequests => engine.authRequests;
  @override
  IGenericStore<StoredCacao> get completeRequests => engine.completeRequests;

  @override
  late IAuthEngine engine;

  static Future<AuthClient> createInstance({
    required ICore core,
    required PairingMetadata metadata,
  }) async {
    final client = AuthClient(
      core: core,
      metadata: metadata,
    );

    await client.init();

    return client;
  }

  AuthClient({
    required ICore core,
    required PairingMetadata metadata,
  }) {
    engine = AuthEngine(
      core: core,
      metadata: metadata,
      authKeys: GenericStore(
        core: core,
        context: AuthConstants.CONTEXT_AUTH_KEYS,
        version: AuthConstants.VERSION_AUTH_KEYS,
        toJsonString: (AuthPublicKey value) {
          return jsonEncode(value.toJson());
        },
        fromJsonString: (String value) {
          return AuthPublicKey.fromJson(jsonDecode(value));
        },
      ),
      pairingTopics: GenericStore(
        core: core,
        context: AuthConstants.CONTEXT_PAIRING_TOPICS,
        version: AuthConstants.VERSION_PAIRING_TOPICS,
        toJsonString: (String value) {
          return value;
        },
        fromJsonString: (String value) {
          return value;
        },
      ),
      authRequests: GenericStore(
        core: core,
        context: AuthConstants.CONTEXT_AUTH_REQUESTS,
        version: AuthConstants.VERSION_AUTH_REQUESTS,
        toJsonString: (PendingAuthRequest value) {
          return jsonEncode(value.toJson());
        },
        fromJsonString: (String value) {
          return PendingAuthRequest.fromJson(jsonDecode(value));
        },
      ),
      completeRequests: GenericStore(
        core: core,
        context: AuthConstants.CONTEXT_COMPLETE_REQUESTS,
        version: AuthConstants.VERSION_COMPLETE_REQUESTS,
        toJsonString: (StoredCacao value) {
          return jsonEncode(value.toJson());
        },
        fromJsonString: (String value) {
          return StoredCacao.fromJson(jsonDecode(value));
        },
      ),
    );
  }

  @override
  Future<void> init() async {
    if (_initialized) {
      return;
    }

    await core.start();
    await engine.init();

    _initialized = true;
  }

  @override
  Future<AuthRequestResponse> requestAuth({
    required AuthRequestParams params,
    String? pairingTopic,
    List<List<String>>? methods = AuthEngine.DEFAULT_METHODS,
  }) async {
    try {
      return engine.requestAuth(
        params: params,
        pairingTopic: pairingTopic,
        methods: methods,
      );
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<void> respondAuthRequest({
    required int id,
    required String iss,
    CacaoSignature? signature,
    WalletConnectError? error,
  }) async {
    try {
      return engine.respondAuthRequest(
        id: id,
        iss: iss,
        signature: signature,
        error: error,
      );
    } catch (e) {
      rethrow;
    }
  }

  @override
  Map<int, PendingAuthRequest> getPendingAuthRequests() {
    try {
      return engine.getPendingAuthRequests();
    } catch (e) {
      rethrow;
    }
  }

  @override
  String formatAuthMessage({
    required String iss,
    required CacaoRequestPayload cacaoPayload,
  }) {
    try {
      return engine.formatAuthMessage(
        iss: iss,
        cacaoPayload: cacaoPayload,
      );
    } catch (e) {
      rethrow;
    }
  }
}

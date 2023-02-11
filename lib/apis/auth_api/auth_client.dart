import 'dart:convert';

import 'package:event/event.dart';
import 'package:wallet_connect_flutter_v2/apis/auth_api/auth_engine.dart';
import 'package:wallet_connect_flutter_v2/apis/auth_api/i_auth_client.dart';
import 'package:wallet_connect_flutter_v2/apis/auth_api/i_auth_engine.dart';
import 'package:wallet_connect_flutter_v2/apis/auth_api/models/auth_client_events.dart';
import 'package:wallet_connect_flutter_v2/apis/auth_api/stores/generic_store.dart';
import 'package:wallet_connect_flutter_v2/apis/auth_api/stores/i_generic_store.dart';
import 'package:wallet_connect_flutter_v2/apis/auth_api/models/auth_client_models.dart';
import 'package:wallet_connect_flutter_v2/apis/core/i_core.dart';
import 'package:wallet_connect_flutter_v2/apis/models/basic_models.dart';
import 'package:wallet_connect_flutter_v2/apis/core/pairing/utils/pairing_models.dart';

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
  PairingMetadata get metadata => engine.metadata;
  @override
  IGenericStore<AuthPublicKey> get authKeys => engine.authKeys;
  @override
  IGenericStore<PendingAuthRequest> get authRequests => engine.authRequests;
  @override
  IGenericStore<String> get pairingTopics => engine.pairingTopics;

  @override
  final ICore core;
  @override
  late IAuthEngine engine;

  AuthClient(this.core) {
    engine = AuthEngine(
      core: core,
      metadata: metadata,
      authKeys: GenericStore(
        core,
        'authKeys',
        '2.0',
        (AuthPublicKey value) {
          return jsonEncode(value.toJson());
        },
        (String value) {
          return AuthPublicKey.fromJson(jsonDecode(value));
        },
      ),
      pairingTopics: GenericStore(
        core,
        'authPairingTopics',
        '2.0',
        (String value) {
          return value;
        },
        (String value) {
          return value;
        },
      ),
      authRequests: GenericStore(
        core,
        'authRequests',
        '2.0',
        (PendingAuthRequest value) {
          return jsonEncode(value.toJson());
        },
        (String value) {
          return PendingAuthRequest.fromJson(jsonDecode(value));
        },
      ),
      completeRequests: GenericStore(
        core,
        'completedRequests',
        '2.0',
        (StoredCacao value) {
          return jsonEncode(value.toJson());
        },
        (String value) {
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
  }) async {
    try {
      return engine.requestAuth(
        params: params,
        pairingTopic: pairingTopic,
      );
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<void> respond({
    required int id,
    required String iss,
    CacaoSignature? signature,
    WCErrorResponse? error,
  }) async {
    try {
      return engine.respond(
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
  Map<int, PendingAuthRequest> getPendingRequests() {
    try {
      return engine.getPendingRequests();
    } catch (e) {
      rethrow;
    }
  }

  @override
  String formatMessage({
    required String iss,
    required CacaoPayload cacaoPayload,
  }) {
    try {
      return engine.formatMessage(
        iss: iss,
        cacaoPayload: cacaoPayload,
      );
    } catch (e) {
      rethrow;
    }
  }
}

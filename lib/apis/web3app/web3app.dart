import 'dart:convert';

import 'package:event/event.dart';
import 'package:walletconnect_dart_v2/apis/auth_api/auth_engine.dart';
import 'package:walletconnect_dart_v2/apis/auth_api/utils/auth_constants.dart';
import 'package:walletconnect_dart_v2/apis/core/store/generic_store.dart';
import 'package:walletconnect_dart_v2/apis/core/store/i_generic_store.dart';
import 'package:walletconnect_dart_v2/apis/sign_api/i_sessions.dart';
import 'package:walletconnect_dart_v2/apis/sign_api/sign_engine.dart';
import 'package:walletconnect_dart_v2/apis/sign_api/utils/sign_constants.dart';
import 'package:walletconnect_dart_v2/walletconnect_dart_v2.dart';

class Web3App implements IWeb3App {
  bool _initialized = false;

  static Future<Web3App> createInstance({
    required ICore core,
    required PairingMetadata metadata,
  }) async {
    final client = Web3App(
      core: core,
      metadata: metadata,
    );
    await client.init();

    return client;
  }

  ///---------- GENERIC ----------///

  @override
  final String protocol = 'wc';
  @override
  final int version = 2;

  @override
  final ICore core;
  @override
  final PairingMetadata metadata;

  Web3App({
    required this.core,
    required this.metadata,
  }) {
    signEngine = SignEngine(
      core: core,
      metadata: metadata,
      proposals: GenericStore(
        core: core,
        context: SignConstants.CONTEXT_PROPOSALS,
        version: SignConstants.VERSION_PROPOSALS,
        toJsonString: (ProposalData value) {
          return jsonEncode(value.toJson());
        },
        fromJsonString: (String value) {
          return ProposalData.fromJson(jsonDecode(value));
        },
      ),
      sessions: Sessions(core),
      pendingRequests: GenericStore(
        core: core,
        context: SignConstants.CONTEXT_PENDING_REQUESTS,
        version: SignConstants.VERSION_PENDING_REQUESTS,
        toJsonString: (SessionRequest value) {
          return jsonEncode(value.toJson());
        },
        fromJsonString: (String value) {
          return SessionRequest.fromJson(jsonDecode(value));
        },
      ),
    );

    authEngine = AuthEngine(
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
    await signEngine.init();
    await authEngine.init();

    _initialized = true;
  }

  ///---------- SIGN ENGINE ----------///

  @override
  Event<SessionConnect> get onSessionConnect => signEngine.onSessionConnect;
  @override
  Event<SessionEvent> get onSessionEvent => signEngine.onSessionEvent;
  @override
  Event<SessionExpire> get onSessionExpire => signEngine.onSessionExpire;
  @override
  Event<SessionExtend> get onSessionExtend => signEngine.onSessionExtend;
  @override
  Event<SessionPing> get onSessionPing => signEngine.onSessionPing;
  @override
  Event<SessionUpdate> get onSessionUpdate => signEngine.onSessionUpdate;
  @override
  Event<SessionDelete> get onSessionDelete => signEngine.onSessionDelete;

  @override
  IGenericStore<ProposalData> get proposals => signEngine.proposals;
  @override
  ISessions get sessions => signEngine.sessions;
  @override
  IGenericStore<SessionRequest> get pendingRequests =>
      signEngine.pendingRequests;

  @override
  late ISignEngine signEngine;

  @override
  Future<ConnectResponse> connect({
    Map<String, RequiredNamespace>? requiredNamespaces,
    Map<String, RequiredNamespace>? optionalNamespaces,
    Map<String, String>? sessionProperties,
    String? pairingTopic,
    List<Relay>? relays,
  }) async {
    try {
      return await signEngine.connect(
        requiredNamespaces: requiredNamespaces,
        optionalNamespaces: optionalNamespaces,
        sessionProperties: sessionProperties,
        pairingTopic: pairingTopic,
        relays: relays,
      );
    } catch (e) {
      // print(e);
      rethrow;
    }
  }

  @override
  Future request({
    required String topic,
    required String chainId,
    required SessionRequestParams request,
  }) async {
    try {
      return await signEngine.request(
        topic: topic,
        chainId: chainId,
        request: request,
      );
    } catch (e) {
      rethrow;
    }
  }

  @override
  void registerEventHandler({
    required String chainId,
    required String event,
    void Function(String, dynamic)? handler,
  }) {
    try {
      return signEngine.registerEventHandler(
        chainId: chainId,
        event: event,
        handler: handler,
      );
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<void> ping({
    required String topic,
  }) async {
    try {
      return await signEngine.ping(topic: topic);
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<void> disconnectSession({
    required String topic,
    required WalletConnectErrorResponse reason,
  }) async {
    try {
      return await signEngine.disconnectSession(
        topic: topic,
        reason: reason,
      );
    } catch (e) {
      rethrow;
    }
  }

  @override
  Map<String, SessionData> getActiveSessions() {
    try {
      return signEngine.getActiveSessions();
    } catch (e) {
      rethrow;
    }
  }

  @override
  IPairingStore get pairings => core.pairing.getStore();

  ///---------- AUTH ENGINE ----------///
  @override
  Event<AuthResponse> get onAuthResponse => authEngine.onAuthResponse;

  @override
  IGenericStore<AuthPublicKey> get authKeys => authEngine.authKeys;
  @override
  IGenericStore<String> get pairingTopics => authEngine.pairingTopics;
  @override
  IGenericStore<StoredCacao> get completeRequests =>
      authEngine.completeRequests;

  @override
  late IAuthEngine authEngine;

  @override
  Future<AuthRequestResponse> requestAuth({
    required AuthRequestParams params,
    String? pairingTopic,
  }) async {
    try {
      return authEngine.requestAuth(
        params: params,
        pairingTopic: pairingTopic,
      );
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
      return authEngine.formatAuthMessage(
        iss: iss,
        cacaoPayload: cacaoPayload,
      );
    } catch (e) {
      rethrow;
    }
  }
}

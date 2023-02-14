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

class Web3Wallet implements IWeb3Wallet {
  bool _initialized = false;

  static Future<Web3Wallet> createInstance({
    required ICore core,
    required PairingMetadata metadata,
  }) async {
    final client = Web3Wallet(
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

  Web3Wallet({
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

  @override
  Future<PairingInfo> pair({
    required Uri uri,
  }) async {
    try {
      return await signEngine.pair(uri: uri);
    } catch (e) {
      rethrow;
    }
  }

  ///---------- SIGN ENGINE ----------///

  @override
  Event<SessionDelete> get onSessionDelete => signEngine.onSessionDelete;
  @override
  Event<SessionProposalEvent> get onSessionProposal =>
      signEngine.onSessionProposal;
  @override
  Event<SessionRequestEvent> get onSessionRequest =>
      signEngine.onSessionRequest;

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
  Future<ApproveResponse> approveSession({
    required int id,
    required Map<String, Namespace> namespaces,
    String? relayProtocol,
  }) async {
    try {
      return await signEngine.approveSession(
        id: id,
        namespaces: namespaces,
        relayProtocol: relayProtocol,
      );
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<void> rejectSession({
    required int id,
    required WalletConnectErrorResponse reason,
  }) async {
    try {
      return await signEngine.rejectSession(
        id: id,
        reason: reason,
      );
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<void> updateSession({
    required String topic,
    required Map<String, Namespace> namespaces,
  }) async {
    try {
      return await signEngine.updateSession(
        topic: topic,
        namespaces: namespaces,
      );
    } catch (e) {
      // final error = e as WCError;
      rethrow;
    }
  }

  @override
  Future<void> extendSession({
    required String topic,
  }) async {
    try {
      return await signEngine.extendSession(topic: topic);
    } catch (e) {
      rethrow;
    }
  }

  @override
  void registerRequestHandler({
    required String chainId,
    required String method,
    void Function(String, dynamic)? handler,
  }) {
    try {
      return signEngine.registerRequestHandler(
        chainId: chainId,
        method: method,
        handler: handler,
      );
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<void> respondSessionRequest({
    required String topic,
    required JsonRpcResponse response,
  }) {
    try {
      return signEngine.respondSessionRequest(
        topic: topic,
        response: response,
      );
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<void> emitSessionEvent({
    required String topic,
    required String chainId,
    required SessionEventParams event,
  }) async {
    try {
      return await signEngine.emitSessionEvent(
        topic: topic,
        chainId: chainId,
        event: event,
      );
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
  SessionData? find({
    required Map<String, RequiredNamespace> requiredNamespaces,
  }) {
    try {
      return signEngine.find(requiredNamespaces: requiredNamespaces);
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
  Map<String, ProposalData> getPendingSessionProposals() {
    try {
      return signEngine.getPendingSessionProposals();
    } catch (e) {
      rethrow;
    }
  }

  @override
  Map<String, SessionRequest> getPendingSessionRequests() {
    try {
      return signEngine.getPendingSessionRequests();
    } catch (e) {
      rethrow;
    }
  }

  @override
  IPairingStore get pairings => core.pairing.getStore();

  ///---------- AUTH ENGINE ----------///
  @override
  Event<AuthRequest> get onAuthRequest => authEngine.onAuthRequest;

  @override
  IGenericStore<AuthPublicKey> get authKeys => authEngine.authKeys;
  @override
  IGenericStore<String> get pairingTopics => authEngine.pairingTopics;
  @override
  IGenericStore<PendingAuthRequest> get authRequests => authEngine.authRequests;
  @override
  IGenericStore<StoredCacao> get completeRequests =>
      authEngine.completeRequests;

  @override
  late IAuthEngine authEngine;

  @override
  Future<void> respondAuthRequest({
    required int id,
    required String iss,
    CacaoSignature? signature,
    WalletConnectErrorResponse? error,
  }) async {
    try {
      return authEngine.respondAuthRequest(
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
      return authEngine.getPendingAuthRequests();
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

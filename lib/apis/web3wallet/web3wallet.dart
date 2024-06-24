import 'package:walletconnect_flutter_v2/apis/auth_api/auth_engine.dart';
import 'package:walletconnect_flutter_v2/apis/core/relay_client/websocket/http_client.dart';
import 'package:walletconnect_flutter_v2/apis/core/relay_client/websocket/i_http_client.dart';
import 'package:walletconnect_flutter_v2/apis/core/store/generic_store.dart';
import 'package:walletconnect_flutter_v2/apis/core/store/i_generic_store.dart';
import 'package:walletconnect_flutter_v2/apis/sign_api/i_sessions.dart';
import 'package:walletconnect_flutter_v2/apis/sign_api/sign_engine.dart';
import 'package:walletconnect_flutter_v2/walletconnect_flutter_v2.dart';

class Web3Wallet implements IWeb3Wallet {
  bool _initialized = false;

  static Future<Web3Wallet> createInstance({
    required String projectId,
    String relayUrl = WalletConnectConstants.DEFAULT_RELAY_URL,
    String pushUrl = WalletConnectConstants.DEFAULT_PUSH_URL,
    required PairingMetadata metadata,
    bool memoryStore = false,
    LogLevel logLevel = LogLevel.nothing,
    IHttpClient httpClient = const HttpWrapper(),
  }) async {
    final client = Web3Wallet(
      core: Core(
        projectId: projectId,
        relayUrl: relayUrl,
        pushUrl: pushUrl,
        memoryStore: memoryStore,
        logLevel: logLevel,
        httpClient: httpClient,
      ),
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
        storage: core.storage,
        context: StoreVersions.CONTEXT_PROPOSALS,
        version: StoreVersions.VERSION_PROPOSALS,
        fromJson: (dynamic value) {
          return ProposalData.fromJson(value);
        },
      ),
      sessions: Sessions(
        storage: core.storage,
        context: StoreVersions.CONTEXT_SESSIONS,
        version: StoreVersions.VERSION_SESSIONS,
        fromJson: (dynamic value) {
          return SessionData.fromJson(value);
        },
      ),
      pendingRequests: GenericStore(
        storage: core.storage,
        context: StoreVersions.CONTEXT_PENDING_REQUESTS,
        version: StoreVersions.VERSION_PENDING_REQUESTS,
        fromJson: (dynamic value) {
          return SessionRequest.fromJson(value);
        },
      ),
      authKeys: GenericStore(
        storage: core.storage,
        context: StoreVersions.CONTEXT_AUTH_KEYS,
        version: StoreVersions.VERSION_AUTH_KEYS,
        fromJson: (dynamic value) {
          return AuthPublicKey.fromJson(value);
        },
      ),
      pairingTopics: GenericStore(
        storage: core.storage,
        context: StoreVersions.CONTEXT_PAIRING_TOPICS,
        version: StoreVersions.VERSION_PAIRING_TOPICS,
        fromJson: (dynamic value) {
          return value;
        },
      ),
      authRequests: GenericStore(
        storage: core.storage,
        context: StoreVersions.CONTEXT_AUTH_REQUESTS,
        version: StoreVersions.VERSION_AUTH_REQUESTS,
        fromJson: (dynamic value) {
          return PendingAuthRequest.fromJson(value);
        },
      ),
      completeRequests: GenericStore(
        storage: core.storage,
        context: StoreVersions.CONTEXT_COMPLETE_REQUESTS,
        version: StoreVersions.VERSION_COMPLETE_REQUESTS,
        fromJson: (dynamic value) {
          return StoredCacao.fromJson(value);
        },
      ),
      sessionAuthRequests: GenericStore(
        storage: core.storage,
        context: StoreVersions.CONTEXT_AUTH_REQUESTS,
        version: StoreVersions.VERSION_AUTH_REQUESTS,
        fromJson: (dynamic value) {
          return PendingSessionAuthRequest.fromJson(value);
        },
      ),
    );

    authEngine = AuthEngine(
      core: core,
      metadata: metadata,
      authKeys: signEngine.authKeys,
      pairingTopics: signEngine.pairingTopics,
      authRequests: signEngine.authRequests,
      completeRequests: signEngine.completeRequests,
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
  Event<SessionConnect> get onSessionConnect => signEngine.onSessionConnect;
  @override
  Event<SessionDelete> get onSessionDelete => signEngine.onSessionDelete;
  @override
  Event<SessionExpire> get onSessionExpire => signEngine.onSessionExpire;
  @override
  Event<SessionProposalEvent> get onSessionProposal =>
      signEngine.onSessionProposal;
  @override
  Event<SessionProposalErrorEvent> get onSessionProposalError =>
      signEngine.onSessionProposalError;
  @override
  Event<SessionProposalEvent> get onProposalExpire =>
      signEngine.onProposalExpire;
  @override
  Event<SessionRequestEvent> get onSessionRequest =>
      signEngine.onSessionRequest;
  @override
  Event<SessionPing> get onSessionPing => signEngine.onSessionPing;

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
    Map<String, String>? sessionProperties,
    String? relayProtocol,
  }) async {
    try {
      return await signEngine.approveSession(
        id: id,
        namespaces: namespaces,
        sessionProperties: sessionProperties,
        relayProtocol: relayProtocol,
      );
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<void> rejectSession({
    required int id,
    required WalletConnectError reason,
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
    dynamic Function(String, dynamic)? handler,
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
  void registerEventEmitter({
    required String chainId,
    required String event,
  }) {
    try {
      return signEngine.registerEventEmitter(
        chainId: chainId,
        event: event,
      );
    } catch (e) {
      rethrow;
    }
  }

  @override
  void registerAccount({
    required String chainId,
    required String accountAddress,
  }) {
    try {
      return signEngine.registerAccount(
        chainId: chainId,
        accountAddress: accountAddress,
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
    required WalletConnectError reason,
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
  Map<String, SessionData> getSessionsForPairing({
    required String pairingTopic,
  }) {
    try {
      return signEngine.getSessionsForPairing(
        pairingTopic: pairingTopic,
      );
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

  ///---------- (DEPRECATED) AUTH ENGINE ----------///

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

  @Deprecated(
    'AuthEngine/AuthClient is deprecated and will be removed soon.\n'
    'Please use authentication methods from SignEngine/SignClient instead',
  )
  @override
  late IAuthEngine authEngine;

  @override
  Future<void> respondAuthRequest({
    required int id,
    required String iss,
    CacaoSignature? signature,
    WalletConnectError? error,
  }) {
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
  Map<int, StoredCacao> getCompletedRequestsForPairing({
    required String pairingTopic,
  }) {
    try {
      return authEngine.getCompletedRequestsForPairing(
        pairingTopic: pairingTopic,
      );
    } catch (e) {
      rethrow;
    }
  }

  ///---------- ONE-CLICK AUTH SIGN ENGINE ----------///

  @override
  IGenericStore<PendingSessionAuthRequest> get sessionAuthRequests =>
      signEngine.sessionAuthRequests;
  @override
  Event<SessionAuthRequest> get onSessionAuthRequest =>
      signEngine.onSessionAuthRequest;

  @override
  Future<ApproveResponse> approveSessionAuthenticate({
    required int id,
    List<Cacao>? auths,
  }) {
    try {
      return signEngine.approveSessionAuthenticate(
        id: id,
        auths: auths,
      );
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<void> rejectSessionAuthenticate({
    required int id,
    required WalletConnectError reason,
  }) {
    try {
      return signEngine.rejectSessionAuthenticate(
        id: id,
        reason: reason,
      );
    } catch (e) {
      rethrow;
    }
  }

  @override
  Map<int, PendingSessionAuthRequest> getPendingSessionAuthRequests() {
    try {
      return signEngine.getPendingSessionAuthRequests();
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
      return signEngine.formatAuthMessage(
        iss: iss,
        cacaoPayload: cacaoPayload,
      );
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<bool> validateSignedCacao({
    required Cacao cacao,
    required String projectId,
  }) {
    try {
      return signEngine.validateSignedCacao(
        cacao: cacao,
        projectId: projectId,
      );
    } catch (e) {
      rethrow;
    }
  }
}

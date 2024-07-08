import 'package:walletconnect_flutter_v2/apis/core/store/generic_store.dart';
import 'package:walletconnect_flutter_v2/apis/core/store/i_generic_store.dart';
import 'package:walletconnect_flutter_v2/apis/sign_api/i_sessions.dart';
import 'package:walletconnect_flutter_v2/apis/sign_api/sign_engine.dart';
import 'package:walletconnect_flutter_v2/walletconnect_flutter_v2.dart';

class SignClient implements ISignClient {
  bool _initialized = false;

  @override
  final String protocol = 'wc';
  @override
  final int version = 2;

  @override
  Event<SessionDelete> get onSessionDelete => engine.onSessionDelete;
  @override
  Event<SessionConnect> get onSessionConnect => engine.onSessionConnect;
  @override
  Event<SessionEvent> get onSessionEvent => engine.onSessionEvent;
  @override
  Event<SessionExpire> get onSessionExpire => engine.onSessionExpire;
  @override
  Event<SessionExtend> get onSessionExtend => engine.onSessionExtend;
  @override
  Event<SessionPing> get onSessionPing => engine.onSessionPing;
  @override
  Event<SessionProposalEvent> get onSessionProposal => engine.onSessionProposal;
  @override
  Event<SessionProposalErrorEvent> get onSessionProposalError =>
      engine.onSessionProposalError;
  @override
  Event<SessionProposalEvent> get onProposalExpire => engine.onProposalExpire;
  @override
  Event<SessionRequestEvent> get onSessionRequest => engine.onSessionRequest;
  @override
  Event<SessionUpdate> get onSessionUpdate => engine.onSessionUpdate;

  @override
  ICore get core => engine.core;
  @override
  PairingMetadata get metadata => engine.metadata;
  @override
  IGenericStore<ProposalData> get proposals => engine.proposals;
  @override
  ISessions get sessions => engine.sessions;
  @override
  IGenericStore<SessionRequest> get pendingRequests => engine.pendingRequests;

  @override
  late ISignEngine engine;

  static Future<SignClient> createInstance({
    required String projectId,
    String relayUrl = WalletConnectConstants.DEFAULT_RELAY_URL,
    required PairingMetadata metadata,
    bool memoryStore = false,
    LogLevel logLevel = LogLevel.nothing,
  }) async {
    final client = SignClient(
      core: Core(
        projectId: projectId,
        relayUrl: relayUrl,
        memoryStore: memoryStore,
        logLevel: logLevel,
      ),
      metadata: metadata,
    );
    await client.init();

    return client;
  }

  SignClient({
    required ICore core,
    required PairingMetadata metadata,
  }) {
    engine = SignEngine(
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
  Future<ConnectResponse> connect({
    Map<String, RequiredNamespace>? requiredNamespaces,
    Map<String, RequiredNamespace>? optionalNamespaces,
    Map<String, String>? sessionProperties,
    String? pairingTopic,
    List<Relay>? relays,
    List<List<String>>? methods = SignEngine.DEFAULT_METHODS,
  }) async {
    try {
      return await engine.connect(
        requiredNamespaces: requiredNamespaces,
        optionalNamespaces: optionalNamespaces,
        sessionProperties: sessionProperties,
        pairingTopic: pairingTopic,
        relays: relays,
        methods: methods,
      );
    } catch (e) {
      // print(e);
      rethrow;
    }
  }

  @override
  Future<PairingInfo> pair({
    required Uri uri,
  }) async {
    try {
      return await engine.pair(uri: uri);
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<ApproveResponse> approve({
    required int id,
    required Map<String, Namespace> namespaces,
    Map<String, String>? sessionProperties,
    String? relayProtocol,
  }) async {
    try {
      return await engine.approveSession(
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
  Future<void> reject({
    required int id,
    required WalletConnectError reason,
  }) async {
    try {
      return await engine.rejectSession(
        id: id,
        reason: reason,
      );
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<void> update({
    required String topic,
    required Map<String, Namespace> namespaces,
  }) async {
    try {
      return await engine.updateSession(
        topic: topic,
        namespaces: namespaces,
      );
    } catch (e) {
      // final error = e as WCError;
      rethrow;
    }
  }

  @override
  Future<void> extend({
    required String topic,
  }) async {
    try {
      return await engine.extendSession(topic: topic);
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
      return engine.registerRequestHandler(
        chainId: chainId,
        method: method,
        handler: handler,
      );
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<dynamic> request({
    required String topic,
    required String chainId,
    required SessionRequestParams request,
  }) async {
    try {
      return await engine.request(
        topic: topic,
        chainId: chainId,
        request: request,
      );
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<List<dynamic>> requestReadContract({
    required DeployedContract deployedContract,
    required String functionName,
    required String rpcUrl,
    EthereumAddress? sender,
    List parameters = const [],
  }) async {
    try {
      return await engine.requestReadContract(
        sender: sender,
        deployedContract: deployedContract,
        functionName: functionName,
        rpcUrl: rpcUrl,
        parameters: parameters,
      );
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<dynamic> requestWriteContract({
    required String topic,
    required String chainId,
    required String rpcUrl,
    required DeployedContract deployedContract,
    required String functionName,
    required Transaction transaction,
    String? method,
    List parameters = const [],
  }) async {
    try {
      return await engine.requestWriteContract(
        topic: topic,
        chainId: chainId,
        rpcUrl: rpcUrl,
        deployedContract: deployedContract,
        functionName: functionName,
        transaction: transaction,
        method: method,
        parameters: parameters,
      );
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<void> respond({
    required String topic,
    required JsonRpcResponse response,
  }) {
    try {
      return engine.respondSessionRequest(
        topic: topic,
        response: response,
      );
    } catch (e) {
      rethrow;
    }
  }

  @override
  void registerEventHandler({
    required String chainId,
    required String event,
    dynamic Function(String, dynamic)? handler,
  }) {
    try {
      return engine.registerEventHandler(
        chainId: chainId,
        event: event,
        handler: handler,
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
      return engine.registerEventEmitter(
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
      return engine.registerAccount(
        chainId: chainId,
        accountAddress: accountAddress,
      );
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<void> emit({
    required String topic,
    required String chainId,
    required SessionEventParams event,
  }) async {
    try {
      return await engine.emitSessionEvent(
        topic: topic,
        chainId: chainId,
        event: event,
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
      return await engine.ping(topic: topic);
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<void> disconnect({
    required String topic,
    required WalletConnectError reason,
  }) async {
    try {
      return await engine.disconnectSession(
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
      return engine.find(requiredNamespaces: requiredNamespaces);
    } catch (e) {
      rethrow;
    }
  }

  @override
  Map<String, SessionData> getActiveSessions() {
    try {
      return engine.getActiveSessions();
    } catch (e) {
      rethrow;
    }
  }

  @override
  Map<String, SessionData> getSessionsForPairing({
    required String pairingTopic,
  }) {
    try {
      return engine.getSessionsForPairing(
        pairingTopic: pairingTopic,
      );
    } catch (e) {
      rethrow;
    }
  }

  @override
  Map<String, ProposalData> getPendingSessionProposals() {
    try {
      return engine.getPendingSessionProposals();
    } catch (e) {
      rethrow;
    }
  }

  @override
  Map<String, SessionRequest> getPendingSessionRequests() {
    try {
      return engine.getPendingSessionRequests();
    } catch (e) {
      rethrow;
    }
  }

  @override
  IPairingStore get pairings => core.pairing.getStore();

  // FORMER AUTH ENGINE METHODS

  @override
  IGenericStore<PendingAuthRequest> get authRequests => engine.authRequests;

  @override
  Map<int, PendingAuthRequest> getPendingAuthRequests() {
    try {
      return engine.getPendingAuthRequests();
    } catch (e) {
      rethrow;
    }
  }

  @override
  Map<int, PendingSessionAuthRequest> getPendingSessionAuthRequests() {
    try {
      return engine.getPendingSessionAuthRequests();
    } catch (e) {
      rethrow;
    }
  }

  @override
  IGenericStore<PendingSessionAuthRequest> get sessionAuthRequests =>
      engine.sessionAuthRequests;

  @override
  Event<AuthRequest> get onAuthRequest => engine.onAuthRequest;

  @override
  Event<AuthResponse> get onAuthResponse => engine.onAuthResponse;

  // NEW 1-CLICK AUTH METHOD
  @override
  Event<SessionAuthResponse> get onSessionAuthResponse =>
      engine.onSessionAuthResponse;

  @override
  Event<SessionAuthRequest> get onSessionAuthRequest =>
      engine.onSessionAuthRequest;

  @override
  Future<AuthRequestResponse> requestAuth({
    required AuthRequestParams params,
    String? pairingTopic,
    List<List<String>>? methods = SignEngine.DEFAULT_METHODS_AUTH,
  }) {
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

  // NEW ONE-CLICK AUTH METHOD FOR DAPPS
  @override
  Future<SessionAuthRequestResponse> authenticate({
    required SessionAuthRequestParams params,
    String? pairingTopic,
    List<List<String>>? methods = const [
      [MethodConstants.WC_SESSION_AUTHENTICATE]
    ],
  }) {
    try {
      return engine.authenticate(
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
  }) {
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
  Future<ApproveResponse> approveSessionAuthenticate({
    required int id,
    List<Cacao>? auths,
  }) {
    try {
      return engine.approveSessionAuthenticate(
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
      return engine.rejectSessionAuthenticate(
        id: id,
        reason: reason,
      );
    } catch (e) {
      rethrow;
    }
  }

  @override
  IGenericStore<AuthPublicKey> get authKeys => engine.authKeys;

  @override
  IGenericStore<StoredCacao> get completeRequests => engine.completeRequests;

  @override
  Future<bool> validateSignedCacao({
    required Cacao cacao,
    required String projectId,
  }) {
    try {
      return engine.validateSignedCacao(
        cacao: cacao,
        projectId: projectId,
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
      return engine.formatAuthMessage(
        iss: iss,
        cacaoPayload: cacaoPayload,
      );
    } catch (e) {
      rethrow;
    }
  }

  @override
  Map<int, StoredCacao> getCompletedRequestsForPairing({
    required String pairingTopic,
  }) {
    try {
      return engine.getCompletedRequestsForPairing(
        pairingTopic: pairingTopic,
      );
    } catch (e) {
      rethrow;
    }
  }

  @override
  IGenericStore<String> get pairingTopics => engine.pairingTopics;
}

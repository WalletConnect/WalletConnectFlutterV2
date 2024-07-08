import 'package:walletconnect_flutter_v2/apis/core/relay_client/websocket/http_client.dart';
import 'package:walletconnect_flutter_v2/apis/core/relay_client/websocket/i_http_client.dart';
import 'package:walletconnect_flutter_v2/apis/core/store/i_generic_store.dart';
import 'package:walletconnect_flutter_v2/apis/sign_api/i_sessions.dart';
import 'package:walletconnect_flutter_v2/apis/sign_api/sign_engine.dart';
import 'package:walletconnect_flutter_v2/walletconnect_flutter_v2.dart';

class SignClientTestWrapper implements ISignEngine {
  bool _initialized = false;

  @override
  Event<SessionDelete> get onSessionDelete => client.onSessionDelete;
  @override
  Event<SessionConnect> get onSessionConnect => client.onSessionConnect;
  @override
  Event<SessionEvent> get onSessionEvent => client.onSessionEvent;
  @override
  Event<SessionExpire> get onSessionExpire => client.onSessionExpire;
  @override
  Event<SessionExtend> get onSessionExtend => client.onSessionExtend;
  @override
  Event<SessionPing> get onSessionPing => client.onSessionPing;
  @override
  Event<SessionProposalEvent> get onSessionProposal => client.onSessionProposal;
  @override
  Event<SessionProposalErrorEvent> get onSessionProposalError =>
      client.onSessionProposalError;
  @override
  Event<SessionProposalEvent> get onProposalExpire => client.onProposalExpire;
  @override
  Event<SessionRequestEvent> get onSessionRequest => client.onSessionRequest;
  @override
  Event<SessionUpdate> get onSessionUpdate => client.onSessionUpdate;

  @override
  ICore get core => client.core;
  @override
  PairingMetadata get metadata => client.metadata;
  @override
  IGenericStore<ProposalData> get proposals => client.proposals;
  @override
  ISessions get sessions => client.sessions;
  @override
  IGenericStore<SessionRequest> get pendingRequests => client.pendingRequests;

  late ISignClient client;

  static Future<SignClientTestWrapper> createInstance({
    required String projectId,
    String relayUrl = WalletConnectConstants.DEFAULT_RELAY_URL,
    required PairingMetadata metadata,
    bool memoryStore = false,
    Level logLevel = Level.off,
    IHttpClient httpClient = const HttpWrapper(),
  }) async {
    final client = SignClientTestWrapper(
      core: Core(
        projectId: projectId,
        relayUrl: relayUrl,
        memoryStore: memoryStore,
        httpClient: httpClient,
      ),
      metadata: metadata,
    );
    await client.init();

    return client;
  }

  SignClientTestWrapper({
    required ICore core,
    required PairingMetadata metadata,
  }) {
    client = SignClient(
      core: core,
      metadata: metadata,
    );
  }

  @override
  Future<void> init() async {
    if (_initialized) {
      return;
    }

    await core.start();
    await client.init();

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
      return await client.connect(
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
      return await client.pair(uri: uri);
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<ApproveResponse> approveSession({
    required int id,
    required Map<String, Namespace> namespaces,
    Map<String, String>? sessionProperties,
    String? relayProtocol,
  }) async {
    try {
      return await client.approve(
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
    required WalletConnectError reason,
  }) async {
    try {
      return await client.reject(
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
      return await client.update(
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
      return await client.extend(topic: topic);
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
      return client.registerRequestHandler(
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
      return await client.request(
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
      return await client.requestReadContract(
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
      return await client.requestWriteContract(
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
  Future<void> respondSessionRequest({
    required String topic,
    required JsonRpcResponse response,
  }) {
    try {
      return client.respond(
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
      return client.registerEventHandler(
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
      return client.registerEventEmitter(
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
      return client.registerAccount(
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
      return await client.emit(
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
      return await client.ping(topic: topic);
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
      return await client.disconnect(
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
      return client.find(requiredNamespaces: requiredNamespaces);
    } catch (e) {
      rethrow;
    }
  }

  @override
  Map<String, SessionData> getActiveSessions() {
    try {
      return client.getActiveSessions();
    } catch (e) {
      rethrow;
    }
  }

  @override
  Map<String, SessionData> getSessionsForPairing({
    required String pairingTopic,
  }) {
    try {
      return client.getSessionsForPairing(
        pairingTopic: pairingTopic,
      );
    } catch (e) {
      rethrow;
    }
  }

  @override
  Map<String, ProposalData> getPendingSessionProposals() {
    try {
      return client.getPendingSessionProposals();
    } catch (e) {
      rethrow;
    }
  }

  @override
  Map<String, SessionRequest> getPendingSessionRequests() {
    try {
      return client.getPendingSessionRequests();
    } catch (e) {
      rethrow;
    }
  }

  @override
  IPairingStore get pairings => core.pairing.getStore();

  @override
  Future<void> checkAndExpire() async {
    for (var session in sessions.getAll()) {
      await core.expirer.checkAndExpire(session.topic);
    }
  }

  @override
  IGenericStore<AuthPublicKey> get authKeys => client.authKeys;

  @override
  IGenericStore<PendingAuthRequest> get authRequests => client.authRequests;

  @override
  IGenericStore<StoredCacao> get completeRequests => client.completeRequests;

  @override
  Future<bool> validateSignedCacao({
    required Cacao cacao,
    required String projectId,
  }) {
    try {
      return client.validateSignedCacao(
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
      return client.formatAuthMessage(
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
      return client.getCompletedRequestsForPairing(
        pairingTopic: pairingTopic,
      );
    } catch (e) {
      rethrow;
    }
  }

  @override
  Map<int, PendingAuthRequest> getPendingAuthRequests() {
    try {
      return client.getPendingAuthRequests();
    } catch (e) {
      rethrow;
    }
  }

  @override
  Event<AuthRequest> get onAuthRequest => client.onAuthRequest;

  @override
  Event<AuthResponse> get onAuthResponse => client.onAuthResponse;

  @override
  Event<SessionAuthResponse> get onSessionAuthResponse =>
      client.onSessionAuthResponse;

  @override
  IGenericStore<String> get pairingTopics => client.pairingTopics;

  @override
  IGenericStore<PendingSessionAuthRequest> get sessionAuthRequests =>
      client.sessionAuthRequests;

  @override
  Event<SessionAuthRequest> get onSessionAuthRequest =>
      client.onSessionAuthRequest;

  @override
  Future<AuthRequestResponse> requestAuth({
    required AuthRequestParams params,
    String? pairingTopic,
    List<List<String>>? methods,
  }) async {
    try {
      return await client.requestAuth(
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
    List<List<String>>? methods,
  }) async {
    try {
      return await client.authenticate(
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
      return await client.respondAuthRequest(
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
  }) async {
    try {
      return await client.approveSessionAuthenticate(
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
  }) async {
    try {
      return await client.rejectSessionAuthenticate(
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
      return client.getPendingSessionAuthRequests();
    } catch (e) {
      rethrow;
    }
  }
}

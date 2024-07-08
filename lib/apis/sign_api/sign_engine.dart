import 'dart:async';
import 'dart:convert';
import 'dart:math';

import 'package:http/http.dart' as http;
import 'package:walletconnect_flutter_v2/apis/core/pairing/utils/json_rpc_utils.dart';
import 'package:walletconnect_flutter_v2/apis/core/store/i_generic_store.dart';
import 'package:walletconnect_flutter_v2/apis/sign_api/i_sessions.dart';
import 'package:walletconnect_flutter_v2/apis/sign_api/utils/custom_credentials.dart';
import 'package:walletconnect_flutter_v2/apis/sign_api/utils/sign_api_validator_utils.dart';
import 'package:walletconnect_flutter_v2/walletconnect_flutter_v2.dart';
import 'package:walletconnect_flutter_v2/apis/sign_api/utils/auth/recaps_utils.dart';
import 'package:walletconnect_flutter_v2/apis/core/crypto/crypto_models.dart';
import 'package:walletconnect_flutter_v2/apis/sign_api/utils/auth/auth_constants.dart';

class SignEngine implements ISignEngine {
  static const List<List<String>> DEFAULT_METHODS = [
    [
      MethodConstants.WC_SESSION_PROPOSE,
      MethodConstants.WC_SESSION_REQUEST,
    ],
  ];

  static const List<List<String>> DEFAULT_METHODS_AUTH = [
    [
      MethodConstants.WC_AUTH_REQUEST,
    ]
  ];

  bool _initialized = false;

  @override
  final Event<SessionConnect> onSessionConnect = Event<SessionConnect>();
  @override
  final Event<SessionProposalEvent> onSessionProposal =
      Event<SessionProposalEvent>();
  @override
  final Event<SessionProposalErrorEvent> onSessionProposalError =
      Event<SessionProposalErrorEvent>();
  @override
  final Event<SessionProposalEvent> onProposalExpire =
      Event<SessionProposalEvent>();
  @override
  final Event<SessionUpdate> onSessionUpdate = Event<SessionUpdate>();
  @override
  final Event<SessionExtend> onSessionExtend = Event<SessionExtend>();
  @override
  final Event<SessionExpire> onSessionExpire = Event<SessionExpire>();
  @override
  final Event<SessionRequestEvent> onSessionRequest =
      Event<SessionRequestEvent>();
  @override
  final Event<SessionEvent> onSessionEvent = Event<SessionEvent>();
  @override
  final Event<SessionPing> onSessionPing = Event<SessionPing>();
  @override
  final Event<SessionDelete> onSessionDelete = Event<SessionDelete>();

  @override
  final ICore core;
  @override
  final PairingMetadata metadata;
  @override
  final IGenericStore<ProposalData> proposals;
  @override
  final ISessions sessions;
  @override
  final IGenericStore<SessionRequest> pendingRequests;

  List<SessionProposalCompleter> pendingProposals = [];

  // FORMER AUTH ENGINE PROPERTY
  @override
  late IGenericStore<AuthPublicKey> authKeys;
  @override
  late IGenericStore<PendingAuthRequest> authRequests;
  @override
  IGenericStore<StoredCacao> completeRequests;
  @override
  final Event<AuthRequest> onAuthRequest = Event<AuthRequest>();
  @override
  final Event<AuthResponse> onAuthResponse = Event<AuthResponse>();
  @override
  late IGenericStore<String> pairingTopics;

  // NEW 1-CA METHOD
  @override
  late IGenericStore<PendingSessionAuthRequest> sessionAuthRequests;
  @override
  final Event<SessionAuthRequest> onSessionAuthRequest =
      Event<SessionAuthRequest>();
  @override
  final Event<SessionAuthResponse> onSessionAuthResponse =
      Event<SessionAuthResponse>();

  // FORMER AUTH ENGINE PROPERTY (apparently not used before and not used now)
  List<AuthRequestCompleter> pendingAuthRequests = [];

  SignEngine({
    required this.core,
    required this.metadata,
    required this.proposals,
    required this.sessions,
    required this.pendingRequests,
    // FORMER AUTH ENGINE PROPERTIES
    required this.authKeys,
    required this.pairingTopics,
    required this.authRequests,
    required this.completeRequests,
    // NEW 1-CA PROPERTY
    required this.sessionAuthRequests,
  });

  @override
  Future<void> init() async {
    if (_initialized) {
      return;
    }

    await core.pairing.init();
    await core.verify.init(verifyUrl: metadata.verifyUrl);
    await proposals.init();
    await sessions.init();
    await pendingRequests.init();

    // FORMER AUTH ENGINE PROPERTIES
    await authKeys.init();
    await pairingTopics.init();
    await authRequests.init();
    await completeRequests.init();
    // NEW 1-CA PROPERTY
    await sessionAuthRequests.init();

    _registerInternalEvents();
    _registerRelayClientFunctions();
    await _cleanup();

    await _resubscribeAll();

    _initialized = true;
  }

  @override
  Future<void> checkAndExpire() async {
    for (var session in sessions.getAll()) {
      await core.expirer.checkAndExpire(session.topic);
    }
  }

  @override
  Future<ConnectResponse> connect({
    Map<String, RequiredNamespace>? requiredNamespaces,
    Map<String, RequiredNamespace>? optionalNamespaces,
    Map<String, String>? sessionProperties,
    String? pairingTopic,
    List<Relay>? relays,
    List<List<String>>? methods = DEFAULT_METHODS,
  }) async {
    _checkInitialized();

    await _isValidConnect(
      requiredNamespaces: requiredNamespaces ?? {},
      optionalNamespaces: optionalNamespaces ?? {},
      sessionProperties: sessionProperties,
      pairingTopic: pairingTopic,
      relays: relays,
    );
    String? pTopic = pairingTopic;
    Uri? uri;

    if (pTopic == null) {
      final CreateResponse newTopicAndUri = await core.pairing.create(
        methods: methods,
      );
      pTopic = newTopicAndUri.topic;
      uri = newTopicAndUri.uri;
      // print('connect generated topic: $topic');
    } else {
      core.pairing.isValidPairingTopic(topic: pTopic);
    }

    final publicKey = await core.crypto.generateKeyPair();
    final int id = JsonRpcUtils.payloadId();

    final request = WcSessionProposeRequest(
      relays:
          relays ?? [Relay(WalletConnectConstants.RELAYER_DEFAULT_PROTOCOL)],
      requiredNamespaces: requiredNamespaces ?? {},
      optionalNamespaces: optionalNamespaces ?? {},
      proposer: ConnectionMetadata(
        publicKey: publicKey,
        metadata: metadata,
      ),
      sessionProperties: sessionProperties,
    );

    final expiry = WalletConnectUtils.calculateExpiry(
      WalletConnectConstants.FIVE_MINUTES,
    );
    final ProposalData proposal = ProposalData(
      id: id,
      expiry: expiry,
      relays: request.relays,
      proposer: request.proposer,
      requiredNamespaces: request.requiredNamespaces,
      optionalNamespaces: request.optionalNamespaces ?? {},
      sessionProperties: request.sessionProperties,
      pairingTopic: pTopic,
    );
    await _setProposal(
      id,
      proposal,
    );

    Completer<SessionData> completer = Completer();

    pendingProposals.add(
      SessionProposalCompleter(
        id: id,
        selfPublicKey: publicKey,
        pairingTopic: pTopic,
        requiredNamespaces: request.requiredNamespaces,
        optionalNamespaces: request.optionalNamespaces ?? {},
        sessionProperties: request.sessionProperties,
        completer: completer,
      ),
    );
    _connectResponseHandler(
      pTopic,
      request,
      id,
    );

    final ConnectResponse resp = ConnectResponse(
      pairingTopic: pTopic,
      session: completer,
      uri: uri,
    );

    return resp;
  }

  Future<void> _connectResponseHandler(
    String topic,
    WcSessionProposeRequest request,
    int requestId,
  ) async {
    // print("sending proposal for $topic");
    // print('connectResponseHandler requestId: $requestId');
    try {
      final Map<String, dynamic> response = await core.pairing.sendRequest(
        topic,
        MethodConstants.WC_SESSION_PROPOSE,
        request.toJson(),
        id: requestId,
      );
      final String peerPublicKey = response['responderPublicKey'];

      final ProposalData proposal = proposals.get(
        requestId.toString(),
      )!;
      final String sessionTopic = await core.crypto.generateSharedKey(
        proposal.proposer.publicKey,
        peerPublicKey,
      );
      // print('connectResponseHandler session topic: $sessionTopic');

      // Delete the proposal, we are done with it
      await _deleteProposal(requestId);

      await core.relayClient.subscribe(topic: sessionTopic);
      await core.pairing.activate(topic: topic);
    } catch (e) {
      // Get the completer and finish it with an error
      pendingProposals.removeLast().completer.completeError(e);
    }
  }

  @override
  Future<PairingInfo> pair({
    required Uri uri,
  }) async {
    _checkInitialized();

    return await core.pairing.pair(
      uri: uri,
    );
  }

  /// Approves a proposal with the id provided in the parameters.
  /// Assumes the proposal is already created.
  @override
  Future<ApproveResponse> approveSession({
    required int id,
    required Map<String, Namespace> namespaces,
    Map<String, String>? sessionProperties,
    String? relayProtocol,
  }) async {
    // print('sign approveSession');
    _checkInitialized();

    await _isValidApprove(
      id: id,
      namespaces: namespaces,
      sessionProperties: sessionProperties,
      relayProtocol: relayProtocol,
    );

    final ProposalData proposal = proposals.get(
      id.toString(),
    )!;

    final String selfPubKey = await core.crypto.generateKeyPair();
    final String peerPubKey = proposal.proposer.publicKey;
    final String sessionTopic = await core.crypto.generateSharedKey(
      selfPubKey,
      peerPubKey,
    );
    // print('approve session topic: $sessionTopic');
    final protocol =
        relayProtocol ?? WalletConnectConstants.RELAYER_DEFAULT_PROTOCOL;
    final relay = Relay(protocol);

    // Respond to the proposal
    await core.pairing.sendResult(
      id,
      proposal.pairingTopic,
      MethodConstants.WC_SESSION_PROPOSE,
      WcSessionProposeResponse(
        relay: relay,
        responderPublicKey: selfPubKey,
      ),
    );
    await _deleteProposal(id);
    await core.pairing.activate(topic: proposal.pairingTopic);

    await core.pairing.updateMetadata(
      topic: proposal.pairingTopic,
      metadata: proposal.proposer.metadata,
    );

    await core.relayClient.subscribe(topic: sessionTopic);

    final int expiry = WalletConnectUtils.calculateExpiry(
      WalletConnectConstants.SEVEN_DAYS,
    );

    SessionData session = SessionData(
      topic: sessionTopic,
      pairingTopic: proposal.pairingTopic,
      relay: relay,
      expiry: expiry,
      acknowledged: false,
      controller: selfPubKey,
      namespaces: namespaces,
      self: ConnectionMetadata(
        publicKey: selfPubKey,
        metadata: metadata,
      ),
      peer: proposal.proposer,
      sessionProperties: proposal.sessionProperties,
    );

    onSessionConnect.broadcast(SessionConnect(session));

    await sessions.set(sessionTopic, session);
    await _setSessionExpiry(sessionTopic, expiry);

    // `wc_sessionSettle` is not critical throughout the entire session.
    bool acknowledged = await core.pairing
        .sendRequest(
          sessionTopic,
          MethodConstants.WC_SESSION_SETTLE,
          WcSessionSettleRequest(
            relay: relay,
            namespaces: namespaces,
            sessionProperties: sessionProperties,
            expiry: expiry,
            controller: ConnectionMetadata(
              publicKey: selfPubKey,
              metadata: metadata,
            ),
          ),
        )
        // Sometimes we don't receive any response for a long time,
        // in which case we manually time out to prevent waiting indefinitely.
        .timeout(const Duration(seconds: 15))
        .catchError(
      (_) {
        return false;
      },
    );

    session = session.copyWith(
      acknowledged: acknowledged,
    );

    if (acknowledged && sessions.has(sessionTopic)) {
      // We directly update the latest value.
      await sessions.set(
        sessionTopic,
        session,
      );
    }

    return ApproveResponse(
      topic: sessionTopic,
      session: session,
    );
  }

  @override
  Future<void> rejectSession({
    required int id,
    required WalletConnectError reason,
  }) async {
    _checkInitialized();

    await _isValidReject(id, reason);

    ProposalData? proposal = proposals.get(id.toString());
    if (proposal != null) {
      // Attempt to send a response, if the pairing is not active, this will fail
      // but we don't care
      try {
        final method = MethodConstants.WC_SESSION_PROPOSE;
        final rpcOpts = MethodConstants.RPC_OPTS[method];
        await core.pairing.sendError(
          id,
          proposal.pairingTopic,
          method,
          JsonRpcError(code: reason.code, message: reason.message),
          rpcOptions: rpcOpts?['reject'],
        );
      } catch (_) {
        // print('got here');
      }
    }
    await _deleteProposal(id);
  }

  @override
  Future<void> updateSession({
    required String topic,
    required Map<String, Namespace> namespaces,
  }) async {
    _checkInitialized();
    await _isValidUpdate(
      topic,
      namespaces,
    );

    await sessions.update(
      topic,
      namespaces: namespaces,
    );

    await core.pairing.sendRequest(
      topic,
      MethodConstants.WC_SESSION_UPDATE,
      WcSessionUpdateRequest(namespaces: namespaces),
    );
  }

  @override
  Future<void> extendSession({
    required String topic,
  }) async {
    _checkInitialized();
    await _isValidSessionTopic(topic);

    await core.pairing.sendRequest(
      topic,
      MethodConstants.WC_SESSION_EXTEND,
      {},
    );

    await _setSessionExpiry(
      topic,
      WalletConnectUtils.calculateExpiry(
        WalletConnectConstants.SEVEN_DAYS,
      ),
    );
  }

  /// Maps a request using chainId:method to its handler
  final Map<String, dynamic Function(String, dynamic)?> _methodHandlers = {};

  @override
  void registerRequestHandler({
    required String chainId,
    required String method,
    dynamic Function(String, dynamic)? handler,
  }) {
    _methodHandlers[_getRegisterKey(chainId, method)] = handler;
  }

  @override
  Future request({
    required String topic,
    required String chainId,
    required SessionRequestParams request,
  }) async {
    _checkInitialized();
    await _isValidRequest(
      topic,
      chainId,
      request,
    );
    return await core.pairing.sendRequest(
      topic,
      MethodConstants.WC_SESSION_REQUEST,
      WcSessionRequestRequest(
        chainId: chainId,
        request: request,
      ),
    );
  }

  @override
  Future<List<dynamic>> requestReadContract({
    required DeployedContract deployedContract,
    required String functionName,
    required String rpcUrl,
    EthereumAddress? sender,
    List<dynamic> parameters = const [],
  }) async {
    try {
      final results = await Web3Client(rpcUrl, http.Client()).call(
        sender: sender,
        contract: deployedContract,
        function: deployedContract.function(functionName),
        params: parameters,
      );

      return results;
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
    List<dynamic> parameters = const [],
  }) async {
    if (transaction.from == null) {
      throw Exception('Transaction must include `from` value');
    }
    final credentials = CustomCredentials(
      signEngine: this,
      topic: topic,
      chainId: chainId,
      address: transaction.from!,
      method: method,
    );
    final trx = Transaction.callContract(
      contract: deployedContract,
      function: deployedContract.function(functionName),
      from: credentials.address,
      value: transaction.value,
      maxGas: transaction.maxGas,
      gasPrice: transaction.gasPrice,
      nonce: transaction.nonce,
      maxFeePerGas: transaction.maxFeePerGas,
      maxPriorityFeePerGas: transaction.maxPriorityFeePerGas,
      parameters: parameters,
    );

    if (chainId.contains(':')) {
      chainId = chainId.split(':').last;
    }
    return await Web3Client(rpcUrl, http.Client()).sendTransaction(
      credentials,
      trx,
      chainId: int.parse(chainId),
    );
  }

  @override
  Future<void> respondSessionRequest({
    required String topic,
    required JsonRpcResponse response,
  }) async {
    _checkInitialized();
    await _isValidResponse(topic, response);

    // final SessionRequest req = pendingRequests.get(response.id.toString())!;
    // print('respondSessionRequest: ${req.toJson()}');
    if (response.result != null) {
      await core.pairing.sendResult(
        response.id,
        topic,
        MethodConstants.WC_SESSION_REQUEST,
        response.result,
      );
    } else {
      await core.pairing.sendError(
        response.id,
        topic,
        MethodConstants.WC_SESSION_REQUEST,
        response.error!,
      );
    }

    await _deletePendingRequest(response.id);
  }

  /// Maps a request using chainId:event to its handler
  final Map<String, dynamic Function(String, dynamic)?> _eventHandlers = {};

  @override
  void registerEventHandler({
    required String chainId,
    required String event,
    dynamic Function(String, dynamic)? handler,
  }) {
    _checkInitialized();
    _eventHandlers[_getRegisterKey(chainId, event)] = handler;
  }

  @override
  Future<void> emitSessionEvent({
    required String topic,
    required String chainId,
    required SessionEventParams event,
  }) async {
    _checkInitialized();
    await _isValidEmit(
      topic,
      event,
      chainId,
    );
    await core.pairing.sendRequest(
      topic,
      MethodConstants.WC_SESSION_EVENT,
      WcSessionEventRequest(
        chainId: chainId,
        event: event,
      ),
    );
  }

  @override
  Future<void> ping({
    required String topic,
  }) async {
    _checkInitialized();
    await _isValidPing(topic);

    if (sessions.has(topic)) {
      bool _ = await core.pairing.sendRequest(
        topic,
        MethodConstants.WC_SESSION_PING,
        {},
      );
    } else if (core.pairing.getStore().has(topic)) {
      await core.pairing.ping(topic: topic);
    }
  }

  @override
  Future<void> disconnectSession({
    required String topic,
    required WalletConnectError reason,
  }) async {
    _checkInitialized();
    try {
      await _isValidDisconnect(topic);

      if (sessions.has(topic)) {
        // Send the request to delete the session, we don't care if it fails
        try {
          core.pairing.sendRequest(
            topic,
            MethodConstants.WC_SESSION_DELETE,
            WcSessionDeleteRequest(
              code: reason.code,
              message: reason.message,
              data: reason.data,
            ),
          );
        } catch (_) {}

        await _deleteSession(topic);
      } else {
        await core.pairing.disconnect(topic: topic);
      }
    } on WalletConnectError catch (error, s) {
      core.logger.e(
        '[$runtimeType] disconnectSession()',
        error: error,
        stackTrace: s,
      );
    }
  }

  @override
  SessionData? find({
    required Map<String, RequiredNamespace> requiredNamespaces,
  }) {
    _checkInitialized();
    final compatible = sessions.getAll().where((element) {
      return SignApiValidatorUtils.isSessionCompatible(
        session: element,
        requiredNamespaces: requiredNamespaces,
      );
    });

    return compatible.isNotEmpty ? compatible.first : null;
  }

  @override
  Map<String, SessionData> getActiveSessions() {
    _checkInitialized();

    Map<String, SessionData> activeSessions = {};
    sessions.getAll().forEach((session) {
      activeSessions[session.topic] = session;
    });

    return activeSessions;
  }

  @override
  Map<String, SessionData> getSessionsForPairing({
    required String pairingTopic,
  }) {
    _checkInitialized();

    Map<String, SessionData> pairingSessions = {};
    sessions
        .getAll()
        .where((session) => session.pairingTopic == pairingTopic)
        .forEach((session) {
      pairingSessions[session.topic] = session;
    });

    return pairingSessions;
  }

  @override
  Map<String, ProposalData> getPendingSessionProposals() {
    _checkInitialized();

    Map<String, ProposalData> pendingProposals = {};
    proposals.getAll().forEach((proposal) {
      pendingProposals[proposal.id.toString()] = proposal;
    });

    return pendingProposals;
  }

  @override
  Map<String, SessionRequest> getPendingSessionRequests() {
    _checkInitialized();

    Map<String, SessionRequest> requests = {};
    pendingRequests.getAll().forEach((r) {
      requests[r.id.toString()] = r;
    });

    return requests;
  }

  @override
  IPairingStore get pairings => core.pairing.getStore();

  final Set<String> _eventEmitters = {};
  final Set<String> _accounts = {};

  @override
  void registerEventEmitter({
    required String chainId,
    required String event,
  }) {
    final bool isChainId = NamespaceUtils.isValidChainId(chainId);
    if (!isChainId) {
      throw Errors.getSdkError(
        Errors.UNSUPPORTED_CHAINS,
        context:
            'registerEventEmitter, chain $chainId should conform to "namespace:chainId" format',
      );
    }
    final String value = _getRegisterKey(chainId, event);
    SignApiValidatorUtils.isValidAccounts(
      accounts: [value],
      context: 'registerEventEmitter',
    );
    _eventEmitters.add(value);
  }

  @override
  void registerAccount({
    required String chainId,
    required String accountAddress,
  }) {
    final bool isChainId = NamespaceUtils.isValidChainId(chainId);
    if (!isChainId) {
      throw Errors.getSdkError(
        Errors.UNSUPPORTED_CHAINS,
        context:
            'registerAccount, chain $chainId should conform to "namespace:chainId" format',
      );
    }
    final String value = _getRegisterKey(chainId, accountAddress);
    SignApiValidatorUtils.isValidAccounts(
      accounts: [value],
      context: 'registerAccount',
    );
    _accounts.add(value);
  }

  /// ---- PRIVATE HELPERS ---- ////

  Future<void> _resubscribeAll() async {
    // If the relay is not connected, stop here
    if (!core.relayClient.isConnected) {
      return;
    }

    // Subscribe to all the sessions
    for (final SessionData session in sessions.getAll()) {
      // print('Session: subscribing to ${session.topic}');
      await core.relayClient.subscribe(topic: session.topic);
    }
  }

  void _checkInitialized() {
    if (!_initialized) {
      throw Errors.getInternalError(Errors.NOT_INITIALIZED);
    }
  }

  String _getRegisterKey(String chainId, String value) {
    return '$chainId:$value';
  }

  Future<void> _deleteSession(
    String topic, {
    bool expirerHasDeleted = false,
  }) async {
    // print('deleting session: $topic, expirerHasDeleted: $expirerHasDeleted');
    final SessionData? session = sessions.get(topic);
    if (session == null) {
      return;
    }
    await core.relayClient.unsubscribe(topic: topic);

    await sessions.delete(topic);
    await core.crypto.deleteKeyPair(session.self.publicKey);
    await core.crypto.deleteSymKey(topic);
    if (expirerHasDeleted) {
      await core.expirer.delete(topic);
    }

    onSessionDelete.broadcast(
      SessionDelete(
        topic,
      ),
    );
  }

  Future<void> _deleteProposal(
    int id, {
    bool expirerHasDeleted = false,
  }) async {
    await proposals.delete(id.toString());
    if (expirerHasDeleted) {
      await core.expirer.delete(id.toString());
    }
  }

  Future<void> _deletePendingRequest(
    int id, {
    bool expirerHasDeleted = false,
  }) async {
    await pendingRequests.delete(id.toString());
    if (expirerHasDeleted) {
      await core.expirer.delete(id.toString());
    }
  }

  Future<void> _setSessionExpiry(String topic, int expiry) async {
    if (sessions.has(topic)) {
      await sessions.update(
        topic,
        expiry: expiry,
      );
    }
    await core.expirer.set(topic, expiry);
  }

  Future<void> _setProposal(int id, ProposalData proposal) async {
    await proposals.set(id.toString(), proposal);
    core.expirer.set(id.toString(), proposal.expiry);
  }

  Future<void> _setPendingRequest(int id, SessionRequest request) async {
    await pendingRequests.set(
      id.toString(),
      request,
    );
    core.expirer.set(
      id.toString(),
      WalletConnectUtils.calculateExpiry(
        WalletConnectConstants.FIVE_MINUTES,
      ),
    );
  }

  Future<void> _cleanup() async {
    final List<String> sessionTopics = [];
    final List<int> proposalIds = [];

    for (final SessionData session in sessions.getAll()) {
      if (WalletConnectUtils.isExpired(session.expiry)) {
        sessionTopics.add(session.topic);
      }
    }
    for (final ProposalData proposal in proposals.getAll()) {
      if (WalletConnectUtils.isExpired(proposal.expiry)) {
        proposalIds.add(proposal.id);
      }
    }

    sessionTopics.map((topic) async {
      // print('deleting expired session $topic');
      await _deleteSession(topic);
    });
    proposalIds.map((id) async => await _deleteProposal(id));
  }

  /// ---- Relay Events ---- ///

  void _registerRelayClientFunctions() {
    core.pairing.register(
      method: MethodConstants.WC_SESSION_PROPOSE,
      function: _onSessionProposeRequest,
      type: ProtocolType.sign,
    );
    core.pairing.register(
      method: MethodConstants.WC_SESSION_SETTLE,
      function: _onSessionSettleRequest,
      type: ProtocolType.sign,
    );
    core.pairing.register(
      method: MethodConstants.WC_SESSION_UPDATE,
      function: _onSessionUpdateRequest,
      type: ProtocolType.sign,
    );
    core.pairing.register(
      method: MethodConstants.WC_SESSION_EXTEND,
      function: _onSessionExtendRequest,
      type: ProtocolType.sign,
    );
    core.pairing.register(
      method: MethodConstants.WC_SESSION_PING,
      function: _onSessionPingRequest,
      type: ProtocolType.sign,
    );
    core.pairing.register(
      method: MethodConstants.WC_SESSION_DELETE,
      function: _onSessionDeleteRequest,
      type: ProtocolType.sign,
    );
    core.pairing.register(
      method: MethodConstants.WC_SESSION_REQUEST,
      function: _onSessionRequest,
      type: ProtocolType.sign,
    );
    core.pairing.register(
      method: MethodConstants.WC_SESSION_EVENT,
      function: _onSessionEventRequest,
      type: ProtocolType.sign,
    );
    // FORMER AUTH ENGINE PROPERTY
    core.pairing.register(
      method: MethodConstants.WC_AUTH_REQUEST,
      function: _onAuthRequest,
      type: ProtocolType.sign,
    );
    core.pairing.register(
      method: MethodConstants.WC_SESSION_AUTHENTICATE,
      function: _onSessionAuthRequest,
      type: ProtocolType.sign,
    );
  }

  bool _shouldIgnoreSessionPropose(String topic) {
    final PairingInfo? pairingInfo = core.pairing.getPairing(topic: topic);
    final implementSessionAuth = onSessionAuthRequest.subscriberCount > 0;
    final method = MethodConstants.WC_SESSION_AUTHENTICATE;
    final containsMethod = (pairingInfo?.methods ?? []).contains(method);

    return implementSessionAuth && containsMethod;
  }

  Future<void> _onSessionProposeRequest(
    String topic,
    JsonRpcRequest payload,
  ) async {
    if (_shouldIgnoreSessionPropose(topic)) {
      core.logger.t(
        'Session Propose ignored. Session Authenticate will be used instead',
      );
      return;
    }
    try {
      core.logger.t(
        '_onSessionProposeRequest, topic: $topic, payload: $payload',
      );
      final proposeRequest = WcSessionProposeRequest.fromJson(payload.params);
      await _isValidConnect(
        requiredNamespaces: proposeRequest.requiredNamespaces,
        optionalNamespaces: proposeRequest.optionalNamespaces,
        sessionProperties: proposeRequest.sessionProperties,
        pairingTopic: topic,
        relays: proposeRequest.relays,
      );

      // If there are accounts and event emitters, then handle the Namespace generate automatically
      Map<String, Namespace>? namespaces;
      if (_accounts.isNotEmpty || _eventEmitters.isNotEmpty) {
        namespaces = NamespaceUtils.constructNamespaces(
          availableAccounts: _accounts,
          availableMethods: _methodHandlers.keys.toSet(),
          availableEvents: _eventEmitters,
          requiredNamespaces: proposeRequest.requiredNamespaces,
          optionalNamespaces: proposeRequest.optionalNamespaces,
        );

        // Check that the namespaces are conforming
        try {
          SignApiValidatorUtils.isConformingNamespaces(
            requiredNamespaces: proposeRequest.requiredNamespaces,
            namespaces: namespaces,
            context: 'onSessionProposeRequest',
          );
        } on WalletConnectError catch (err) {
          // If they aren't, send an error
          core.logger.t(
            '_onSessionProposeRequest WalletConnectError: $err',
          );
          final rpcOpts = MethodConstants.RPC_OPTS[payload.method];
          await core.pairing.sendError(
            payload.id,
            topic,
            payload.method,
            JsonRpcError(code: err.code, message: err.message),
            rpcOptions: rpcOpts?['autoReject'],
          );

          // Broadcast that a session proposal error has occurred
          onSessionProposalError.broadcast(
            SessionProposalErrorEvent(
              payload.id,
              proposeRequest.requiredNamespaces,
              namespaces,
              err,
            ),
          );
          return;
        }
      }

      final expiry = WalletConnectUtils.calculateExpiry(
        WalletConnectConstants.FIVE_MINUTES,
      );
      final ProposalData proposal = ProposalData(
        id: payload.id,
        expiry: expiry,
        relays: proposeRequest.relays,
        proposer: proposeRequest.proposer,
        requiredNamespaces: proposeRequest.requiredNamespaces,
        optionalNamespaces: proposeRequest.optionalNamespaces ?? {},
        sessionProperties: proposeRequest.sessionProperties,
        pairingTopic: topic,
        generatedNamespaces: namespaces,
      );

      await _setProposal(payload.id, proposal);

      final verifyContext = await _getVerifyContext(
        payload,
        proposal.proposer.metadata,
      );

      onSessionProposal.broadcast(
        SessionProposalEvent(
          payload.id,
          proposal,
          verifyContext,
        ),
      );
    } on WalletConnectError catch (err) {
      core.logger.e('_onSessionProposeRequest Error: $err');
      final rpcOpts = MethodConstants.RPC_OPTS[payload.method];
      await core.pairing.sendError(
        payload.id,
        topic,
        payload.method,
        JsonRpcError(code: err.code, message: err.message),
        rpcOptions: rpcOpts?['autoReject'],
      );
    }
  }

  Future<void> _onSessionSettleRequest(
    String topic,
    JsonRpcRequest payload,
  ) async {
    // print('wc session settle');
    final request = WcSessionSettleRequest.fromJson(payload.params);
    try {
      await _isValidSessionSettleRequest(request.namespaces, request.expiry);

      final SessionProposalCompleter sProposalCompleter =
          pendingProposals.removeLast();
      // print(sProposalCompleter);

      // Create the session
      final SessionData session = SessionData(
        topic: topic,
        pairingTopic: sProposalCompleter.pairingTopic,
        relay: request.relay,
        expiry: request.expiry,
        acknowledged: true,
        controller: request.controller.publicKey,
        namespaces: request.namespaces,
        sessionProperties: request.sessionProperties,
        self: ConnectionMetadata(
          publicKey: sProposalCompleter.selfPublicKey,
          metadata: metadata,
        ),
        peer: request.controller,
      );

      // Update all the things: session, expiry, metadata, pairing
      sessions.set(topic, session);
      _setSessionExpiry(topic, session.expiry);
      await core.pairing.updateMetadata(
        topic: sProposalCompleter.pairingTopic,
        metadata: request.controller.metadata,
      );
      final pairing = core.pairing.getPairing(topic: topic);
      if (pairing != null && !pairing.active) {
        await core.pairing.activate(topic: topic);
      }

      // Send the session back to the completer
      sProposalCompleter.completer.complete(session);

      // Send back a success!
      // print('responding to session settle: acknolwedged');
      await core.pairing.sendResult(
        payload.id,
        topic,
        MethodConstants.WC_SESSION_SETTLE,
        true,
      );
      onSessionConnect.broadcast(
        SessionConnect(session),
      );
    } on WalletConnectError catch (err) {
      core.logger.e('_onSessionSettleRequest Error: $err');
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

  Future<void> _onSessionUpdateRequest(
    String topic,
    JsonRpcRequest payload,
  ) async {
    try {
      // print(payload.params);
      final request = WcSessionUpdateRequest.fromJson(payload.params);
      await _isValidUpdate(topic, request.namespaces);
      await sessions.update(
        topic,
        namespaces: request.namespaces,
      );
      await core.pairing.sendResult(
        payload.id,
        topic,
        MethodConstants.WC_SESSION_UPDATE,
        true,
      );
      onSessionUpdate.broadcast(
        SessionUpdate(
          payload.id,
          topic,
          request.namespaces,
        ),
      );
    } on WalletConnectError catch (err) {
      core.logger.e('_onSessionUpdateRequest Error: $err');
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

  Future<void> _onSessionExtendRequest(
    String topic,
    JsonRpcRequest payload,
  ) async {
    try {
      final _ = WcSessionExtendRequest.fromJson(payload.params);
      await _isValidSessionTopic(topic);
      await _setSessionExpiry(
        topic,
        WalletConnectUtils.calculateExpiry(
          WalletConnectConstants.SEVEN_DAYS,
        ),
      );
      await core.pairing.sendResult(
        payload.id,
        topic,
        MethodConstants.WC_SESSION_EXTEND,
        true,
      );
      onSessionExtend.broadcast(
        SessionExtend(
          payload.id,
          topic,
        ),
      );
    } on WalletConnectError catch (err) {
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

  Future<void> _onSessionPingRequest(
    String topic,
    JsonRpcRequest payload,
  ) async {
    try {
      final _ = WcSessionPingRequest.fromJson(payload.params);
      await _isValidPing(topic);
      await core.pairing.sendResult(
        payload.id,
        topic,
        MethodConstants.WC_SESSION_PING,
        true,
      );
      onSessionPing.broadcast(
        SessionPing(
          payload.id,
          topic,
        ),
      );
    } on WalletConnectError catch (err) {
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

  Future<void> _onSessionDeleteRequest(
    String topic,
    JsonRpcRequest payload,
  ) async {
    try {
      final _ = WcSessionDeleteRequest.fromJson(payload.params);
      await _isValidDisconnect(topic);
      await core.pairing.sendResult(
        payload.id,
        topic,
        MethodConstants.WC_SESSION_DELETE,
        true,
      );
      await _deleteSession(topic);
    } on WalletConnectError catch (err) {
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

  /// Called when a session request is received
  /// Will attempt to find a handler for the request, if it doesn't,
  /// it will throw an error.
  Future<void> _onSessionRequest(String topic, JsonRpcRequest payload) async {
    try {
      final request = WcSessionRequestRequest.fromJson(payload.params);
      await _isValidRequest(
        topic,
        request.chainId,
        request.request,
      );

      final session = sessions.get(topic)!;
      final verifyContext = await _getVerifyContext(
        payload,
        session.peer.metadata,
      );

      final sessionRequest = SessionRequest(
        id: payload.id,
        topic: topic,
        method: request.request.method,
        chainId: request.chainId,
        params: request.request.params,
        verifyContext: verifyContext,
      );

      // print('payload id: ${payload.id}');
      await _setPendingRequest(
        payload.id,
        sessionRequest,
      );

      final methodKey = _getRegisterKey(
        request.chainId,
        request.request.method,
      );
      final handler = _methodHandlers[methodKey];
      // If a method handler has been set using registerRequestHandler we use it to process the request
      if (handler != null) {
        try {
          await handler(topic, request.request.params);
        } on WalletConnectError catch (e) {
          await core.pairing.sendError(
            payload.id,
            topic,
            payload.method,
            JsonRpcError.fromJson(
              e.toJson(),
            ),
          );
          await _deletePendingRequest(payload.id);
        } on WalletConnectErrorSilent catch (_) {
          // Do nothing on silent error
          await _deletePendingRequest(payload.id);
        } catch (err) {
          await core.pairing.sendError(
            payload.id,
            topic,
            payload.method,
            JsonRpcError.invalidParams(
              err.toString(),
            ),
          );
          await _deletePendingRequest(payload.id);
        }
      } else {
        // Otherwise we send onSessionRequest event
        onSessionRequest.broadcast(
          SessionRequestEvent.fromSessionRequest(
            sessionRequest,
          ),
        );
      }
    } on WalletConnectError catch (err) {
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

  Future<void> _onSessionEventRequest(
    String topic,
    JsonRpcRequest payload,
  ) async {
    try {
      final request = WcSessionEventRequest.fromJson(payload.params);
      final SessionEventParams event = request.event;
      await _isValidEmit(
        topic,
        event,
        request.chainId,
      );

      final String eventKey = _getRegisterKey(
        request.chainId,
        request.event.name,
      );
      if (_eventHandlers.containsKey(eventKey)) {
        final handler = _methodHandlers[eventKey];
        if (handler != null) {
          final handler = _eventHandlers[eventKey]!;
          try {
            await handler(
              topic,
              event.data,
            );
          } catch (err) {
            await core.pairing.sendError(
              payload.id,
              topic,
              payload.method,
              JsonRpcError.invalidParams(
                err.toString(),
              ),
            );
          }
        }

        await core.pairing.sendResult(
          payload.id,
          topic,
          MethodConstants.WC_SESSION_REQUEST,
          true,
        );

        onSessionEvent.broadcast(
          SessionEvent(
            payload.id,
            topic,
            event.name,
            request.chainId,
            event.data,
          ),
        );
      } else {
        await core.pairing.sendError(
          payload.id,
          topic,
          payload.method,
          JsonRpcError.methodNotFound(
            'No handler found for chainId:event -> $eventKey',
          ),
        );
      }
    } on WalletConnectError catch (err) {
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

  /// ---- Event Registers ---- ///

  void _registerInternalEvents() {
    core.relayClient.onRelayClientConnect.subscribe(_onRelayConnect);
    core.expirer.onExpire.subscribe(_onExpired);
    core.pairing.onPairingDelete.subscribe(_onPairingDelete);
    core.pairing.onPairingExpire.subscribe(_onPairingDelete);
    core.heartbeat.onPulse.subscribe(_heartbeatSubscription);
  }

  Future<void> _onRelayConnect(EventArgs? args) async {
    // print('Session: relay connected');
    await _resubscribeAll();
  }

  Future<void> _onPairingDelete(PairingEvent? event) async {
    // Delete all the sessions associated with the pairing
    if (event == null) {
      return;
    }

    // Delete the proposals
    final List<ProposalData> proposalsToDelete = proposals
        .getAll()
        .where((proposal) => proposal.pairingTopic == event.topic)
        .toList();

    for (final proposal in proposalsToDelete) {
      await _deleteProposal(
        proposal.id,
      );
    }

    // Delete the sessions
    final List<SessionData> sessionsToDelete = sessions
        .getAll()
        .where((session) => session.pairingTopic == event.topic)
        .toList();

    for (final session in sessionsToDelete) {
      await _deleteSession(
        session.topic,
      );
    }
  }

  Future<void> _onExpired(ExpirationEvent? event) async {
    if (event == null) {
      return;
    }

    if (sessions.has(event.target)) {
      await _deleteSession(
        event.target,
        expirerHasDeleted: true,
      );
      onSessionExpire.broadcast(
        SessionExpire(
          event.target,
        ),
      );
    } else if (proposals.has(event.target)) {
      ProposalData proposal = proposals.get(event.target)!;
      await _deleteProposal(
        int.parse(event.target),
        expirerHasDeleted: true,
      );
      onProposalExpire.broadcast(
        SessionProposalEvent(
          int.parse(event.target),
          proposal,
        ),
      );
    } else if (pendingRequests.has(event.target)) {
      await _deletePendingRequest(
        int.parse(event.target),
        expirerHasDeleted: true,
      );
      return;
    }
  }

  void _heartbeatSubscription(EventArgs? args) async {
    await checkAndExpire();
  }

  /// ---- Validation Helpers ---- ///

  Future<bool> _isValidSessionTopic(String topic) async {
    if (!sessions.has(topic)) {
      throw Errors.getInternalError(
        Errors.NO_MATCHING_KEY,
        context: "session topic doesn't exist: $topic",
      );
    }

    if (await core.expirer.checkAndExpire(topic)) {
      throw Errors.getInternalError(
        Errors.EXPIRED,
        context: 'session topic: $topic',
      );
    }

    return true;
  }

  Future<bool> _isValidSessionOrPairingTopic(String topic) async {
    if (sessions.has(topic)) {
      await _isValidSessionTopic(topic);
    } else if (core.pairing.getStore().has(topic)) {
      await core.pairing.isValidPairingTopic(topic: topic);
    } else {
      throw Errors.getInternalError(
        Errors.NO_MATCHING_KEY,
        context: "session or pairing topic doesn't exist: $topic",
      );
    }

    return true;
  }

  Future<bool> _isValidProposalId(int id) async {
    if (!proposals.has(id.toString())) {
      throw Errors.getInternalError(
        Errors.NO_MATCHING_KEY,
        context: "proposal id doesn't exist: $id",
      );
    }

    if (await core.expirer.checkAndExpire(id.toString())) {
      throw Errors.getInternalError(
        Errors.EXPIRED,
        context: 'proposal id: $id',
      );
    }

    return true;
  }

  Future<bool> _isValidPendingRequest(int id) async {
    if (!pendingRequests.has(id.toString())) {
      throw Errors.getInternalError(
        Errors.NO_MATCHING_KEY,
        context: "proposal id doesn't exist: $id",
      );
    }

    if (await core.expirer.checkAndExpire(id.toString())) {
      throw Errors.getInternalError(
        Errors.EXPIRED,
        context: 'pending request id: $id',
      );
    }

    return true;
  }

  /// ---- Validations ---- ///

  Future<bool> _isValidConnect({
    Map<String, RequiredNamespace>? requiredNamespaces,
    Map<String, RequiredNamespace>? optionalNamespaces,
    Map<String, String>? sessionProperties,
    String? pairingTopic,
    List<Relay>? relays,
  }) async {
    // No need to validate sessionProperties. Strict typing enforces Strings are valid
    // No need to see if the relays are a valid array and whatnot. Strict typing enforces that.
    if (pairingTopic != null) {
      await core.pairing.isValidPairingTopic(
        topic: pairingTopic,
      );
    }

    if (requiredNamespaces != null) {
      SignApiValidatorUtils.isValidRequiredNamespaces(
        requiredNamespaces: requiredNamespaces,
        context: 'connect() check requiredNamespaces.',
      );
    }

    if (optionalNamespaces != null) {
      SignApiValidatorUtils.isValidRequiredNamespaces(
        requiredNamespaces: optionalNamespaces,
        context: 'connect() check optionalNamespaces.',
      );
    }

    return true;
  }

  Future<bool> _isValidApprove({
    required int id,
    required Map<String, Namespace> namespaces,
    Map<String, String>? sessionProperties,
    String? relayProtocol,
  }) async {
    // No need to validate sessionProperties. Strict typing enforces Strings are valid
    await _isValidProposalId(id);
    final ProposalData proposal = proposals.get(id.toString())!;

    // Validate the namespaces
    SignApiValidatorUtils.isValidNamespaces(
      namespaces: namespaces,
      context: 'approve()',
    );

    // Validate the required and optional namespaces
    SignApiValidatorUtils.isValidRequiredNamespaces(
      requiredNamespaces: proposal.requiredNamespaces,
      context: 'approve() check requiredNamespaces.',
    );
    SignApiValidatorUtils.isValidRequiredNamespaces(
      requiredNamespaces: proposal.optionalNamespaces,
      context: 'approve() check optionalNamespaces.',
    );

    // Make sure the provided namespaces conforms with the required
    SignApiValidatorUtils.isConformingNamespaces(
      requiredNamespaces: proposal.requiredNamespaces,
      namespaces: namespaces,
      context: 'approve()',
    );

    return true;
  }

  Future<bool> _isValidReject(int id, WalletConnectError reason) async {
    // No need to validate reason. Strict typing enforces ErrorResponse is valid
    await _isValidProposalId(id);
    return true;
  }

  Future<bool> _isValidSessionSettleRequest(
    Map<String, Namespace> namespaces,
    int expiry,
  ) async {
    SignApiValidatorUtils.isValidNamespaces(
      namespaces: namespaces,
      context: 'onSessionSettleRequest()',
    );

    if (WalletConnectUtils.isExpired(expiry)) {
      throw Errors.getInternalError(
        Errors.EXPIRED,
        context: 'onSessionSettleRequest()',
      );
    }

    return true;
  }

  Future<bool> _isValidUpdate(
    String topic,
    Map<String, Namespace> namespaces,
  ) async {
    await _isValidSessionTopic(topic);
    SignApiValidatorUtils.isValidNamespaces(
      namespaces: namespaces,
      context: 'update()',
    );
    final SessionData session = sessions.get(topic)!;

    SignApiValidatorUtils.isConformingNamespaces(
      requiredNamespaces: session.requiredNamespaces ?? {},
      namespaces: namespaces,
      context: 'update()',
    );

    return true;
  }

  Future<bool> _isValidRequest(
    String topic,
    String chainId,
    SessionRequestParams request,
  ) async {
    await _isValidSessionTopic(topic);
    final SessionData session = sessions.get(topic)!;
    SignApiValidatorUtils.isValidNamespacesChainId(
      namespaces: session.namespaces,
      chainId: chainId,
    );
    SignApiValidatorUtils.isValidNamespacesRequest(
      namespaces: session.namespaces,
      chainId: chainId,
      method: request.method,
    );

    return true;
  }

  Future<bool> _isValidResponse(
    String topic,
    JsonRpcResponse response,
  ) async {
    await _isValidSessionTopic(topic);

    if (response.result == null && response.error == null) {
      throw Errors.getInternalError(
        Errors.MISSING_OR_INVALID,
        context: 'JSON-RPC response and error cannot both be null',
      );
    }

    await _isValidPendingRequest(response.id);

    return true;
  }

  Future<bool> _isValidPing(
    String topic,
  ) async {
    await _isValidSessionOrPairingTopic(topic);

    return true;
  }

  Future<bool> _isValidEmit(
    String topic,
    SessionEventParams event,
    String chainId,
  ) async {
    await _isValidSessionTopic(topic);
    final SessionData session = sessions.get(topic)!;
    SignApiValidatorUtils.isValidNamespacesChainId(
      namespaces: session.namespaces,
      chainId: chainId,
    );
    SignApiValidatorUtils.isValidNamespacesEvent(
      namespaces: session.namespaces,
      chainId: chainId,
      eventName: event.name,
    );

    return true;
  }

  Future<bool> _isValidDisconnect(String topic) async {
    await _isValidSessionOrPairingTopic(topic);

    return true;
  }

  Future<VerifyContext> _getVerifyContext(
    JsonRpcRequest payload,
    PairingMetadata proposerMetada,
  ) async {
    try {
      final jsonStringify = jsonEncode(payload.toJson());
      final hash = core.crypto.getUtils().hashMessage(jsonStringify);

      final result = await core.verify.resolve(attestationId: hash);
      final validation = result?.origin == Uri.parse(proposerMetada.url).origin
          ? Validation.VALID
          : Validation.INVALID;

      return VerifyContext(
        origin: result?.origin ?? proposerMetada.url,
        verifyUrl: proposerMetada.verifyUrl ?? '',
        validation: result?.isScam == true ? Validation.SCAM : validation,
        isScam: result?.isScam,
      );
    } catch (e, s) {
      if (e is! AttestationNotFound) {
        core.logger.e('[$runtimeType] verify error', error: e, stackTrace: s);
      }
      return VerifyContext(
        origin: proposerMetada.url,
        verifyUrl: proposerMetada.verifyUrl ?? '',
        validation: Validation.UNKNOWN,
      );
    }
  }

  // NEW 1-CA METHOD (Should this be private?)

  @override
  Future<bool> validateSignedCacao({
    required Cacao cacao,
    required String projectId,
  }) async {
    final CacaoSignature signature = cacao.s;
    final CacaoPayload payload = cacao.p;

    final reconstructed = formatAuthMessage(
      iss: payload.iss,
      cacaoPayload: CacaoRequestPayload.fromCacaoPayload(payload),
    );

    final walletAddress = AddressUtils.getDidAddress(payload.iss);
    final chainId = AddressUtils.getDidChainId(payload.iss);

    final isValid = await AuthSignature.verifySignature(
      walletAddress,
      reconstructed,
      signature,
      chainId,
      projectId,
    );

    return isValid;
  }

  // FORMER AUTH ENGINE PROPERTY
  @override
  String formatAuthMessage({
    required String iss,
    required CacaoRequestPayload cacaoPayload,
  }) {
    final header =
        '${cacaoPayload.domain} wants you to sign in with your Ethereum account:';
    final walletAddress = AddressUtils.getDidAddress(iss);

    if (cacaoPayload.aud.isEmpty) {
      throw WalletConnectError(code: -1, message: 'aud is required');
    }

    String statement = cacaoPayload.statement ?? '';
    final uri = 'URI: ${cacaoPayload.aud}';
    final version = 'Version: ${cacaoPayload.version}';
    final chainId = 'Chain ID: ${AddressUtils.getDidChainId(iss)}';
    final nonce = 'Nonce: ${cacaoPayload.nonce}';
    final issuedAt = 'Issued At: ${cacaoPayload.iat}';
    final expirationTime = (cacaoPayload.exp != null)
        ? 'Expiration Time: ${cacaoPayload.exp}'
        : null;
    final notBefore =
        (cacaoPayload.nbf != null) ? 'Not Before: ${cacaoPayload.nbf}' : null;
    final requestId = (cacaoPayload.requestId != null)
        ? 'Request ID: ${cacaoPayload.requestId}'
        : null;
    final resources = cacaoPayload.resources != null &&
            cacaoPayload.resources!.isNotEmpty
        ? 'Resources:\n${cacaoPayload.resources!.map((resource) => '- $resource').join('\n')}'
        : null;
    final recap = ReCapsUtils.getRecapFromResources(
      resources: cacaoPayload.resources,
    );
    if (recap != null) {
      final decoded = ReCapsUtils.decodeRecap(recap);
      statement = ReCapsUtils.formatStatementFromRecap(
        statement: statement,
        recap: decoded,
      );
    }

    final message = [
      header,
      walletAddress,
      '',
      statement,
      '',
      uri,
      version,
      chainId,
      nonce,
      issuedAt,
      expirationTime,
      notBefore,
      requestId,
      resources,
    ].where((element) => element != null).join('\n');

    return message;
  }

  // FORMER AUTH ENGINE PROPERTY
  @override
  Map<int, StoredCacao> getCompletedRequestsForPairing({
    required String pairingTopic,
  }) {
    Map<int, StoredCacao> completedRequests = {};
    completeRequests
        .getAll()
        .where(
          (e) => e.pairingTopic == pairingTopic,
        )
        .forEach((key) {
      completedRequests[key.id] = key;
    });
    return completedRequests;
  }

  // FORMER AUTH ENGINE PROPERTY
  @override
  Map<int, PendingAuthRequest> getPendingAuthRequests() {
    Map<int, PendingAuthRequest> pendingRequests = {};
    authRequests.getAll().forEach((key) {
      pendingRequests[key.id] = key;
    });
    return pendingRequests;
  }

  // FORMER AUTH ENGINE PROPERTY
  @override
  Future<AuthRequestResponse> requestAuth({
    required AuthRequestParams params,
    String? pairingTopic,
    List<List<String>>? methods = DEFAULT_METHODS_AUTH,
  }) async {
    _checkInitialized();

    AuthApiValidators.isValidRequest(params);
    String? pTopic = pairingTopic;
    Uri? uri;

    if (pTopic == null) {
      final CreateResponse newTopicAndUri = await core.pairing.create(
        methods: methods,
      );
      pTopic = newTopicAndUri.topic;
      uri = newTopicAndUri.uri;
    } else {
      // TODO this should be used when pairingTopic is passed (existent pairing topic case)
      // but it does not seems right
      core.pairing.isValidPairingTopic(topic: pTopic);
    }

    final publicKey = await core.crypto.generateKeyPair();
    // print('requestAuth, publicKey: $publicKey');
    final String responseTopic = core.crypto.getUtils().hashKey(publicKey);
    final int id = JsonRpcUtils.payloadId();

    final request = WcAuthRequestRequest(
      payloadParams: AuthPayloadParams.fromRequestParams(
        params,
      ),
      requester: ConnectionMetadata(
        publicKey: publicKey,
        metadata: metadata,
      ),
    );

    final int expiry = params.expiry ?? WalletConnectConstants.FIVE_MINUTES;

    await authKeys.set(
      AuthConstants.AUTH_CLIENT_PUBLIC_KEY_NAME,
      AuthPublicKey(publicKey: publicKey),
    );

    await pairingTopics.set(
      responseTopic,
      pTopic,
    );

    // Set the one time use receiver public key for decoding the Type 1 envelope
    await core.pairing.setReceiverPublicKey(
      topic: responseTopic,
      publicKey: publicKey,
      expiry: expiry,
    );

    Completer<AuthResponse> completer = Completer();

    _requestAuthResponseHandler(
      pairingTopic: pTopic,
      responseTopic: responseTopic,
      request: request,
      id: id,
      expiry: expiry,
      completer: completer,
    );

    return AuthRequestResponse(
      id: id,
      pairingTopic: pTopic,
      completer: completer,
      uri: uri,
    );
  }

  // FORMER AUTH ENGINE PROPERTY
  Future<void> _requestAuthResponseHandler({
    required String pairingTopic,
    required String responseTopic,
    required WcAuthRequestRequest request,
    required int id,
    required int expiry,
    required Completer<AuthResponse> completer,
  }) async {
    // Subscribe to the responseTopic because we expect the response to use this topic
    await core.relayClient.subscribe(topic: responseTopic);

    late WcAuthRequestResult result;
    try {
      final Map<String, dynamic> response = await core.pairing.sendRequest(
        pairingTopic,
        MethodConstants.WC_AUTH_REQUEST,
        request.toJson(),
        id: id,
        ttl: expiry,
      );
      result = WcAuthRequestResult.fromJson({'cacao': response});
    } catch (error) {
      final response = AuthResponse(
        id: id,
        topic: responseTopic,
        jsonRpcError: (error is JsonRpcError) ? error : null,
        error: (error is! JsonRpcError)
            ? WalletConnectError(
                code: -1,
                message: error.toString(),
              )
            : null,
      );
      onAuthResponse.broadcast(response);
      completer.complete(response);
      return;
    }

    await core.pairing.activate(topic: pairingTopic);

    final Cacao cacao = result.cacao;
    await completeRequests.set(
      id.toString(),
      StoredCacao.fromCacao(
        id: id,
        pairingTopic: pairingTopic,
        cacao: cacao,
      ),
    );

    final isValid = await validateSignedCacao(
      cacao: cacao,
      projectId: core.projectId,
    );

    if (!isValid) {
      final resp = AuthResponse(
        id: id,
        topic: responseTopic,
        error: const WalletConnectError(
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

  // NEW ONE-CLICK AUTH METHOD FOR DAPPS
  @override
  Map<int, PendingSessionAuthRequest> getPendingSessionAuthRequests() {
    Map<int, PendingSessionAuthRequest> pendingRequests = {};
    sessionAuthRequests.getAll().forEach((key) {
      pendingRequests[key.id] = key;
    });
    return pendingRequests;
  }

  @override
  Future<SessionAuthRequestResponse> authenticate({
    required SessionAuthRequestParams params,
    String? pairingTopic,
    List<List<String>>? methods = const [
      [MethodConstants.WC_SESSION_AUTHENTICATE]
    ],
  }) async {
    _checkInitialized();

    AuthApiValidators.isValidAuthenticate(params);

    final chains = params.chains;
    final resources = params.resources ?? [];
    final requestMethods = params.methods ?? [];

    String? pTopic = pairingTopic;
    Uri? connectionUri;

    if (pTopic == null) {
      final CreateResponse pairing = await core.pairing.create(
        methods: methods,
      );
      pTopic = pairing.topic;
      connectionUri = pairing.uri;
    } else {
      core.pairing.isValidPairingTopic(topic: pTopic);
    }

    final publicKey = await core.crypto.generateKeyPair();
    final responseTopic = core.crypto.getUtils().hashKey(publicKey);

    await Future.wait([
      authKeys.set(
        AuthConstants.OCAUTH_CLIENT_PUBLIC_KEY_NAME,
        AuthPublicKey(publicKey: publicKey),
      ),
      pairingTopics.set(responseTopic, pTopic),
    ]);

    if (requestMethods.isNotEmpty) {
      final namespace = NamespaceUtils.getNamespaceFromChain(chains.first);
      String recap = ReCapsUtils.createEncodedRecap(
        namespace,
        'request',
        requestMethods,
      );
      final existingRecap = ReCapsUtils.getRecapFromResources(
        resources: resources,
      );
      if (existingRecap != null) {
        // per Recaps spec, recap must occupy the last position in the resources array
        // using .removeLast() to remove the element given we already checked it's a recap and will replace it
        recap = ReCapsUtils.mergeEncodedRecaps(recap, resources.removeLast());
      }
      resources.add(recap);
    }

    // Subscribe to the responseTopic because we expect the response to use this topic
    await core.relayClient.subscribe(topic: responseTopic);

    final id = JsonRpcUtils.payloadId();
    final proposalId = JsonRpcUtils.payloadId();

    // Ensure the expiry is greater than the minimum required for the request - currently 1h
    final method = MethodConstants.WC_SESSION_AUTHENTICATE;
    final opts = MethodConstants.RPC_OPTS[method]!['req']!;
    final authRequestExpiry = max((params.expiry ?? 0), opts.ttl);
    final expiryTimestamp = DateTime.now().add(
      Duration(seconds: authRequestExpiry),
    );

    final request = WcSessionAuthRequestParams(
      authPayload: SessionAuthPayload.fromRequestParams(params).copyWith(
        resources: resources,
      ),
      requester: ConnectionMetadata(
        publicKey: publicKey,
        metadata: metadata,
      ),
      expiryTimestamp: expiryTimestamp.millisecondsSinceEpoch,
    );

    // Set the one time use receiver public key for decoding the Type 1 envelope
    await core.pairing.setReceiverPublicKey(
      topic: responseTopic,
      publicKey: publicKey,
      expiry: authRequestExpiry,
    );

    Completer<SessionAuthResponse> completer = Completer();

    // ----- build fallback session proposal request ----- //

    final fallbackMethod = MethodConstants.WC_SESSION_PROPOSE;
    final fallbackOpts = MethodConstants.RPC_OPTS[fallbackMethod]!['req']!;
    final fallbackExpiryTimestamp = DateTime.now().add(
      Duration(seconds: fallbackOpts.ttl),
    );
    final proposalData = ProposalData(
      id: proposalId,
      requiredNamespaces: {},
      optionalNamespaces: {
        'eip155': RequiredNamespace(
          chains: chains,
          methods: {'personal_sign', ...requestMethods}.toList(),
          events: EventsConstants.requiredEvents,
        ),
      },
      relays: [Relay(WalletConnectConstants.RELAYER_DEFAULT_PROTOCOL)],
      expiry: fallbackExpiryTimestamp.millisecondsSinceEpoch,
      proposer: ConnectionMetadata(
        publicKey: publicKey,
        metadata: metadata,
      ),
      pairingTopic: pTopic,
    );
    final proposeRequest = WcSessionProposeRequest(
      relays: proposalData.relays,
      requiredNamespaces: proposalData.requiredNamespaces,
      optionalNamespaces: proposalData.optionalNamespaces,
      proposer: proposalData.proposer,
    );
    await _setProposal(proposalData.id, proposalData);

    Completer<SessionData> completerFallback = Completer();

    pendingProposals.add(
      SessionProposalCompleter(
        id: proposalData.id,
        selfPublicKey: proposalData.proposer.publicKey,
        pairingTopic: proposalData.pairingTopic,
        requiredNamespaces: proposalData.requiredNamespaces,
        optionalNamespaces: proposalData.optionalNamespaces,
        completer: completerFallback,
      ),
    );

    // ------------------------------------------------------- //

    // Send One-Click Auth request
    _sessionAuthResponseHandler(
      id: id,
      publicKey: publicKey,
      pairingTopic: pTopic,
      responseTopic: responseTopic,
      request: request,
      expiry: authRequestExpiry,
      completer: completer,
    );

    // Send Session Proposal request
    _connectResponseHandler(
      pTopic,
      proposeRequest,
      proposalData.id,
    );

    return SessionAuthRequestResponse(
      id: id,
      pairingTopic: pTopic,
      completer: completer,
      uri: connectionUri,
    );
  }

  Future<void> _sessionAuthResponseHandler({
    required int id,
    required String publicKey,
    required String pairingTopic,
    required String responseTopic,
    required int expiry,
    required WcSessionAuthRequestParams request,
    required Completer<SessionAuthResponse> completer,
  }) async {
    //
    late WcSessionAuthRequestResult result;
    try {
      final Map<String, dynamic> response = await core.pairing.sendRequest(
        pairingTopic,
        MethodConstants.WC_SESSION_AUTHENTICATE,
        request.toJson(),
        id: id,
        ttl: expiry,
      );
      result = WcSessionAuthRequestResult.fromJson(response);
    } catch (error) {
      final response = SessionAuthResponse(
        id: id,
        topic: responseTopic,
        jsonRpcError: (error is JsonRpcError) ? error : null,
        error: (error is! JsonRpcError)
            ? WalletConnectError(
                code: -1,
                message: error.toString(),
              )
            : null,
      );
      onSessionAuthResponse.broadcast(response);
      completer.complete(response);
      return;
    }

    await core.pairing.activate(topic: pairingTopic);

    final List<Cacao> cacaos = result.cacaos;
    final ConnectionMetadata responder = result.responder;

    final approvedMethods = <String>{};
    final approvedAccounts = <String>{};

    try {
      for (final Cacao cacao in cacaos) {
        final isValid = await validateSignedCacao(
          cacao: cacao,
          projectId: core.projectId,
        );
        if (!isValid) {
          throw Errors.getSdkError(
            Errors.SIGNATURE_VERIFICATION_FAILED,
            context: 'Invalid signature',
          );
        }

        // This is used on Auth request, would it be needed on 1-CA?
        // await completeRequests.set(
        //   id.toString(),
        //   StoredCacao.fromCacao(
        //     id: id,
        //     pairingTopic: pairingTopic,
        //     cacao: cacao,
        //   ),
        // );

        final CacaoPayload payload = cacao.p;
        final chainId = AddressUtils.getDidChainId(payload.iss);
        final approvedChains = ['eip155:$chainId'];

        final recap = ReCapsUtils.getRecapFromResources(
          resources: payload.resources,
        );
        if (recap != null) {
          final methodsfromRecap = ReCapsUtils.getMethodsFromRecap(recap);
          final chainsFromRecap = ReCapsUtils.getChainsFromRecap(recap);
          approvedMethods.addAll(methodsfromRecap);
          approvedChains.addAll(chainsFromRecap);
        }

        final parsedAddress = AddressUtils.getDidAddress(payload.iss);
        for (var chain in approvedChains.toSet()) {
          approvedAccounts.add('$chain:$parsedAddress');
        }
      }
    } on WalletConnectError catch (e) {
      final resp = SessionAuthResponse(
        id: id,
        topic: responseTopic,
        error: WalletConnectError(
          code: e.code,
          message: e.message,
        ),
      );
      onSessionAuthResponse.broadcast(resp);
      completer.complete(resp);
      return;
    }

    final sessionTopic = await core.crypto.generateSharedKey(
      publicKey,
      responder.publicKey,
    );

    SessionData? session;
    if (approvedMethods.isNotEmpty) {
      session = SessionData(
        topic: sessionTopic,
        acknowledged: true,
        self: ConnectionMetadata(
          publicKey: publicKey,
          metadata: metadata,
        ),
        peer: responder,
        controller: publicKey,
        expiry: WalletConnectUtils.calculateExpiry(
          WalletConnectConstants.SEVEN_DAYS,
        ),
        relay: Relay(WalletConnectConstants.RELAYER_DEFAULT_PROTOCOL),
        pairingTopic: pairingTopic,
        namespaces: NamespaceUtils.buildNamespacesFromAuth(
          accounts: approvedAccounts,
          methods: approvedMethods,
        ),
      );

      await core.relayClient.subscribe(topic: sessionTopic);
      await sessions.set(sessionTopic, session);

      await core.pairing.updateMetadata(
        topic: pairingTopic,
        metadata: responder.metadata,
      );

      session = sessions.get(sessionTopic);
    }

    final resp = SessionAuthResponse(
      id: id,
      topic: responseTopic,
      auths: cacaos,
      session: session,
    );
    onSessionAuthResponse.broadcast(resp);
    completer.complete(resp);
  }

  // FORMER AUTH ENGINE PROPERTY
  @override
  Future<void> respondAuthRequest({
    required int id,
    required String iss,
    CacaoSignature? signature,
    WalletConnectError? error,
  }) async {
    _checkInitialized();

    Map<int, PendingAuthRequest> pendingRequests = getPendingAuthRequests();
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
        h: const CacaoHeader(),
        p: CacaoPayload.fromRequestPayload(
          issuer: iss,
          payload: pendingRequest.cacaoPayload,
        ),
        s: signature!,
      );

      // print('auth res id: $id');
      await core.pairing.sendResult(
        id,
        responseTopic,
        MethodConstants.WC_AUTH_REQUEST,
        cacao.toJson(),
        encodeOptions: encodeOpts,
      );

      await authRequests.delete(id.toString());

      await completeRequests.set(
        id.toString(),
        StoredCacao.fromCacao(
          id: id,
          pairingTopic: pendingRequest.pairingTopic,
          cacao: cacao,
        ),
      );
    }
  }

  @override
  Future<ApproveResponse> approveSessionAuthenticate({
    required int id,
    List<Cacao>? auths,
  }) async {
    _checkInitialized();

    final pendingRequests = getPendingSessionAuthRequests();

    AuthApiValidators.isValidRespondAuthenticate(
      id: id,
      pendingRequests: pendingRequests,
      auths: auths,
    );

    final PendingSessionAuthRequest pendingRequest = pendingRequests[id]!;
    final receiverPublicKey = pendingRequest.requester.publicKey;
    final senderPublicKey = await core.crypto.generateKeyPair();
    final responseTopic = core.crypto.getUtils().hashKey(receiverPublicKey);

    final encodeOpts = EncodeOptions(
      type: EncodeOptions.TYPE_1,
      receiverPublicKey: receiverPublicKey,
      senderPublicKey: senderPublicKey,
    );

    final approvedMethods = <String>{};
    final approvedAccounts = <String>{};
    for (final Cacao cacao in auths!) {
      final isValid = await validateSignedCacao(
        cacao: cacao,
        projectId: core.projectId,
      );
      if (!isValid) {
        final error = Errors.getSdkError(
          Errors.SIGNATURE_VERIFICATION_FAILED,
          context: 'Signature verification failed',
        );
        await core.pairing.sendError(
          id,
          responseTopic,
          MethodConstants.WC_SESSION_AUTHENTICATE,
          JsonRpcError(code: error.code, message: error.message),
          encodeOptions: encodeOpts,
        );
        throw error;
      }

      final CacaoPayload payload = cacao.p;
      final chainId = AddressUtils.getDidChainId(payload.iss);
      final approvedChains = ['eip155:$chainId'];

      final recap = ReCapsUtils.getRecapFromResources(
        resources: payload.resources,
      );
      if (recap != null) {
        final methodsfromRecap = ReCapsUtils.getMethodsFromRecap(recap);
        final chainsFromRecap = ReCapsUtils.getChainsFromRecap(recap);
        approvedMethods.addAll(methodsfromRecap);
        approvedChains.addAll(chainsFromRecap);
      }

      final parsedAddress = AddressUtils.getDidAddress(payload.iss);
      for (var chain in approvedChains.toSet()) {
        approvedAccounts.add('$chain:$parsedAddress');
      }
    }

    final sessionTopic = await core.crypto.generateSharedKey(
      senderPublicKey,
      receiverPublicKey,
    );

    SessionData? session;
    if (approvedMethods.isNotEmpty) {
      session = SessionData(
        topic: sessionTopic,
        acknowledged: true,
        self: ConnectionMetadata(
          publicKey: senderPublicKey,
          metadata: metadata,
        ),
        peer: pendingRequest.requester,
        controller: receiverPublicKey,
        expiry: WalletConnectUtils.calculateExpiry(
          WalletConnectConstants.SEVEN_DAYS,
        ),
        relay: Relay(WalletConnectConstants.RELAYER_DEFAULT_PROTOCOL),
        pairingTopic: pendingRequest.pairingTopic,
        namespaces: NamespaceUtils.buildNamespacesFromAuth(
          accounts: approvedAccounts,
          methods: approvedMethods,
        ),
      );

      await core.relayClient.subscribe(topic: sessionTopic);
      await sessions.set(sessionTopic, session);

      session = sessions.get(sessionTopic);
    }

    final result = WcSessionAuthRequestResult(
      cacaos: auths,
      responder: ConnectionMetadata(
        publicKey: senderPublicKey,
        metadata: metadata,
      ),
    );
    await core.pairing.sendResult(
      id,
      responseTopic,
      MethodConstants.WC_SESSION_AUTHENTICATE,
      result.toJson(),
      encodeOptions: encodeOpts,
    );

    await sessionAuthRequests.delete(id.toString());
    await core.pairing.activate(topic: pendingRequest.pairingTopic);
    await core.pairing.updateMetadata(
      topic: pendingRequest.pairingTopic,
      metadata: pendingRequest.requester.metadata,
    );

    return ApproveResponse(
      topic: sessionTopic,
      session: session,
    );
  }

  @override
  Future<void> rejectSessionAuthenticate({
    required int id,
    required WalletConnectError reason,
  }) async {
    _checkInitialized();

    final pendingRequests = getPendingSessionAuthRequests();

    if (!pendingRequests.containsKey(id)) {
      throw Errors.getInternalError(
        Errors.MISSING_OR_INVALID,
        context:
            'rejectSessionAuthenticate() Could not find pending auth request with id $id',
      );
    }

    final PendingSessionAuthRequest pendingRequest = pendingRequests[id]!;
    final receiverPublicKey = pendingRequest.requester.publicKey;
    final senderPublicKey = await core.crypto.generateKeyPair();
    final responseTopic = core.crypto.getUtils().hashKey(receiverPublicKey);

    final encodeOpts = EncodeOptions(
      type: EncodeOptions.TYPE_1,
      receiverPublicKey: receiverPublicKey,
      senderPublicKey: senderPublicKey,
    );

    final method = MethodConstants.WC_SESSION_AUTHENTICATE;
    final rpcOpts = MethodConstants.RPC_OPTS[method];
    await core.pairing.sendError(
      id,
      responseTopic,
      method,
      JsonRpcError(code: reason.code, message: reason.message),
      encodeOptions: encodeOpts,
      rpcOptions: rpcOpts?['reject'],
    );

    await sessionAuthRequests.delete(id.toString());
    await _deleteProposal(id);
  }

  // FORMER AUTH ENGINE PROPERTY
  void _onAuthRequest(String topic, JsonRpcRequest payload) async {
    try {
      final request = WcAuthRequestRequest.fromJson(payload.params);

      final CacaoRequestPayload cacaoPayload =
          CacaoRequestPayload.fromPayloadParams(
        request.payloadParams,
      );

      authRequests.set(
        payload.id.toString(),
        PendingAuthRequest(
          id: payload.id,
          pairingTopic: topic,
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
    } on WalletConnectError catch (err) {
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

  void _onSessionAuthRequest(String topic, JsonRpcRequest payload) async {
    core.logger.t('_onSessionAuthRequest, topic: $topic, payload: $payload');

    final sessionAuthRequest = WcSessionAuthRequestParams.fromJson(
      payload.params,
    );
    try {
      final cacaoPayload = CacaoRequestPayload.fromSessionAuthPayload(
        sessionAuthRequest.authPayload,
      );

      final verifyContext = await _getVerifyContext(payload, metadata);

      sessionAuthRequests.set(
        payload.id.toString(),
        PendingSessionAuthRequest(
          id: payload.id,
          pairingTopic: topic,
          requester: sessionAuthRequest.requester,
          authPayload: cacaoPayload,
          expiryTimestamp: sessionAuthRequest.expiryTimestamp,
          verifyContext: verifyContext,
        ),
      );

      onSessionAuthRequest.broadcast(
        SessionAuthRequest(
          id: payload.id,
          topic: topic,
          requester: sessionAuthRequest.requester,
          authPayload: sessionAuthRequest.authPayload,
          verifyContext: verifyContext,
        ),
      );
    } on WalletConnectError catch (err) {
      final receiverPublicKey = sessionAuthRequest.requester.publicKey;
      final senderPublicKey = await core.crypto.generateKeyPair();

      final encodeOpts = EncodeOptions(
        type: EncodeOptions.TYPE_1,
        receiverPublicKey: receiverPublicKey,
        senderPublicKey: senderPublicKey,
      );
      final rpcOpts = MethodConstants.RPC_OPTS[payload.method];
      await core.pairing.sendError(
        payload.id,
        topic,
        payload.method,
        JsonRpcError.invalidParams(err.message),
        encodeOptions: encodeOpts,
        rpcOptions: rpcOpts?['autoReject'],
      );
    }
  }
}

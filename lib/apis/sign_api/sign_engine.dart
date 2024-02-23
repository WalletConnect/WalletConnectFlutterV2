import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;

import 'package:walletconnect_flutter_v2/apis/core/pairing/utils/json_rpc_utils.dart';
import 'package:walletconnect_flutter_v2/apis/core/store/i_generic_store.dart';
import 'package:walletconnect_flutter_v2/apis/core/verify/models/verify_context.dart';
import 'package:walletconnect_flutter_v2/apis/models/json_rpc_request.dart';
import 'package:walletconnect_flutter_v2/apis/sign_api/i_sessions.dart';
import 'package:walletconnect_flutter_v2/apis/sign_api/utils/custom_credentials.dart';
import 'package:walletconnect_flutter_v2/apis/sign_api/utils/sign_api_validator_utils.dart';
import 'package:walletconnect_flutter_v2/walletconnect_flutter_v2.dart';

class SignEngine implements ISignEngine {
  static const List<List<String>> DEFAULT_METHODS = [
    [
      MethodConstants.WC_SESSION_PROPOSE,
      MethodConstants.WC_SESSION_REQUEST,
    ],
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

  SignEngine({
    required this.core,
    required this.metadata,
    required this.proposals,
    required this.sessions,
    required this.pendingRequests,
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

    final WcSessionProposeRequest request = WcSessionProposeRequest(
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
      final Map<String, dynamic> resp = await core.pairing.sendRequest(
        topic,
        MethodConstants.WC_SESSION_PROPOSE,
        request,
        id: requestId,
      );
      final String peerPublicKey = resp['responderPublicKey'];

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
      requiredNamespaces: proposal.requiredNamespaces,
      optionalNamespaces: proposal.optionalNamespaces,
      self: ConnectionMetadata(
        publicKey: selfPubKey,
        metadata: metadata,
      ),
      peer: proposal.proposer,
    );

    // print('session connect');
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
            requiredNamespaces: proposal.requiredNamespaces,
            optionalNamespaces: proposal.optionalNamespaces,
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
        await core.pairing.sendError(
          id,
          proposal.pairingTopic,
          MethodConstants.WC_SESSION_PROPOSE,
          JsonRpcError.fromJson(
            reason.toJson(),
          ),
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
  Future<dynamic> requestReadContract({
    required DeployedContract deployedContract,
    required String functionName,
    required String rpcUrl,
    List<dynamic> parameters = const [],
  }) async {
    try {
      core.logger.i('readContractCall: with function $functionName');
      final result = await Web3Client(rpcUrl, http.Client()).call(
        contract: deployedContract,
        function: deployedContract.function(functionName),
        params: parameters,
      );

      core.logger.i(
          'readContractCall - function: $functionName - result: ${result.first}');
      return result.first;
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
      parameters: [
        if (transaction.to != null) transaction.to,
        if (transaction.value != null) transaction.value!.getInWei,
        ...parameters,
      ],
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
  }

  Future<void> _onSessionProposeRequest(
    String topic,
    JsonRpcRequest payload,
  ) async {
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
          await core.pairing.sendError(
            payload.id,
            topic,
            payload.method,
            JsonRpcError.fromJson(
              err.toJson(),
            ),
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
      await core.pairing.sendError(
        payload.id,
        topic,
        payload.method,
        JsonRpcError.fromJson(
          err.toJson(),
        ),
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
        requiredNamespaces: request.requiredNamespaces,
        optionalNamespaces: request.optionalNamespaces,
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
}

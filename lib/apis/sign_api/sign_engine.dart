import 'dart:async';

import 'package:event/event.dart';
import 'package:walletconnect_flutter_v2/apis/core/store/i_generic_store.dart';
import 'package:walletconnect_flutter_v2/apis/core/pairing/i_pairing_store.dart';
import 'package:walletconnect_flutter_v2/apis/core/pairing/utils/pairing_utils.dart';
import 'package:walletconnect_flutter_v2/apis/core/pairing/utils/pairing_models.dart';
import 'package:walletconnect_flutter_v2/apis/core/i_core.dart';
import 'package:walletconnect_flutter_v2/apis/core/relay_client/relay_client_models.dart';
import 'package:walletconnect_flutter_v2/apis/models/json_rpc_error.dart';
import 'package:walletconnect_flutter_v2/apis/models/json_rpc_request.dart';
import 'package:walletconnect_flutter_v2/apis/models/basic_models.dart';
import 'package:walletconnect_flutter_v2/apis/models/json_rpc_response.dart';
import 'package:walletconnect_flutter_v2/apis/sign_api/i_sign_engine.dart';
import 'package:walletconnect_flutter_v2/apis/sign_api/models/json_rpc_models.dart';
import 'package:walletconnect_flutter_v2/apis/sign_api/models/proposal_models.dart';
import 'package:walletconnect_flutter_v2/apis/sign_api/models/sign_client_events.dart';
import 'package:walletconnect_flutter_v2/apis/sign_api/models/session_models.dart';
import 'package:walletconnect_flutter_v2/apis/sign_api/i_sessions.dart';
import 'package:walletconnect_flutter_v2/apis/sign_api/models/sign_client_models.dart';
import 'package:walletconnect_flutter_v2/apis/sign_api/utils/sign_api_validator_utils.dart';
import 'package:walletconnect_flutter_v2/apis/utils/constants.dart';
import 'package:walletconnect_flutter_v2/apis/utils/errors.dart';
import 'package:walletconnect_flutter_v2/apis/utils/method_constants.dart';
import 'package:walletconnect_flutter_v2/apis/utils/walletconnect_utils.dart';

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
    await proposals.init();
    await sessions.init();
    await pendingRequests.init();

    _registerExpirerEvents();
    _registerRelayClientFunctions();
    await _cleanup();

    // Subscribe to all the sessions
    for (final SessionData session in sessions.getAll()) {
      await core.relayClient.subscribe(topic: session.topic);
    }

    _initialized = true;
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
    final int id = PairingUtils.payloadId();

    final WcSessionProposeRequest request = WcSessionProposeRequest(
      relays: relays == null
          ? [Relay(WalletConnectConstants.RELAYER_DEFAULT_PROTOCOL)]
          : relays,
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
      optionalNamespaces: request.optionalNamespaces,
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
        optionalNamespaces: request.optionalNamespaces,
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
    final Map<String, dynamic> resp = await core.pairing.sendRequest(
      topic,
      MethodConstants.WC_SESSION_PROPOSE,
      request.toJson(),
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
  }

  @override
  Future<PairingInfo> pair({
    required Uri uri,
  }) async {
    _checkInitialized();

    return await core.pairing.pair(uri: uri);
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
    final relay = Relay(
      relayProtocol != null ? relayProtocol : 'irn',
    );
    final int expiry = WalletConnectUtils.calculateExpiry(
      WalletConnectConstants.SEVEN_DAYS,
    );
    final request = WcSessionSettleRequest(
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
    );

    // If we received this request from somewhere, respond with the sessionTopic
    // so they can update their listener.
    // print('approve requestId: ${id}');

    if (proposal.pairingTopic != null && id > 0) {
      // print('approve proposal topic: ${proposal.pairingTopic!}');
      await core.pairing.sendResult(
        id,
        proposal.pairingTopic!,
        MethodConstants.WC_SESSION_PROPOSE,
        WcSessionProposeResponse(
          relay: Relay(
            relayProtocol != null
                ? relayProtocol
                : WalletConnectConstants.RELAYER_DEFAULT_PROTOCOL,
          ),
          responderPublicKey: selfPubKey,
        ).toJson(),
      );
      await _deleteProposal(id);
      await core.pairing.activate(topic: proposal.pairingTopic!);

      await core.pairing.updateMetadata(
        topic: proposal.pairingTopic!,
        metadata: proposal.proposer.metadata,
      );
    }

    await core.relayClient.subscribe(topic: sessionTopic);
    bool acknowledged = await core.pairing.sendRequest(
      sessionTopic,
      MethodConstants.WC_SESSION_SETTLE,
      request.toJson(),
    );

    SessionData session = SessionData(
      topic: sessionTopic,
      relay: relay,
      expiry: expiry,
      acknowledged: acknowledged,
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

    await sessions.set(sessionTopic, session);
    await _setExpiry(sessionTopic, expiry);

    // If we have a pairing topic, update its metadata with the peer
    if (proposal.pairingTopic != null) {}

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
    if (proposal != null && proposal.pairingTopic != null) {
      await core.pairing.sendError(
        id,
        proposal.pairingTopic!,
        MethodConstants.WC_SESSION_PROPOSE,
        JsonRpcError.serverError('User rejected request'),
      );
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
      WcSessionUpdateRequest(namespaces: namespaces).toJson(),
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

    await _setExpiry(
      topic,
      WalletConnectUtils.calculateExpiry(
        WalletConnectConstants.SEVEN_DAYS,
      ),
    );
  }

  /// Maps a request using chainId:method to its handler
  Map<String, dynamic Function(String, dynamic)?> _methodHandlers = {};

  void registerRequestHandler({
    required String chainId,
    required String method,
    dynamic Function(String, dynamic)? handler,
  }) {
    _checkInitialized();
    _methodHandlers[getRegisterKey(chainId, method)] = handler;
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
    Map<String, dynamic> payload = WcSessionRequestRequest(
      chainId: chainId,
      request: request,
    ).toJson();
    request.toJson();
    return await core.pairing.sendRequest(
      topic,
      MethodConstants.WC_SESSION_REQUEST,
      payload,
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
  Map<String, dynamic Function(String, dynamic)?> _eventHandlers = {};

  void registerEventHandler({
    required String chainId,
    required String event,
    dynamic Function(String, dynamic)? handler,
  }) {
    _checkInitialized();
    _eventHandlers[getRegisterKey(chainId, event)] = handler;
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
    Map<String, dynamic> payload = WcSessionEventRequest(
      chainId: chainId,
      event: event,
    ).toJson();
    await core.pairing.sendRequest(
      topic,
      MethodConstants.WC_SESSION_EVENT,
      payload,
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
    await _isValidDisconnect(topic);

    if (sessions.has(topic)) {
      Map<String, dynamic> payload = WcSessionDeleteRequest(
        code: reason.code,
        message: reason.message,
        data: reason.data,
      ).toJson();

      int id = PairingUtils.payloadId();

      // Send the request to delete the session, we don't care if it fails
      try {
        core.pairing.sendRequest(
          topic,
          MethodConstants.WC_SESSION_DELETE,
          payload,
          id: id,
        );
      } catch (_) {}

      await _deleteSession(topic);

      onSessionDelete.broadcast(
        SessionDelete(
          id,
          topic,
        ),
      );
    } else {
      await core.pairing.disconnect(topic: topic);
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

  /// ---- PRIVATE HELPERS ---- ////
  void _checkInitialized() {
    if (!_initialized) {
      throw Errors.getInternalError(Errors.NOT_INITIALIZED);
    }
  }

  String getRegisterKey(String namespace, String method) {
    return '$namespace:$method';
  }

  Future<void> _deleteSession(
    String topic, {
    bool expirerHasDeleted = false,
  }) async {
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

  Future<void> _setExpiry(String topic, int expiry) async {
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
    sessionTopics.map((topic) async => await _deleteSession(topic));
    proposalIds.map((id) async => await _deleteProposal(id));
  }

  /// ---- Relay Events ---- ///

  void _registerRelayClientFunctions() {
    core.pairing.register(
      method: MethodConstants.WC_SESSION_PROPOSE,
      function: _onSessionProposeRequest,
      type: ProtocolType.Sign,
    );
    core.pairing.register(
      method: MethodConstants.WC_SESSION_SETTLE,
      function: _onSessionSettleRequest,
      type: ProtocolType.Sign,
    );
    core.pairing.register(
      method: MethodConstants.WC_SESSION_UPDATE,
      function: _onSessionUpdateRequest,
      type: ProtocolType.Sign,
    );
    core.pairing.register(
      method: MethodConstants.WC_SESSION_EXTEND,
      function: _onSessionExtendRequest,
      type: ProtocolType.Sign,
    );
    core.pairing.register(
      method: MethodConstants.WC_SESSION_PING,
      function: _onSessionPingRequest,
      type: ProtocolType.Sign,
    );
    core.pairing.register(
      method: MethodConstants.WC_SESSION_DELETE,
      function: _onSessionDeleteRequest,
      type: ProtocolType.Sign,
    );
    core.pairing.register(
      method: MethodConstants.WC_SESSION_REQUEST,
      function: _onSessionRequest,
      type: ProtocolType.Sign,
    );
    core.pairing.register(
      method: MethodConstants.WC_SESSION_EVENT,
      function: _onSessionEventRequest,
      type: ProtocolType.Sign,
    );
  }

  Future<void> _onSessionProposeRequest(
    String topic,
    JsonRpcRequest payload,
  ) async {
    try {
      // print(payload.params);
      final proposeRequest = WcSessionProposeRequest.fromJson(payload.params);
      await _isValidConnect(
        requiredNamespaces: proposeRequest.requiredNamespaces,
        optionalNamespaces: proposeRequest.optionalNamespaces,
        sessionProperties: proposeRequest.sessionProperties,
        pairingTopic: topic,
        relays: proposeRequest.relays,
      );
      final expiry = WalletConnectUtils.calculateExpiry(
        WalletConnectConstants.FIVE_MINUTES,
      );
      final ProposalData proposal = ProposalData(
        id: payload.id,
        expiry: expiry,
        relays: proposeRequest.relays,
        proposer: proposeRequest.proposer,
        requiredNamespaces: proposeRequest.requiredNamespaces,
        optionalNamespaces: proposeRequest.optionalNamespaces,
        sessionProperties: proposeRequest.sessionProperties,
        pairingTopic: topic,
      );

      await _setProposal(payload.id, proposal);
      onSessionProposal.broadcast(SessionProposalEvent(
        payload.id,
        proposal,
      ));
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

  Future<void> _onSessionSettleRequest(
    String topic,
    JsonRpcRequest payload,
  ) async {
    // print('wc session settle');
    final request = WcSessionSettleRequest.fromJson(payload.params);
    try {
      await _isValidSessionSettleRequest(request.namespaces, request.expiry);
      // SessionProposalCompleter sProposalCompleter =
      //     pendingProposals.remove(topic)!;
      final SessionProposalCompleter sProposalCompleter =
          pendingProposals.removeLast();

      // Create the session
      final SessionData session = SessionData(
        topic: topic,
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
      _setExpiry(topic, session.expiry);
      await core.pairing.updateMetadata(
        topic: sProposalCompleter.pairingTopic,
        metadata: request.controller.metadata,
      );
      await core.pairing.activate(topic: topic);

      // Send the session back to the completer
      sProposalCompleter.completer.complete(session);

      // Send back a success!
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
      await _setExpiry(
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
      onSessionDelete.broadcast(
        SessionDelete(
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

  /// Called when a session request is received
  /// Will attempt to find a handler for the request, if it doesn't,
  /// it will throw an error.
  Future<void> _onSessionRequest(
    String topic,
    JsonRpcRequest payload,
  ) async {
    try {
      final request = WcSessionRequestRequest.fromJson(payload.params);
      await _isValidRequest(
        topic,
        request.chainId,
        request.request,
      );

      SessionRequest sessionRequest = SessionRequest(
        id: payload.id,
        topic: topic,
        method: request.request.method,
        chainId: request.chainId,
        params: request.request.params,
      );

      // print('payload id: ${payload.id}');
      await _setPendingRequest(
        payload.id,
        sessionRequest,
      );

      final String methodKey = getRegisterKey(
        request.chainId,
        request.request.method,
      );
      // print('method key: $methodKey');
      if (_methodHandlers.containsKey(methodKey)) {
        final handler = _methodHandlers[methodKey];
        if (handler != null) {
          try {
            final result = await handler(
              topic,
              request.request.params,
            );
            await core.pairing.sendResult(
              payload.id,
              topic,
              MethodConstants.WC_SESSION_REQUEST,
              result,
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
          await pendingRequests.delete(
            payload.id.toString(),
          );
        }
      } else {
        await core.pairing.sendError(
          payload.id,
          topic,
          payload.method,
          JsonRpcError.methodNotFound(
            'No handler found for chainId:method -> $methodKey',
          ),
        );
      }

      onSessionRequest.broadcast(
        SessionRequestEvent.fromSessionRequest(
          sessionRequest,
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

      onSessionEvent.broadcast(
        SessionEvent(
          payload.id,
          topic,
          event.name,
          request.chainId,
          event.data,
        ),
      );

      final String eventKey = getRegisterKey(
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

  void _registerExpirerEvents() {
    core.expirer.onExpire.subscribe(_onExpired);
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

  /// ---- Validation Helpers ---- ///

  Future<bool> _isValidPairingTopic(String topic) async {
    if (!core.pairing.getStore().has(topic)) {
      throw Errors.getInternalError(
        Errors.NO_MATCHING_KEY,
        context: "pairing topic doesn't exist: $topic",
      );
    }

    if (await core.expirer.checkAndExpire(topic)) {
      throw Errors.getInternalError(
        Errors.EXPIRED,
        context: "pairing topic: $topic",
      );
    }

    return true;
  }

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
        context: "session topic: $topic",
      );
    }

    return true;
  }

  Future<bool> _isValidSessionOrPairingTopic(String topic) async {
    if (sessions.has(topic)) {
      await _isValidSessionTopic(topic);
    } else if (core.pairing.getStore().has(topic)) {
      await _isValidPairingTopic(topic);
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
        context: "proposal id: $id",
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
        context: "pending request id: $id",
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
      await _isValidPairingTopic(pairingTopic);
    }

    if (requiredNamespaces != null) {
      SignApiValidatorUtils.isValidRequiredNamespaces(
        requiredNamespaces: requiredNamespaces,
        context: "connect() check requiredNamespaces.",
      );
    }

    if (optionalNamespaces != null) {
      SignApiValidatorUtils.isValidRequiredNamespaces(
        requiredNamespaces: optionalNamespaces,
        context: "connect() check optionalNamespaces.",
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
      context: "approve()",
    );

    // Validate the required and optional namespaces
    SignApiValidatorUtils.isValidRequiredNamespaces(
      requiredNamespaces: proposal.requiredNamespaces,
      context: "approve() check requiredNamespaces.",
    );
    SignApiValidatorUtils.isValidRequiredNamespaces(
      requiredNamespaces: proposal.optionalNamespaces,
      context: "approve() check optionalNamespaces.",
    );

    // Make sure the provided namespaces conforms with the required
    SignApiValidatorUtils.isConformingNamespaces(
      requiredNamespaces: proposal.requiredNamespaces,
      namespaces: namespaces,
      context: "approve()",
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
      context: "onSessionSettleRequest()",
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
      context: "update()",
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

  Future<bool> _isValidDisconnect(
    String topic,
  ) async {
    await _isValidSessionOrPairingTopic(topic);

    return true;
  }
}

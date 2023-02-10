import 'package:event/event.dart';
import 'package:wallet_connect_flutter_v2/apis/core/pairing/i_pairing_store.dart';
import 'package:wallet_connect_flutter_v2/apis/core/relay_client/relay_client_models.dart';
import 'package:wallet_connect_flutter_v2/apis/models/basic_models.dart';
import 'package:wallet_connect_flutter_v2/apis/signing_api/sign_engine.dart';
import 'package:wallet_connect_flutter_v2/apis/signing_api/i_sign_engine.dart';
import 'package:wallet_connect_flutter_v2/apis/core/pairing/utils/pairing_models.dart';
import 'package:wallet_connect_flutter_v2/apis/core/i_core.dart';
import 'package:wallet_connect_flutter_v2/apis/signing_api/i_sessions.dart';
import 'package:wallet_connect_flutter_v2/apis/signing_api/i_proposals.dart';
import 'package:wallet_connect_flutter_v2/apis/signing_api/i_sign_client.dart';
import 'package:wallet_connect_flutter_v2/apis/signing_api/models/json_rpc_models.dart';
import 'package:wallet_connect_flutter_v2/apis/signing_api/models/proposal_models.dart';
import 'package:wallet_connect_flutter_v2/apis/signing_api/models/sign_client_models.dart';
import 'package:wallet_connect_flutter_v2/apis/signing_api/models/sign_client_events.dart';
import 'package:wallet_connect_flutter_v2/apis/signing_api/models/session_models.dart';
import 'package:wallet_connect_flutter_v2/apis/signing_api/proposals.dart';
import 'package:wallet_connect_flutter_v2/apis/signing_api/sessions.dart';

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
  Event<SessionProposal> get onSessionProposal => engine.onSessionProposal;

  @override
  Event<SessionRequest> get onSessionRequest => engine.onSessionRequest;

  @override
  Event<SessionUpdate> get onSessionUpdate => engine.onSessionUpdate;

  @override
  IProposals get proposals => engine.proposals;

  @override
  ISessions get sessions => engine.sessions;

  @override
  final ICore core;

  @override
  late ISignEngine engine;

  static Future<SignClient> createInstance(
    ICore core, {
    PairingMetadata? self,
  }) async {
    final client = SignClient(core, self: self);
    await client.init();

    return client;
  }

  SignClient(
    this.core, {
    PairingMetadata? self,
  }) {
    Proposals p = Proposals(core);
    Sessions s = Sessions(core);
    engine = SignEngine(
      core,
      p,
      s,
      selfMetadata: self,
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
  }) async {
    try {
      return await engine.connect(
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
    String? relayProtocol,
  }) async {
    try {
      return await engine.approve(
        id: id,
        namespaces: namespaces,
        relayProtocol: relayProtocol,
      );
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<void> reject({
    required int id,
    required WCErrorResponse reason,
  }) async {
    try {
      return await engine.reject(
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
      return await engine.update(
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
      return await engine.extend(topic: topic);
    } catch (e) {
      rethrow;
    }
  }

  @override
  void registerRequestHandler({
    required String chainId,
    required String method,
    required void Function(String, dynamic) handler,
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
  Future request({
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
  void registerEventHandler({
    required String chainId,
    required String event,
    required void Function(String, dynamic) handler,
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
  Future<void> emit({
    required String topic,
    required String chainId,
    required SessionEventParams event,
  }) async {
    try {
      return await engine.emit(
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
    required WCErrorResponse reason,
  }) async {
    try {
      return await engine.disconnect(
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
  IPairingStore get pairings => core.pairing.getStore();
}

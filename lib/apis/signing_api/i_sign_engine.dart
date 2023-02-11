import 'package:event/event.dart';
import 'package:wallet_connect_flutter_v2/apis/core/i_core.dart';
import 'package:wallet_connect_flutter_v2/apis/core/pairing/i_pairing_store.dart';
import 'package:wallet_connect_flutter_v2/apis/core/pairing/utils/pairing_models.dart';
import 'package:wallet_connect_flutter_v2/apis/core/relay_client/relay_client_models.dart';
import 'package:wallet_connect_flutter_v2/apis/models/basic_models.dart';
import 'package:wallet_connect_flutter_v2/apis/signing_api/i_proposals.dart';
import 'package:wallet_connect_flutter_v2/apis/signing_api/i_sessions.dart';
import 'package:wallet_connect_flutter_v2/apis/signing_api/models/json_rpc_models.dart';
import 'package:wallet_connect_flutter_v2/apis/signing_api/models/proposal_models.dart';
import 'package:wallet_connect_flutter_v2/apis/signing_api/models/session_models.dart';
import 'package:wallet_connect_flutter_v2/apis/signing_api/models/sign_client_events.dart';
import 'package:wallet_connect_flutter_v2/apis/signing_api/models/sign_client_models.dart';

abstract class ISignEngine {
  abstract final Event<SessionConnect> onSessionConnect;
  abstract final Event<SessionProposal> onSessionProposal;
  abstract final Event<SessionUpdate> onSessionUpdate;
  abstract final Event<SessionExtend> onSessionExtend;
  abstract final Event<SessionExpire> onSessionExpire;
  abstract final Event<SessionRequest> onSessionRequest;
  abstract final Event<SessionEvent> onSessionEvent;
  abstract final Event<SessionPing> onSessionPing;
  abstract final Event<SessionDelete> onSessionDelete;

  abstract final ICore core;
  abstract final IProposals proposals;
  abstract final ISessions sessions;

  Future<void> init();
  Future<ConnectResponse> connect({
    Map<String, RequiredNamespace>? requiredNamespaces,
    Map<String, RequiredNamespace>? optionalNamespaces,
    Map<String, String>? sessionProperties,
    String? pairingTopic,
    List<Relay>? relays,
  });
  Future<PairingInfo> pair({
    required Uri uri,
  });
  Future<ApproveResponse> approveSession({
    required int id,
    required Map<String, Namespace> namespaces,
    String? relayProtocol,
  });
  Future<void> reject({
    required int id,
    required WCErrorResponse reason,
  });
  Future<void> update({
    required String topic,
    required Map<String, Namespace> namespaces,
  });
  Future<void> extend({
    required String topic,
  });
  void registerRequestHandler({
    required String chainId,
    required String method,
    required dynamic Function(String, dynamic) handler,
  });
  Future<dynamic> request({
    required String topic,
    required String chainId,
    required SessionRequestParams request,
  });
  void registerEventHandler({
    required String chainId,
    required String event,
    required dynamic Function(String, dynamic) handler,
  });
  Future<void> emit({
    required String topic,
    required String chainId,
    required SessionEventParams event,
  });
  Future<void> ping({
    required String topic,
  });
  Future<void> disconnect({
    required String topic,
    required WCErrorResponse reason,
  });
  SessionData? find({
    required Map<String, RequiredNamespace> requiredNamespaces,
  });
  abstract final IPairingStore pairings;
}

import 'package:event/event.dart';
import 'package:wallet_connect_flutter_v2/apis/core/store/i_generic_store.dart';
import 'package:wallet_connect_flutter_v2/apis/core/i_core.dart';
import 'package:wallet_connect_flutter_v2/apis/core/pairing/i_pairing_store.dart';
import 'package:wallet_connect_flutter_v2/apis/core/pairing/utils/pairing_models.dart';
import 'package:wallet_connect_flutter_v2/apis/models/basic_models.dart';
import 'package:wallet_connect_flutter_v2/apis/models/json_rpc_error.dart';
import 'package:wallet_connect_flutter_v2/apis/models/json_rpc_response.dart';
import 'package:wallet_connect_flutter_v2/apis/signing_api/i_sessions.dart';
import 'package:wallet_connect_flutter_v2/apis/signing_api/models/json_rpc_models.dart';
import 'package:wallet_connect_flutter_v2/apis/signing_api/models/proposal_models.dart';
import 'package:wallet_connect_flutter_v2/apis/signing_api/models/session_models.dart';
import 'package:wallet_connect_flutter_v2/apis/signing_api/models/sign_client_events.dart';
import 'package:wallet_connect_flutter_v2/apis/signing_api/models/sign_client_models.dart';

abstract class ISignEngineWallet {
  abstract final Event<SessionProposalEvent> onSessionProposal;
  abstract final Event<SessionRequestEvent> onSessionRequest;
  abstract final Event<SessionDelete> onSessionDelete;

  abstract final ICore core;
  abstract final PairingMetadata metadata;
  abstract final IGenericStore<ProposalData> proposals;
  abstract final ISessions sessions;
  abstract final IGenericStore<SessionRequest> pendingRequests;

  Future<void> init();
  Future<PairingInfo> pair({
    required Uri uri,
  });
  Future<ApproveResponse> approveSession({
    required int id,
    required Map<String, Namespace> namespaces,
    String? relayProtocol,
  });
  Future<void> rejectSession({
    required int id,
    required WCErrorResponse reason,
  });
  Future<void> updateSession({
    required String topic,
    required Map<String, Namespace> namespaces,
  });
  Future<void> extendSession({
    required String topic,
  });
  void registerRequestHandler({
    required String chainId,
    required String method,
    dynamic Function(String, dynamic)? handler,
  });
  Future<void> respondSessionRequest({
    required String topic,
    required JsonRpcResponse response,
  });
  Future<void> emitSessionEvent({
    required String topic,
    required String chainId,
    required SessionEventParams event,
  });
  Future<void> disconnectSession({
    required String topic,
    required WCErrorResponse reason,
  });
  SessionData? find({
    required Map<String, RequiredNamespace> requiredNamespaces,
  });
  Map<String, SessionData> getActiveSessions();
  Map<String, ProposalData> getPendingSessionProposals();
  Map<String, SessionRequest> getPendingSessionRequests();
  abstract final IPairingStore pairings;
}

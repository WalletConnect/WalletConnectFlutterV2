import 'package:event/event.dart';
import 'package:walletconnect_flutter_v2/apis/core/pairing/utils/pairing_models.dart';
import 'package:walletconnect_flutter_v2/apis/models/basic_models.dart';
import 'package:walletconnect_flutter_v2/apis/models/json_rpc_response.dart';
import 'package:walletconnect_flutter_v2/apis/sign_api/i_sign_engine_common.dart';
import 'package:walletconnect_flutter_v2/apis/sign_api/models/auth/common_auth_models.dart';
import 'package:walletconnect_flutter_v2/apis/sign_api/models/json_rpc_models.dart';
import 'package:walletconnect_flutter_v2/apis/sign_api/models/proposal_models.dart';
import 'package:walletconnect_flutter_v2/apis/sign_api/models/session_models.dart';
import 'package:walletconnect_flutter_v2/apis/sign_api/models/sign_client_events.dart';
import 'package:walletconnect_flutter_v2/apis/sign_api/models/sign_client_models.dart';
import 'package:walletconnect_flutter_v2/apis/core/store/i_generic_store.dart';
import 'package:walletconnect_flutter_v2/apis/sign_api/models/auth/auth_client_events.dart';
import 'package:walletconnect_flutter_v2/apis/sign_api/models/auth/auth_client_models.dart';

import 'package:walletconnect_flutter_v2/apis/sign_api/models/auth/session_auth_models.dart';
import 'package:walletconnect_flutter_v2/apis/sign_api/models/auth/session_auth_events.dart';

abstract class ISignEngineWallet extends ISignEngineCommon {
  abstract final Event<SessionProposalEvent> onSessionProposal;
  abstract final Event<SessionProposalErrorEvent> onSessionProposalError;
  abstract final Event<SessionRequestEvent> onSessionRequest;

  // FORMER AUTH ENGINE PROPERTY
  abstract final Event<AuthRequest> onAuthRequest;
  abstract final IGenericStore<PendingAuthRequest> authRequests;
  // NEW 1-CA METHOD
  abstract final Event<SessionAuthRequest> onSessionAuthRequest;
  abstract final IGenericStore<PendingSessionAuthRequest> sessionAuthRequests;

  Future<PairingInfo> pair({
    required Uri uri,
  });
  Future<ApproveResponse> approveSession({
    required int id,
    required Map<String, Namespace> namespaces,
    Map<String, String>? sessionProperties,
    String? relayProtocol,
  });
  Future<void> rejectSession({
    required int id,
    required WalletConnectError reason,
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
  SessionData? find({
    required Map<String, RequiredNamespace> requiredNamespaces,
  });
  Map<String, SessionRequest> getPendingSessionRequests();

  /// Register event emitters for a given namespace or chainId
  /// Used to construct the Namespaces map for the session proposal
  void registerEventEmitter({
    required String chainId,
    required String event,
  });

  /// Register accounts for a given namespace or chainId.
  /// Used to construct the Namespaces map for the session proposal.
  /// Each account must follow the namespace:chainId:address format or this will throw an error.
  void registerAccount({
    required String chainId,
    required String accountAddress,
  });

  /// Construct the Namespaces map for a session proposal.
  /// Uses the registered methods, events, and keys to build them.
  /// If the required namespaces is not satisfied, this function will throw a [WalletConnectError].
  /// The optional namespaces are included if they exist in the registered information.
  // Map<String, Namespace> constructNamespaces({
  //   required Map<String, RequiredNamespace> requiredNamespaces,
  //   Map<String, RequiredNamespace>? optionalNamespaces,
  // });

  // FORMER AUTH ENGINE METHODS

  Future<void> respondAuthRequest({
    required int id,
    required String iss,
    CacaoSignature? signature,
    WalletConnectError? error,
  });

  Map<int, PendingAuthRequest> getPendingAuthRequests();

  // NEW 1-CA METHODS

  Future<ApproveResponse> approveSessionAuthenticate({
    required int id,
    List<Cacao>? auths,
  });

  Future<void> rejectSessionAuthenticate({
    required int id,
    required WalletConnectError reason,
  });

  Map<int, PendingSessionAuthRequest> getPendingSessionAuthRequests();
}

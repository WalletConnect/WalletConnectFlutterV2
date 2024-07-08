import 'package:walletconnect_flutter_v2/apis/core/store/i_generic_store.dart';
import 'package:walletconnect_flutter_v2/apis/sign_api/i_sessions.dart';
import 'package:walletconnect_flutter_v2/walletconnect_flutter_v2.dart';

abstract class ISignClient {
  final String protocol = 'wc';
  final int version = 2;

  abstract final ISignEngine engine;

  // Common
  abstract final Event<SessionConnect> onSessionConnect;
  abstract final Event<SessionDelete> onSessionDelete;
  abstract final Event<SessionExpire> onSessionExpire;
  abstract final Event<SessionPing> onSessionPing;
  abstract final Event<SessionProposalEvent> onProposalExpire;

  abstract final ICore core;
  abstract final PairingMetadata metadata;
  abstract final IGenericStore<ProposalData> proposals;
  abstract final ISessions sessions;
  abstract final IGenericStore<SessionRequest> pendingRequests;

  // FORMER AUTH ENGINE PROPERTIES
  abstract final IGenericStore<AuthPublicKey> authKeys;
  abstract final IGenericStore<String> pairingTopics;
  abstract final IGenericStore<StoredCacao> completeRequests;

  // Wallet
  abstract final Event<SessionProposalEvent> onSessionProposal;
  abstract final Event<SessionProposalErrorEvent> onSessionProposalError;
  abstract final Event<SessionRequestEvent> onSessionRequest;
  // FORMER AUTH ENGINE METHODS
  abstract final Event<AuthRequest> onAuthRequest;
  abstract final IGenericStore<PendingAuthRequest> authRequests;
  // NEW 1-CA METHODS
  abstract final Event<SessionAuthRequest> onSessionAuthRequest;
  abstract final IGenericStore<PendingSessionAuthRequest> sessionAuthRequests;

  // App
  abstract final Event<SessionUpdate> onSessionUpdate;
  abstract final Event<SessionExtend> onSessionExtend;
  abstract final Event<SessionEvent> onSessionEvent;
  // FORMER AUTH ENGINE METHOD
  abstract final Event<AuthResponse> onAuthResponse;
  // NEW 1-CA METHOD
  abstract final Event<SessionAuthResponse> onSessionAuthResponse;

  Future<void> init();
  Future<ConnectResponse> connect({
    Map<String, RequiredNamespace>? requiredNamespaces,
    Map<String, RequiredNamespace>? optionalNamespaces,
    Map<String, String>? sessionProperties,
    String? pairingTopic,
    List<Relay>? relays,
    List<List<String>>? methods,
  });
  Future<PairingInfo> pair({
    required Uri uri,
  });
  Future<ApproveResponse> approve({
    required int id,
    required Map<String, Namespace> namespaces,
    Map<String, String>? sessionProperties,
    String? relayProtocol,
  });
  Future<void> reject({
    required int id,
    required WalletConnectError reason,
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
    dynamic Function(String, dynamic)? handler,
  });
  Future<void> respond({
    required String topic,
    required JsonRpcResponse response,
  });
  Future<void> emit({
    required String topic,
    required String chainId,
    required SessionEventParams event,
  });
  Future<dynamic> request({
    required String topic,
    required String chainId,
    required SessionRequestParams request,
  });
  Future<List<dynamic>> requestReadContract({
    required DeployedContract deployedContract,
    required String functionName,
    required String rpcUrl,
    EthereumAddress? sender,
    List<dynamic> parameters = const [],
  });
  Future<dynamic> requestWriteContract({
    required String topic,
    required String chainId,
    required String rpcUrl,
    required DeployedContract deployedContract,
    required String functionName,
    required Transaction transaction,
    String? method,
    List<dynamic> parameters = const [],
  });

  void registerEventHandler({
    required String chainId,
    required String event,
    required dynamic Function(String, dynamic)? handler,
  });
  Future<void> ping({
    required String topic,
  });
  Future<void> disconnect({
    required String topic,
    required WalletConnectError reason,
  });
  SessionData? find({
    required Map<String, RequiredNamespace> requiredNamespaces,
  });
  Map<String, SessionData> getActiveSessions();
  Map<String, SessionData> getSessionsForPairing({
    required String pairingTopic,
  });
  Map<String, ProposalData> getPendingSessionProposals();
  Map<String, SessionRequest> getPendingSessionRequests();
  abstract final IPairingStore pairings;

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

  // FORMER AUTH ENGINE COMMON METHODS

  String formatAuthMessage({
    required String iss,
    required CacaoRequestPayload cacaoPayload,
  });

  Map<int, StoredCacao> getCompletedRequestsForPairing({
    required String pairingTopic,
  });

  // FORMER AUTH ENGINE WALLET METHODS

  Future<void> respondAuthRequest({
    required int id,
    required String iss,
    CacaoSignature? signature,
    WalletConnectError? error,
  });

  Map<int, PendingAuthRequest> getPendingAuthRequests();

  // FORMER AUTH ENGINE DAPP METHODS

  Future<AuthRequestResponse> requestAuth({
    required AuthRequestParams params,
    String? pairingTopic,
    List<List<String>>? methods,
  });

  // NEW 1-CA WALLET METHODS

  Future<ApproveResponse> approveSessionAuthenticate({
    required int id,
    List<Cacao>? auths,
  });

  Future<void> rejectSessionAuthenticate({
    required int id,
    required WalletConnectError reason,
  });

  Map<int, PendingSessionAuthRequest> getPendingSessionAuthRequests();

  // NEW 1-CA DAPP METHODS

  Future<SessionAuthRequestResponse> authenticate({
    required SessionAuthRequestParams params,
    String? pairingTopic,
    List<List<String>>? methods,
  });

  Future<bool> validateSignedCacao({
    required Cacao cacao,
    required String projectId,
  });
}

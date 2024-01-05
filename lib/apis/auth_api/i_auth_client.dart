import 'package:walletconnect_flutter_v2/apis/core/store/i_generic_store.dart';
import 'package:walletconnect_flutter_v2/walletconnect_flutter_v2.dart';

abstract class IAuthClient {
  final String protocol = 'wc';
  final int version = 2;

  abstract final IAuthEngine engine;

  // Common
  abstract final ICore core;
  abstract final PairingMetadata metadata;

  abstract final IGenericStore<AuthPublicKey> authKeys;
  abstract final IGenericStore<String> pairingTopics;
  abstract final IGenericStore<StoredCacao> completeRequests;

  // initializes the client with persisted storage and a network connection
  Future<void> init();

  /// format payload to message string
  String formatMessage({
    required String iss,
    required CacaoRequestPayload cacaoPayload,
  });

  Map<int, StoredCacao> getCompletedRequestsForPairing({
    required String pairingTopic,
  });

  // App
  abstract final Event<AuthResponse> onAuthResponse;

  // request wallet authentication
  Future<AuthRequestResponse> request({
    required AuthRequestParams params,
    String? pairingTopic,
    List<List<String>>? methods,
  });

  // Wallet
  abstract final Event<AuthRequest> onAuthRequest;

  abstract final IGenericStore<PendingAuthRequest> authRequests;

  /// respond wallet authentication
  Future<void> respond({
    required int id,
    required String iss,
    CacaoSignature? signature,
    WalletConnectError? error,
  });

  // query all pending requests
  Map<int, PendingAuthRequest> getPendingRequests();
}

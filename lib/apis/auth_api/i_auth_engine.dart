import 'package:event/event.dart';
import 'package:wallet_connect_flutter_v2/apis/auth_api/models/auth_client_events.dart';
import 'package:wallet_connect_flutter_v2/apis/auth_api/models/auth_client_models.dart';
import 'package:wallet_connect_flutter_v2/apis/auth_api/stores/i_generic_store.dart';
import 'package:wallet_connect_flutter_v2/apis/core/i_core.dart';
import 'package:wallet_connect_flutter_v2/apis/core/pairing/utils/pairing_models.dart';
import 'package:wallet_connect_flutter_v2/apis/models/basic_models.dart';

abstract class IAuthEngine {
  // ---------- Events ----------------------------------------------- //

  abstract final Event<AuthRequest> onAuthRequest;
  abstract final Event<AuthResponse> onAuthResponse;

  abstract final ICore core;
  abstract final PairingMetadata metadata;

  abstract final IGenericStore<AuthPublicKey> authKeys;
  abstract final IGenericStore<String> pairingTopics;
  abstract final IGenericStore<PendingRequest> authRequests;

  // initializes the client with persisted storage and a network connection
  Future<void> init();

  // request wallet authentication
  Future<AuthRequestResponse> requestAuth({
    required String topic,
    required AuthRequestParams params,
  });

  /// respond wallet authentication
  Future<bool> respond({
    required int id,
    required String iss,
    CacaoSignature? signature,
    WCErrorResponse? error,
  });

  // query all pending requests
  Map<int, PendingRequest> getPendingRequests();

  /// format payload to message string
  String formatMessage({
    required String iss,
    required CacaoPayload cacao,
  });
}

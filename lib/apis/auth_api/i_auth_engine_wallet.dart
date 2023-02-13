import 'package:event/event.dart';
import 'package:wallet_connect_flutter_v2/apis/auth_api/models/auth_client_events.dart';
import 'package:wallet_connect_flutter_v2/apis/auth_api/models/auth_client_models.dart';
import 'package:wallet_connect_flutter_v2/apis/core/store/i_generic_store.dart';
import 'package:wallet_connect_flutter_v2/apis/core/i_core.dart';
import 'package:wallet_connect_flutter_v2/apis/core/pairing/utils/pairing_models.dart';
import 'package:wallet_connect_flutter_v2/apis/models/basic_models.dart';

abstract class IAuthEngineWallet {
  abstract final Event<AuthRequest> onAuthRequest;

  abstract final ICore core;
  abstract final PairingMetadata metadata;

  abstract final IGenericStore<AuthPublicKey> authKeys;
  abstract final IGenericStore<String> pairingTopics;
  abstract final IGenericStore<PendingAuthRequest> authRequests;
  abstract final IGenericStore<StoredCacao> completeRequests;

  // initializes the client with persisted storage and a network connection
  Future<void> init();

  /// respond wallet authentication
  Future<void> respondAuthRequest({
    required int id,
    required String iss,
    CacaoSignature? signature,
    WCErrorResponse? error,
  });

  // query all pending requests
  Map<int, PendingAuthRequest> getPendingAuthRequests();

  /// format payload to message string
  String formatAuthMessage({
    required String iss,
    required CacaoRequestPayload cacaoPayload,
  });
}

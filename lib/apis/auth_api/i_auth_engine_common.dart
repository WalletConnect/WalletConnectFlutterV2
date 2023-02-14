import 'package:walletconnect_dart_v2/apis/auth_api/models/auth_client_models.dart';
import 'package:walletconnect_dart_v2/apis/core/store/i_generic_store.dart';
import 'package:walletconnect_dart_v2/apis/core/i_core.dart';
import 'package:walletconnect_dart_v2/apis/core/pairing/utils/pairing_models.dart';

abstract class IAuthEngineCommon {
  abstract final ICore core;
  abstract final PairingMetadata metadata;

  abstract final IGenericStore<AuthPublicKey> authKeys;
  abstract final IGenericStore<String> pairingTopics;
  abstract final IGenericStore<StoredCacao> completeRequests;

  // initializes the client with persisted storage and a network connection
  Future<void> init();

  /// format payload to message string
  String formatAuthMessage({
    required String iss,
    required CacaoRequestPayload cacaoPayload,
  });
}

import 'package:event/event.dart';
import 'package:walletconnect_dart_v2/apis/auth_api/models/auth_client_events.dart';
import 'package:walletconnect_dart_v2/apis/auth_api/models/auth_client_models.dart';
import 'package:walletconnect_dart_v2/apis/core/store/i_generic_store.dart';
import 'package:walletconnect_dart_v2/apis/core/i_core.dart';
import 'package:walletconnect_dart_v2/apis/core/pairing/utils/pairing_models.dart';
import 'package:walletconnect_dart_v2/apis/models/basic_models.dart';

abstract class IAuthEngineApp {
  abstract final Event<AuthResponse> onAuthResponse;

  abstract final ICore core;
  abstract final PairingMetadata metadata;

  abstract final IGenericStore<AuthPublicKey> authKeys;
  abstract final IGenericStore<String> pairingTopics;
  abstract final IGenericStore<StoredCacao> completeRequests;

  // initializes the client with persisted storage and a network connection
  Future<void> init();

  // request wallet authentication
  Future<AuthRequestResponse> requestAuth({
    required AuthRequestParams params,
    String? pairingTopic,
  });

  /// format payload to message string
  String formatAuthMessage({
    required String iss,
    required CacaoRequestPayload cacaoPayload,
  });
}

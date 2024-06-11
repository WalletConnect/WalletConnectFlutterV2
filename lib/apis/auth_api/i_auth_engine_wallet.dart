import 'package:event/event.dart';
import 'package:walletconnect_flutter_v2/apis/auth_api/i_auth_engine_common.dart';
import 'package:walletconnect_flutter_v2/apis/sign_api/models/auth/auth_client_events.dart';
import 'package:walletconnect_flutter_v2/apis/sign_api/models/auth/auth_client_models.dart';
import 'package:walletconnect_flutter_v2/apis/sign_api/models/auth/common_auth_models.dart';
import 'package:walletconnect_flutter_v2/apis/core/store/i_generic_store.dart';
import 'package:walletconnect_flutter_v2/apis/models/basic_models.dart';

abstract class IAuthEngineWallet extends IAuthEngineCommon {
  abstract final Event<AuthRequest> onAuthRequest;

  abstract final IGenericStore<PendingAuthRequest> authRequests;

  /// respond wallet authentication
  Future<void> respondAuthRequest({
    required int id,
    required String iss,
    CacaoSignature? signature,
    WalletConnectError? error,
  });

  // query all pending requests
  Map<int, PendingAuthRequest> getPendingAuthRequests();
}

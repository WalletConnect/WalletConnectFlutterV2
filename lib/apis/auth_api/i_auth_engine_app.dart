import 'package:event/event.dart';
import 'package:walletconnect_flutter_v2/apis/auth_api/i_auth_engine_common.dart';
import 'package:walletconnect_flutter_v2/apis/sign_api/models/auth/auth_client_events.dart';
import 'package:walletconnect_flutter_v2/apis/sign_api/models/auth/auth_client_models.dart';

abstract class IAuthEngineApp extends IAuthEngineCommon {
  abstract final Event<AuthResponse> onAuthResponse;

  @Deprecated(
    'AuthEngine/AuthClient is deprecated and will be removed soon. '
    'Please use authenticate() method from SignEngine/SignClient instead',
  )
  Future<AuthRequestResponse> requestAuth({
    required AuthRequestParams params,
    String? pairingTopic,
    List<List<String>>? methods,
  });
}

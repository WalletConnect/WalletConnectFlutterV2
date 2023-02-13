import 'package:event/event.dart';
import 'package:wallet_connect_flutter_v2/apis/auth_api/i_auth_engine_wallet.dart';
import 'package:wallet_connect_flutter_v2/apis/auth_api/models/auth_client_events.dart';
import 'package:wallet_connect_flutter_v2/apis/auth_api/models/auth_client_models.dart';

abstract class IAuthEngine extends IAuthEngineWallet {
  abstract final Event<AuthResponse> onAuthResponse;

  // request wallet authentication
  Future<AuthRequestResponse> requestAuth({
    required AuthRequestParams params,
    String? pairingTopic,
  });
}

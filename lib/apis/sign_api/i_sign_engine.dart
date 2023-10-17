import 'package:walletconnect_flutter_v2/apis/sign_api/i_sign_engine_app.dart';
import 'package:walletconnect_flutter_v2/apis/sign_api/i_sign_engine_wallet.dart';

abstract class ISignEngine implements ISignEngineWallet, ISignEngineApp {
  Future<void> checkAndExpire();
}

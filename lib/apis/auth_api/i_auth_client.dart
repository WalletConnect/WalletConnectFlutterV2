import 'package:walletconnect_flutter_v2/apis/auth_api/i_auth_engine.dart';

abstract class IAuthClient extends IAuthEngine {
  final String protocol = 'wc';
  final int version = 2;

  abstract final IAuthEngine engine;
}

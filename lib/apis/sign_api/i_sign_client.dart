import 'package:walletconnect_flutter_v2/apis/sign_api/i_sign_engine.dart';

abstract class ISignClient extends ISignEngine {
  final String protocol = 'wc';
  final int version = 2;

  abstract final ISignEngine engine;
}

import 'package:walletconnect_flutter_v2/apis/sign_api/i_sign_engine_app.dart';
import 'package:walletconnect_flutter_v2/walletconnect_flutter_v2.dart';

abstract class IWeb3App implements ISignEngineApp {
  final String protocol = 'wc';
  final int version = 2;

  abstract final ISignEngine signEngine;
}

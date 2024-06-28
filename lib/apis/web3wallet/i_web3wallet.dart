import 'package:walletconnect_flutter_v2/apis/sign_api/i_sign_engine_wallet.dart';
import 'package:walletconnect_flutter_v2/walletconnect_flutter_v2.dart';

import 'package:walletconnect_flutter_v2/apis/auth_api/i_auth_engine_wallet.dart';

abstract class IWeb3Wallet implements ISignEngineWallet, IAuthEngineWallet {
  final String protocol = 'wc';
  final int version = 2;

  abstract final ISignEngine signEngine;
  abstract final IAuthEngine authEngine;
}

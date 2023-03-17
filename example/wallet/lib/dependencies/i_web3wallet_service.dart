import 'package:get_it/get_it.dart';
import 'package:walletconnect_flutter_v2/walletconnect_flutter_v2.dart';

abstract class IWeb3WalletService extends Disposable {
  void create();
  Future<void> init();
  Web3Wallet getWeb3Wallet();
}

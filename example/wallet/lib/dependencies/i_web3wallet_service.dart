import 'package:get_it/get_it.dart';
import 'package:walletconnect_flutter_v2/walletconnect_flutter_v2.dart';

class UpdateEvent extends EventArgs {
  final bool loading;

  UpdateEvent({required this.loading});
}

abstract class IWeb3WalletService extends Disposable {
  Future<void> create();
  Future<void> init();

  Web3Wallet get web3wallet;
}

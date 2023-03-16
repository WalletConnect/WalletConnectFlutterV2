import 'package:flutter/material.dart';
import 'package:walletconnect_flutter_v2/walletconnect_flutter_v2.dart';

class Web3WalletHandler extends StatefulWidget {
  const Web3WalletHandler({
    super.key,
    required this.web3Wallet,
  });

  final Web3Wallet web3Wallet;

  @override
  State<Web3WalletHandler> createState() => _Web3WalletHandlerState();
}

class _Web3WalletHandlerState extends State<Web3WalletHandler> {
  @override
  void initState() {
    widget.web3Wallet.onSessionConnect.subscribe(_onSessionConnect);

    super.initState();
  }

  @override
  void dispose() {
    widget.web3Wallet.onSessionConnect.unsubscribe(_onSessionConnect);

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container();
  }

  void _onSessionConnect(SessionConnect? args) {
    if (args != null) {
      print(args);
    }
  }
}

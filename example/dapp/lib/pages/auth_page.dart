import 'package:flutter/material.dart';

import 'package:walletconnect_flutter_v2_dapp/utils/constants.dart';
import 'package:walletconnect_flutter_v2_dapp/widgets/auth_item.dart';
import 'package:walletconnect_flutter_v2_dapp/imports.dart';

class AuthPage extends StatefulWidget {
  const AuthPage({
    super.key,
    required this.web3App,
  });

  final Web3App web3App;

  @override
  AuthPageState createState() => AuthPageState();
}

class AuthPageState extends State<AuthPage> {
  List<StoredCacao> authItems = [];

  @override
  void initState() {
    widget.web3App.onAuthResponse.subscribe(_onAuthResponse);
    super.initState();
  }

  @override
  void dispose() {
    widget.web3App.onAuthResponse.unsubscribe(_onAuthResponse);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    authItems = widget.web3App.completeRequests.getAll();

    final List<AuthItem> children = [];
    for (int i = 0; i < authItems.length; i++) {
      children.add(
        AuthItem(
          key: ValueKey(i),
          auth: authItems[i],
          onTap: () {},
        ),
      );
    }

    return Center(
      child: Container(
        constraints: const BoxConstraints(
          maxWidth: StyleConstants.maxWidth,
        ),
        child: ListView(
          children: children,
        ),
      ),
    );
  }

  void _onAuthResponse(AuthResponse? auth) {
    // If there wasn't an error, show the complete request
    if (auth!.error != null) {
      setState(() {
        authItems = widget.web3App.completeRequests.getAll();
      });
    }
  }
}

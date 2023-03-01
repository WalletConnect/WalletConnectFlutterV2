import 'package:flutter/material.dart';
import 'package:walletconnect_flutter_v2/walletconnect_flutter_v2.dart';

class AuthItem extends StatelessWidget {
  const AuthItem({
    required Key key,
    required this.auth,
    required this.onTap,
  }) : super(key: key);

  final StoredCacao auth;
  final void Function() onTap;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(auth.p.domain),
      subtitle: Text(auth.p.iss),
      onTap: onTap,
    );
  }
}

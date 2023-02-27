import 'package:flutter/material.dart';
import 'package:walletconnect_flutter_v2/walletconnect_flutter_v2.dart';

class SessionItem extends StatelessWidget {
  const SessionItem({
    required Key key,
    required this.session,
    required this.onTap,
  }) : super(key: key);

  final SessionData session;
  final void Function() onTap;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(session.peer.metadata.name),
      subtitle: Text(session.peer.metadata.url),
      onTap: onTap,
    );
  }
}

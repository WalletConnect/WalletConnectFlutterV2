import 'package:flutter/material.dart';
import 'package:walletconnect_flutter_v2/walletconnect_flutter_v2.dart';
import 'package:walletconnect_flutter_v2_dapp/utils/constants.dart';

class SessionItem extends StatelessWidget {
  const SessionItem({
    required Key key,
    required this.session,
  }) : super(key: key);

  final SessionData session;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            session.peer.metadata.name,
            style: StyleConstants.paragraph,
          ),
          Text(
            session.peer.metadata.url,
          ),
        ],
      ),
    );
  }
}

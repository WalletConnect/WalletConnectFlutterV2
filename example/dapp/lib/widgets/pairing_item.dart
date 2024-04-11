import 'package:flutter/material.dart';
import 'package:walletconnect_flutter_v2/walletconnect_flutter_v2.dart';
import 'package:walletconnect_flutter_v2_dapp/utils/constants.dart';

class PairingItem extends StatelessWidget {
  const PairingItem({
    required Key key,
    required this.pairing,
    required this.onTap,
  }) : super(key: key);

  final PairingInfo pairing;
  final void Function() onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(12.0),
        color: Colors.blue.withOpacity(0.2),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              pairing.peerMetadata?.name ?? 'Unknown',
              style: StyleConstants.paragraph,
            ),
            Text(
              pairing.peerMetadata?.url ?? 'Unknown',
            ),
          ],
        ),
      ),
    );
  }
}

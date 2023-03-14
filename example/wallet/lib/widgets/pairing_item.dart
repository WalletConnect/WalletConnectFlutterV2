import 'package:flutter/material.dart';
import 'package:walletconnect_flutter_v2/walletconnect_flutter_v2.dart';

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
    return ListTile(
      title: Text(pairing.peerMetadata?.name ?? 'Unknown'),
      subtitle: Text(pairing.peerMetadata?.url ?? 'Unknown'),
      onTap: onTap,
    );
  }
}

import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:walletconnect_flutter_v2/walletconnect_flutter_v2.dart';
// import 'package:walletconnect_flutter_v2_wallet/dependencies/deep_link_handler.dart';
import 'package:walletconnect_flutter_v2_wallet/dependencies/i_web3wallet_service.dart';

class PairingItem extends StatelessWidget {
  const PairingItem({
    super.key,
    required this.pairing,
    required this.onTap,
  });

  final PairingInfo pairing;
  final void Function() onTap;

  @override
  Widget build(BuildContext context) {
    PairingMetadata? metadata = pairing.peerMetadata;
    if (metadata == null) {
      return ListTile(
        title: const Text('Unknown'),
        subtitle: const Text('No metadata available'),
        onTap: onTap,
      );
    }
    final sessions = GetIt.I<IWeb3WalletService>()
        .web3wallet
        .sessions
        .getAll()
        .where((element) => element.pairingTopic == pairing.topic)
        .toList();

    return ListTile(
      leading: CircleAvatar(
        backgroundImage: (metadata.icons.isNotEmpty
                ? NetworkImage(metadata.icons[0])
                : const AssetImage('assets/images/default_icon.png'))
            as ImageProvider<Object>,
      ),
      title: Text(
        metadata.name,
        style: const TextStyle(color: Colors.black),
      ),
      subtitle: Text(
        sessions.isEmpty
            // ? DeepLinkHandler.waiting.value
            //     ? 'Settling session. Wait...'
            //     : 'No active sessions'
            ? 'No active sessions'
            : 'Active sessions: ${sessions.length}',
        style: TextStyle(
          color: sessions.isEmpty
              // ? DeepLinkHandler.waiting.value
              //     ? Colors.green
              //     : Colors.black
              ? Colors.black
              : Colors.blueAccent,
          fontSize: 13.0,
          fontWeight: sessions.isEmpty
              // ? DeepLinkHandler.waiting.value
              //     ? FontWeight.bold
              //     : FontWeight.normal
              ? FontWeight.normal
              : FontWeight.bold,
        ),
      ),
      trailing: const Icon(
        Icons.arrow_forward_ios,
        size: 20.0,
        color: Colors.black,
      ),
      onTap: onTap,
    );
  }
}

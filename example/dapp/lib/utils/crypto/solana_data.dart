import 'package:dapp/models/chain_metadata.dart';

enum SolanaMethods { solanaSignTransaction, solanaSignMessage }

class SolanaData {
  static const List<ChainMetadata> mainChains = [
    ChainMetadata(
      chainId: 'solana:4sGjMW1sUnHzSxGspuhpqLDx6wiyjNtZ',
      name: 'Solana',
      logo: 'TODO',
      rpc: [
        "https://api.mainnet-beta.solana.com",
        "https://solana-api.projectserum.com",
      ],
    ),
  ];

  static const List<ChainMetadata> testChains = [
    ChainMetadata(
      chainId: 'solana:8E9rvCKLFQia2Y35HXjjpWzj8weVo44K',
      name: 'Solana Devnet',
      logo: 'TODO',
      rpc: ["https://api.devnet.solana.com"],
    )
  ];

  static const List<ChainMetadata> chains = [...mainChains, ...testChains];

  static final Map<SolanaMethods, String> methods = {
    SolanaMethods.solanaSignTransaction: 'solana_signTransaction',
    SolanaMethods.solanaSignMessage: 'solana_signMessage'
  };

  static final Map<dynamic, String> events = {};
}

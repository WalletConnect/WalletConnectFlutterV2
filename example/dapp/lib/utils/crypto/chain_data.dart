import 'package:flutter/material.dart';
import 'package:walletconnect_flutter_v2_dapp/models/chain_metadata.dart';

class ChainData {
  static final List<ChainMetadata> mainChains = [
    ChainMetadata(
      type: ChainType.eip155,
      chainId: 'eip155:1',
      name: 'Ethereum',
      logo: '/chain-logos/eip155-1.png',
      color: Colors.blue.shade300,
      rpc: ['https://cloudflare-eth.com/'],
    ),
    ChainMetadata(
      type: ChainType.eip155,
      chainId: 'eip155:137',
      name: 'Polygon',
      logo: '/chain-logos/eip155-137.png',
      color: Colors.purple.shade300,
      rpc: ['https://polygon-rpc.com/'],
    ),
    // const ChainMetadata(
    //   type: ChainType.solana,
    //   chainId: 'solana:4sGjMW1sUnHzSxGspuhpqLDx6wiyjNtZ',
    //   name: 'Solana',
    //   logo: 'TODO',
    //   color: Colors.black,
    //   rpc: [
    //     "https://api.mainnet-beta.solana.com",
    //     "https://solana-api.projectserum.com",
    //   ],
    // ),
    // ChainMetadata(
    //   type: ChainType.kadena,
    //   chainId: 'kadena:mainnet01',
    //   name: 'Kadena',
    //   logo: 'TODO',
    //   color: Colors.purple.shade600,
    //   rpc: [
    //     "https://api.testnet.chainweb.com",
    //   ],
    // ),
  ];

  static final List<ChainMetadata> testChains = [
    ChainMetadata(
      type: ChainType.eip155,
      chainId: 'eip155:5',
      name: 'Ethereum Goerli',
      logo: '/chain-logos/eip155-1.png',
      color: Colors.blue.shade300,
      isTestnet: true,
      rpc: ['https://goerli.infura.io/v3/9aa3d95b3bc440fa88ea12eaa4456161'],
    ),
    ChainMetadata(
      type: ChainType.eip155,
      chainId: 'eip155:80001',
      name: 'Polygon Mumbai',
      logo: '/chain-logos/eip155-137.png',
      color: Colors.purple.shade300,
      isTestnet: true,
      rpc: ['https://matic-mumbai.chainstacklabs.com'],
    ),
    // const ChainMetadata(
    //   type: ChainType.eip155,
    //   chainId: 'solana:8E9rvCKLFQia2Y35HXjjpWzj8weVo44K',
    //   name: 'Solana Devnet',
    //   logo: 'TODO',
    //   color: Colors.black,
    //   isTestnet: true,
    //   rpc: ["https://api.devnet.solana.com"],
    // ),
    ChainMetadata(
      type: ChainType.kadena,
      chainId: 'kadena:testnet04',
      name: 'Kadena',
      logo: 'TODO',
      color: Colors.purple.shade600,
      rpc: [
        "https://api.testnet.chainweb.com",
      ],
    ),
  ];

  static final List<ChainMetadata> allChains = [...mainChains, ...testChains];
}

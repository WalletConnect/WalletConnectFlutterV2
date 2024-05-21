import 'package:flutter/material.dart';
import 'package:walletconnect_flutter_v2_dapp/models/chain_metadata.dart';

class ChainData {
  static final List<ChainMetadata> eip155Chains = [
    ChainMetadata(
      type: ChainType.eip155,
      chainId: 'eip155:1',
      name: 'Ethereum',
      logo: '/chain-logos/eip155-1.png',
      color: Colors.blue.shade300,
      rpc: ['https://eth.drpc.org'],
    ),
    ChainMetadata(
      type: ChainType.eip155,
      chainId: 'eip155:137',
      name: 'Polygon',
      logo: '/chain-logos/eip155-137.png',
      color: Colors.purple.shade300,
      rpc: ['https://polygon-rpc.com/'],
    ),
    const ChainMetadata(
      type: ChainType.eip155,
      chainId: 'eip155:42161',
      name: 'Arbitrum',
      logo: '/chain-logos/eip155-42161.png',
      color: Colors.blue,
      rpc: ['https://arbitrum.blockpi.network/v1/rpc/public'],
    ),
    const ChainMetadata(
      type: ChainType.eip155,
      chainId: 'eip155:10',
      name: 'OP Mainnet',
      logo: '/chain-logos/eip155-10.png',
      color: Colors.red,
      rpc: ['https://mainnet.optimism.io/'],
    ),
    const ChainMetadata(
      type: ChainType.eip155,
      chainId: 'eip155:43114',
      name: 'Avalanche',
      logo: '/chain-logos/eip155-43114.png',
      color: Colors.orange,
      rpc: ['https://api.avax.network/ext/bc/C/rpc'],
    ),
    const ChainMetadata(
      type: ChainType.eip155,
      chainId: 'eip155:56',
      name: 'BNB Smart Chain Mainnet',
      logo: '/chain-logos/eip155-56.png',
      color: Colors.orange,
      rpc: ['https://bsc-dataseed1.bnbchain.org'],
    ),
    const ChainMetadata(
      type: ChainType.eip155,
      chainId: 'eip155:42220',
      name: 'Celo',
      logo: '/chain-logos/eip155-42220.png',
      color: Colors.green,
      rpc: ['https://forno.celo.org/'],
    ),
    const ChainMetadata(
      type: ChainType.eip155,
      chainId: 'eip155:100',
      name: 'Gnosis',
      logo: '/chain-logos/eip155-100.png',
      color: Colors.greenAccent,
      rpc: ['https://rpc.gnosischain.com/'],
    ),
    const ChainMetadata(
      type: ChainType.eip155,
      chainId: 'eip155:324',
      name: 'zkSync',
      logo: '/chain-logos/eip155-324.png',
      color: Colors.black,
      rpc: ['https://mainnet.era.zksync.io'],
    ),
    ChainMetadata(
      type: ChainType.eip155,
      chainId: 'eip155:11155111',
      name: 'Sepolia',
      logo: '/chain-logos/eip155-1.png',
      color: Colors.blue.shade300,
      isTestnet: true,
      rpc: ['https://ethereum-sepolia.publicnode.com'],
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
  ];

  static final List<ChainMetadata> solanaChains = [
    const ChainMetadata(
      type: ChainType.solana,
      chainId: 'solana:4sGjMW1sUnHzSxGspuhpqLDx6wiyjNtZ',
      name: 'Solana Mainnet 1',
      logo: '/chain-logos/solana.png',
      color: Color.fromARGB(255, 247, 0, 255),
      rpc: [
        'https://rpc.ankr.com/solana',
        'https://api.tatum.io/v3/blockchain/node/solana-mainnet',
      ],
    ),
    const ChainMetadata(
      type: ChainType.solana,
      chainId: 'solana:5eykt4UsFv8P8NJdTREpY1vzqKqZKvdp',
      name: 'Solana Mainnet 2',
      logo: '/chain-logos/solana.png',
      color: Color.fromARGB(255, 247, 0, 255),
      rpc: [
        'https://rpc.ankr.com/solana',
        'https://api.tatum.io/v3/blockchain/node/solana-mainnet',
      ],
    ),
    const ChainMetadata(
      type: ChainType.solana,
      chainId: 'solana:4uhcVJyU9pJkvQyS88uRDiswHXSCkY3z',
      name: 'Solana Testnet',
      logo: '/chain-logos/solana.png',
      color: Colors.black,
      isTestnet: true,
      rpc: [
        'https://api.testnet.solana.com',
      ],
    ),
  ];

  static final List<ChainMetadata> cosmosChains = [
    // TODO TO BE SUPPORTED
    const ChainMetadata(
      type: ChainType.cosmos,
      chainId: 'cosmos:cosmoshub-4',
      name: 'Cosmos Mainnet',
      logo: '/chain-logos/cosmos.png',
      color: Colors.purple,
      rpc: [
        'https://cosmos-rpc.polkachu.com:443',
        'https://rpc-cosmoshub-ia.cosmosia.notional.ventures:443',
        'https://rpc.cosmos.network:443',
      ],
    ),
  ];

  static final List<ChainMetadata> kadenaChains = [
    // TODO TO BE SUPPORTED
    const ChainMetadata(
      type: ChainType.kadena,
      chainId: 'kadena:mainnet01',
      name: 'Kadena Mainnet',
      logo: '/chain-logos/kadena.png',
      color: Colors.green,
      rpc: [
        'https://api.chainweb.com',
      ],
    ),
    const ChainMetadata(
      type: ChainType.kadena,
      chainId: 'kadena:testnet04',
      name: 'Kadena Testnet',
      logo: '/chain-logos/kadena.png',
      color: Colors.green,
      isTestnet: true,
      rpc: [
        'https://api.chainweb.com',
      ],
    ),
  ];

  static final List<ChainMetadata> polkadotChains = [
    const ChainMetadata(
      type: ChainType.polkadot,
      chainId: 'polkadot:91b171bb158e2d3848fa23a9f1c25182',
      name: 'Polkadot Mainnet',
      logo: '/chain-logos/polkadot.png',
      color: Color.fromARGB(255, 174, 57, 220),
      rpc: [
        'wss://rpc.polkadot.io',
        // 'wss://rpc.matrix.canary.enjin.io'
      ],
    ),
    const ChainMetadata(
      type: ChainType.polkadot,
      chainId: 'polkadot:e143f23803ac50e8f6f8e62695d1ce9e',
      name: 'Polkadot Testnet (Westend)',
      logo: '/chain-logos/polkadot.png',
      color: Color.fromARGB(255, 174, 57, 220),
      isTestnet: true,
      rpc: [
        'wss://westend-rpc.polkadot.io',
      ],
    ),
  ];

  static final List<ChainMetadata> allChains = [
    ...eip155Chains,
    ...solanaChains,
    ...polkadotChains,
    // ...kadenaChains,
    // ...cosmosChains,
  ];
}

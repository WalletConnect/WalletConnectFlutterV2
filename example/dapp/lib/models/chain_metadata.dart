import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

enum ChainType {
  eip155,
  solana,
  kadena,
}

class ChainMetadata {
  final String chain;
  final String name;
  final String logo;
  final bool isTestnet;
  final Color color;
  final ChainType type;
  final List<String> rpc;

  const ChainMetadata({
    required this.chain,
    required this.name,
    required this.logo,
    this.isTestnet = false,
    required this.color,
    required this.type,
    required this.rpc,
  });

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is ChainMetadata &&
        other.chain == chain &&
        other.name == name &&
        other.logo == logo &&
        other.isTestnet == isTestnet &&
        listEquals(other.rpc, rpc);
  }

  @override
  int get hashCode {
    return chain.hashCode ^
        name.hashCode ^
        logo.hashCode ^
        rpc.hashCode ^
        isTestnet.hashCode;
  }
}

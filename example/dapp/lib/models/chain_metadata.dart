import 'package:flutter/foundation.dart';

class ChainMetadata {
  final String chainId;
  final String name;
  final String logo;
  final List<String> rpc;

  const ChainMetadata({
    required this.chainId,
    required this.name,
    required this.logo,
    required this.rpc,
  });

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is ChainMetadata &&
        other.chainId == chainId &&
        other.name == name &&
        other.logo == logo &&
        listEquals(other.rpc, rpc);
  }

  @override
  int get hashCode {
    return chainId.hashCode ^ name.hashCode ^ logo.hashCode ^ rpc.hashCode;
  }
}

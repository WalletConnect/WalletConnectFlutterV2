class ChainKey {
  final List<String> chainIds;
  final String privateKey;
  final String publicKey;

  ChainKey({
    required this.chainIds,
    required this.privateKey,
    required this.publicKey,
  });

  /// Get the namespaces of each chain id.
  List<String> getNamespaces() {
    return chainIds.map((e) => e.split(':')[0]).toList();
  }

  @override
  String toString() {
    return 'ChainKey(chainId: $chainIds, privateKey: $privateKey, publicKey: $publicKey)';
  }
}

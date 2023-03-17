class ChainKey {
  final List<String> chains;
  final String privateKey;
  final String publicKey;

  ChainKey({
    required this.chains,
    required this.privateKey,
    required this.publicKey,
  });

  @override
  String toString() {
    return 'ChainKey(chains: $chains, privateKey: $privateKey, publicKey: $publicKey)';
  }
}

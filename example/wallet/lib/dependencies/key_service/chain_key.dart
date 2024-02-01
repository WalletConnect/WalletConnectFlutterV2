class ChainKey {
  final List<String> chains;
  final String privateKey;
  final String publicKey;
  final String address;

  ChainKey({
    required this.chains,
    required this.privateKey,
    required this.publicKey,
    required this.address,
  });

  @override
  String toString() {
    return 'ChainKey(chains: $chains, privateKey: $privateKey, publicKey: $publicKey, address: $address)';
  }
}

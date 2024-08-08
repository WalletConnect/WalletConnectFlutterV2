import 'dart:convert';

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

  String get namespace {
    if (chains.isNotEmpty) {
      return chains.first.split(':').first;
    }
    return '';
  }

  Map<String, dynamic> toJson() => {
        'chains': chains,
        'privateKey': privateKey,
        'publicKey': privateKey,
        'address': address,
      };

  factory ChainKey.fromJson(Map<String, dynamic> json) {
    return ChainKey(
      chains: (json['chains'] as List).map((e) => '$e').toList(),
      privateKey: json['privateKey'],
      publicKey: json['publicKey'],
      address: json['address'],
    );
  }

  @override
  String toString() => jsonEncode(toJson());
}

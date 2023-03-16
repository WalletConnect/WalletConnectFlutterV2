import 'package:walletconnect_flutter_v2_wallet/dependencies/key_service/chain_key.dart';
import 'package:walletconnect_flutter_v2_wallet/dependencies/key_service/i_key_service.dart';

class KeyService extends IKeyService {
  final List<ChainKey> keys = [
    ChainKey(
      chainIds: [
        'kadena:mainnet01',
        'kadena:testnet04',
        'kadena:devnet',
      ],
      privateKey:
          '7d54a79feeb95ac4efdc6cfd4b702da5ee5dc1c31781b76ea092301c266e2451',
      publicKey:
          'af242a8d963f184eca742271a5134ee3d3e006f0377d667510e15f6fc18e41d9',
    ),
  ];

  @override
  List<String> getChainIds() {
    final List<String> chainIds = [];
    for (final ChainKey key in keys) {
      chainIds.addAll(key.chainIds);
    }
    return chainIds;
  }

  @override
  List<ChainKey> getKeys() {
    return keys;
  }

  @override
  List<ChainKey> getKeysForChainId(String chainId) {
    return keys.where((e) => e.chainIds.contains(chainId)).toList();
  }
}

import 'package:walletconnect_flutter_v2_wallet/dependencies/key_service/chain_key.dart';
import 'package:walletconnect_flutter_v2_wallet/dependencies/key_service/i_key_service.dart';
import 'package:walletconnect_flutter_v2_wallet/utils/dart_defines.dart';

class KeyService extends IKeyService {
  final List<ChainKey> keys = [
    ChainKey(
      chains: [
        'kadena:mainnet01',
        'kadena:testnet04',
        'kadena:development',
      ],
      privateKey: DartDefines.kadenaPrivateKey,
      publicKey: DartDefines.kadenaPublicKey,
    ),
    ChainKey(
      chains: [
        'eip155:1',
        'eip155:5',
        'eip155:137',
        'eip155:80001',
      ],
      privateKey:
          '5c863219aac113b78823027ed8fd3e287b38bc0f5a65756e1797c8f7fce56b8e',
      publicKey:
          '0x83ba3013f776d4e2801010ee88581aedf5349b43', // Eth Address, not actual public key
    )
  ];

  @override
  List<String> getChains() {
    final List<String> chainIds = [];
    for (final ChainKey key in keys) {
      chainIds.addAll(key.chains);
    }
    return chainIds;
  }

  @override
  List<ChainKey> getKeys() {
    return keys;
  }

  @override
  List<ChainKey> getKeysForChain(String chain) {
    return keys.where((e) => e.chains.contains(chain)).toList();
  }

  @override
  List<String> getAllAccounts() {
    final List<String> accounts = [];
    for (final ChainKey key in keys) {
      for (final String chain in key.chains) {
        accounts.add('$chain:${key.publicKey}');
      }
    }
    return accounts;
  }
}

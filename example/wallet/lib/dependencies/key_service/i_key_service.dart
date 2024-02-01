import 'package:walletconnect_flutter_v2/apis/core/crypto/crypto_models.dart';
import 'package:walletconnect_flutter_v2_wallet/dependencies/key_service/chain_key.dart';

abstract class IKeyService {
  /// Returns a list of all the keys.
  Future<List<ChainKey>> setKeys();

  /// Returns a list of all the chain ids.
  List<String> getChains();

  /// Returns a list of all the keys for a given chain id.
  /// If the chain is not found, returns an empty list.
  ///  - [chain]: The chain to get the keys for.
  List<ChainKey> getKeysForChain(String chain);

  /// Returns a list of all the accounts in namespace:chainId:address format.
  List<String> getAllAccounts();

  String generateMnemonic();

  CryptoKeyPair keyPairFromMnemonic(String mnemonic);

  String getAddressFromPrivateKey(String privateKey);

  Future<void> createWallet();

  Future<void> restoreWallet({required String mnemonic});

  Future<void> deleteWallet();
}

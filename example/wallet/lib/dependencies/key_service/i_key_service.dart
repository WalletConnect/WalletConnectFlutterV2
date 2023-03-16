import 'package:walletconnect_flutter_v2_wallet/dependencies/key_service/chain_key.dart';

abstract class IKeyService {
  /// Returns a list of all the keys.
  List<ChainKey> getKeys();

  /// Returns a list of all the chain ids.
  List<String> getChainIds();

  /// Returns a list of all the keys for a given chain id.
  /// If the chain id is not found, returns an empty list.
  ///  - [chainId]: The chain id to get the keys for.
  List<ChainKey> getKeysForChainId(String chainId);
}

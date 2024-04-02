import 'package:convert/convert.dart';
import 'package:flutter/foundation.dart';
import 'package:walletconnect_flutter_v2/apis/core/crypto/crypto_models.dart';
import 'package:walletconnect_flutter_v2/walletconnect_flutter_v2.dart';
import 'package:walletconnect_flutter_v2_wallet/dependencies/key_service/chain_key.dart';
import 'package:walletconnect_flutter_v2_wallet/dependencies/key_service/i_key_service.dart';
import 'package:walletconnect_flutter_v2_wallet/models/chain_data.dart';
import 'package:walletconnect_flutter_v2_wallet/utils/dart_defines.dart';
import 'package:walletconnect_flutter_v2_wallet/dependencies/bip39/bip39_base.dart'
    as bip39;
import 'package:walletconnect_flutter_v2_wallet/dependencies/bip32/bip32_base.dart'
    as bip32;

class KeyService extends IKeyService {
  final List<ChainKey> keys = [];

  @override
  Future<List<ChainKey>> setKeys() async {
    // WARNING: SharedPreferences is not the best way to store your keys!
    final prefs = await SharedPreferences.getInstance();
    final privateKey = prefs.getString('privateKey') ?? '';
    if (privateKey.isEmpty) {
      return [];
    }
    final publicKey = prefs.getString('publicKey') ?? '';
    final address = getAddressFromPrivateKey(privateKey);
    final evmChainKey = ChainKey(
      chains: ChainData.allChains.map((e) => e.chainId).toList(),
      privateKey: privateKey,
      publicKey: publicKey,
      address: address,
    );
    debugPrint(evmChainKey.toString());
    final kadenaChainKey = ChainKey(
      chains: [
        'kadena:mainnet01',
        'kadena:testnet04',
        'kadena:development',
      ],
      privateKey: DartDefines.kadenaPrivateKey,
      publicKey: '',
      address: DartDefines.kadenaAddress,
    );
    keys
      ..clear()
      ..addAll(
        [kadenaChainKey, evmChainKey],
      );
    return keys;
  }

  @override
  List<String> getChains() {
    final List<String> chainIds = [];
    for (final ChainKey key in keys) {
      chainIds.addAll(key.chains);
    }
    return chainIds;
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
        accounts.add('$chain:${key.address}');
      }
    }
    return accounts;
  }

  @override
  String generateMnemonic() => bip39.generateMnemonic();

  @override
  CryptoKeyPair keyPairFromMnemonic(String mnemonic) {
    final isValidMnemonic = bip39.validateMnemonic(mnemonic);
    if (!isValidMnemonic) {
      throw 'Invalid mnemonic';
    }

    final seed = bip39.mnemonicToSeed(mnemonic);
    final root = bip32.BIP32.fromSeed(seed);

    final firstChild = root.derivePath("m/44'/60'/0'/0/0");
    final private = hex.encode(firstChild.privateKey as List<int>);
    final public = hex.encode(firstChild.publicKey);
    return CryptoKeyPair(private, public);
  }

  @override
  String getAddressFromPrivateKey(String privateKey) {
    final private = EthPrivateKey.fromHex(privateKey);
    return private.address.hex;
  }

  @override
  Future<void> createWallet() async {
    final mnemonic = generateMnemonic();
    return await restoreWallet(mnemonic: mnemonic);
  }

  @override
  Future<void> restoreWallet({required String mnemonic}) async {
    final keyPair = keyPairFromMnemonic(mnemonic);
    final address = getAddressFromPrivateKey(keyPair.privateKey);
    final evmChainKey = ChainKey(
      chains: ChainData.allChains.map((e) => e.chainId).toList(),
      privateKey: keyPair.privateKey,
      publicKey: keyPair.publicKey,
      address: address,
    );
    debugPrint(evmChainKey.toString());
    final kadenaChainKey = ChainKey(
      chains: [
        'kadena:mainnet01',
        'kadena:testnet04',
        'kadena:development',
      ],
      privateKey: DartDefines.kadenaPrivateKey,
      publicKey: '',
      address: DartDefines.kadenaAddress,
    );

    keys
      ..clear()
      ..addAll(
        [kadenaChainKey, evmChainKey],
      );

    // WARNING: SharedPreferences is not the best way to store your keys!
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('privateKey', keyPair.privateKey);
    await prefs.setString('publicKey', keyPair.publicKey);
    await prefs.setString('mnemonic', mnemonic);
    return;
  }

  @override
  Future<void> deleteWallet() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.clear();
    keys.clear();
    return;
  }
}

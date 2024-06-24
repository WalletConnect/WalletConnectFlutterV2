import 'package:convert/convert.dart';
import 'package:flutter/foundation.dart';
import 'package:walletconnect_flutter_v2/apis/core/crypto/crypto_models.dart';
import 'package:walletconnect_flutter_v2/walletconnect_flutter_v2.dart';
import 'package:walletconnect_flutter_v2_wallet/dependencies/key_service/chain_key.dart';
import 'package:walletconnect_flutter_v2_wallet/dependencies/key_service/i_key_service.dart';
import 'package:walletconnect_flutter_v2_wallet/models/chain_data.dart';
import 'package:walletconnect_flutter_v2_wallet/dependencies/bip39/bip39_base.dart'
    as bip39;
import 'package:walletconnect_flutter_v2_wallet/dependencies/bip32/bip32_base.dart'
    as bip32;
import 'package:walletconnect_flutter_v2_wallet/utils/dart_defines.dart';

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

    final keyPair = CryptoKeyPair(privateKey, publicKey);
    final eip155KeyPair = _eip155KeyPair(keyPair);
    keys
      ..clear()
      ..add(eip155KeyPair);

    final extraKeys = await _extraKeyPairs();
    keys.addAll(extraKeys);

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

  // ** bip39/bip32 - EIP155 **

  @override
  Future<void> createNewWallet() async {
    final mnemonic = bip39.generateMnemonic();
    await restoreWallet(mnemonic: mnemonic);
  }

  @override
  Future<void> restoreWallet({required String mnemonic}) async {
    final keyPair = _keyPairFromMnemonic(mnemonic);

    // WARNING: SharedPreferences is not the best way to store your keys!
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('privateKey', keyPair.privateKey);
    await prefs.setString('publicKey', keyPair.publicKey);
    await prefs.setString('mnemonic', mnemonic);

    await setKeys();
  }

  @override
  Future<void> loadDefaultWallet() async {
    const mnemonic =
        'spoil video deputy round immense setup wasp secret maze slight bag what';
    await restoreWallet(mnemonic: mnemonic);
  }

  @override
  Future<void> deleteWallet() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.clear();
    keys.clear();
  }

  CryptoKeyPair _keyPairFromMnemonic(String mnemonic) {
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

  ChainKey _eip155KeyPair(CryptoKeyPair keyPair) {
    final private = EthPrivateKey.fromHex(keyPair.privateKey);
    final address = private.address.hex;
    final evmChainKey = ChainKey(
      chains: ChainData.eip155Chains.map((e) => e.chainId).toList(),
      privateKey: keyPair.privateKey,
      publicKey: keyPair.publicKey,
      address: address,
    );
    debugPrint('[WALLET] evmChainKey ${evmChainKey.toString()}');
    return evmChainKey;
  }

  // ** extra derivations **

  Future<List<ChainKey>> _extraKeyPairs() async {
    // HARDCODED VALUES
    final kadenaChainKey = _kadenaKeyPair();
    debugPrint('[WALLET] kadenaChainKey ${kadenaChainKey.toString()}');
    final polkadotChainKey = _polkadotKeyPair();
    debugPrint('[WALLET] polkadotChainKey ${polkadotChainKey.toString()}');
    final solanaChainKeys = _solanaKeyPair();
    debugPrint('[WALLET] solanaChainKey $solanaChainKeys');
    //
    return [
      kadenaChainKey,
      polkadotChainKey,
      solanaChainKeys,
    ];
  }

  ChainKey _kadenaKeyPair() {
    return ChainKey(
      chains: ChainData.kadenaChains.map((e) => e.chainId).toList(),
      privateKey: DartDefines.kadenaSecretKey,
      publicKey: DartDefines.kadenaAddress,
      address: DartDefines.kadenaAddress,
    );
  }

  ChainKey _polkadotKeyPair() {
    return ChainKey(
      chains: ChainData.polkadotChains.map((e) => e.chainId).toList(),
      privateKey: DartDefines.polkadotMnemonic,
      publicKey: '',
      address: DartDefines.polkadotAddress,
    );
  }

  ChainKey _solanaKeyPair() {
    return ChainKey(
      chains: ChainData.solanaChains.map((e) => e.chainId).toList(),
      privateKey: DartDefines.solanaSecretKey,
      publicKey: DartDefines.solanaAddress,
      address: DartDefines.solanaAddress,
    );
  }
}

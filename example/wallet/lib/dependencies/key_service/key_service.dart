import 'dart:convert';
import 'dart:developer';

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
  List<ChainKey> _keys = [];

  @override
  Future<List<ChainKey>> loadKeys() async {
    // ⚠️ WARNING: SharedPreferences is not the best way to store your keys! This is just for example purposes!
    final prefs = await SharedPreferences.getInstance();
    try {
      final savedKeys = prefs.getStringList('w3w_chain_keys')!;
      final chainKeys = savedKeys.map((e) => ChainKey.fromJson(jsonDecode(e)));
      _keys = List<ChainKey>.from(chainKeys.toList());
      //
      final extraKeys = await _extraChainKeys();
      _keys.addAll(extraKeys);
    } catch (e, s) {
      debugPrint('[$runtimeType] loadKeys() error: $e');
      debugPrint(s.toString());
    }

    log('[$runtimeType] _keys $_keys');
    return _keys;
  }

  @override
  List<String> getChains() {
    final List<String> chainIds = [];
    for (final ChainKey key in _keys) {
      chainIds.addAll(key.chains);
    }
    return chainIds;
  }

  @override
  List<ChainKey> getKeysForChain(String value) {
    if (value.contains(':')) {
      return _keys.where((e) => e.chains.contains(value)).toList();
    }
    return _keys.where((e) => e.namespace == value).toList();
  }

  @override
  List<String> getAllAccounts() {
    final List<String> accounts = [];
    for (final ChainKey key in _keys) {
      for (final String chain in key.chains) {
        accounts.add('$chain:${key.address}');
      }
    }
    return accounts;
  }

  // ** bip39/bip32 - EIP155 **

  @override
  Future<void> loadDefaultWallet() async {
    const mnemonic =
        'spoil video deputy round immense setup wasp secret maze slight bag what';
    await restoreWalletFromSeed(mnemonic: mnemonic);
  }

  @override
  Future<void> createAddressFromSeed() async {
    final prefs = await SharedPreferences.getInstance();
    final mnemonic = prefs.getString('w3w_mnemonic')!;

    final chainKeys = getKeysForChain('eip155');
    final index = chainKeys.length;

    final keyPair = _keyPairFromMnemonic(mnemonic, index: index);
    final chainKey = _eip155ChainKey(keyPair);

    _keys.add(chainKey);

    await _saveKeys();
  }

  @override
  Future<void> restoreWalletFromSeed({required String mnemonic}) async {
    // ⚠️ WARNING: SharedPreferences is not the best way to store your keys! This is just for example purposes!
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('w3w_chain_keys');
    await prefs.setString('w3w_mnemonic', mnemonic);

    final keyPair = _keyPairFromMnemonic(mnemonic);
    final chainKey = _eip155ChainKey(keyPair);

    _keys = List<ChainKey>.from([chainKey]);

    await _saveKeys();
  }

  Future<void> _saveKeys() async {
    final prefs = await SharedPreferences.getInstance();
    // Store only eip155 keys
    final chainKeys = _keys
        .where((k) => k.namespace == 'eip155')
        .map((e) => jsonEncode(e.toJson()))
        .toList();
    await prefs.setStringList('w3w_chain_keys', chainKeys);
  }

  CryptoKeyPair _keyPairFromMnemonic(String mnemonic, {int index = 0}) {
    final isValidMnemonic = bip39.validateMnemonic(mnemonic);
    if (!isValidMnemonic) {
      throw 'Invalid mnemonic';
    }

    final seed = bip39.mnemonicToSeed(mnemonic);
    final root = bip32.BIP32.fromSeed(seed);

    final child = root.derivePath("m/44'/60'/0'/0/$index");
    final private = hex.encode(child.privateKey as List<int>);
    final public = hex.encode(child.publicKey);
    return CryptoKeyPair(private, public);
  }

  ChainKey _eip155ChainKey(CryptoKeyPair keyPair) {
    final private = EthPrivateKey.fromHex(keyPair.privateKey);
    final address = private.address.hex;
    final evmChainKey = ChainKey(
      chains: ChainData.eip155Chains.map((e) => e.chainId).toList(),
      privateKey: keyPair.privateKey,
      publicKey: keyPair.publicKey,
      address: address,
    );
    debugPrint('[SampleWallet] evmChainKey ${evmChainKey.toString()}');
    return evmChainKey;
  }

  // ** extra derivations **

  Future<List<ChainKey>> _extraChainKeys() async {
    // HARDCODED VALUES
    final kadenaChainKey = _kadenaChainKey();
    final polkadotChainKey = _polkadotChainKey();
    final solanaChainKeys = _solanaChainKey();
    //
    return [
      kadenaChainKey,
      polkadotChainKey,
      solanaChainKeys,
    ];
  }

  ChainKey _kadenaChainKey() {
    return ChainKey(
      chains: ChainData.kadenaChains.map((e) => e.chainId).toList(),
      privateKey: DartDefines.kadenaSecretKey,
      publicKey: DartDefines.kadenaAddress,
      address: DartDefines.kadenaAddress,
    );
  }

  ChainKey _polkadotChainKey() {
    return ChainKey(
      chains: ChainData.polkadotChains.map((e) => e.chainId).toList(),
      privateKey: DartDefines.polkadotMnemonic,
      publicKey: '',
      address: DartDefines.polkadotAddress,
    );
  }

  ChainKey _solanaChainKey() {
    return ChainKey(
      chains: ChainData.solanaChains.map((e) => e.chainId).toList(),
      privateKey: DartDefines.solanaSecretKey,
      publicKey: DartDefines.solanaAddress,
      address: DartDefines.solanaAddress,
    );
  }
}

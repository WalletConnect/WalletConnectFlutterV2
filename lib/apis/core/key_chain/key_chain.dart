import 'package:wallet_connect_flutter_v2/apis/core/i_core.dart';
import 'package:wallet_connect_flutter_v2/apis/core/key_chain/i_key_chain.dart';
import 'package:wallet_connect_flutter_v2/apis/utils/errors.dart';
import 'package:wallet_connect_flutter_v2/apis/utils/wallet_connect_utils.dart';

class KeyChain implements IKeyChain {
  static const KEYCHAIN = 'keychain';
  static const KEYCHAIN_STORAGE_VERSION = '0.3';

  @override
  String get storageKey => '$KEYCHAIN_STORAGE_VERSION//$KEYCHAIN';
  @override
  final ICore core;

  bool _initialized = false;
  Map<String, String> keyChain = {};

  KeyChain(this.core);

  @override
  Future<void> init() async {
    if (_initialized) {
      return;
    }

    // store = GetStorageStore(storageKey);
    await core.storage.init();
    await restore();

    _initialized = true;
  }

  /// Returns true if the keychain has the given tag
  @override
  bool has(
    String tag, {
    dynamic options,
  }) {
    _checkInitialized();
    return keyChain.containsKey(tag);
  }

  /// Gets the key associated with the provided tag
  @override
  String get(
    String tag, {
    dynamic options,
  }) {
    _checkInitialized();
    if (keyChain.containsKey(tag)) {
      return keyChain[tag]!;
    }
    return '';
  }

  /// Sets the value with the given key
  @override
  Future<void> set(
    String tag,
    String key, {
    dynamic options,
  }) async {
    _checkInitialized();
    keyChain[tag] = key;
    await persist();
  }

  /// Deletes the key from the keychain
  @override
  Future<void> delete(
    String tag, {
    dynamic options,
  }) async {
    _checkInitialized();
    keyChain.remove(tag);
    await persist();
  }

  @override
  Future<void> persist() async {
    _checkInitialized();
    await core.storage.set(storageKey, keyChain);
  }

  @override
  Future<void> restore() async {
    if (core.storage.has(storageKey)) {
      keyChain = WalletConnectUtils.convertMapTo<String>(
        core.storage.get(storageKey),
      );
    }
  }

  void _checkInitialized() {
    if (!_initialized) {
      throw Errors.getInternalError(Errors.NOT_INITIALIZED);
    }
  }
}


import 'package:walletconnect_flutter_v2/apis/core/store/i_store.dart';
import 'package:walletconnect_flutter_v2/apis/utils/constants.dart';
import 'package:walletconnect_flutter_v2/apis/utils/errors.dart';

class MemoryStore implements IStore<Map<String, dynamic>> {
  bool _initialized = false;

  final Map<String, Map<String, dynamic>> _map;

  @override
  Map<String, Map<String, dynamic>> get map => _map;

  @override
  List<String> get keys => map.keys.toList();

  @override
  List<Map<String, dynamic>> get values => map.values.toList();

  @override
  String get storagePrefix => WalletConnectConstants.CORE_STORAGE_PREFIX;

  MemoryStore({
    Map<String, Map<String, dynamic>>? defaultValue,
  }) : _map = defaultValue ?? {};

  /// Initializes the store, loading all persistent values into memory.
  @override
  Future<void> init() async {
    if (_initialized) {
      return;
    }

    _initialized = true;
  }

  /// Gets the value of the specified key, if it hasn't been cached yet, it caches it.
  /// If the key doesn't exist it throws an error.
  @override
  Map<String, dynamic>? get(String key) {
    _checkInitialized();

    final String keyWithPrefix = _addPrefix(key);
    if (_map.containsKey(keyWithPrefix)) {
      return _map[keyWithPrefix];
    }

    return null;
  }

  @override
  bool has(String key) {
    final String keyWithPrefix = _addPrefix(key);
    return _map.containsKey(keyWithPrefix);
  }

  /// Gets all of the values of the store
  @override
  List<Map<String, dynamic>> getAll() {
    _checkInitialized();
    return values;
  }

  /// Sets the value of a key within the store, overwriting the value if it exists.
  @override
  Future<void> set(String key, Map<String, dynamic> value) async {
    _checkInitialized();

    final String keyWithPrefix = _addPrefix(key);
    _map[keyWithPrefix] = value;
  }

  /// Updates the value of a key. Fails if it does not exist.
  @override
  Future<void> update(String key, Map<String, dynamic> value) async {
    _checkInitialized();

    final String keyWithPrefix = _addPrefix(key);
    if (!map.containsKey(keyWithPrefix)) {
      throw Errors.getInternalError(Errors.NO_MATCHING_KEY);
    } else {
      _map[keyWithPrefix] = value;
    }
  }

  /// Removes the key from the persistent store
  @override
  Future<void> delete(String key) async {
    _checkInitialized();

    final String keyWithPrefix = _addPrefix(key);
    _map.remove(keyWithPrefix);
  }

  String _addPrefix(String key) {
    return '$storagePrefix$key';
  }

  void _checkInitialized() {
    if (!_initialized) {
      throw Errors.getInternalError(Errors.NOT_INITIALIZED);
    }
  }
}

import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:walletconnect_flutter_v2/apis/core/store/i_store.dart';
import 'package:walletconnect_flutter_v2/apis/utils/constants.dart';
import 'package:walletconnect_flutter_v2/apis/utils/errors.dart';

class SharedPrefsStores implements IStore<Map<String, dynamic>> {
  late SharedPreferences prefs;
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

  final bool memoryStore;
  final String extraStoragePrefix;

  SharedPrefsStores(
      {Map<String, Map<String, dynamic>>? defaultValue,
      this.memoryStore = false,
      this.extraStoragePrefix = ''})
      : _map = defaultValue ?? {};

  /// Initializes the store, loading all persistent values into memory.
  @override
  Future<void> init() async {
    if (_initialized) {
      return;
    }

    if (!memoryStore) {
      prefs = await SharedPreferences.getInstance();
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

    Map<String, dynamic>? value = _getPref(keyWithPrefix);
    if (value != null) {
      _map[keyWithPrefix] = value;
    }
    return value;
  }

  @override
  bool has(String key) {
    final String keyWithPrefix = _addPrefix(key);
    if (memoryStore) {
      return _map.containsKey(keyWithPrefix);
    }
    return prefs.containsKey(keyWithPrefix);
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
    await _updatePref(keyWithPrefix, value);
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
      await _updatePref(keyWithPrefix, value);
    }
  }

  /// Removes the key from the persistent store
  @override
  Future<void> delete(String key) async {
    _checkInitialized();

    final String keyWithPrefix = _addPrefix(key);
    _map.remove(keyWithPrefix);
    await _removePref(keyWithPrefix);
  }

  Map<String, dynamic>? _getPref(String key) {
    if (memoryStore) {
      return null;
    }

    if (prefs.containsKey(key)) {
      final value = prefs.getString(key)!;
      return jsonDecode(value);
    } else {
      throw Errors.getInternalError(Errors.NO_MATCHING_KEY);
    }
  }

  Future<void> _updatePref(String key, Map<String, dynamic> value) async {
    if (memoryStore) {
      return;
    }

    try {
      final stringValue = jsonEncode(value);
      await prefs.setString(key, stringValue);
    } on Exception catch (e) {
      throw Errors.getInternalError(
        Errors.MISSING_OR_INVALID,
        context: e.toString(),
      );
    }
  }

  Future<void> _removePref(String key) async {
    if (memoryStore) {
      return;
    }
    await prefs.remove(key);
  }

  String _addPrefix(String key) {
    return '$extraStoragePrefix$storagePrefix$key';
  }

  void _checkInitialized() {
    if (!_initialized) {
      throw Errors.getInternalError(Errors.NOT_INITIALIZED);
    }
  }
}

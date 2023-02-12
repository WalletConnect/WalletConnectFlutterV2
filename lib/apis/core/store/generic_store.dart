import 'package:wallet_connect_flutter_v2/apis/core/store/i_generic_store.dart';
import 'package:wallet_connect_flutter_v2/apis/core/i_core.dart';
import 'package:wallet_connect_flutter_v2/apis/utils/errors.dart';
import 'package:wallet_connect_flutter_v2/apis/utils/wallet_connect_utils.dart';

class GenericStore<T> implements IGenericStore<T> {
  final String context;
  final String version;

  @override
  String get storageKey => '$version//$context';
  @override
  final ICore core;

  bool _initialized = false;

  /// Stores map of key to pairing info
  Map<String, T> data = {};

  /// Stores map of key to pairing info as json encoded string
  Map<String, String> dataStrings = {};

  @override
  final String Function(T) toJsonString;
  @override
  final T Function(String) fromJsonString;

  GenericStore({
    required this.core,
    required this.context,
    required this.version,
    required this.toJsonString,
    required this.fromJsonString,
  });

  @override
  Future<void> init() async {
    if (_initialized) {
      return;
    }

    await core.storage.init();
    await restore();

    _initialized = true;
  }

  @override
  bool has(String key) {
    _checkInitialized();
    return data.containsKey(key);
  }

  @override
  T? get(String key) {
    _checkInitialized();
    if (data.containsKey(key)) {
      return data[key]!;
    }
    return null;
  }

  @override
  List<T> getAll() {
    return data.values.toList();
  }

  @override
  Future<void> set(String key, T value) async {
    _checkInitialized();
    data[key] = value;
    dataStrings[key] = toJsonString(value);
    await persist();
  }

  @override
  Future<void> delete(String key) async {
    _checkInitialized();
    data.remove(key);
    dataStrings.remove(key);
    await persist();
  }

  @override
  Future<void> persist() async {
    _checkInitialized();
    await core.storage.set(storageKey, data);
  }

  @override
  Future<void> restore() async {
    if (core.storage.has(storageKey)) {
      dataStrings = WalletConnectUtils.convertMapTo<String>(
        core.storage.get(storageKey),
      );
      for (var entry in dataStrings.entries) {
        data[entry.key] = fromJsonString(entry.value);
      }
    }
  }

  void _checkInitialized() {
    if (!_initialized) {
      throw Errors.getInternalError(Errors.NOT_INITIALIZED);
    }
  }
}

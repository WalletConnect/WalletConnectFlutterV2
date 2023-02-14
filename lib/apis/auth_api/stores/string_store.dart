import 'package:walletconnect_dart_v2/apis/auth_api/stores/i_string_store.dart';
import 'package:walletconnect_dart_v2/apis/core/i_core.dart';
import 'package:walletconnect_dart_v2/apis/utils/errors.dart';
import 'package:walletconnect_dart_v2/apis/utils/walletconnect_utils.dart';

class AuthKeys implements IStringStore {
  static const CONTEXT = 'authKeys';
  static const VERSION = '1.0';

  @override
  String get storageKey => '$VERSION//$CONTEXT';
  @override
  final ICore core;

  bool _initialized = false;

  /// Stores map of topic to pairing info
  Map<String, String> data = {};

  AuthKeys(
    this.core,
  );

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
  bool has(String topic) {
    _checkInitialized();
    return data.containsKey(topic);
  }

  @override
  String? get(String topic) {
    _checkInitialized();
    if (data.containsKey(topic)) {
      return data[topic]!;
    }
    return null;
  }

  @override
  List<String> getAll() {
    return data.values.toList();
  }

  @override
  Future<void> set(String topic, String value) async {
    _checkInitialized();
    data[topic] = value;
    await persist();
  }

  @override
  Future<void> delete(String topic) async {
    _checkInitialized();
    data.remove(topic);
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
      data = WalletConnectUtils.convertMapTo<String>(
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

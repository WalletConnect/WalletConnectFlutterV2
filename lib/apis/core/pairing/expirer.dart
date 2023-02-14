import 'package:event/event.dart';
import 'package:walletconnect_dart_v2/apis/core/i_core.dart';
import 'package:walletconnect_dart_v2/apis/core/pairing/i_expirer.dart';
import 'package:walletconnect_dart_v2/apis/core/pairing/utils/pairing_models.dart';
import 'package:walletconnect_dart_v2/apis/utils/errors.dart';
import 'package:walletconnect_dart_v2/apis/utils/walletconnect_utils.dart';

class Expirer implements IExpirer {
  static const CONTEXT = 'expirer';
  static const VERSION = '0.3';

  @override
  final Event<ExpirationEvent> onCreate = Event<ExpirationEvent>();
  @override
  final Event<ExpirationEvent> onDelete = Event<ExpirationEvent>();
  @override
  final Event onSync = Event();
  @override
  final Event<ExpirationEvent> onExpire = Event<ExpirationEvent>();

  @override
  String get storageKey => '$VERSION//$CONTEXT';
  @override
  final ICore core;

  bool _initialized = false;
  Map<String, int> expirations = {};

  Expirer(this.core);

  @override
  Future<void> init() async {
    if (_initialized) {
      return;
    }

    await core.storage.init();
    await restore();

    _initialized = true;
  }

  /// Returns true if the keychain has the given tag
  @override
  bool has(String key) {
    _checkInitialized();
    return expirations.containsKey(key);
  }

  /// Gets the key associated with the provided tag
  @override
  int get(String key) {
    _checkInitialized();
    if (expirations.containsKey(key)) {
      return expirations[key]!;
    }
    return -1;
  }

  /// Sets the value with the given key
  @override
  Future<void> set(String key, int value) async {
    _checkInitialized();
    expirations[key] = value;
    onCreate.broadcast(
      ExpirationEvent(
        target: key,
        expiry: value,
      ),
    );
    await persist();
  }

  /// Deletes the key from the keychain
  @override
  Future<void> delete(String key) async {
    _checkInitialized();
    int? expiry = expirations.remove(key);
    expiry ??= -1;
    onDelete.broadcast(
      ExpirationEvent(
        target: key,
        expiry: expiry,
      ),
    );
    await persist();
  }

  @override
  Future<bool> checkExpiry(String key, int expiry) async {
    _checkInitialized();

    int msToTimeout = WalletConnectUtils.toMilliseconds(expiry) -
        DateTime.now().toUtc().millisecondsSinceEpoch;
    if (msToTimeout <= 0) {
      await expire(key);
      return true;
    }
    return false;
  }

  @override
  Future<bool> checkAndExpire(String key) async {
    _checkInitialized();

    if (expirations.containsKey(key)) {
      int expiration = expirations[key]!;
      int msToTimeout = WalletConnectUtils.toMilliseconds(expiration) -
          DateTime.now().toUtc().millisecondsSinceEpoch;
      if (msToTimeout <= 0) {
        await expire(key);
        return true;
      }
    }

    return false;
  }

  @override
  Future<void> expire(String key) async {
    _checkInitialized();

    int? expiry = expirations.remove(key);
    if (expiry == null) {
      return;
    }
    onExpire.broadcast(
      ExpirationEvent(
        target: key,
        expiry: expiry,
      ),
    );
    await persist();
  }

  @override
  Future<void> persist() async {
    _checkInitialized();
    await core.storage.set(storageKey, expirations);
    onSync.broadcast();
  }

  @override
  Future<void> restore() async {
    if (core.storage.has(storageKey)) {
      expirations = WalletConnectUtils.convertMapTo<int>(
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

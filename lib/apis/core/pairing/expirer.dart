import 'package:event/event.dart';
import 'package:walletconnect_flutter_v2/apis/core/pairing/i_expirer.dart';
import 'package:walletconnect_flutter_v2/apis/core/pairing/utils/pairing_models.dart';
import 'package:walletconnect_flutter_v2/apis/core/store/generic_store.dart';
import 'package:walletconnect_flutter_v2/apis/utils/constants.dart';
import 'package:walletconnect_flutter_v2/apis/utils/walletconnect_utils.dart';

class Expirer extends GenericStore<int> implements IExpirer {
  @override
  final Event<ExpirationEvent> onExpire = Event();

  Expirer({
    required super.core,
    required super.context,
    required super.version,
    required super.fromJson,
  });

  @override
  Future<bool> checkExpiry(String key, int expiry) async {
    checkInitialized();

    int msToTimeout = WalletConnectUtils.toMilliseconds(expiry) -
        DateTime.now().toUtc().millisecondsSinceEpoch;
    if (msToTimeout <= 0) {
      await expire(key);
      return true;
    }
    return false;
  }

  /// Checks if the key has expired and deletes it if it has
  /// Returns true if the key was deleted
  /// Returns false if the key was not deleted
  @override
  Future<bool> checkAndExpire(String key) async {
    checkInitialized();

    if (data.containsKey(key)) {
      int expiration = data[key]!;
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
    checkInitialized();

    int? expiry = data.remove(key);
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
}

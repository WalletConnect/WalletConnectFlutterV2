import 'package:event/event.dart';
import 'package:wallet_connect_flutter_v2/apis/core/pairing/utils/pairing_models.dart';
import 'package:wallet_connect_flutter_v2/apis/core/store/i_store_user.dart';

abstract class IExpirer extends IStoreUser {
  abstract final Event<ExpirationEvent> onCreate;
  abstract final Event<ExpirationEvent> onDelete;
  abstract final Event onSync;
  abstract final Event<ExpirationEvent> onExpire;

  Future<void> init();
  bool has(String key);
  Future<void> set(String key, int value);
  int get(String key);
  Future<void> delete(String key);
  Future<bool> checkExpiry(String key, int expiry);
  Future<bool> checkAndExpire(String key);
  Future<void> expire(String key);
}

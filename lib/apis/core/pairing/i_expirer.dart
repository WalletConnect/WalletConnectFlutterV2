import 'package:event/event.dart';
import 'package:wallet_connect_flutter_v2/apis/core/pairing/utils/pairing_models.dart';
import 'package:wallet_connect_flutter_v2/apis/core/store/i_store_user.dart';

abstract class IExpirer extends IStoreUser {
  abstract final Event<ExpirationEvent> created;
  abstract final Event<ExpirationEvent> deleted;
  abstract final Event sync;
  abstract final Event<ExpirationEvent> expired;

  Future<void> init();
  bool has(String key);
  Future<void> set(String key, int value);
  int get(String key);
  Future<void> delete(String key);
  bool checkExpiry(String key, int expiry);
  void expire(String key);
}

import 'package:walletconnect_dart_v2/apis/core/store/i_store_user.dart';

abstract class ITopicMap extends IStoreUser {
  Future<void> init();
  bool has(String key);
  Future<void> set(String key, String value);
  String get(String key);
  Future<void> delete(String key);
}

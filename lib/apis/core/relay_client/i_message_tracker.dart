import 'package:walletconnect_dart_v2/apis/core/store/i_store_user.dart';

abstract class IMessageTracker extends IStoreUser {
  Future<void> init();
  Future<void> recordMessageEvent(String topic, String message);
  bool messageIsRecorded(String topc, String message);
  Future<void> deleteSubscriptionMessages(String topic);
}

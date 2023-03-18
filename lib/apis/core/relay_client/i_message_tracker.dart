import 'package:walletconnect_flutter_v2/apis/core/store/i_generic_store.dart';

abstract class IMessageTracker extends IGenericStore<Map<String, String>> {
  Future<void> recordMessageEvent(String topic, String message);
  bool messageIsRecorded(String topc, String message);
  Future<void> deleteSubscriptionMessages(String topic);
}

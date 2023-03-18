import 'package:walletconnect_flutter_v2/apis/core/relay_client/i_message_tracker.dart';
import 'package:walletconnect_flutter_v2/apis/core/store/generic_store.dart';

class MessageTracker extends GenericStore<Map<String, String>>
    implements IMessageTracker {
  MessageTracker({
    required super.core,
    required super.context,
    required super.version,
    required super.fromJson,
  });

  Future<void> recordMessageEvent(String topic, String message) async {
    final String hash = core.crypto.getUtils().hashMessage(message);
    if (!data.containsKey(topic)) {
      data[topic] = {};
    }
    data[topic]![hash] = message;
    await persist();
  }

  bool messageIsRecorded(String topic, String message) {
    final String hash = core.crypto.getUtils().hashMessage(message);
    return data.containsKey(topic) && data[topic]!.containsKey(hash);
  }

  Future<void> deleteSubscriptionMessages(String topic) async {
    data.remove(topic);
    await persist();
  }
}

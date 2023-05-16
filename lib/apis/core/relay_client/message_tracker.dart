import 'dart:convert';
import 'dart:typed_data';

import 'package:convert/convert.dart';
import 'package:pointycastle/digests/sha256.dart';
import 'package:walletconnect_flutter_v2/apis/core/relay_client/i_message_tracker.dart';
import 'package:walletconnect_flutter_v2/apis/core/store/generic_store.dart';
import 'package:walletconnect_flutter_v2/apis/core/store/store_models.dart';

class MessageTracker extends GenericStore<Map<String, String>>
    implements IMessageTracker {
  MessageTracker({
    required super.storage,
    required super.context,
    required super.version,
    required super.fromJson,
  });

  String hashMessage(String message) {
    return hex.encode(
      SHA256Digest().process(
        Uint8List.fromList(
          utf8.encode(message),
        ),
      ),
    );
  }

  @override
  Future<void> recordMessageEvent(String topic, String message) async {
    final String hash = hashMessage(message);

    onCreate.broadcast(
      StoreCreateEvent(
        topic,
        {hash: message},
      ),
    );

    if (!data.containsKey(topic)) {
      data[topic] = {};
    }
    data[topic]![hash] = message;
    await persist();
  }

  @override
  bool messageIsRecorded(String topic, String message) {
    final String hash = hashMessage(message);
    return data.containsKey(topic) && data[topic]!.containsKey(hash);
  }
}

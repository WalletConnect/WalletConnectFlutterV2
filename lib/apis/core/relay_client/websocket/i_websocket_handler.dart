import 'dart:async';

import 'package:stream_channel/stream_channel.dart';

abstract class IWebSocketHandler {
  String? get url;

  int? get closeCode;
  String? get closeReason;

  StreamChannel<String>? get channel;

  Future<void> get ready;

  Future<void> setup({
    required String url,
  });

  Future<void> connect();

  Future<void> close();
}

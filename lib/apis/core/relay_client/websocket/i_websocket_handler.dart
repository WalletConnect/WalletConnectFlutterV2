import 'dart:async';

import 'package:stream_channel/stream_channel.dart';

abstract class IWebSocketHandler {
  abstract final String url;

  Future<void> init();

  int? get closeCode;
  String? get closeReason;

  StreamChannel<String>? get channel;

  Future<void> close();

  Future<void> get ready;
}

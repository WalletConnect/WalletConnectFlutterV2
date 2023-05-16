import 'dart:async';

import 'package:stream_channel/stream_channel.dart';

abstract class IWebSocketHandler {
  abstract final String url;
  abstract final Duration heartbeatInterval;

  Future<void> init();

  StreamChannel<String>? get channel;

  Future<void> close();

  Future<void> get ready;
}

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:stream_channel/stream_channel.dart';
import 'package:web_socket_channel/web_socket_channel.dart';
import 'package:http/http.dart' as http;

abstract class IWebSocketHandler {
  abstract final String url;
  abstract final Duration heartbeatInterval;

  Future<void> init();

  StreamChannel<String>? get channel;

  Future<void> close();

  Future<void> get ready;
}

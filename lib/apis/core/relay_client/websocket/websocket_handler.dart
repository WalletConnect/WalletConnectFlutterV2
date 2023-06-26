import 'dart:async';

import 'package:stream_channel/stream_channel.dart';
import 'package:walletconnect_flutter_v2/apis/core/relay_client/websocket/i_http_client.dart';
import 'package:walletconnect_flutter_v2/apis/core/relay_client/websocket/i_websocket_handler.dart';
import 'package:walletconnect_flutter_v2/apis/models/basic_models.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

class WebSocketHandler implements IWebSocketHandler {
  @override
  final String url;
  final IHttpClient httpClient;

  WebSocketChannel? _socket;

  @override
  int? get closeCode => _socket?.closeCode;
  @override
  String? get closeReason => _socket?.closeReason;

  StreamChannel<String>? _channel;
  @override
  StreamChannel<String>? get channel => _channel;

  @override
  Future<void> get ready => _socket!.ready;

  WebSocketHandler({
    required this.url,
    required this.httpClient,
  });

  @override
  Future<void> init() async {
    await _connect();
  }

  @override
  Future<void> close() async {
    try {
      await _socket?.sink.close();
    } catch (_) {}
    _socket = null;
  }

  Future<void> _connect() async {
    // print('connecting');
    _socket = WebSocketChannel.connect(
      Uri.parse(
        '$url&useOnCloseEvent=true',
      ),
    );

    _channel = _socket!.cast<String>();

    if (_channel == null) {
      // print('Socket channel is null, waiting...');
      await Future.delayed(const Duration(milliseconds: 500));
      if (_channel == null) {
        // print('Socket channel is still null, throwing ');
        throw Exception('Socket channel is null');
      }
    }

    await _socket!.ready;

    // Check if the request was successful (status code 200)
    // try {} catch (e) {
    //   throw WalletConnectError(
    //     code: 400,
    //     message: 'WebSocket connection failed, missing or invalid project id.',
    //   );
    // }
  }

  @override
  String toString() {
    return 'WebSocketHandler{url: $url, _socket: $_socket, _channel: $_channel}';
  }
}

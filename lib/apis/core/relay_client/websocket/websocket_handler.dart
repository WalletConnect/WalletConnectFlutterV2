import 'dart:async';

import 'package:stream_channel/stream_channel.dart';
import 'package:walletconnect_flutter_v2/apis/core/relay_client/websocket/i_http_client.dart';
import 'package:walletconnect_flutter_v2/apis/core/relay_client/websocket/i_websocket_handler.dart';
import 'package:walletconnect_flutter_v2/apis/models/basic_models.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

class WebSocketHandler implements IWebSocketHandler {
  // static final _random = Random.secure();

  @override
  final String url;
  @override
  final Duration heartbeatInterval;
  final IHttpClient httpClient;
  final String origin;

  WebSocketChannel? _socket;

  StreamChannel<String>? _channel;
  @override
  StreamChannel<String>? get channel => _channel;

  @override
  Future<void> get ready => _socket!.ready;

  WebSocketHandler({
    required this.url,
    required this.httpClient,
    required this.origin,
    this.heartbeatInterval = const Duration(seconds: 30),
  });

  @override
  Future<void> init() async {
    await _connect();
  }

  @override
  Future<void> close() async {
    await _socket?.sink.close();
    // await _streamController?.close();
  }

  Future<void> _connect() async {
    // Perform the HTTP GET request
    // print(httpClient);
    // late Response response;

    // if (kIsWeb) {
    //   // Can't make a get request on web due to CORS, so we just assume we are good.
    //   response = Response('', 200);
    // } else {
    //   final httpsUrl = url.replaceFirst('wss', 'https');
    //   response = await httpClient.get(
    //     Uri.parse(
    //       httpsUrl,
    //     ),
    //   );
    // }

    // Check if the request was successful (status code 200)
    try {
      // print('connecting');
      _socket = WebSocketChannel.connect(
        Uri.parse(
          url,
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
      // print('websocket ready');

    } catch (e) {
      // If the request failed, handle the error
      // debugPrint(
      //   'HTTP GET request failed with status code: ${response.statusCode}',
      // );
      // print(response.headers);
      // print(response.statusCode);

      // switch (response.statusCode) {
      //   case WebSocketErrors.PROJECT_ID_NOT_FOUND:
      //     throw HttpException(WebSocketErrors.PROJECT_ID_NOT_FOUND_MESSAGE);
      //   case WebSocketErrors.INVALID_PROJECT_ID:
      //     throw HttpException(WebSocketErrors.INVALID_PROJECT_ID_MESSAGE);
      //   case WebSocketErrors.TOO_MANY_REQUESTS:
      //     throw HttpException(WebSocketErrors.TOO_MANY_REQUESTS_MESSAGE);
      //   default:
      //     throw HttpException(response.body);
      // }

      throw WalletConnectError(
        code: 400,
        message:
            'WebSocket connection failed, this could be: 1. Missing project id, 2. Invalid project id, 3. Too many requests',
      );
    }
  }

  // Future<Response> testWebSocketHandshake(String url) async {
  //   final uri = Uri.parse(url);
  //   final websocketKey = base64.encode(
  //     List<int>.generate(
  //       16,
  //       (index) => _random.nextInt(256),
  //     ),
  //   );

  //   final response = await httpClient.get(
  //     uri,
  //     headers: {
  //       'Connection': 'Upgrade',
  //       'Upgrade': 'websocket',
  //       'Origin': origin,
  //       'Sec-WebSocket-Key': websocketKey,
  //       'Sec-WebSocket-Version': '13',
  //     },
  //   );

  //   return response;
  // }

  @override
  String toString() {
    return 'WebSocketHandler{url: $url, heartbeatInterval: $heartbeatInterval, httpClient: $httpClient, origin: $origin, _socket: $_socket, _channel: $_channel}';
  }
}

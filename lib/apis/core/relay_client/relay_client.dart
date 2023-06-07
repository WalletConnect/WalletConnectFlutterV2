import 'dart:async';

import 'package:event/event.dart';
// import 'package:json_rpc_2/json_rpc_2.dart';
import 'package:walletconnect_flutter_v2/apis/core/i_core.dart';
import 'package:walletconnect_flutter_v2/apis/core/pairing/utils/json_rpc_utils.dart';
import 'package:walletconnect_flutter_v2/apis/core/relay_client/i_message_tracker.dart';
import 'package:walletconnect_flutter_v2/apis/core/relay_client/i_relay_client.dart';
import 'package:walletconnect_flutter_v2/apis/core/relay_client/json_rpc_2/src/parameters.dart';
import 'package:walletconnect_flutter_v2/apis/core/relay_client/json_rpc_2/src/peer.dart';
import 'package:walletconnect_flutter_v2/apis/core/relay_client/websocket/i_http_client.dart';
import 'package:walletconnect_flutter_v2/apis/core/relay_client/websocket/i_websocket_handler.dart';
import 'package:walletconnect_flutter_v2/apis/core/relay_client/relay_client_models.dart';
import 'package:walletconnect_flutter_v2/apis/core/relay_client/websocket/websocket_handler.dart';
import 'package:walletconnect_flutter_v2/apis/core/store/i_generic_store.dart';
import 'package:walletconnect_flutter_v2/apis/utils/constants.dart';
import 'package:walletconnect_flutter_v2/apis/utils/errors.dart';
import 'package:walletconnect_flutter_v2/apis/utils/walletconnect_utils.dart';

class RelayClient implements IRelayClient {
  static const JSON_RPC_PUBLISH = 'publish';
  static const JSON_RPC_SUBSCRIPTION = 'subscription';
  static const JSON_RPC_SUBSCRIBE = 'subscribe';
  static const JSON_RPC_UNSUBSCRIBE = 'unsubscribe';

  /// Events ///
  /// Relay Client

  @override
  final Event<EventArgs> onRelayClientConnect = Event();

  @override
  final Event<EventArgs> onRelayClientDisconnect = Event();

  @override
  final Event<ErrorEvent> onRelayClientError = Event<ErrorEvent>();

  @override
  final Event<MessageEvent> onRelayClientMessage = Event<MessageEvent>();

  /// Subscriptions
  @override
  final Event<SubscriptionEvent> onSubscriptionCreated =
      Event<SubscriptionEvent>();

  @override
  final Event<SubscriptionDeletionEvent> onSubscriptionDeleted =
      Event<SubscriptionDeletionEvent>();

  @override
  final Event<EventArgs> onSubscriptionResubscribed = Event();

  @override
  final Event<EventArgs> onSubscriptionSync = Event();

  bool _initialized = false;

  // late WebSocketChannel socket;
  late IWebSocketHandler socket;
  late Peer jsonRPC;

  /// Stores all the subs that haven't been completed
  Map<String, Future<dynamic>> pendingSubscriptions = {};

  IMessageTracker messageTracker;
  IGenericStore<String> topicMap;
  IHttpClient httpClient;

  ICore core;

  Timer? _heartbeatTimer;
  final int heartbeatPeriod;

  RelayClient({
    required this.core,
    required this.messageTracker,
    required this.topicMap,
    required this.httpClient,
    this.heartbeatPeriod = 5,
    relayUrl = WalletConnectConstants.RELAYER_DEFAULT_PROTOCOL,
  });

  @override
  Future<void> init() async {
    if (_initialized) {
      return;
    }

    onRelayClientDisconnect.subscribe(_reconnect);

    // Setup the json RPC server
    await _createJsonRPCProvider();
    _startHeartbeat();

    await messageTracker.init();
    await topicMap.init();

    _initialized = true;
  }

  @override
  Future<void> publish({
    required String topic,
    required String message,
    required int ttl,
    required int tag,
  }) async {
    _checkInitialized();

    Map<String, dynamic> data = {
      'message': message,
      'ttl': ttl,
      'topic': topic,
      'tag': tag,
    };

    try {
      await messageTracker.recordMessageEvent(topic, message);
      var _ = await _sendJsonRpcRequest(
        _buildMethod(JSON_RPC_PUBLISH),
        data,
        JsonRpcUtils.payloadId(entropy: 6),
      );
    } catch (e) {
      // print(e);
      onRelayClientError.broadcast(ErrorEvent(e));
    }
  }

  @override
  Future<String> subscribe({required String topic}) async {
    _checkInitialized();

    pendingSubscriptions[topic] = _onSubscribe(topic);

    return await pendingSubscriptions[topic];
  }

  @override
  Future<void> unsubscribe({required String topic}) async {
    _checkInitialized();

    String id = topicMap.get(topic) ?? '';
    // print('Unsub from id: $id');

    try {
      await _sendJsonRpcRequest(
        _buildMethod(JSON_RPC_UNSUBSCRIBE),
        {
          'topic': topic,
          'id': id,
        },
        JsonRpcUtils.payloadId(entropy: 6),
      );
    } catch (e) {
      onRelayClientError.broadcast(ErrorEvent(e));
    }

    // Remove the subscription
    pendingSubscriptions.remove(topic);
    await topicMap.delete(topic);

    // Delete all the messages
    await messageTracker.delete(topic);
  }

  @override
  Future<void> connect({String? relayUrl}) async {
    _checkInitialized();

    if (!jsonRPC.isClosed) {
      return;
    }
    // print('connecting to relay server');

    await disconnect();
    await _createJsonRPCProvider();
    if (_heartbeatTimer == null) {
      _startHeartbeat();
    }
  }

  @override
  Future<void> disconnect() async {
    _checkInitialized();
    onRelayClientDisconnect.unsubscribe(_reconnect);
    await jsonRPC.close();
    await socket.close();
    _heartbeatTimer?.cancel();
    _heartbeatTimer = null;
    onRelayClientDisconnect.subscribe(_reconnect);
  }

  /// PRIVATE FUNCTIONS ///

  Future<void> _createJsonRPCProvider() async {
    var auth = await core.crypto.signJWT(core.relayUrl);
    try {
      final String url = WalletConnectUtils.formatRelayRpcUrl(
        protocol: WalletConnectConstants.CORE_PROTOCOL,
        version: WalletConnectConstants.CORE_VERSION,
        relayUrl: core.relayUrl,
        sdkVersion: WalletConnectConstants.SDK_VERSION,
        auth: auth,
        projectId: core.projectId,
      );
      socket = WebSocketHandler(
        url: url,
        httpClient: httpClient,
        origin: core.projectId,
      );

      core.logger.v('Initializing WebSocket with $url');
      await socket.init();

      jsonRPC = Peer(socket.channel!);

      jsonRPC.registerMethod(
        _buildMethod(JSON_RPC_SUBSCRIPTION),
        _handleSubscription,
      );
      jsonRPC.registerMethod(
        _buildMethod(JSON_RPC_SUBSCRIBE),
        _handleSubscribe,
      );
      jsonRPC.registerMethod(
        _buildMethod(JSON_RPC_UNSUBSCRIBE),
        _handleUnsubscribe,
      );

      jsonRPC.listen();

      // When jsonRPC closes, emit the event
      jsonRPC.done.then((value) => onRelayClientDisconnect.broadcast());

      // print('connected');

      onRelayClientConnect.broadcast();
    } catch (e) {
      onRelayClientError.broadcast(ErrorEvent(e));
      rethrow;
    }
  }

  Future<void> _reconnect(EventArgs? args) async {
    core.logger.v('WebSocket disconnected, reconnecting');
    await connect();
  }

  void _startHeartbeat() {
    _heartbeatTimer = Timer.periodic(
      Duration(seconds: heartbeatPeriod),
      (timer) async {
        if (jsonRPC.isClosed) {
          core.logger.v('Heartbeat, WebSocket closed, reconnecting');
          await connect();
        }
        //  else {
        //   try {
        //     socket.channel!.sink.add('ping');
        //   } catch (e) {
        //     // Close the socket and trigger the disconnect -> reconnect
        //     await socket.close();
        //   }
        // }
      },
    );
  }

  String _buildMethod(String method) {
    return '${WalletConnectConstants.RELAYER_DEFAULT_PROTOCOL}_$method';
  }

  /// JSON RPC MESSAGE HANDLERS

  Future<bool> handlePublish(String topic, String message) async {
    core.logger.v('Handling Publish Message: $topic, $message');
    // If we want to ignore the message, stop
    if (await _shouldIgnoreMessageEvent(topic, message)) {
      core.logger.w('Ignoring Message: $topic, $message');
      return false;
    }

    // Record a message event
    await messageTracker.recordMessageEvent(topic, message);

    // Broadcast the message
    onRelayClientMessage.broadcast(
      MessageEvent(
        topic,
        message,
      ),
    );
    return true;
  }

  Future<bool> _handleSubscription(Parameters params) async {
    String topic = params['data']['topic'].value;
    String message = params['data']['message'].value;
    return await handlePublish(topic, message);
  }

  int _handleSubscribe(Parameters params) {
    return params.hashCode;
  }

  void _handleUnsubscribe(Parameters params) {}

  /// MESSAGE HANDLING

  Future<bool> _shouldIgnoreMessageEvent(String topic, String message) async {
    if (!await _isSubscribed(topic)) return true;
    return messageTracker.messageIsRecorded(topic, message);
  }

  /// SUBSCRIPTION HANDLING

  Future _sendJsonRpcRequest(
    String method, [
    dynamic parameters,
    int? id,
  ]) async {
    dynamic response;

    try {
      response = await jsonRPC.sendRequest(
        method,
        parameters,
        id,
      );
    } on StateError catch (_) {
      // Reconnect to the websocket
      core.logger.v('StateError, reconnecting: $_');
      await connect();
      response = await jsonRPC.sendRequest(
        method,
        parameters,
        id,
      );
    }

    return response;
  }

  Future<String> _onSubscribe(String topic) async {
    String? requestId;
    try {
      requestId = await _sendJsonRpcRequest(
        _buildMethod(JSON_RPC_SUBSCRIBE),
        {'topic': topic},
        JsonRpcUtils.payloadId(entropy: 6),
      );
    } catch (e) {
      // print('onSubscribe error: $e');
      core.logger.e('RelayClient, onSubscribe error: $e, Topic: $topic');
      onRelayClientError.broadcast(ErrorEvent(e));
    }

    if (requestId == null) {
      return '';
    }

    await topicMap.set(topic, requestId.toString());
    pendingSubscriptions.remove(topic);

    return requestId;
  }

  Future<bool> _isSubscribed(String topic) async {
    if (topicMap.has(topic)) {
      return true;
    }

    if (pendingSubscriptions.containsKey(topic)) {
      await pendingSubscriptions[topic];
      return topicMap.has(topic);
    }

    return false;
  }

  void _checkInitialized() {
    if (!_initialized) {
      throw Errors.getInternalError(Errors.NOT_INITIALIZED);
    }
  }
}

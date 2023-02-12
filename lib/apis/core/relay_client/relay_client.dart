import 'dart:async';

import 'package:event/event.dart';
import 'package:json_rpc_2/json_rpc_2.dart';
import 'package:wallet_connect_flutter_v2/apis/core/i_core.dart';
import 'package:wallet_connect_flutter_v2/apis/core/relay_client/i_message_tracker.dart';
import 'package:wallet_connect_flutter_v2/apis/core/relay_client/i_relay_client.dart';
import 'package:wallet_connect_flutter_v2/apis/core/relay_client/i_topic_map.dart';
import 'package:wallet_connect_flutter_v2/apis/core/relay_client/message_tracker.dart';
import 'package:wallet_connect_flutter_v2/apis/core/relay_client/relay_client_models.dart';
import 'package:wallet_connect_flutter_v2/apis/core/relay_client/topic_map.dart';
import 'package:wallet_connect_flutter_v2/apis/models/basic_models.dart';
import 'package:wallet_connect_flutter_v2/apis/utils/constants.dart';
import 'package:wallet_connect_flutter_v2/apis/utils/errors.dart';
import 'package:wallet_connect_flutter_v2/apis/utils/wallet_connect_utils.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

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

  late WebSocketChannel socket;
  late Peer jsonRPC;

  /// Stores all the subs that haven't been completed
  Map<String, Future<dynamic>> pendingSubscriptions = {};

  IMessageTracker? messageTracker;
  ITopicMap? topicMap;

  ICore core;

  RelayClient(
    this.core, {
    this.messageTracker,
    this.topicMap,
    // this.test = false,
    relayUrl = WalletConnectConstants.RELAYER_DEFAULT_PROTOCOL,
  });

  @override
  Future<void> init() async {
    if (_initialized) {
      return;
    }

    // Setup the json RPC server
    jsonRPC = await _createJsonRPCProvider();
    // jsonRPC.registerMethod(
    //   _buildMethod(JSON_RPC_PUBLISH),
    //   _handlePublish,
    // );
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

    // Initialize all of our stores
    // if (test) {
    //   _initialized = true;
    //   return;
    // }
    messageTracker ??= MessageTracker(core);
    topicMap ??= TopicMap(core);

    await messageTracker!.init();
    await topicMap!.init();

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
      var value = await jsonRPC.sendRequest(
        _buildMethod(JSON_RPC_PUBLISH),
        data,
      );
      // print(value);
      await messageTracker!.recordMessageEvent(topic, message);
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

    String id = topicMap!.get(topic);
    // print('Unsub from id: $id');

    try {
      await jsonRPC.sendRequest(
        _buildMethod(JSON_RPC_UNSUBSCRIBE),
        {
          'topic': topic,
          'id': id,
        },
      );
    } catch (e) {
      onRelayClientError.broadcast(ErrorEvent(e));
    }

    // Temove the subscription
    pendingSubscriptions.remove(topic);
    await topicMap!.delete(topic);

    // Delete all the messages
    messageTracker!.deleteSubscriptionMessages(topic);
  }

  @override
  Future<void> connect({String? relayUrl}) async {
    _checkInitialized();

    jsonRPC = await _createJsonRPCProvider();
  }

  @override
  Future<void> disconnect() async {
    _checkInitialized();
    await jsonRPC.close();
  }

  /// PRIVATE FUNCTIONS ///

  Future<Peer> _createJsonRPCProvider() async {
    // if (test) {
    //   StreamController<String> data = StreamController.broadcast();
    //   return Peer(StreamChannel(data.stream, data.sink));
    // }

    var auth = await core.crypto.signJWT(core.relayUrl);
    try {
      socket = WebSocketChannel.connect(
        Uri.parse(
          WalletConnectUtils.formatRelayRpcUrl(
            protocol: WalletConnectConstants.CORE_PROTOCOL,
            version: WalletConnectConstants.CORE_VERSION,
            relayUrl: core.relayUrl,
            sdkVersion: WalletConnectConstants.SDK_VERSION,
            auth: auth,
            projectId: core.projectId,
          ),
        ),
      );

      await socket.ready;

      return Peer(socket.cast<String>());
    } catch (e) {
      onRelayClientError.broadcast(ErrorEvent(e));
      throw WCError(
        code: 401,
        message:
            "Project ID doesn't exist, is invalid, or has too many requests",
      );
    }
  }

  String _buildMethod(String method) {
    return '${WalletConnectConstants.RELAYER_DEFAULT_PROTOCOL}_$method';
  }

  /// JSON RPC MESSAGE HANDLERS

  Future<bool> handlePublish(String topic, String message) async {
    // print('handle publish');
    // If we want to ignore the message, stop
    if (await _shouldIgnoreMessageEvent(topic, message)) return false;

    // Record a message event
    await messageTracker!.recordMessageEvent(topic, message);

    // Broadcast the message
    onRelayClientMessage.broadcast(
      MessageEvent(
        topic,
        message,
      ),
    );
    return true;
  }

  // Future<bool> _handlePublish(Parameters params) async {
  //   // print('handle publish');
  //   String topic = params['topic'].value;
  //   String message = params['message'].value;
  //   return await handlePublish(topic, message);
  // }

  Future<bool> _handleSubscription(Parameters params) async {
    // print('handle subscription.');
    String topic = params['data']['topic'].value;
    String message = params['data']['message'].value;
    // print(topic);
    // print(message);
    return await handlePublish(topic, message);
  }

  int _handleSubscribe(Parameters params) {
    // print('handle subscribe');
    return params.hashCode;
  }

  void _handleUnsubscribe(Parameters params) {}

  /// MESSAGE HANDLING

  Future<bool> _shouldIgnoreMessageEvent(String topic, String message) async {
    if (!await _isSubscribed(topic)) return true;
    return messageTracker!.messageIsRecorded(topic, message);
  }

  /// SUBSCRIPTION HANDLING

  Future<String> _onSubscribe(String topic) async {
    String? requestId;
    try {
      requestId = await jsonRPC.sendRequest(
        _buildMethod(JSON_RPC_SUBSCRIBE),
        {
          'topic': topic,
        },
      );
      // print('onSubscribe response $requestId');
    } catch (e) {
      // print('onSubscribe error: $e');
      onRelayClientError.broadcast(ErrorEvent(e));
    }

    if (requestId == null) {
      return '';
    }

    await topicMap!.set(topic, requestId.toString());
    pendingSubscriptions.remove(topic);

    return requestId;
  }

  Future<bool> _isSubscribed(String topic) async {
    if (topicMap!.has(topic)) {
      return true;
    }

    if (pendingSubscriptions.containsKey(topic)) {
      await pendingSubscriptions[topic];
      return topicMap!.has(topic);
    }

    return false;
  }

  void _checkInitialized() {
    if (!_initialized) {
      throw Errors.getInternalError(Errors.NOT_INITIALIZED);
    }
  }
}

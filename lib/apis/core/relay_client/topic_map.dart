import 'package:walletconnect_dart_v2/apis/core/i_core.dart';
import 'package:walletconnect_dart_v2/apis/core/relay_client/i_topic_map.dart';
import 'package:walletconnect_dart_v2/apis/utils/errors.dart';
import 'package:walletconnect_dart_v2/apis/utils/walletconnect_utils.dart';

class TopicMap implements ITopicMap {
  static const CONTEXT = 'topicMap';
  static const VERSION = '1.0';

  @override
  String get storageKey => '$VERSION//$CONTEXT';
  @override
  final ICore core;

  bool _initialized = false;
  Map<String, String> topicMap = {};

  TopicMap(this.core);

  @override
  Future<void> init() async {
    if (_initialized) {
      return;
    }

    await core.storage.init();
    await restore();

    _initialized = true;
  }

  @override
  bool has(String key) {
    _checkInitialized();
    return topicMap.containsKey(key);
  }

  @override
  String get(String key) {
    _checkInitialized();
    if (topicMap.containsKey(key)) {
      return topicMap[key]!;
    }
    return '';
  }

  @override
  Future<void> set(String key, String value) async {
    _checkInitialized();
    topicMap[key] = value;
    await persist();
  }

  @override
  Future<void> delete(String key) async {
    _checkInitialized();
    topicMap.remove(key);
    await persist();
  }

  @override
  Future<void> persist() async {
    _checkInitialized();
    await core.storage.set(storageKey, topicMap);
  }

  @override
  Future<void> restore() async {
    if (core.storage.has(storageKey)) {
      topicMap = WalletConnectUtils.convertMapTo<String>(
        core.storage.get(storageKey),
      );
    }
  }

  void _checkInitialized() {
    if (!_initialized) {
      throw Errors.getInternalError(Errors.NOT_INITIALIZED);
    }
  }
}

import 'dart:convert';

import 'package:walletconnect_flutter_v2/apis/core/i_core.dart';
import 'package:walletconnect_flutter_v2/apis/sign_api/i_sessions.dart';
import 'package:walletconnect_flutter_v2/apis/sign_api/models/session_models.dart';
import 'package:walletconnect_flutter_v2/apis/utils/errors.dart';
import 'package:walletconnect_flutter_v2/apis/utils/walletconnect_utils.dart';

class Sessions implements ISessions {
  static const CONTEXT = 'sessions';
  static const VERSION = '1.0';

  @override
  String get storageKey => '$VERSION//$CONTEXT';
  @override
  final ICore core;

  bool _initialized = false;

  /// Stores map of topic to pairing info
  Map<String, SessionData> data = {};

  /// Stores map of topic to pairing info as json encoded string
  Map<String, String> dataStrings = {};

  Sessions(this.core);

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
  bool has(String topic) {
    _checkInitialized();
    return data.containsKey(topic);
  }

  @override
  SessionData? get(String topic) {
    _checkInitialized();
    if (data.containsKey(topic)) {
      return data[topic]!;
    }
    return null;
  }

  @override
  List<SessionData> getAll() {
    return data.values.toList();
  }

  @override
  Future<void> set(String topic, SessionData value) async {
    _checkInitialized();
    data[topic] = value;
    dataStrings[topic] = jsonEncode(value.toJson());
    await persist();
  }

  @override
  Future<void> update(
    String topic, {
    int? expiry,
    Map<String, Namespace>? namespaces,
  }) async {
    _checkInitialized();

    SessionData? info = get(topic);
    if (info == null) {
      return;
    }

    if (expiry != null) {
      info.expiry = expiry;
    }
    if (namespaces != null) {
      info.namespaces = namespaces;
    }

    await set(topic, info);
  }

  @override
  Future<void> delete(String topic) async {
    _checkInitialized();
    data.remove(topic);
    dataStrings.remove(topic);
    await persist();
  }

  @override
  Future<void> persist() async {
    _checkInitialized();
    await core.storage.set(storageKey, dataStrings);
  }

  @override
  Future<void> restore() async {
    if (core.storage.has(storageKey)) {
      dataStrings = WalletConnectUtils.convertMapTo<String>(
        core.storage.get(storageKey),
      );
      for (var entry in dataStrings.entries) {
        data[entry.key] = SessionData.fromJson(
          jsonDecode(entry.value),
        );
      }
    }
  }

  void _checkInitialized() {
    if (!_initialized) {
      throw Errors.getInternalError(Errors.NOT_INITIALIZED);
    }
  }
}

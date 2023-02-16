import 'package:event/event.dart';
import 'package:walletconnect_flutter_v2/apis/core/i_core.dart';
import 'package:walletconnect_flutter_v2/apis/core/pairing/i_json_rpc_history.dart';
import 'package:walletconnect_flutter_v2/apis/core/pairing/utils/pairing_models.dart';
import 'package:walletconnect_flutter_v2/apis/models/json_rpc_request.dart';
import 'package:walletconnect_flutter_v2/apis/utils/errors.dart';
import 'package:walletconnect_flutter_v2/apis/utils/walletconnect_utils.dart';

class JsonRpcHistory implements IJsonRpcHistory {
  static const CONTEXT = 'jsonRpcHistory';
  static const VERSION = '1.0';

  @override
  final Event<HistoryEvent> created = Event<HistoryEvent>();
  @override
  final Event<HistoryEvent> updated = Event<HistoryEvent>();
  @override
  final Event<HistoryEvent> deleted = Event<HistoryEvent>();
  @override
  final Event sync = Event();

  @override
  String get storageKey => '$VERSION//$CONTEXT';
  @override
  final ICore core;

  bool _initialized = false;
  Map<String, Map<String, dynamic>> history = {};

  JsonRpcHistory(this.core);

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
  bool has(int key) {
    _checkInitialized();
    return history.containsKey(key.toString());
  }

  @override
  JsonRpcRecord? get(int key) {
    _checkInitialized();
    if (history.containsKey(key.toString())) {
      return JsonRpcRecord.fromJson(history[key.toString()]!);
    }
    return null;
  }

  @override
  Future<void> set(
    String topic,
    JsonRpcRequest value, {
    String? chainId,
  }) async {
    _checkInitialized();

    final JsonRpcRecord record = JsonRpcRecord(
      id: value.id,
      topic: topic,
      method: value.method,
      params: value.params,
      chainId: chainId,
    );

    history[value.id.toString()] = record.toJson();
    created.broadcast(HistoryEvent(record: record));
    await persist();
  }

  @override
  Future<void> resolve(Map<String, dynamic> response) async {
    _checkInitialized();

    // If we don't have a matching id, stop
    if (!history.containsKey(response['id'])) {
      return;
    }

    JsonRpcRecord record = get(response['id'])!;

    // If we already recorded a response, stop
    if (record.response != null) {
      return;
    }

    record.response =
        response.containsKey('result') ? response['result'] : response['error'];
    history[response['id'].toString()] = record.toJson();
    updated.broadcast(HistoryEvent(record: record));
    await persist();
  }

  @override
  Future<void> delete(int key) async {
    _checkInitialized();
    Map<String, dynamic>? r = history.remove(key.toString());
    if (r != null) {
      deleted.broadcast(
        HistoryEvent(
          record: JsonRpcRecord.fromJson(
            r,
          ),
        ),
      );
    }
    await persist();
  }

  @override
  Future<void> persist() async {
    _checkInitialized();
    await core.storage.set(storageKey, history);
    sync.broadcast();
  }

  @override
  Future<void> restore() async {
    if (core.storage.has(storageKey)) {
      history = WalletConnectUtils.convertMapTo<Map<String, dynamic>>(
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

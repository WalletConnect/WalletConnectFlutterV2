import 'package:walletconnect_flutter_v2/apis/core/i_core.dart';
import 'package:walletconnect_flutter_v2/apis/core/pairing/i_pairing_store.dart';
import 'package:walletconnect_flutter_v2/apis/core/pairing/utils/pairing_models.dart';
import 'package:walletconnect_flutter_v2/apis/utils/errors.dart';

class PairingStore implements IPairingStore {
  static const CONTEXT = 'pairings';
  static const VERSION = '1.0';

  @override
  String get storageKey => '$VERSION//$CONTEXT';
  @override
  final ICore core;

  bool _initialized = false;

  /// Stores map of topic to pairing info
  Map<String, PairingInfo> pairings = {};

  PairingStore(this.core);

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
    return pairings.containsKey(topic);
  }

  @override
  PairingInfo? get(String topic) {
    _checkInitialized();
    if (pairings.containsKey(topic)) {
      return pairings[topic]!;
    }
    return null;
  }

  @override
  List<PairingInfo> getAll() {
    return pairings.values.toList();
  }

  @override
  Future<void> set(String topic, PairingInfo value) async {
    _checkInitialized();
    pairings[topic] = value;
    await persist();
  }

  @override
  Future<void> update(
    String topic, {
    int? expiry,
    bool? active,
    PairingMetadata? metadata,
  }) async {
    _checkInitialized();

    PairingInfo? info = get(topic);
    if (info == null) {
      return;
    }

    if (expiry != null) {
      info.expiry = expiry;
    }
    if (active != null) {
      info.active = active;
    }
    if (metadata != null) {
      info.peerMetadata = metadata;
    }

    await set(topic, info);
  }

  @override
  Future<void> delete(String topic) async {
    _checkInitialized();
    pairings.remove(topic);
    await persist();
  }

  @override
  Future<void> persist() async {
    _checkInitialized();
    await core.storage.set(storageKey, pairings);
  }

  @override
  Future<void> restore() async {
    if (core.storage.has(storageKey)) {
      Map<String, dynamic> data = core.storage.get(storageKey);
      for (var entry in data.entries) {
        pairings[entry.key] = PairingInfo.fromJson(
          entry.value,
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

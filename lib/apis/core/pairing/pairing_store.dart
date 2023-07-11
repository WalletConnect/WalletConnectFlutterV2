import 'package:walletconnect_flutter_v2/apis/core/pairing/i_pairing_store.dart';
import 'package:walletconnect_flutter_v2/apis/core/pairing/utils/pairing_models.dart';
import 'package:walletconnect_flutter_v2/apis/core/store/generic_store.dart';

class PairingStore extends GenericStore<PairingInfo> implements IPairingStore {
  PairingStore({
    required super.storage,
    required super.context,
    required super.version,
    required super.fromJson,
  });

  @override
  Future<void> update(
    String topic, {
    int? expiry,
    bool? active,
    PairingMetadata? metadata,
  }) async {
    checkInitialized();

    PairingInfo? info = get(topic);
    if (info == null) {
      return;
    }

    if (expiry != null) {
      info = info.copyWith(expiry: expiry);
    }
    if (active != null) {
      info = info.copyWith(active: active);
    }
    if (metadata != null) {
      info = info.copyWith(peerMetadata: metadata);
    }

    await set(topic, info);
  }
}

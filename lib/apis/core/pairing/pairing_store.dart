import 'package:walletconnect_flutter_v2/apis/core/pairing/i_pairing_store.dart';
import 'package:walletconnect_flutter_v2/apis/core/pairing/utils/pairing_models.dart';
import 'package:walletconnect_flutter_v2/apis/core/store/generic_store.dart';
import 'package:walletconnect_flutter_v2/apis/core/store/store_models.dart';

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
    // int prevExpiry = info.expiry;
    // bool wasActive = info.active;

    if (expiry != null) {
      info.expiry = expiry;
    }
    if (active != null) {
      info.active = active;
    }
    if (metadata != null) {
      info.peerMetadata = metadata;
    }

    // onUpdate.broadcast(
    //   StoreUpdateEvent(
    //     topic,
    //     info,
    //   ),
    // );

    // print('Previous expiry: $prevExpiry, new expiry: ${info.expiry}');
    // print('Previous active: $wasActive, new active: ${info.active}');
    await set(topic, info);

    // print('Saved PairingInfo');
    // print(get(topic));
  }
}

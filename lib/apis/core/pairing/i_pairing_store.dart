import 'package:walletconnect_flutter_v2/apis/core/pairing/utils/pairing_models.dart';
import 'package:walletconnect_flutter_v2/apis/core/store/i_generic_store.dart';

abstract class IPairingStore extends IGenericStore<PairingInfo> {
  Future<void> update(
    String topic, {
    int? expiry,
    bool? active,
    PairingMetadata? metadata,
  });
}

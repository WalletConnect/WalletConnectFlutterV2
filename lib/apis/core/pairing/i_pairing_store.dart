import 'package:walletconnect_flutter_v2/apis/core/pairing/utils/pairing_models.dart';
import 'package:walletconnect_flutter_v2/apis/core/store/i_store_user.dart';

abstract class IPairingStore extends IStoreUser {
  Future<void> init();
  bool has(String topic);
  Future<void> set(String topic, PairingInfo value);
  Future<void> update(
    String topic, {
    int? expiry,
    bool? active,
    PairingMetadata? metadata,
  });
  PairingInfo? get(String topic);
  List<PairingInfo> getAll();
  Future<void> delete(String topic);
}

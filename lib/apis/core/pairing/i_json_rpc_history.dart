import 'package:event/event.dart';
import 'package:walletconnect_flutter_v2/apis/core/pairing/utils/pairing_models.dart';
import 'package:walletconnect_flutter_v2/apis/core/store/i_generic_store.dart';

abstract class IJsonRpcHistory extends IGenericStore<JsonRpcRecord> {
  Future<void> resolve(Map<String, dynamic> response);
}

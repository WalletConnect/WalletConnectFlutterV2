import 'package:event/event.dart';
import 'package:walletconnect_flutter_v2/apis/core/i_core.dart';
import 'package:walletconnect_flutter_v2/apis/core/pairing/i_json_rpc_history.dart';
import 'package:walletconnect_flutter_v2/apis/core/pairing/utils/pairing_models.dart';
import 'package:walletconnect_flutter_v2/apis/core/store/generic_store.dart';
import 'package:walletconnect_flutter_v2/apis/core/store/store_models.dart';
import 'package:walletconnect_flutter_v2/apis/models/json_rpc_request.dart';
import 'package:walletconnect_flutter_v2/apis/utils/errors.dart';
import 'package:walletconnect_flutter_v2/apis/utils/walletconnect_utils.dart';

class JsonRpcHistory extends GenericStore<JsonRpcRecord>
    implements IJsonRpcHistory {
  JsonRpcHistory({
    required super.core,
    required super.context,
    required super.version,
    required super.fromJson,
  });

  @override
  Future<void> resolve(Map<String, dynamic> response) async {
    checkInitialized();

    // If we don't have a matching id, stop
    if (!data.containsKey(response['id'])) {
      return;
    }

    JsonRpcRecord record = get(response['id'])!;

    // If we already recorded a response, stop
    if (record.response != null) {
      return;
    }

    record.response =
        response.containsKey('result') ? response['result'] : response['error'];
    data[response['id'].toString()] = record;
    onUpdate.broadcast(
      StoreUpdateEvent(
        response['id'].toString(),
        record,
      ),
    );
    await persist();
  }
}

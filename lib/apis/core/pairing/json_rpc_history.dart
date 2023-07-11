import 'package:walletconnect_flutter_v2/apis/core/pairing/i_json_rpc_history.dart';
import 'package:walletconnect_flutter_v2/apis/core/pairing/utils/pairing_models.dart';
import 'package:walletconnect_flutter_v2/apis/core/store/generic_store.dart';

class JsonRpcHistory extends GenericStore<JsonRpcRecord>
    implements IJsonRpcHistory {
  JsonRpcHistory({
    required super.storage,
    required super.context,
    required super.version,
    required super.fromJson,
  });

  @override
  Future<void> resolve(Map<String, dynamic> response) async {
    checkInitialized();

    // If we don't have a matching id, stop
    String sId = response['id'].toString();
    if (!data.containsKey(sId)) {
      return;
    }

    JsonRpcRecord record = get(sId)!;

    // If we already recorded a response, stop
    if (record.response != null) {
      return;
    }

    record = record.copyWith(
      response: response.containsKey('result')
          ? response['result']
          : response['error'],
    );
    await set(sId, record);
  }
}

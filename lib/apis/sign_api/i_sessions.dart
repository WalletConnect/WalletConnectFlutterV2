import 'package:walletconnect_flutter_v2/apis/core/relay_client/relay_client_models.dart';
import 'package:walletconnect_flutter_v2/apis/core/store/i_generic_store.dart';
import 'package:walletconnect_flutter_v2/apis/sign_api/models/session_models.dart';

abstract class ISessions extends IGenericStore<SessionData> {
  Future<void> update(
    String topic, {
    int? expiry,
    Map<String, Namespace>? namespaces,
    TransportType? transportType,
  });
}

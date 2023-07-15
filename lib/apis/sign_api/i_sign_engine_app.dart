import 'package:event/event.dart';
import 'package:walletconnect_flutter_v2/apis/core/relay_client/relay_client_models.dart';
import 'package:walletconnect_flutter_v2/apis/sign_api/i_sign_engine_common.dart';
import 'package:walletconnect_flutter_v2/apis/sign_api/models/json_rpc_models.dart';
import 'package:walletconnect_flutter_v2/apis/sign_api/models/proposal_models.dart';
import 'package:walletconnect_flutter_v2/apis/sign_api/models/sign_client_events.dart';
import 'package:walletconnect_flutter_v2/apis/sign_api/models/sign_client_models.dart';

abstract class ISignEngineApp extends ISignEngineCommon {
  abstract final Event<SessionUpdate> onSessionUpdate;
  abstract final Event<SessionExtend> onSessionExtend;
  abstract final Event<SessionEvent> onSessionEvent;

  Future<ConnectResponse> connect({
    Map<String, RequiredNamespace>? requiredNamespaces,
    Map<String, RequiredNamespace>? optionalNamespaces,
    Map<String, String>? sessionProperties,
    String? pairingTopic,
    List<Relay>? relays,
    List<List<String>>? methods,
  });
  Future<dynamic> request({
    required String topic,
    required String chainId,
    required SessionRequestParams request,
  });
  void registerEventHandler({
    required String chainId,
    required String event,
    dynamic Function(String, dynamic)? handler,
  });
  Future<void> ping({
    required String topic,
  });
}

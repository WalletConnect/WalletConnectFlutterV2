import 'package:walletconnect_flutter_v2/apis/sign_api/i_sign_engine_common.dart';
import 'package:walletconnect_flutter_v2/walletconnect_flutter_v2.dart';

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
  Future<dynamic> requestReadContract({
    required DeployedContract deployedContract,
    required String functionName,
    required String rpcUrl,
    List<dynamic> parameters = const [],
  });
  Future<dynamic> requestWriteContract({
    required String topic,
    required String chainId,
    required String rpcUrl,
    required DeployedContract deployedContract,
    required String functionName,
    required Transaction transaction,
    String? method,
    List<dynamic> parameters = const [],
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

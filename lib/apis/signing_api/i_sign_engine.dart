import 'package:event/event.dart';
import 'package:wallet_connect_flutter_v2/apis/core/relay_client/relay_client_models.dart';
import 'package:wallet_connect_flutter_v2/apis/signing_api/i_sign_engine_wallet.dart';
import 'package:wallet_connect_flutter_v2/apis/signing_api/models/json_rpc_models.dart';
import 'package:wallet_connect_flutter_v2/apis/signing_api/models/proposal_models.dart';
import 'package:wallet_connect_flutter_v2/apis/signing_api/models/sign_client_events.dart';
import 'package:wallet_connect_flutter_v2/apis/signing_api/models/sign_client_models.dart';

abstract class ISignEngine extends ISignEngineWallet {
  abstract final Event<SessionConnect> onSessionConnect;
  abstract final Event<SessionUpdate> onSessionUpdate;
  abstract final Event<SessionExtend> onSessionExtend;
  abstract final Event<SessionExpire> onSessionExpire;
  abstract final Event<SessionEvent> onSessionEvent;
  abstract final Event<SessionPing> onSessionPing;

  Future<ConnectResponse> connect({
    Map<String, RequiredNamespace>? requiredNamespaces,
    Map<String, RequiredNamespace>? optionalNamespaces,
    Map<String, String>? sessionProperties,
    String? pairingTopic,
    List<Relay>? relays,
  });
  Future<dynamic> request({
    required String topic,
    required String chainId,
    required SessionRequestParams request,
  });
  void registerEventHandler({
    required String chainId,
    required String event,
    required dynamic Function(String, dynamic)? handler,
  });
  Future<void> ping({
    required String topic,
  });
}

import 'package:logger/logger.dart';
import 'package:walletconnect_flutter_v2/apis/core/connectivity/i_connectivity.dart';
import 'package:walletconnect_flutter_v2/apis/core/crypto/i_crypto.dart';
import 'package:walletconnect_flutter_v2/apis/core/echo/i_echo.dart';
import 'package:walletconnect_flutter_v2/apis/core/heartbit/i_heartbeat.dart';
import 'package:walletconnect_flutter_v2/apis/core/pairing/i_expirer.dart';
import 'package:walletconnect_flutter_v2/apis/core/pairing/i_pairing.dart';
import 'package:walletconnect_flutter_v2/apis/core/relay_client/i_relay_client.dart';
import 'package:walletconnect_flutter_v2/apis/core/store/i_store.dart';
import 'package:walletconnect_flutter_v2/apis/core/store/supported_linkmode_store.dart';
import 'package:walletconnect_flutter_v2/apis/core/verify/i_verify.dart';

abstract class ICore {
  final String protocol = 'wc';
  final String version = '2';

  abstract String relayUrl;
  abstract final String projectId;
  abstract final String pushUrl;

  abstract IHeartBeat heartbeat;
  abstract ICrypto crypto;
  abstract IRelayClient relayClient;
  abstract IStore<Map<String, dynamic>> storage;

  abstract IConnectivity connectivity;
  abstract IExpirer expirer;
  abstract IPairing pairing;
  abstract IEcho echo;
  abstract final Logger logger;
  abstract IVerify verify;
  abstract ILinkModeStore linkModeStore;

  Future<void> start();

  void confirmOnlineStateOrThrow();

  Future<void> addLinkModeSupportedApp(String universalLink);

  List<String> getLinkModeSupportedApps();

  void addLogListener(LogCallback callback);
  bool removeLogListener(LogCallback callback);
}

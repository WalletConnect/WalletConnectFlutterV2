import 'package:walletconnect_dart_v2/apis/core/crypto/i_crypto.dart';
import 'package:walletconnect_dart_v2/apis/core/pairing/i_expirer.dart';
import 'package:walletconnect_dart_v2/apis/core/pairing/i_json_rpc_history.dart';
import 'package:walletconnect_dart_v2/apis/core/pairing/i_pairing.dart';
import 'package:walletconnect_dart_v2/apis/core/relay_client/i_relay_client.dart';
import 'package:walletconnect_dart_v2/apis/core/store/i_store.dart';

abstract class ICore {
  final String protocol = 'wc';
  final String version = '2';

  abstract final String relayUrl;
  abstract final String projectId;

  // abstract IHeartBeat heartbeat;
  abstract ICrypto crypto;
  abstract IRelayClient relayClient;
  abstract IStore<Map<String, dynamic>> storage;
  abstract IJsonRpcHistory history;
  abstract IExpirer expirer;
  abstract IPairing pairing;

  Future<void> start();
}

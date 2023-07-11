import 'package:logger/logger.dart';
import 'package:walletconnect_flutter_v2/apis/core/crypto/crypto.dart';
import 'package:walletconnect_flutter_v2/apis/core/crypto/i_crypto.dart';
import 'package:walletconnect_flutter_v2/apis/core/echo/echo.dart';
import 'package:walletconnect_flutter_v2/apis/core/echo/echo_client.dart';
import 'package:walletconnect_flutter_v2/apis/core/echo/i_echo.dart';
import 'package:walletconnect_flutter_v2/apis/core/i_core.dart';
import 'package:walletconnect_flutter_v2/apis/core/pairing/expirer.dart';
import 'package:walletconnect_flutter_v2/apis/core/pairing/i_expirer.dart';
import 'package:walletconnect_flutter_v2/apis/core/pairing/json_rpc_history.dart';
import 'package:walletconnect_flutter_v2/apis/core/pairing/pairing.dart';
import 'package:walletconnect_flutter_v2/apis/core/pairing/pairing_store.dart';
import 'package:walletconnect_flutter_v2/apis/core/pairing/utils/pairing_models.dart';
import 'package:walletconnect_flutter_v2/apis/core/relay_client/message_tracker.dart';
import 'package:walletconnect_flutter_v2/apis/core/relay_client/relay_client.dart';
import 'package:walletconnect_flutter_v2/apis/core/relay_client/websocket/http_client.dart';
import 'package:walletconnect_flutter_v2/apis/core/relay_client/websocket/i_http_client.dart';
import 'package:walletconnect_flutter_v2/apis/core/store/generic_store.dart';
import 'package:walletconnect_flutter_v2/apis/core/store/i_store.dart';
import 'package:walletconnect_flutter_v2/apis/core/relay_client/i_relay_client.dart';
import 'package:walletconnect_flutter_v2/apis/core/pairing/i_pairing.dart';
import 'package:walletconnect_flutter_v2/apis/core/store/shared_prefs_store.dart';
import 'package:walletconnect_flutter_v2/apis/utils/constants.dart';
import 'package:walletconnect_flutter_v2/apis/utils/walletconnect_utils.dart';

class Core implements ICore {
  @override
  String get protocol => 'wc';
  @override
  String get version => '2';

  @override
  final String relayUrl;

  @override
  final String projectId;

  @override
  final String pushUrl;

  @override
  late ICrypto crypto;

  @override
  late IRelayClient relayClient;

  @override
  late IExpirer expirer;

  // @override
  // late IJsonRpcHistory history;

  @override
  late IPairing pairing;

  @override
  late IEcho echo;

  @override
  final Logger logger = Logger(
    printer: PrettyPrinter(
        // methodCount: 3,
        ),
  );

  @override
  late IStore<Map<String, dynamic>> storage;

  Core({
    this.relayUrl = WalletConnectConstants.DEFAULT_RELAY_URL,
    required this.projectId,
    this.pushUrl = WalletConnectConstants.DEFAULT_PUSH_URL,
    bool memoryStore = false,
    String extraStoragePrefix = '',
    Level logLevel = Level.info,
    IHttpClient httpClient = const HttpWrapper(),
  }) {
    Logger.level = logLevel;
    storage = SharedPrefsStores(
      memoryStore: memoryStore,
      extraStoragePrefix: extraStoragePrefix,
    );
    crypto = Crypto(
      core: this,
      keyChain: GenericStore<String>(
        storage: storage,
        context: StoreVersions.CONTEXT_KEYCHAIN,
        version: StoreVersions.VERSION_KEYCHAIN,
        fromJson: (dynamic value) => value as String,
      ),
    );
    relayClient = RelayClient(
      core: this,
      messageTracker: MessageTracker(
        storage: storage,
        context: StoreVersions.CONTEXT_MESSAGE_TRACKER,
        version: StoreVersions.VERSION_MESSAGE_TRACKER,
        fromJson: (dynamic value) {
          return WalletConnectUtils.convertMapTo<String>(value);
        },
      ),
      topicMap: GenericStore<String>(
        storage: storage,
        context: StoreVersions.CONTEXT_TOPIC_MAP,
        version: StoreVersions.VERSION_TOPIC_MAP,
        fromJson: (dynamic value) => value as String,
      ),
      httpClient: httpClient,
    );
    expirer = Expirer(
      storage: storage,
      context: StoreVersions.CONTEXT_EXPIRER,
      version: StoreVersions.VERSION_EXPIRER,
      fromJson: (dynamic value) => value as int,
    );
    pairing = Pairing(
      core: this,
      pairings: PairingStore(
        storage: storage,
        context: StoreVersions.CONTEXT_PAIRINGS,
        version: StoreVersions.VERSION_PAIRINGS,
        fromJson: (dynamic value) {
          return PairingInfo.fromJson(value as Map<String, dynamic>);
        },
      ),
      history: JsonRpcHistory(
        storage: storage,
        context: StoreVersions.CONTEXT_JSON_RPC_HISTORY,
        version: StoreVersions.VERSION_JSON_RPC_HISTORY,
        fromJson: (dynamic value) => JsonRpcRecord.fromJson(value),
      ),
      topicToReceiverPublicKey: GenericStore(
        storage: storage,
        context: StoreVersions.CONTEXT_TOPIC_TO_RECEIVER_PUBLIC_KEY,
        version: StoreVersions.VERSION_TOPIC_TO_RECEIVER_PUBLIC_KEY,
        fromJson: (dynamic value) => ReceiverPublicKey.fromJson(value),
      ),
    );
    echo = Echo(
      core: this,
      echoClient: EchoClient(
        baseUrl: pushUrl,
        httpClient: httpClient,
      ),
    );
  }

  @override
  Future<void> start() async {
    await storage.init();
    await crypto.init();
    await relayClient.init();
    await expirer.init();
    // await history.init();
    await pairing.init();
  }
}

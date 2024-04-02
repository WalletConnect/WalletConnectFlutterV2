import 'package:flutter_test/flutter_test.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:walletconnect_flutter_v2/apis/core/core.dart';
import 'package:walletconnect_flutter_v2/apis/core/i_core.dart';
import 'package:walletconnect_flutter_v2/apis/core/pairing/i_json_rpc_history.dart';
import 'package:walletconnect_flutter_v2/apis/core/pairing/i_pairing.dart';
import 'package:walletconnect_flutter_v2/apis/core/pairing/i_pairing_store.dart';
import 'package:walletconnect_flutter_v2/apis/core/pairing/json_rpc_history.dart';
import 'package:walletconnect_flutter_v2/apis/core/pairing/pairing.dart';
import 'package:walletconnect_flutter_v2/apis/core/pairing/pairing_store.dart';
import 'package:walletconnect_flutter_v2/apis/core/pairing/utils/pairing_models.dart';
import 'package:walletconnect_flutter_v2/apis/core/relay_client/relay_client_models.dart';
import 'package:walletconnect_flutter_v2/apis/core/store/generic_store.dart';
import 'package:walletconnect_flutter_v2/apis/utils/constants.dart';

import '../shared/shared_test_utils.dart';
import '../shared/shared_test_values.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  PackageInfo.setMockInitialValues(
    appName: 'walletconnect_flutter_v2',
    packageName: 'com.walletconnect.flutterdapp',
    version: '1.0',
    buildNumber: '2',
    buildSignature: 'buildSignature',
  );

  group('Pairing store', () {
    late ICore coreA;
    late ICore coreB;

    late IPairing pairing;
    late IJsonRpcHistory history;
    late IPairingStore pairingStore;
    late GenericStore<ReceiverPublicKey> topicToReceiverPublicKey;

    setUp(() async {
      coreA = Core(
        relayUrl: TEST_RELAY_URL,
        projectId: TEST_PROJECT_ID,
        memoryStore: true,
        httpClient: getHttpWrapper(),
      );
      coreB = Core(
        relayUrl: TEST_RELAY_URL,
        projectId: TEST_PROJECT_ID,
        memoryStore: true,
        httpClient: getHttpWrapper(),
      );
      await coreA.start();
      await coreB.start();

      pairingStore = PairingStore(
        storage: coreA.storage,
        context: StoreVersions.CONTEXT_PAIRINGS,
        version: StoreVersions.VERSION_PAIRINGS,
        fromJson: (dynamic value) {
          return PairingInfo.fromJson(value as Map<String, dynamic>);
        },
      );
      history = JsonRpcHistory(
        storage: coreA.storage,
        context: StoreVersions.CONTEXT_JSON_RPC_HISTORY,
        version: StoreVersions.VERSION_JSON_RPC_HISTORY,
        fromJson: (dynamic value) => JsonRpcRecord.fromJson(value),
      );
      topicToReceiverPublicKey = GenericStore(
        storage: coreA.storage,
        context: StoreVersions.CONTEXT_TOPIC_TO_RECEIVER_PUBLIC_KEY,
        version: StoreVersions.VERSION_TOPIC_TO_RECEIVER_PUBLIC_KEY,
        fromJson: (dynamic value) => ReceiverPublicKey.fromJson(value),
      );
      pairing = Pairing(
        core: coreA,
        pairings: pairingStore,
        history: history,
        topicToReceiverPublicKey: topicToReceiverPublicKey,
      );
    });

    tearDown(() async {
      await coreA.relayClient.disconnect();
      await coreB.relayClient.disconnect();
    });

    group('pairing init', () {
      test('deletes expired records', () async {
        await history.init();
        await history.set(
          '1',
          const JsonRpcRecord(
            id: 1,
            topic: '1',
            method: 'eth_sign',
            params: '',
          ),
        );
        await history.set(
          '2',
          const JsonRpcRecord(
            id: 2,
            topic: '1',
            method: 'eth_sign',
            params: '',
            expiry: 0,
          ),
        );
        await pairingStore.init();
        await pairingStore.set(
          'expired',
          PairingInfo(
            topic: 'expired',
            expiry: -1,
            relay: Relay(
              'irn',
            ),
            active: true,
          ),
        );
        await topicToReceiverPublicKey.init();
        await topicToReceiverPublicKey.set(
          'abc',
          const ReceiverPublicKey(
            topic: 'abc',
            publicKey: 'def',
            expiry: -1,
          ),
        );

        expect(history.getAll().length, 2);
        expect(pairingStore.getAll().length, 1);
        expect(topicToReceiverPublicKey.getAll().length, 1);
        await pairing.init();
        expect(history.getAll().length, 0);
        expect(pairingStore.getAll().length, 0);
        expect(topicToReceiverPublicKey.getAll().length, 0);
      });
    });
  });
}

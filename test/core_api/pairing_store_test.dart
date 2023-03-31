import 'dart:async';

import 'package:flutter_test/flutter_test.dart';
import 'package:walletconnect_flutter_v2/apis/core/core.dart';
import 'package:walletconnect_flutter_v2/apis/core/i_core.dart';
import 'package:walletconnect_flutter_v2/apis/core/pairing/i_json_rpc_history.dart';
import 'package:walletconnect_flutter_v2/apis/core/pairing/i_pairing.dart';
import 'package:walletconnect_flutter_v2/apis/core/pairing/i_pairing_store.dart';
import 'package:walletconnect_flutter_v2/apis/core/pairing/json_rpc_history.dart';
import 'package:walletconnect_flutter_v2/apis/core/pairing/pairing.dart';
import 'package:walletconnect_flutter_v2/apis/core/pairing/pairing_store.dart';
import 'package:walletconnect_flutter_v2/apis/core/pairing/utils/pairing_models.dart';
import 'package:walletconnect_flutter_v2/apis/core/pairing/utils/json_rpc_utils.dart';
import 'package:walletconnect_flutter_v2/apis/core/relay_client/relay_client_models.dart';
import 'package:walletconnect_flutter_v2/apis/core/store/generic_store.dart';
import 'package:walletconnect_flutter_v2/apis/models/basic_models.dart';
import 'package:walletconnect_flutter_v2/apis/models/uri_parse_result.dart';
import 'package:walletconnect_flutter_v2/apis/utils/constants.dart';
import 'package:walletconnect_flutter_v2/apis/utils/method_constants.dart';
import 'package:walletconnect_flutter_v2/apis/utils/walletconnect_utils.dart';

import '../shared/shared_test_utils.dart';
import '../shared/shared_test_values.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  group('Pairing store', () {
    late ICore coreA;
    late ICore coreB;

    late IPairing pairing;
    late IJsonRpcHistory history;
    late IPairingStore pairingStore;

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
        core: coreA,
        context: StoreVersions.CONTEXT_PAIRINGS,
        version: StoreVersions.VERSION_PAIRINGS,
        fromJson: (dynamic value) {
          return PairingInfo.fromJson(value as Map<String, dynamic>);
        },
      );
      history = JsonRpcHistory(
        core: coreA,
        context: StoreVersions.CONTEXT_JSON_RPC_HISTORY,
        version: StoreVersions.VERSION_JSON_RPC_HISTORY,
        fromJson: (dynamic value) => JsonRpcRecord.fromJson(value),
      );
      pairing = Pairing(
        core: coreA,
        pairings: pairingStore,
        history: history,
        topicToReceiverPublicKey: GenericStore(
          core: coreA,
          context: StoreVersions.CONTEXT_TOPIC_TO_RECEIVER_PUBLIC_KEY,
          version: StoreVersions.VERSION_TOPIC_TO_RECEIVER_PUBLIC_KEY,
          fromJson: (dynamic value) {
            return value as String;
          },
        ),
      );
    });

    tearDown(() async {
      await coreA.relayClient.disconnect();
      await coreB.relayClient.disconnect();
    });

    group('history', () {
      test('deletes old records', () async {
        await history.init();
        await history.set(
          '1',
          JsonRpcRecord(
            id: 1,
            topic: '1',
            method: 'eth_sign',
            params: '',
          ),
        );
        await history.set(
          '2',
          JsonRpcRecord(
            id: 2,
            topic: '1',
            method: 'eth_sign',
            params: '',
            expiry: 0,
          ),
        );

        expect(history.getAll().length, 2);
        await pairing.init();
        expect(history.getAll().length, 0);
      });

      test('emits events when records are updated', () async {
        Completer completer = Completer();
        history.onUpdate.subscribe((args) {
          completer.complete();
        });

        await pairing.init();

        await history.set(
          '3',
          JsonRpcRecord(
            id: 3,
            topic: '1',
            method: 'eth_sign',
            params: '',
            expiry: WalletConnectUtils.calculateExpiry(
              WalletConnectConstants.ONE_DAY,
            ),
          ),
        );

        await history.resolve(
          {'id': '3', 'result': 'test'},
        );

        await completer.future;

        expect(history.getAll().length, 1);
        expect(history.get('3')!.response, 'test');
      });
    });
  });
}

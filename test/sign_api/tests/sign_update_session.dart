import 'dart:async';

import 'package:flutter_test/flutter_test.dart';
import 'package:walletconnect_flutter_v2/apis/sign_api/i_sign_engine_app.dart';
import 'package:walletconnect_flutter_v2/apis/sign_api/i_sign_engine_common.dart';
import 'package:walletconnect_flutter_v2/apis/sign_api/i_sign_engine_wallet.dart';
import 'package:walletconnect_flutter_v2/walletconnect_flutter_v2.dart';

import '../../shared/shared_test_values.dart';
import '../utils/engine_constants.dart';
import '../utils/sign_client_constants.dart';
import 'sign_client_helpers.dart';

void signUpdateSession({
  required Future<ISignEngineApp> Function(PairingMetadata) clientACreator,
  required Future<ISignEngineWallet> Function(PairingMetadata) clientBCreator,
}) {
  group('updateSession', () {
    late ISignEngineApp clientA;
    late ISignEngineWallet clientB;
    List<ISignEngineCommon> clients = [];

    setUp(() async {
      clientA = await clientACreator(PROPOSER);
      clientB = await clientBCreator(RESPONDER);
      clients.add(clientA);
      clients.add(clientB);

      await clientB.sessions.set(
        TEST_SESSION_VALID_TOPIC,
        testSessionValid,
      );
      await clientB.sessions.set(
        TEST_SESSION_EXPIRED_TOPIC,
        testSessionExpired,
      );
      await clientB.core.expirer.set(
        TEST_SESSION_EXPIRED_TOPIC.toString(),
        testSessionExpired.expiry,
      );
    });

    tearDown(() async {
      clients.clear();
      await clientA.core.relayClient.disconnect();
      await clientB.core.relayClient.disconnect();
    });

    test('works', () async {
      final connectionInfo = await SignClientHelpers.testConnectPairApprove(
        clientA,
        clientB,
        requiredNamespaces: {
          EVM_NAMESPACE: TEST_ETH_ARB_REQUIRED_NAMESPACE,
        },
        accounts: {
          TEST_ETHEREUM_CHAIN: [TEST_ETHEREUM_ADDRESS],
          TEST_ARBITRUM_CHAIN: [TEST_ETHEREUM_ADDRESS],
        },
        methods: {
          TEST_ETHEREUM_CHAIN: TEST_METHODS_1,
          TEST_ARBITRUM_CHAIN: TEST_METHODS_1,
        },
        events: {
          TEST_ETHEREUM_CHAIN: [TEST_EVENT_1],
          TEST_ARBITRUM_CHAIN: [TEST_EVENT_1],
          TEST_AVALANCHE_CHAIN: [TEST_EVENT_2],
        },
      );

      int counter = 0;
      Completer completer = Completer();
      clientA.onSessionUpdate.subscribe((args) {
        counter++;
        completer.complete();
      });

      await clientB.updateSession(
        topic: connectionInfo.session.topic,
        namespaces: {EVM_NAMESPACE: TEST_ETH_ARB_NAMESPACE},
      );

      // await Future.delayed(Duration(milliseconds: 100));
      await completer.future;

      final resultA =
          clientA.sessions.get(connectionInfo.session.topic)!.namespaces;
      final resultB =
          clientB.sessions.get(connectionInfo.session.topic)!.namespaces;
      expect(resultA, equals({EVM_NAMESPACE: TEST_ETH_ARB_NAMESPACE}));
      expect(resultB, equals({EVM_NAMESPACE: TEST_ETH_ARB_NAMESPACE}));
      expect(counter, 1);

      clientA.onSessionUpdate.unsubscribeAll();
    });

    test('invalid session topic', () async {
      expect(
        () async => await clientB.updateSession(
          topic: TEST_SESSION_INVALID_TOPIC,
          namespaces: TEST_NAMESPACES,
        ),
        throwsA(
          isA<WalletConnectError>().having(
            (e) => e.message,
            'message',
            'No matching key. session topic doesn\'t exist: $TEST_SESSION_INVALID_TOPIC',
          ),
        ),
      );

      int counterExpire = 0;
      Completer completerExpire = Completer();
      clientB.core.expirer.onExpire.subscribe((args) {
        counterExpire++;
        completerExpire.complete();
      });
      int counterSession = 0;
      Completer completerSession = Completer();
      clientB.onSessionExpire.subscribe((args) {
        counterSession++;
        completerSession.complete();
      });
      expect(
        () async => await clientB.updateSession(
          topic: TEST_SESSION_EXPIRED_TOPIC,
          namespaces: TEST_NAMESPACES,
        ),
        throwsA(
          isA<WalletConnectError>().having(
            (e) => e.message,
            'message',
            'Expired. session topic: $TEST_SESSION_EXPIRED_TOPIC',
          ),
        ),
      );
      // await Future.delayed(Duration(milliseconds: 150));
      await completerExpire.future;
      await completerSession.future;

      expect(
        clientB.sessions.has(
          TEST_SESSION_EXPIRED_TOPIC,
        ),
        false,
      );
      expect(counterExpire, 1);
      expect(counterSession, 1);
      clientB.core.expirer.onExpire.unsubscribeAll();
      clientB.onSessionExpire.unsubscribeAll();
    });

    test('invalid namespaces', () async {
      expect(
        () async => await clientB.updateSession(
          topic: TEST_SESSION_VALID_TOPIC,
          namespaces: TEST_NAMESPACES_INVALID_ACCOUNTS,
        ),
        throwsA(
          isA<WalletConnectError>().having(
            (e) => e.message,
            'message',
            'Unsupported accounts. update() namespace, account swag should conform to "namespace:chainId:address" format',
          ),
        ),
      );
      expect(
        () async => await clientB.updateSession(
          topic: TEST_SESSION_VALID_TOPIC,
          namespaces: TEST_NAMESPACES_NONCONFORMING_CHAINS,
        ),
        throwsA(
          isA<WalletConnectError>().having(
            (e) => e.message,
            'message',
            'Unsupported chains. update() namespaces chains don\'t satisfy requiredNamespaces chains for eip155',
          ),
        ),
      );
    });
  });
}

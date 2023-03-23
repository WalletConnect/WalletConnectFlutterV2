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

void signDisconnect({
  required Future<ISignEngineApp> Function(PairingMetadata) clientACreator,
  required Future<ISignEngineWallet> Function(PairingMetadata) clientBCreator,
}) {
  group('disconnect', () {
    late ISignEngineApp clientA;
    late ISignEngineWallet clientB;
    List<ISignEngineCommon> clients = [];

    setUp(() async {
      clientA = await clientACreator(PROPOSER);
      clientB = await clientBCreator(RESPONDER);
      clients.add(clientA);
      clients.add(clientB);
    });

    tearDown(() async {
      clients.clear();
      await clientA.core.relayClient.disconnect();
      await clientB.core.relayClient.disconnect();
    });

    test("using pairing works", () async {
      TestConnectMethodReturn connectionInfo =
          await SignClientHelpers.testConnectPairApprove(
        clientA,
        clientB,
      );
      String pairingATopic = connectionInfo.pairing.topic;
      String sessionATopic = connectionInfo.session.topic;

      // Create another proposal that we will check is deleted on disconnect
      await clientA.connect(
        requiredNamespaces: TEST_REQUIRED_NAMESPACES,
        pairingTopic: pairingATopic,
      );
      expect(clientA.getPendingSessionProposals().length, 1);

      Completer completerA = Completer<void>();
      Completer completerB = Completer<void>();
      Completer completerSessionA = Completer<void>();
      Completer completerSessionB = Completer<void>();
      int counterA = 0;
      int counterB = 0;
      int counterSessionA = 0;
      int counterSessionB = 0;
      clientA.core.pairing.onPairingDelete.subscribe((PairingEvent? e) {
        expect(e != null, true);
        expect(e!.topic, pairingATopic);
        counterA++;
        completerA.complete();
      });
      clientB.core.pairing.onPairingDelete.subscribe((PairingEvent? e) {
        expect(e != null, true);
        expect(e!.topic, pairingATopic);
        counterB++;
        completerB.complete();
      });
      clientA.onSessionDelete.subscribe((SessionDelete? e) {
        expect(e != null, true);
        expect(e!.topic, sessionATopic);
        counterSessionA++;
        completerSessionA.complete();
      });
      clientB.onSessionDelete.subscribe((SessionDelete? e) {
        expect(e != null, true);
        expect(e!.topic, sessionATopic);
        counterSessionB++;
        completerSessionB.complete();
      });

      await clientA.disconnectSession(
        topic: pairingATopic,
        reason: Errors.getSdkError(
          Errors.USER_DISCONNECTED,
        ),
      );

      // await Future.delayed(Duration(milliseconds: 150));
      await completerA.future;
      await completerB.future;
      await completerSessionA.future;
      await completerSessionB.future;

      expect(clientA.pairings.get(pairingATopic), null);
      expect(clientB.pairings.get(pairingATopic), null);
      expect(clientA.sessions.get(sessionATopic), null);
      expect(clientB.sessions.get(sessionATopic), null);
      expect(clientA.getPendingSessionProposals().length, 0);

      expect(counterA, 1);
      expect(counterB, 1);
      expect(counterSessionA, 1);
      expect(counterSessionB, 1);

      completerA = Completer();
      completerB = Completer();
      completerSessionA = Completer();
      completerSessionB = Completer();

      connectionInfo = await SignClientHelpers.testConnectPairApprove(
        clientA,
        clientB,
      );
      pairingATopic = connectionInfo.pairing.topic;
      sessionATopic = connectionInfo.session.topic;

      await clientB.disconnectSession(
        topic: pairingATopic,
        reason: Errors.getSdkError(Errors.USER_DISCONNECTED),
      );

      // await Future.delayed(Duration(milliseconds: 150));
      await completerA.future;
      await completerB.future;
      await completerSessionA.future;
      await completerSessionB.future;

      expect(clientA.pairings.get(pairingATopic), null);
      expect(clientB.pairings.get(pairingATopic), null);
      expect(clientA.sessions.get(sessionATopic), null);
      expect(clientB.sessions.get(sessionATopic), null);

      expect(counterA, 2);
      expect(counterB, 2);
      expect(counterSessionA, 2);
      expect(counterSessionB, 2);

      clientA.core.pairing.onPairingDelete.unsubscribeAll();
      clientB.core.pairing.onPairingDelete.unsubscribeAll();
      clientA.onSessionDelete.unsubscribeAll();
      clientB.onSessionDelete.unsubscribeAll();
    });

    test("using session works", () async {
      TestConnectMethodReturn connectionInfo =
          await SignClientHelpers.testConnectPairApprove(
        clientA,
        clientB,
      );
      String sessionATopic = connectionInfo.session.topic;

      Completer completerA = Completer<void>();
      Completer completerB = Completer<void>();
      int counterA = 0;
      int counterB = 0;
      clientA.onSessionDelete.subscribe((SessionDelete? e) {
        expect(e != null, true);
        expect(e!.topic, sessionATopic);
        counterA++;
        completerA.complete();
      });
      clientB.onSessionDelete.subscribe((SessionDelete? e) {
        expect(e != null, true);
        expect(e!.topic, sessionATopic);
        counterB++;
        completerB.complete();
      });

      await clientA.disconnectSession(
        topic: sessionATopic,
        reason: Errors.getSdkError(Errors.USER_DISCONNECTED),
      );

      // await Future.delayed(Duration(milliseconds: 250));
      await completerA.future;
      await completerB.future;

      expect(clientA.sessions.get(sessionATopic), null);
      expect(clientB.sessions.get(sessionATopic), null);

      expect(counterA, 1);
      expect(counterB, 1);

      completerA = Completer();
      completerB = Completer();

      connectionInfo = await SignClientHelpers.testConnectPairApprove(
        clientA,
        clientB,
      );
      sessionATopic = connectionInfo.session.topic;

      await clientB.disconnectSession(
        topic: sessionATopic,
        reason: Errors.getSdkError(Errors.USER_DISCONNECTED),
      );

      await completerA.future;

      expect(clientA.pairings.get(sessionATopic), null);
      expect(clientB.pairings.get(sessionATopic), null);

      expect(counterA, 2);
      expect(counterB, 2);

      clientA.onSessionDelete.unsubscribeAll();
      clientB.onSessionDelete.unsubscribeAll();
    });

    for (var client in clients) {
      setUp(() async {
        await client.sessions.set(
          TEST_SESSION_VALID_TOPIC,
          testSessionValid,
        );
        await client.sessions.set(
          TEST_SESSION_EXPIRED_TOPIC,
          testSessionExpired,
        );
        await clientA.core.expirer.set(
          TEST_SESSION_EXPIRED_TOPIC,
          testSessionExpired.expiry,
        );
      });

      test('invalid topic', () async {
        final reason = Errors.getSdkError(Errors.USER_DISCONNECTED);
        expect(
          () async => await client.disconnectSession(
            topic: TEST_SESSION_INVALID_TOPIC,
            reason: WalletConnectError(
              code: reason.code,
              message: reason.message,
            ),
          ),
          throwsA(
            isA<WalletConnectError>().having(
              (e) => e.message,
              'message',
              'No matching key. session or pairing topic doesn\'t exist: $TEST_SESSION_INVALID_TOPIC',
            ),
          ),
        );

        int counter = 0;
        Completer completer = Completer<void>();
        client.core.expirer.onExpire.subscribe((e) {
          counter++;
          completer.complete();
        });
        int counterSession = 0;
        Completer completerSession = Completer();
        client.onSessionExpire.subscribe((args) {
          counterSession++;
          completerSession.complete();
        });
        expect(
          () async => await client.disconnectSession(
            topic: TEST_SESSION_EXPIRED_TOPIC,
            reason: WalletConnectError(
              code: reason.code,
              message: reason.message,
            ),
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
        await completer.future;
        await completerSession.future;

        expect(
          client.sessions.has(
            TEST_SESSION_EXPIRED_TOPIC,
          ),
          false,
        );
        expect(counter, 1);
        expect(counterSession, 1);
        client.core.expirer.onExpire.unsubscribeAll();
        client.onSessionExpire.unsubscribeAll();
      });
    }
  });
}

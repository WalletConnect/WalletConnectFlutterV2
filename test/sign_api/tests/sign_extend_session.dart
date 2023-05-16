import 'dart:async';

import 'package:flutter_test/flutter_test.dart';
import 'package:walletconnect_flutter_v2/apis/sign_api/i_sign_engine_app.dart';
import 'package:walletconnect_flutter_v2/apis/sign_api/i_sign_engine_common.dart';
import 'package:walletconnect_flutter_v2/apis/sign_api/i_sign_engine_wallet.dart';
import 'package:walletconnect_flutter_v2/walletconnect_flutter_v2.dart';

import '../../shared/shared_test_values.dart';
import '../utils/sign_client_constants.dart';
import 'sign_client_helpers.dart';

void signExtendSession({
  required Future<ISignEngineApp> Function(PairingMetadata) clientACreator,
  required Future<ISignEngineWallet> Function(PairingMetadata) clientBCreator,
}) {
  group('extendSession', () {
    late ISignEngineApp clientA;
    late ISignEngineWallet clientB;
    List<ISignEngineCommon> clients = [];

    setUp(() async {
      clientA = await clientACreator(PROPOSER);
      clientB = await clientBCreator(RESPONDER);
      clients.add(clientA);
      clients.add(clientB);

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
      );

      final startingExpiryA =
          clientA.sessions.get(connectionInfo.session.topic)!.expiry;
      final startingExpiryB =
          clientB.sessions.get(connectionInfo.session.topic)!.expiry;
      // TODO: Figure out why the expirer and session expiry are not the same
      // expect(
      //   clientA.core.expirer.get(connectionInfo.session.topic) ==
      //       startingExpiryA,
      //   true,
      // );
      // expect(
      //   clientB.core.expirer.get(connectionInfo.session.topic) ==
      //       startingExpiryB,
      //   true,
      // );

      int counter = 0;
      Completer completer = Completer();
      clientA.onSessionExtend.subscribe((args) {
        counter++;
        completer.complete();
      });

      const offset = 100;
      await Future.delayed(const Duration(milliseconds: offset));

      await clientB.extendSession(
        topic: connectionInfo.session.topic,
      );

      // await Future.delayed(Duration(milliseconds: 100));
      await completer.future;

      final endingExpiryA =
          clientA.sessions.get(connectionInfo.session.topic)!.expiry;
      final endingExpiryB =
          clientB.sessions.get(connectionInfo.session.topic)!.expiry;

      expect(
        endingExpiryA >= startingExpiryA,
        true,
      );
      expect(
        endingExpiryB >= startingExpiryB,
        true,
      );
      expect(
        clientA.core.expirer.get(connectionInfo.session.topic) == endingExpiryA,
        true,
      );
      expect(
        clientB.core.expirer.get(connectionInfo.session.topic) == endingExpiryB,
        true,
      );
      expect(counter, 1);

      clientA.onSessionExtend.unsubscribeAll();
    });
    test('invalid session topic', () async {
      expect(
        () async => await clientB.extendSession(
          topic: TEST_SESSION_INVALID_TOPIC,
        ),
        throwsA(
          isA<WalletConnectError>().having(
            (e) => e.message,
            'message',
            'No matching key. session topic doesn\'t exist: $TEST_SESSION_INVALID_TOPIC',
          ),
        ),
      );

      int counter = 0;
      Completer completer = Completer();
      clientB.core.expirer.onExpire.subscribe((args) {
        counter++;
        completer.complete();
      });
      int counterSession = 0;
      Completer completerSession = Completer();
      clientB.onSessionExpire.subscribe((args) {
        counterSession++;
        completerSession.complete();
      });
      expect(
        () async => await clientB.extendSession(
          topic: TEST_SESSION_EXPIRED_TOPIC,
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
        clientB.sessions.has(
          TEST_SESSION_EXPIRED_TOPIC,
        ),
        false,
      );
      expect(counter, 1);
      expect(counterSession, 1);
      clientB.core.expirer.onExpire.unsubscribeAll();
      clientB.onSessionExpire.unsubscribeAll();
    });
  });
}

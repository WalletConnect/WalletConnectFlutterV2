import 'dart:async';

import 'package:flutter_test/flutter_test.dart';
import 'package:walletconnect_flutter_v2/apis/sign_api/i_sign_engine_app.dart';
import 'package:walletconnect_flutter_v2/apis/sign_api/i_sign_engine_common.dart';
import 'package:walletconnect_flutter_v2/apis/sign_api/i_sign_engine_wallet.dart';
import 'package:walletconnect_flutter_v2/walletconnect_flutter_v2.dart';

import '../../shared/shared_test_values.dart';
import '../utils/sign_client_constants.dart';
import 'sign_client_helpers.dart';

void signPing({
  required Future<ISignEngineApp> Function(PairingMetadata) clientACreator,
  required Future<ISignEngineWallet> Function(PairingMetadata) clientBCreator,
}) {
  group('ping', () {
    late ISignEngineApp clientA;
    late ISignEngineWallet clientB;
    List<ISignEngineCommon> clients = [];

    setUp(() async {
      clientA = await clientACreator(PROPOSER);
      clientB = await clientBCreator(RESPONDER);
      clients.add(clientA);
      clients.add(clientB);

      await clientA.sessions.set(
        TEST_SESSION_VALID_TOPIC,
        testSessionValid,
      );
      await clientA.sessions.set(
        TEST_SESSION_EXPIRED_TOPIC,
        testSessionExpired,
      );
      await clientA.core.expirer.set(
        TEST_SESSION_EXPIRED_TOPIC,
        testSessionExpired.expiry,
      );
    });

    tearDown(() async {
      clients.clear();
      await clientA.core.relayClient.disconnect();
      await clientB.core.relayClient.disconnect();
    });

    test('works from pairing and session', () async {
      final connectionInfo = await SignClientHelpers.testConnectPairApprove(
        clientA,
        clientB,
      );
      final sessionTopic = connectionInfo.session.topic;
      final pairingTopic = connectionInfo.pairing.topic;

      Completer completerA = Completer<void>();
      Completer completerB = Completer<void>();
      int counterAP = 0;
      int counterBP = 0;
      clientB.onSessionPing.subscribe((SessionPing? ping) {
        expect(ping != null, true);
        expect(ping!.topic, sessionTopic);
        counterAP++;
        completerA.complete();
      });
      clientB.core.pairing.onPairingPing.subscribe((PairingEvent? pairing) {
        expect(pairing != null, true);
        expect(pairing!.topic, pairingTopic);
        counterBP++;
        completerB.complete();
      });

      await clientA.ping(topic: sessionTopic);
      await clientA.ping(topic: pairingTopic);

      await completerA.future;
      await completerB.future;

      expect(counterAP, 1);
      expect(counterBP, 1);

      clientA.onSessionPing.unsubscribeAll();
      clientA.core.pairing.onPairingPing.unsubscribeAll();
      clientB.core.pairing.onPairingPing.unsubscribeAll();
    });

    test('invalid topic', () async {
      expect(
        () async => await clientA.ping(
          topic: TEST_SESSION_INVALID_TOPIC,
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
      clientA.core.expirer.onExpire.subscribe((args) {
        counter++;
        completer.complete();
      });
      int counterSession = 0;
      Completer completerSession = Completer();
      clientA.onSessionExpire.subscribe((args) {
        counterSession++;
        completerSession.complete();
      });
      expect(
        () async => await clientA.ping(
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
        clientA.sessions.has(
          TEST_SESSION_EXPIRED_TOPIC,
        ),
        false,
      );
      expect(counter, 1);
      expect(counterSession, 1);
      clientA.core.expirer.onExpire.unsubscribeAll();
      clientA.onSessionExpire.unsubscribeAll();
    });
  });
}

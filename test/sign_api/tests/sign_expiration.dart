import 'dart:async';

import 'package:flutter_test/flutter_test.dart';
import 'package:walletconnect_flutter_v2/apis/sign_api/i_sign_engine_app.dart';
import 'package:walletconnect_flutter_v2/walletconnect_flutter_v2.dart';

import '../../shared/shared_test_values.dart';
import '../utils/engine_constants.dart';
import '../utils/sign_client_constants.dart';

void signExpiration({
  required Future<ISignEngineApp> Function(PairingMetadata) clientACreator,
}) {
  group('expiration', () {
    late ISignEngineApp clientA;

    setUp(() async {
      clientA = await clientACreator(PROPOSER);
    });

    tearDown(() async {
      await clientA.core.relayClient.disconnect();
    });

    test('deletes session', () async {
      int counter = 0;
      final completer = Completer.sync();
      clientA.onSessionExpire.subscribe((args) {
        counter++;
        completer.complete();
      });

      clientA.sessions.set(TEST_SESSION_TOPIC, testSessionExpired);
      clientA.core.expirer.set(
        TEST_SESSION_TOPIC.toString(),
        testSessionExpired.expiry,
      );

      clientA.core.expirer.expire(TEST_SESSION_TOPIC);

      // await Future.delayed(Duration(milliseconds: 150));
      await completer.future;

      expect(clientA.sessions.has(TEST_SESSION_TOPIC), false);
      expect(counter, 1);
    });

    test('deletes proposal', () async {
      await clientA.proposals.set(
        TEST_PROPOSAL_EXPIRED_ID.toString(),
        TEST_PROPOSAL_EXPIRED,
      );
      await clientA.core.expirer.set(
        TEST_PROPOSAL_EXPIRED_ID.toString(),
        TEST_PROPOSAL_EXPIRED.expiry,
      );

      await clientA.core.expirer.expire(
        TEST_PROPOSAL_EXPIRED_ID.toString(),
      );

      // await Future.delayed(Duration(milliseconds: 150));

      expect(
        clientA.proposals.has(
          TEST_PROPOSAL_EXPIRED_ID.toString(),
        ),
        false,
      );
    });
  });
}

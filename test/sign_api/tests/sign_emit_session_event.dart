import 'dart:async';

import 'package:flutter_test/flutter_test.dart';
import 'package:walletconnect_flutter_v2/apis/sign_api/i_sign_engine_app.dart';
import 'package:walletconnect_flutter_v2/apis/sign_api/i_sign_engine_common.dart';
import 'package:walletconnect_flutter_v2/apis/sign_api/i_sign_engine_wallet.dart';
import 'package:walletconnect_flutter_v2/walletconnect_flutter_v2.dart';

import '../../shared/shared_test_values.dart';
import '../utils/sign_client_constants.dart';
import 'sign_client_helpers.dart';

void signEmitSessionEvent({
  required Future<ISignEngineApp> Function(PairingMetadata) clientACreator,
  required Future<ISignEngineWallet> Function(PairingMetadata) clientBCreator,
}) {
  group('emitSessionEvent and handler', () {
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
        TEST_SESSION_EXPIRED_TOPIC,
        testSessionExpired.expiry,
      );
    });

    tearDown(() async {
      clients.clear();
      await clientA.core.relayClient.disconnect();
      await clientB.core.relayClient.disconnect();
    });

    test('register an event handler and recieve events with it', () async {
      final connectionInfo = await SignClientHelpers.testConnectPairApprove(
        clientA,
        clientB,
      );
      final sessionTopic = connectionInfo.session.topic;

      try {
        await clientB.emitSessionEvent(
          topic: connectionInfo.session.topic,
          chainId: TEST_ETHEREUM_CHAIN,
          event: const SessionEventParams(
            name: TEST_EVENT_1,
            data: TEST_MESSAGE_1,
          ),
        );
      } on JsonRpcError catch (e) {
        expect(
          e.toString(),
          JsonRpcError.methodNotFound(
            'No handler found for chainId:event -> $TEST_ETHEREUM_CHAIN:$TEST_EVENT_1',
          ).toString(),
        );
      }

      final completer = Completer<void>();
      clientA.onSessionEvent.subscribe((SessionEvent? session) {
        expect(session != null, true);
        expect(session!.topic, sessionTopic);
        expect(session.data, TEST_MESSAGE_1);
        completer.complete();
      });

      requestHandler(topic, request) async {
        expect(topic, sessionTopic);
        expect(request, TEST_MESSAGE_1);

        // Events return no responses
      }

      clientA.registerEventHandler(
        chainId: TEST_ETHEREUM_CHAIN,
        event: TEST_EVENT_1,
        handler: requestHandler,
      );

      try {
        await clientB.emitSessionEvent(
          topic: connectionInfo.session.topic,
          chainId: TEST_ETHEREUM_CHAIN,
          event: const SessionEventParams(
            name: TEST_EVENT_1,
            data: TEST_MESSAGE_1,
          ),
        );

        // Events receive no responses
      } on JsonRpcError catch (_) {
        // print(e);
        expect(false, true);
      }

      // Wait a second for the event to fire
      await completer.future;

      clientA.onSessionEvent.unsubscribeAll();
    });

    test('invalid session topic', () async {
      expect(
        () async => await clientB.emitSessionEvent(
          topic: TEST_SESSION_INVALID_TOPIC,
          chainId: TEST_ETHEREUM_CHAIN,
          event: const SessionEventParams(
            name: TEST_EVENT_1,
            data: TEST_MESSAGE_1,
          ),
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
      Completer completer = Completer<void>();
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
        () async => await clientB.emitSessionEvent(
          topic: TEST_SESSION_EXPIRED_TOPIC,
          chainId: TEST_ETHEREUM_CHAIN,
          event: const SessionEventParams(
            name: TEST_EVENT_1,
            data: TEST_MESSAGE_1,
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

    test('invalid chains or events', () async {
      expect(
        () async => await clientB.emitSessionEvent(
          topic: TEST_SESSION_VALID_TOPIC,
          chainId: TEST_UNINCLUDED_CHAIN,
          event: const SessionEventParams(
            name: TEST_EVENT_1,
            data: TEST_MESSAGE_1,
          ),
        ),
        throwsA(
          isA<WalletConnectError>().having(
            (e) => e.message,
            'message',
            'Unsupported chains. The chain $TEST_UNINCLUDED_CHAIN is not supported',
          ),
        ),
      );
      expect(
        () async => await clientB.emitSessionEvent(
          topic: TEST_SESSION_VALID_TOPIC,
          chainId: TEST_ETHEREUM_CHAIN,
          event: const SessionEventParams(
            name: TEST_EVENT_INVALID_1,
            data: TEST_MESSAGE_1,
          ),
        ),
        throwsA(
          isA<WalletConnectError>().having(
            (e) => e.message,
            'message',
            'Unsupported events. The event $TEST_EVENT_INVALID_1 is not supported',
          ),
        ),
      );
    });
  });
}

import 'dart:async';

import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:walletconnect_flutter_v2/apis/core/core.dart';
import 'package:walletconnect_flutter_v2/apis/core/i_core.dart';
import 'package:walletconnect_flutter_v2/apis/core/pairing/utils/pairing_models.dart';
import 'package:walletconnect_flutter_v2/apis/core/relay_client/relay_client.dart';
import 'package:walletconnect_flutter_v2/apis/core/relay_client/relay_client_models.dart';
import 'package:walletconnect_flutter_v2/apis/models/basic_models.dart';

import '../shared/shared_test_values.dart';
import 'shared/shared_test_utils.dart';
import 'shared/shared_test_utils.mocks.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  const TEST_TOPIC = 'abc123';
  const TEST_MESSAGE = 'swagmasterss';

  group('Relay throws errors', () {
    test('when connection parameters are invalid', () async {
      final ICore core = Core(
        projectId: 'abc',
        memoryStore: true,
      );

      expect(
        () async => await core.start(),
        throwsA(isA<WalletConnectError>()),
      );
    });
  });

  test('Relay client connect and disconnect events broadcast', () async {
    ICore coreA = Core(
      projectId: TEST_PROJECT_ID,
      memoryStore: true,
    );
    ICore coreB = Core(
      projectId: TEST_PROJECT_ID,
      memoryStore: true,
    );

    int counterA = 0, counterB = 0, counterC = 0, counterD = 0;
    Completer completerA = Completer(),
        completerB = Completer(),
        completerC = Completer(),
        completerD = Completer();
    coreA.relayClient.onRelayClientConnect.subscribe((args) {
      expect(args, null);
      counterA++;
      completerA.complete();
    });
    coreA.relayClient.onRelayClientDisconnect.subscribe((args) {
      expect(args, null);
      counterB++;
      completerB.complete();
    });
    coreB.relayClient.onRelayClientConnect.subscribe((args) {
      expect(args, null);
      counterC++;
      completerC.complete();
    });
    coreB.relayClient.onRelayClientDisconnect.subscribe((args) {
      expect(args, null);
      counterD++;
      completerD.complete();
    });

    await coreA.start();
    await coreB.start();

    await completerA.future;
    await completerC.future;

    expect(counterA, 1);
    expect(counterC, 1);

    await coreA.relayClient.disconnect();
    await coreB.relayClient.disconnect();

    await completerB.future;
    await completerD.future;

    expect(counterB, 1);
    expect(counterD, 1);
  });

  group('Relay Client', () {
    ICore core = Core(
      projectId: TEST_PROJECT_ID,
      memoryStore: true,
    );
    late RelayClient relayClient;
    MockMessageTracker messageTracker = MockMessageTracker();

    setUp(() async {
      await core.start();
      relayClient = RelayClient(
        core: core,
        messageTracker: messageTracker,
        topicMap: getTopicMap(core: core),
      );
      await relayClient.init();
    });

    // tearDown(() async {
    //   await relayClient.disconnect();
    // });

    test('Handle publish broadcasts and stores the message event', () async {
      await relayClient.topicMap.set(TEST_TOPIC, 'test');

      int counter = 0;
      relayClient.onRelayClientMessage.subscribe((MessageEvent? args) {
        counter++;
      });

      when(messageTracker.messageIsRecorded(
        TEST_TOPIC,
        TEST_MESSAGE,
      )).thenAnswer(
        (_) => false,
      );

      bool published = await relayClient.handlePublish(
        TEST_TOPIC,
        TEST_MESSAGE,
      );
      expect(published, true);
      expect(counter, 1);

      verify(
        messageTracker.recordMessageEvent(
          TEST_TOPIC,
          TEST_MESSAGE,
        ),
      ).called(1);
    });

    group('JSON RPC', () {
      late ICore coreA;
      late ICore coreB;

      setUp(() async {
        coreA = Core(
          relayUrl: TEST_RELAY_URL,
          projectId: TEST_PROJECT_ID,
          memoryStore: true,
        );
        coreB = Core(
          relayUrl: TEST_RELAY_URL,
          projectId: TEST_PROJECT_ID,
          memoryStore: true,
        );
        await coreA.start();
        await coreB.start();
        coreA.relayClient = RelayClient(
          core: coreA,
          messageTracker: getMessageTracker(core: coreA),
          topicMap: getTopicMap(core: coreA),
        );
        coreB.relayClient = RelayClient(
          core: coreB,
          messageTracker: getMessageTracker(core: coreB),
          topicMap: getTopicMap(core: coreB),
        );
        await coreA.relayClient.init();
        await coreB.relayClient.init();
      });

      tearDown(() async {
        await coreA.relayClient.disconnect();
        await coreB.relayClient.disconnect();
      });

      test('Publish is received by clients', () async {
        CreateResponse response = await coreA.pairing.create();
        await coreB.pairing.pair(uri: response.uri, activatePairing: true);
        coreA.pairing.activate(topic: response.topic);

        Completer completerA = Completer();
        Completer completerB = Completer();
        int counterA = 0;
        int counterB = 0;
        coreA.relayClient.onRelayClientMessage.subscribe((args) {
          expect(args == null, false);
          expect(args!.topic, response.topic);
          expect(args.message, 'Swag');
          counterA++;
          completerA.complete();
        });
        coreB.relayClient.onRelayClientMessage.subscribe((args) {
          expect(args == null, false);
          expect(args!.topic, response.topic);
          expect(args.message, TEST_MESSAGE);
          counterB++;
          completerB.complete();
        });

        // await coreA.relayClient.unsubscribe(response.topic);
        // await coreB.relayClient.unsubscribe(response.topic);

        await coreA.relayClient.publish(
          topic: response.topic,
          message: TEST_MESSAGE,
          ttl: 6000,
          tag: 0,
        );
        await coreB.relayClient.publish(
          topic: response.topic,
          message: 'Swag',
          ttl: 6000,
          tag: 0,
        );

        await completerA.future;
        await completerB.future;

        expect(counterA, 1);
        expect(counterB, 1);
      });
    });
  });
}

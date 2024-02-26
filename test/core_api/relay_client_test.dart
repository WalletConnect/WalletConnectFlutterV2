import 'dart:async';

import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart';
import 'package:mockito/mockito.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:walletconnect_flutter_v2/apis/core/relay_client/relay_client.dart';
import 'package:walletconnect_flutter_v2/walletconnect_flutter_v2.dart';

import '../shared/shared_test_values.dart';
import '../shared/shared_test_utils.dart';
import '../shared/shared_test_utils.mocks.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  PackageInfo.setMockInitialValues(
    appName: 'walletconnect_flutter_v2',
    packageName: 'com.walletconnect.flutterdapp',
    version: '1.0',
    buildNumber: '2',
    buildSignature: 'buildSignature',
  );

  const TEST_TOPIC = 'abc123';
  const TEST_MESSAGE = 'swagmasterss';

  test('relays are correct', () {
    expect(
      WalletConnectConstants.DEFAULT_RELAY_URL,
      'wss://relay.walletconnect.com',
    );
    expect(
      WalletConnectConstants.DEFAULT_PUSH_URL,
      'https://echo.walletconnect.com',
    );
  });

  group('Relay throws errors', () {
    test('on init if there is no internet connection', () async {
      final MockWebSocketHandler mockWebSocketHandler = MockWebSocketHandler();
      when(mockWebSocketHandler.connect()).thenThrow(const WalletConnectError(
        code: -1,
        message: 'No internet connection: test',
      ));

      const testRelayUrl = 'wss://relay.test.com';
      ICore core = Core(
        projectId: 'abc',
        memoryStore: true,
        relayUrl: testRelayUrl,
      );
      core.relayClient = RelayClient(
        core: core,
        messageTracker: getMessageTracker(core: core),
        topicMap: getTopicMap(core: core),
        socketHandler: mockWebSocketHandler,
      );
      int errorCounter = 0;
      core.relayClient.onRelayClientError.subscribe((args) {
        errorCounter++;
        expect(args!.error.message, 'No internet connection: test');
      });
      await core.storage.init();
      await core.crypto.init();
      await core.relayClient.init();

      verify(mockWebSocketHandler.setup(
        url: argThat(
          contains(testRelayUrl),
          named: 'url',
        ),
      )).called(1);
      verify(mockWebSocketHandler.connect()).called(1);
      expect(errorCounter, 1);
    });

    test('when connection parameters are invalid', () async {
      final http = MockHttpWrapper();
      when(http.get(any)).thenAnswer(
        (_) async => Response('', 3000),
      );
      final ICore core = Core(
        projectId: 'abc',
        memoryStore: true,
        httpClient: http,
      );

      Completer completer = Completer();
      core.relayClient.onRelayClientError.subscribe((args) {
        expect(args!.error, isA<WalletConnectError>());
        expect(args.error.code, 3000);
        completer.complete();
      });

      await core.start();

      await completer.future;

      core.relayClient.onRelayClientError.unsubscribeAll();
    });
  });

  test('Relay client connect and disconnect events broadcast', () async {
    ICore coreA = Core(
      projectId: TEST_PROJECT_ID,
      memoryStore: true,
      httpClient: getHttpWrapper(),
    );
    ICore coreB = Core(
      projectId: TEST_PROJECT_ID,
      memoryStore: true,
      httpClient: getHttpWrapper(),
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

    if (!completerA.isCompleted) {
      coreA.logger.i('relay client test waiting sessionACompleter');
      await completerA.future;
    }
    if (!completerC.isCompleted) {
      coreA.logger.i('relay client test waiting sessionCCompleter');
      await completerC.future;
    }

    expect(counterA, 1);
    expect(counterC, 1);

    await coreA.relayClient.disconnect();
    await coreB.relayClient.disconnect();

    if (!completerB.isCompleted) {
      coreA.logger.i('relay client test waiting sessionBCompleter');
      await completerB.future;
    }
    if (!completerD.isCompleted) {
      coreA.logger.i('relay client test waiting sessionDCompleter');
      await completerD.future;
    }

    expect(counterB, 1);
    expect(counterD, 1);
  });

  group('Relay Client', () {
    ICore core = Core(
      projectId: TEST_PROJECT_ID,
      memoryStore: true,
      httpClient: getHttpWrapper(),
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

        if (!completerA.isCompleted) {
          await completerA.future;
        }
        if (!completerB.isCompleted) {
          await completerB.future;
        }

        expect(counterA, 1);
        expect(counterB, 1);
      });
    });
  });
}

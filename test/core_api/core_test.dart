import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:walletconnect_flutter_v2/apis/core/relay_client/relay_client.dart';
import 'package:walletconnect_flutter_v2/walletconnect_flutter_v2.dart';

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

  group('Core throws errors', () {
    test('on start if there is no internet connection', () async {
      final MockWebSocketHandler mockWebSocketHandler = MockWebSocketHandler();
      when(mockWebSocketHandler.connect()).thenThrow(const WalletConnectError(
        code: -1,
        message: 'No internet connection: test',
      ));

      ICore core = Core(
        projectId: 'abc',
        memoryStore: true,
      );
      core.relayClient = RelayClient(
        core: core,
        messageTracker: getMessageTracker(core: core),
        topicMap: getTopicMap(core: core),
        socketHandler: mockWebSocketHandler,
      );
      int errorCount = 0;
      core.relayClient.onRelayClientError.subscribe((args) {
        errorCount++;
        expect(args!.error.message, 'No internet connection: test');
      });

      await core.start();
      expect(errorCount, 1);
      expect(core.relayUrl, WalletConnectConstants.DEFAULT_RELAY_URL);

      verifyInOrder([
        mockWebSocketHandler.setup(
          url: argThat(
            contains(
              WalletConnectConstants.DEFAULT_RELAY_URL,
            ),
            named: 'url',
          ),
        ),
        mockWebSocketHandler.connect(),
      ]);

      core.relayClient.onRelayClientError.unsubscribeAll();

      const testRelayUrl = 'wss://relay.test.com';
      core = Core(
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
      errorCount = 0;
      core.relayClient.onRelayClientError.subscribe((args) {
        errorCount++;
        expect(args!.error.message, 'No internet connection: test');
      });

      await core.start();

      // Check that setup was called once for custom URL
      verify(
        mockWebSocketHandler.setup(
          url: argThat(
            contains(testRelayUrl),
            named: 'url',
          ),
        ),
      ).called(1);
      verify(mockWebSocketHandler.connect()).called(1);
      expect(errorCount, 1);
      expect(core.relayUrl, testRelayUrl);
    });
  });
}

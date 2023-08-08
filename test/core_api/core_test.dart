import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:walletconnect_flutter_v2/apis/core/relay_client/relay_client.dart';
import 'package:walletconnect_flutter_v2/walletconnect_flutter_v2.dart';

import '../shared/shared_test_utils.dart';
import '../shared/shared_test_utils.mocks.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

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

      try {
        await core.start();
        expect(true, false);
      } on WalletConnectError catch (e) {
        expect(e.message, 'No internet connection: test');
      }

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
        mockWebSocketHandler.setup(
          url: argThat(
            contains(
              WalletConnectConstants.FALLBACK_RELAY_URL,
            ),
            named: 'url',
          ),
        ),
        mockWebSocketHandler.connect(),
      ]);

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

      try {
        await core.start();
        expect(true, false);
      } on WalletConnectError catch (e) {
        expect(e.message, 'No internet connection: test');
      }

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
    });
  });
}

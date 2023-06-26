import 'package:flutter_test/flutter_test.dart';
import 'package:logger/logger.dart';
import 'package:walletconnect_flutter_v2/walletconnect_flutter_v2.dart';

import '../shared/shared_test_utils.dart';
import '../shared/shared_test_values.dart';
import 'tests/sign_common.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  signEngineTests(
    context: 'Web3App/Wallet',
    clientACreator: (PairingMetadata metadata) async {
      final app = Web3App(
        core: Core(
          projectId: TEST_PROJECT_ID,
          relayUrl: TEST_RELAY_URL,
          memoryStore: true,
          logLevel: Level.info,
          httpClient: getHttpWrapper(),
        ),
        metadata: metadata,
      );
      await app.init();
      return app;
    },
    clientBCreator: (PairingMetadata metadata) async =>
        await Web3Wallet.createInstance(
      projectId: TEST_PROJECT_ID,
      relayUrl: TEST_RELAY_URL,
      metadata: metadata,
      memoryStore: true,
      logLevel: Level.info,
      httpClient: getHttpWrapper(),
    ),
  );
}

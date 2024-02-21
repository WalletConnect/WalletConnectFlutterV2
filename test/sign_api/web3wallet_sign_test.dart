import 'package:flutter_test/flutter_test.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:walletconnect_flutter_v2/walletconnect_flutter_v2.dart';

import '../shared/shared_test_utils.dart';
import '../shared/shared_test_values.dart';
import 'tests/sign_common.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  PackageInfo.setMockInitialValues(
    appName: 'walletconnect_flutter_v2',
    packageName: 'com.walletconnect.flutterdapp',
    version: '1.0',
    buildNumber: '2',
    buildSignature: 'buildSignature',
  );

  signEngineTests(
    context: 'Web3App/Wallet',
    clientACreator: (PairingMetadata metadata) async =>
        await Web3App.createInstance(
      projectId: TEST_PROJECT_ID,
      relayUrl: TEST_RELAY_URL,
      metadata: metadata,
      memoryStore: true,
      logLevel: LogLevel.info,
      httpClient: getHttpWrapper(),
    ),
    clientBCreator: (PairingMetadata metadata) async =>
        await Web3Wallet.createInstance(
      projectId: TEST_PROJECT_ID,
      relayUrl: TEST_RELAY_URL,
      metadata: metadata,
      memoryStore: true,
      logLevel: LogLevel.info,
      httpClient: getHttpWrapper(),
    ),
  );
}

import 'package:flutter_test/flutter_test.dart';
import 'package:walletconnect_flutter_v2/apis/core/store/generic_store.dart';
import 'package:walletconnect_flutter_v2/apis/sign_api/i_sign_engine_app.dart';
import 'package:walletconnect_flutter_v2/apis/sign_api/i_sign_engine_wallet.dart';
import 'package:walletconnect_flutter_v2/apis/sign_api/sign_engine.dart';
import 'package:walletconnect_flutter_v2/apis/sign_api/utils/sign_constants.dart';
import 'package:walletconnect_flutter_v2/walletconnect_flutter_v2.dart';

import '../shared/shared_test_values.dart';
import 'tests/sign_common.dart';
import 'utils/sign_client_test_wrapper.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  signEngineTests(
    context: 'Web3App/Wallet',
    clientACreator: (PairingMetadata metadata) async =>
        await Web3App.createInstance(
      projectId: TEST_PROJECT_ID,
      relayUrl: TEST_RELAY_URL,
      metadata: metadata,
      memoryStore: true,
    ),
    clientBCreator: (PairingMetadata metadata) async =>
        await Web3Wallet.createInstance(
      projectId: TEST_PROJECT_ID,
      relayUrl: TEST_RELAY_URL,
      metadata: metadata,
      memoryStore: true,
    ),
  );
}

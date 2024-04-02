import 'package:flutter_test/flutter_test.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:walletconnect_flutter_v2/apis/core/store/generic_store.dart';
import 'package:walletconnect_flutter_v2/apis/sign_api/sign_engine.dart';
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
    context: 'SignEngine',
    clientACreator: (PairingMetadata metadata) async {
      final core = Core(
        projectId: TEST_PROJECT_ID,
        relayUrl: TEST_RELAY_URL,
        memoryStore: true,
        logLevel: LogLevel.info,
        httpClient: getHttpWrapper(),
      );
      ISignEngine e = SignEngine(
        core: core,
        metadata: metadata,
        proposals: GenericStore(
          storage: core.storage,
          context: StoreVersions.CONTEXT_PROPOSALS,
          version: StoreVersions.VERSION_PROPOSALS,
          fromJson: (dynamic value) {
            return ProposalData.fromJson(value);
          },
        ),
        sessions: Sessions(
          storage: core.storage,
          context: StoreVersions.CONTEXT_SESSIONS,
          version: StoreVersions.VERSION_SESSIONS,
          fromJson: (dynamic value) {
            return SessionData.fromJson(value);
          },
        ),
        pendingRequests: GenericStore(
          storage: core.storage,
          context: StoreVersions.CONTEXT_PENDING_REQUESTS,
          version: StoreVersions.VERSION_PENDING_REQUESTS,
          fromJson: (dynamic value) {
            return SessionRequest.fromJson(value);
          },
        ),
      );
      await core.start();
      await e.init();

      return e;
    },
    clientBCreator: (PairingMetadata metadata) async {
      final core = Core(
        projectId: TEST_PROJECT_ID,
        relayUrl: TEST_RELAY_URL,
        memoryStore: true,
        logLevel: LogLevel.info,
        httpClient: getHttpWrapper(),
      );
      ISignEngine e = SignEngine(
        core: core,
        metadata: metadata,
        proposals: GenericStore(
          storage: core.storage,
          context: StoreVersions.CONTEXT_PROPOSALS,
          version: StoreVersions.VERSION_PROPOSALS,
          fromJson: (dynamic value) {
            return ProposalData.fromJson(value);
          },
        ),
        sessions: Sessions(
          storage: core.storage,
          context: StoreVersions.CONTEXT_SESSIONS,
          version: StoreVersions.VERSION_SESSIONS,
          fromJson: (dynamic value) {
            return SessionData.fromJson(value);
          },
        ),
        pendingRequests: GenericStore(
          storage: core.storage,
          context: StoreVersions.CONTEXT_PENDING_REQUESTS,
          version: StoreVersions.VERSION_PENDING_REQUESTS,
          fromJson: (dynamic value) {
            return SessionRequest.fromJson(value);
          },
        ),
      );
      await core.start();
      await e.init();

      return e;
    },
  );
}

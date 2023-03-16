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
    context: 'SignEngine',
    clientACreator: (PairingMetadata metadata) async {
      final core = Core(
        projectId: TEST_PROJECT_ID,
        relayUrl: TEST_RELAY_URL,
        memoryStore: true,
      );
      ISignEngine e = SignEngine(
        core: core,
        metadata: metadata,
        proposals: GenericStore(
          core: core,
          context: SignConstants.CONTEXT_PROPOSALS,
          version: SignConstants.VERSION_PROPOSALS,
          toJson: (ProposalData value) {
            return value.toJson();
          },
          fromJson: (dynamic value) {
            return ProposalData.fromJson(value);
          },
        ),
        sessions: Sessions(core),
        pendingRequests: GenericStore(
          core: core,
          context: SignConstants.CONTEXT_PENDING_REQUESTS,
          version: SignConstants.VERSION_PENDING_REQUESTS,
          toJson: (SessionRequest value) {
            return value.toJson();
          },
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
      );
      ISignEngine e = SignEngine(
        core: core,
        metadata: metadata,
        proposals: GenericStore(
          core: core,
          context: SignConstants.CONTEXT_PROPOSALS,
          version: SignConstants.VERSION_PROPOSALS,
          toJson: (ProposalData value) {
            return value.toJson();
          },
          fromJson: (dynamic value) {
            return ProposalData.fromJson(value);
          },
        ),
        sessions: Sessions(core),
        pendingRequests: GenericStore(
          core: core,
          context: SignConstants.CONTEXT_PENDING_REQUESTS,
          version: SignConstants.VERSION_PENDING_REQUESTS,
          toJson: (SessionRequest value) {
            return value.toJson();
          },
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

import 'dart:async';

import 'package:flutter_test/flutter_test.dart';
import 'package:walletconnect_flutter_v2/apis/sign_api/i_sign_engine_app.dart';
import 'package:walletconnect_flutter_v2/apis/sign_api/i_sign_engine_common.dart';
import 'package:walletconnect_flutter_v2/apis/sign_api/i_sign_engine_wallet.dart';
import 'package:walletconnect_flutter_v2/walletconnect_flutter_v2.dart';

import '../../shared/shared_test_values.dart';
import '../utils/engine_constants.dart';
import '../utils/sign_client_constants.dart';

void signApproveSession({
  required Future<ISignEngineApp> Function(PairingMetadata) clientACreator,
  required Future<ISignEngineWallet> Function(PairingMetadata) clientBCreator,
}) {
  group('approveSession', () {
    late ISignEngineApp clientA;
    late ISignEngineWallet clientB;
    List<ISignEngineCommon> clients = [];

    setUp(() async {
      clientA = await clientACreator(PROPOSER);
      clientB = await clientBCreator(RESPONDER);
      clients.add(clientA);
      clients.add(clientB);

      await clientB.proposals.set(
        TEST_PROPOSAL_VALID_ID.toString(),
        TEST_PROPOSAL_VALID,
      );
      await clientB.proposals.set(
        TEST_PROPOSAL_EXPIRED_ID.toString(),
        TEST_PROPOSAL_EXPIRED,
      );
      await clientB.core.expirer.set(
        TEST_PROPOSAL_EXPIRED_ID.toString(),
        TEST_PROPOSAL_EXPIRED.expiry,
      );
      await clientB.proposals.set(
        TEST_PROPOSAL_INVALID_REQUIRED_NAMESPACES_ID.toString(),
        TEST_PROPOSAL_INVALID_REQUIRED_NAMESPACES,
      );
      await clientB.proposals.set(
        TEST_PROPOSAL_INVALID_OPTIONAL_NAMESPACES_ID.toString(),
        TEST_PROPOSAL_INVALID_OPTIONAL_NAMESPACES,
      );
    });

    tearDown(() async {
      clients.clear();
      await clientA.core.relayClient.disconnect();
      await clientB.core.relayClient.disconnect();
    });

    test('invalid proposal id', () async {
      expect(
        () async => await clientB.approveSession(
          id: TEST_APPROVE_ID_INVALID,
          namespaces: TEST_NAMESPACES,
        ),
        throwsA(
          isA<WalletConnectError>().having(
            (e) => e.message,
            'message',
            'No matching key. proposal id doesn\'t exist: $TEST_APPROVE_ID_INVALID',
          ),
        ),
      );

      int counter = 0;
      Completer completer = Completer();
      clientB.core.expirer.onExpire.subscribe((args) {
        counter++;
        completer.complete();
      });
      int counterSession = 0;
      Completer completer2 = Completer();
      clientB.onProposalExpire.subscribe((args) {
        counterSession++;
        completer2.complete();
      });
      expect(
        () async => await clientB.approveSession(
          id: TEST_PROPOSAL_EXPIRED_ID,
          namespaces: TEST_NAMESPACES,
        ),
        throwsA(
          isA<WalletConnectError>().having(
            (e) => e.message,
            'message',
            'Expired. proposal id: $TEST_PROPOSAL_EXPIRED_ID',
          ),
        ),
      );

      // await Future.delayed(Duration(milliseconds: 250));
      await completer.future;
      await completer2.future;

      expect(
        clientB.proposals.has(
          TEST_PROPOSAL_EXPIRED_ID.toString(),
        ),
        false,
      );
      expect(counter, 1);
      expect(counterSession, 1);
      clientB.core.expirer.onExpire.unsubscribeAll();
      clientB.onProposalExpire.unsubscribeAll();
    });

    test('invalid namespaces', () async {
      expect(
        () async => await clientB.approveSession(
          id: TEST_PROPOSAL_INVALID_REQUIRED_NAMESPACES_ID,
          namespaces: TEST_NAMESPACES,
        ),
        throwsA(
          isA<WalletConnectError>().having(
            (e) => e.message,
            'message',
            'Unsupported chains. approve() check requiredNamespaces. requiredNamespace, namespace is a chainId, but chains is not empty',
          ),
        ),
      );
      expect(
        () async => await clientB.approveSession(
          id: TEST_PROPOSAL_INVALID_OPTIONAL_NAMESPACES_ID,
          namespaces: TEST_NAMESPACES,
        ),
        throwsA(
          isA<WalletConnectError>().having(
            (e) => e.message,
            'message',
            'Unsupported chains. approve() check optionalNamespaces. requiredNamespace, namespace is a chainId, but chains is not empty',
          ),
        ),
      );
      expect(
        () async => await clientB.approveSession(
          id: TEST_PROPOSAL_VALID_ID,
          namespaces: TEST_NAMESPACES_NONCONFORMING_KEY_1,
        ),
        throwsA(
          isA<WalletConnectError>().having(
            (e) => e.message,
            'message',
            'Unsupported namespace key. approve() namespaces keys don\'t satisfy requiredNamespaces',
          ),
        ),
      );
    });
  });
}

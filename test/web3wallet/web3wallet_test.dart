import 'package:flutter_test/flutter_test.dart';
import 'package:walletconnect_dart_v2/apis/sign_api/i_sign_engine_wallet.dart';
import 'package:walletconnect_dart_v2/walletconnect_dart_v2.dart';

import '../shared/shared_test_values.dart';
import '../shared/sign_client_helpers.dart';
import 'web3wallet_helpers.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  final List<Future<IWeb3App> Function(ICore, PairingMetadata)> appCreators = [
    (ICore core, PairingMetadata metadata) async =>
        await Web3App.createInstance(
          core: core,
          metadata: metadata,
        ),
  ];
  final List<Future<IWeb3Wallet> Function(ICore, PairingMetadata)>
      walletCreators = [
    (ICore core, PairingMetadata metadata) async =>
        await Web3Wallet.createInstance(
          core: core,
          metadata: metadata,
        ),
  ];

  final List<String> contexts = ['Web3Wallet'];

  for (int i = 0; i < walletCreators.length; i++) {
    runTests(
      context: contexts[i],
      web3appCreator: appCreators[i],
      web3walletCreator: walletCreators[i],
    );
  }
}

void runTests({
  required String context,
  required Future<IWeb3App> Function(ICore, PairingMetadata) web3appCreator,
  required Future<IWeb3Wallet> Function(ICore, PairingMetadata)
      web3walletCreator,
}) {
  group(context, () {
    late IWeb3App clientA;
    late IWeb3Wallet clientB;

    setUp(() async {
      clientA = await web3appCreator(
        Core(
          relayUrl: TEST_RELAY_URL,
          projectId: TEST_PROJECT_ID,
          memoryStore: true,
        ),
        PairingMetadata(
          name: 'App A (Proposer, dapp)',
          description: 'Description of Proposer App run by client A',
          url: 'https://walletconnect.com',
          icons: ['https://avatars.githubusercontent.com/u/37784886'],
        ),
      );
      clientB = await web3walletCreator(
        Core(
          relayUrl: TEST_RELAY_URL,
          projectId: TEST_PROJECT_ID,
          memoryStore: true,
        ),
        PairingMetadata(
          name: 'App B (Responder, Wallet)',
          description: 'Description of Proposer App run by client B',
          url: 'https://walletconnect.com',
          icons: ['https://avatars.githubusercontent.com/u/37784886'],
        ),
      );
    });

    tearDown(() async {
      await clientA.core.relayClient.disconnect();
      await clientB.core.relayClient.disconnect();
    });

    group('happy path', () {
      test('connects, reconnects, and emits proper events', () async {
        int counterA = 0;
        int counterBSign = 0;
        int counterBAuth = 0;
        clientA.onSessionConnect.subscribe((args) {
          counterA++;
        });
        clientB.onSessionProposal.subscribe((args) {
          counterBSign++;
        });
        clientB.onAuthRequest.subscribe((args) {
          counterBAuth++;
        });

        final connectionInfo = await Web3WalletHelpers.testWeb3Wallet(
          clientA,
          clientB,
        );

        await Future.delayed(Duration(milliseconds: 100));

        expect(counterA, 1);
        expect(counterBSign, 1);
        expect(counterBAuth, 1);

        expect(
          clientA.pairings.getAll().length,
          clientB.pairings.getAll().length,
        );
        expect(
          clientA.getActiveSessions().length,
          1,
        );
        expect(
          clientA.getActiveSessions().length,
          clientB.getActiveSessions().length,
        );
        final connectionInfo2 = await Web3WalletHelpers.testWeb3Wallet(
          clientA,
          clientB,
          pairingTopic: connectionInfo.pairing.topic,
        );

        await Future.delayed(Duration(milliseconds: 100));

        expect(counterA, 2);
        expect(counterBSign, 2);
        expect(counterBAuth, 2);

        clientA.onSessionConnect.unsubscribeAll();
        clientB.onSessionProposal.unsubscribeAll();
      });

      test('connects, and reconnects with scan latency', () async {
        final connectionInfo = await Web3WalletHelpers.testWeb3Wallet(
          clientA,
          clientB,
          qrCodeScanLatencyMs: 1000,
        );
        expect(
          clientA.pairings.getAll().length,
          clientB.pairings.getAll().length,
        );
        final connectionInfo2 = await Web3WalletHelpers.testWeb3Wallet(
          clientA,
          clientB,
          pairingTopic: connectionInfo.pairing.topic,
          qrCodeScanLatencyMs: 1000,
        );
      });
    });
  });
}

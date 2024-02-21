import 'dart:async';

import 'package:flutter_test/flutter_test.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:walletconnect_flutter_v2/walletconnect_flutter_v2.dart';

import '../shared/shared_test_utils.dart';
import '../shared/shared_test_values.dart';
import 'web3wallet_helpers.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  PackageInfo.setMockInitialValues(
    appName: 'walletconnect_flutter_v2',
    packageName: 'com.walletconnect.flutterdapp',
    version: '1.0',
    buildNumber: '2',
    buildSignature: 'buildSignature',
  );
  final List<Future<IWeb3App> Function(PairingMetadata)> appCreators = [
    (PairingMetadata metadata) async => await Web3App.createInstance(
          projectId: TEST_PROJECT_ID,
          relayUrl: TEST_RELAY_URL,
          memoryStore: true,
          metadata: metadata,
          logLevel: LogLevel.info,
          httpClient: getHttpWrapper(),
        ),
  ];
  final List<Future<IWeb3Wallet> Function(PairingMetadata)> walletCreators = [
    (PairingMetadata metadata) async => await Web3Wallet.createInstance(
          projectId: TEST_PROJECT_ID,
          relayUrl: TEST_RELAY_URL,
          memoryStore: true,
          metadata: metadata,
          logLevel: LogLevel.info,
          httpClient: getHttpWrapper(),
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
  required Future<IWeb3App> Function(PairingMetadata) web3appCreator,
  required Future<IWeb3Wallet> Function(PairingMetadata) web3walletCreator,
}) {
  group(context, () {
    late IWeb3App clientA;
    late IWeb3Wallet clientB;

    setUp(() async {
      clientA = await web3appCreator(
        const PairingMetadata(
          name: 'App A (Proposer, dapp)',
          description: 'Description of Proposer App run by client A',
          url: 'https://walletconnect.com',
          icons: ['https://avatars.githubusercontent.com/u/37784886'],
        ),
      );
      clientB = await web3walletCreator(
        const PairingMetadata(
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
        Completer completer = Completer();
        Completer completerBSign = Completer();
        Completer completerBAuth = Completer();
        int counterA = 0;
        int counterBSign = 0;
        int counterBAuth = 0;
        clientA.onSessionConnect.subscribe((args) {
          counterA++;
          completer.complete();
        });
        clientB.onSessionProposal.subscribe((args) {
          counterBSign++;
          completerBSign.complete();
        });
        clientB.onAuthRequest.subscribe((args) {
          counterBAuth++;
          completerBAuth.complete();
        });

        final connectionInfo = await Web3WalletHelpers.testWeb3Wallet(
          clientA,
          clientB,
          qrCodeScanLatencyMs: 1000,
        );

        // print('swag 1');
        await completer.future;
        // print('swag 2');
        await completerBSign.future;
        // print('swag 3');
        await completerBAuth.future;

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

        completer = Completer();
        completerBSign = Completer();
        completerBAuth = Completer();

        final _ = await Web3WalletHelpers.testWeb3Wallet(
          clientA,
          clientB,
          pairingTopic: connectionInfo.pairing.topic,
        );

        // print('swag 4');
        await completer.future;
        // print('swag 5');
        await completerBSign.future;
        // print('swag 6');
        await completerBAuth.future;

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
        final _ = await Web3WalletHelpers.testWeb3Wallet(
          clientA,
          clientB,
          pairingTopic: connectionInfo.pairing.topic,
          qrCodeScanLatencyMs: 1000,
        );
      });
    });
  });
}

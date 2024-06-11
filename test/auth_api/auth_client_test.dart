import 'dart:async';
import 'dart:typed_data';

import 'package:eth_sig_util/eth_sig_util.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:walletconnect_flutter_v2/apis/auth_api/auth_engine.dart';
import 'package:walletconnect_flutter_v2/apis/auth_api/i_auth_engine_app.dart';
import 'package:walletconnect_flutter_v2/apis/auth_api/i_auth_engine_wallet.dart';
import 'package:walletconnect_flutter_v2/apis/core/store/generic_store.dart';
import 'package:walletconnect_flutter_v2/walletconnect_flutter_v2.dart';

import '../shared/shared_test_utils.dart';
import '../shared/shared_test_values.dart';
import 'utils/auth_client_test_wrapper.dart';
import 'utils/engine_constants.dart';
import 'utils/signature_constants.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  PackageInfo.setMockInitialValues(
    appName: 'walletconnect_flutter_v2',
    packageName: 'com.walletconnect.flutterdapp',
    version: '1.0',
    buildNumber: '2',
    buildSignature: 'buildSignature',
  );

  final List<Future<IAuthEngineApp> Function(PairingMetadata)> authAppCreators =
      [
    (PairingMetadata metadata) async =>
        await AuthClientTestWrapper.createInstance(
          projectId: TEST_PROJECT_ID,
          relayUrl: TEST_RELAY_URL,
          metadata: metadata,
          memoryStore: true,
          logLevel: LogLevel.info,
          httpClient: getHttpWrapper(),
        ),
    (PairingMetadata? self) async {
      final core = Core(
        projectId: TEST_PROJECT_ID,
        relayUrl: TEST_RELAY_URL,
        memoryStore: true,
        logLevel: LogLevel.info,
        httpClient: getHttpWrapper(),
      );
      IAuthEngine e = AuthEngine(
        core: core,
        metadata: self ?? PairingMetadata.empty(),
        authKeys: GenericStore(
          storage: core.storage,
          context: StoreVersions.CONTEXT_AUTH_KEYS,
          version: StoreVersions.VERSION_AUTH_KEYS,
          fromJson: (dynamic value) {
            return AuthPublicKey.fromJson(value);
          },
        ),
        pairingTopics: GenericStore(
          storage: core.storage,
          context: StoreVersions.CONTEXT_PAIRING_TOPICS,
          version: StoreVersions.VERSION_PAIRING_TOPICS,
          fromJson: (dynamic value) {
            return value;
          },
        ),
        authRequests: GenericStore(
          storage: core.storage,
          context: StoreVersions.CONTEXT_AUTH_REQUESTS,
          version: StoreVersions.VERSION_AUTH_REQUESTS,
          fromJson: (dynamic value) {
            return PendingAuthRequest.fromJson(value);
          },
        ),
        completeRequests: GenericStore(
          storage: core.storage,
          context: StoreVersions.CONTEXT_COMPLETE_REQUESTS,
          version: StoreVersions.VERSION_COMPLETE_REQUESTS,
          fromJson: (dynamic value) {
            return StoredCacao.fromJson(value);
          },
        ),
      );
      await core.start();
      await e.init();

      return e;
    },
    (PairingMetadata metadata) async =>
        await AuthClientTestWrapper.createInstance(
          projectId: TEST_PROJECT_ID,
          relayUrl: TEST_RELAY_URL,
          metadata: metadata,
          memoryStore: true,
          logLevel: LogLevel.info,
          httpClient: getHttpWrapper(),
        ),
  ];

  final List<Future<IAuthEngineWallet> Function(PairingMetadata)>
      authWalletCreators = [
    (PairingMetadata metadata) async => await Web3Wallet.createInstance(
          projectId: TEST_PROJECT_ID,
          relayUrl: TEST_RELAY_URL,
          metadata: metadata,
          memoryStore: true,
          logLevel: LogLevel.info,
          httpClient: getHttpWrapper(),
        ),
    (PairingMetadata metadata) async {
      final core = Core(
        projectId: TEST_PROJECT_ID,
        relayUrl: TEST_RELAY_URL,
        memoryStore: true,
        logLevel: LogLevel.info,
        httpClient: getHttpWrapper(),
      );
      IAuthEngine e = AuthEngine(
        core: core,
        metadata: metadata,
        authKeys: GenericStore(
          storage: core.storage,
          context: StoreVersions.CONTEXT_AUTH_KEYS,
          version: StoreVersions.VERSION_AUTH_KEYS,
          fromJson: (dynamic value) {
            return AuthPublicKey.fromJson(value);
          },
        ),
        pairingTopics: GenericStore(
          storage: core.storage,
          context: StoreVersions.CONTEXT_PAIRING_TOPICS,
          version: StoreVersions.VERSION_PAIRING_TOPICS,
          fromJson: (dynamic value) {
            return value;
          },
        ),
        authRequests: GenericStore(
          storage: core.storage,
          context: StoreVersions.CONTEXT_AUTH_REQUESTS,
          version: StoreVersions.VERSION_AUTH_REQUESTS,
          fromJson: (dynamic value) {
            return PendingAuthRequest.fromJson(value);
          },
        ),
        completeRequests: GenericStore(
          storage: core.storage,
          context: StoreVersions.CONTEXT_COMPLETE_REQUESTS,
          version: StoreVersions.VERSION_COMPLETE_REQUESTS,
          fromJson: (dynamic value) {
            return StoredCacao.fromJson(value);
          },
        ),
      );
      await core.start();
      await e.init();

      return e;
    },
    (PairingMetadata metadata) async => await Web3Wallet.createInstance(
          projectId: TEST_PROJECT_ID,
          relayUrl: TEST_RELAY_URL,
          metadata: metadata,
          memoryStore: true,
          logLevel: LogLevel.info,
          httpClient: getHttpWrapper(),
        ),
  ];

  final List<String> contexts = ['AuthClient', 'AuthEngine', 'Web3App/Wallet'];

  for (int i = 0; i < authAppCreators.length; i++) {
    runTests(
      context: contexts[i],
      engineAppCreator: authAppCreators[i],
      engineWalletCreator: authWalletCreators[i],
    );
  }
}

void runTests({
  required String context,
  required Future<IAuthEngineApp> Function(PairingMetadata) engineAppCreator,
  required Future<IAuthEngineWallet> Function(PairingMetadata)
      engineWalletCreator,
}) {
  group(context, () {
    late IAuthEngineApp clientA;
    late IAuthEngineWallet clientB;

    setUp(() async {
      clientA = await engineAppCreator(
        TEST_METADATA_REQUESTER,
      );
      clientB = await engineWalletCreator(
        TEST_METADATA_RESPONDER,
      );
    });

    tearDown(() async {
      await clientA.core.relayClient.disconnect();
      await clientB.core.relayClient.disconnect();
    });

    group('happy path', () {
      test('Initializes', () async {
        expect(clientA.core.pairing.getPairings().length, 0);
        expect(clientB.core.pairing.getPairings().length, 0);
      });

      test(
          'connects and receives request, reconnects and receives another request, and emits proper events',
          () async {
        AuthRequestResponse response = await clientA.requestAuth(
          params: defaultRequestParams,
        );
        final String pairingTopic = response.pairingTopic;

        Completer completerAPairing = Completer();
        Completer completerBPairing = Completer();
        Completer completerA = Completer();
        Completer completerB = Completer();
        int counterAPairing = 0;
        int counterBPairing = 0;
        int counterA = 0;
        int counterB = 0;
        clientA.core.pairing.onPairingPing.subscribe((PairingEvent? pairing) {
          expect(pairing != null, true);
          expect(pairing!.topic, pairingTopic);
          counterAPairing++;
          completerAPairing.complete();
        });
        clientB.core.pairing.onPairingPing.subscribe((PairingEvent? pairing) {
          expect(pairing != null, true);
          expect(pairing!.topic, pairingTopic);
          counterBPairing++;
          completerBPairing.complete();
        });
        clientA.onAuthResponse.subscribe((AuthResponse? args) {
          counterA++;
          completerA.complete();

          expect(args!.result, isNotNull);
        });
        clientB.onAuthRequest.subscribe((AuthRequest? args) async {
          counterB++;

          int currReqCount = clientB.getPendingAuthRequests().length;

          expect(args != null, true);

          // Create the message to be signed
          String message = clientB.formatAuthMessage(
            iss: TEST_ISSUER_EIP191,
            cacaoPayload: CacaoRequestPayload.fromPayloadParams(
              args!.payloadParams,
            ),
          );

          String sig = EthSigUtil.signPersonalMessage(
            message: Uint8List.fromList(message.codeUnits),
            privateKey: TEST_PRIVATE_KEY_EIP191,
          );

          await clientB.respondAuthRequest(
            id: args.id,
            iss: TEST_ISSUER_EIP191,
            signature: CacaoSignature(t: CacaoSignature.EIP191, s: sig),
          );

          expect(clientB.getPendingAuthRequests().length, currReqCount - 1);

          completerB.complete();
        });

        expect(response.uri != null, true);

        await clientB.core.pairing.pair(uri: response.uri!);
        expect(clientA.core.pairing.getPairings().length, 1);
        expect(clientB.core.pairing.getPairings().length, 1);
        // AuthResponse authResponse = await response.completer.future;

        await clientA.core.pairing.ping(topic: pairingTopic);
        await clientB.core.pairing.ping(topic: pairingTopic);

        if (!completerAPairing.isCompleted) {
          clientA.core.logger.i('Waiting for completerAPairing');
          await completerAPairing.future;
        }
        if (!completerBPairing.isCompleted) {
          clientA.core.logger.i('Waiting for completerBPairing');
          await completerBPairing.future;
        }
        if (!completerA.isCompleted) {
          clientA.core.logger.i('Waiting for completerA');
          await completerA.future;
        }
        if (!completerB.isCompleted) {
          clientA.core.logger.i('Waiting for completerB');
          await completerB.future;
        }

        AuthResponse authResponse = await response.completer.future;
        expect(authResponse.result != null, true);

        expect(counterAPairing, 1);
        expect(counterBPairing, 1);

        expect(counterA, 1);
        expect(counterB, 1);

        expect(
          clientA
              .getCompletedRequestsForPairing(
                pairingTopic: pairingTopic,
              )
              .length,
          1,
        );
        expect(
          clientB
              .getCompletedRequestsForPairing(
                pairingTopic: pairingTopic,
              )
              .length,
          1,
        );

        completerA = Completer();
        completerB = Completer();

        response = await clientA.requestAuth(
          params: defaultRequestParams,
          pairingTopic: pairingTopic,
        );

        expect(response.uri == null, true);

        if (!completerA.isCompleted) {
          clientA.core.logger.i('Waiting for completerA');
          await completerA.future;
        }
        if (!completerB.isCompleted) {
          clientA.core.logger.i('Waiting for completerB');
          await completerB.future;
        }

        authResponse = await response.completer.future;
        expect(authResponse.result != null, true);

        // Got the second request and response
        expect(counterA, 2);
        expect(counterB, 2);

        expect(
          clientA
              .getCompletedRequestsForPairing(
                pairingTopic: pairingTopic,
              )
              .length,
          2,
        );
        expect(
          clientB
              .getCompletedRequestsForPairing(
                pairingTopic: pairingTopic,
              )
              .length,
          2,
        );

        clientA.onAuthResponse.unsubscribeAll();
        clientB.onAuthRequest.unsubscribeAll();
        clientA.core.pairing.onPairingPing.unsubscribeAll();
        clientB.core.pairing.onPairingPing.unsubscribeAll();
      });

      test('counts pendingAuthRequests properly', () async {
        AuthRequestResponse response = await clientA.requestAuth(
          params: defaultRequestParams,
        );
        final String pairingTopic = response.pairingTopic;

        await clientB.core.pairing.pair(uri: response.uri!);

        Completer completerA = Completer();
        clientB.onAuthRequest.subscribe((AuthRequest? args) async {
          // print('got here');
          // print(clientB.getPendingAuthRequests().length);
          completerA.complete();
        });

        if (!completerA.isCompleted) {
          clientA.core.logger.i('Waiting for completerA');
          await completerA.future;
        }

        expect(clientB.getPendingAuthRequests().length, 1);

        completerA = Completer();

        response = await clientA.requestAuth(
          params: defaultRequestParams,
          pairingTopic: pairingTopic,
        );

        if (!completerA.isCompleted) {
          clientA.core.logger.i('Waiting for completerA');
          await completerA.future;
        }

        expect(clientB.getPendingAuthRequests().length, 2);
      });
    });

    group('requestAuth', () {
      test('creates correct URI', () async {
        AuthRequestResponse response = await clientA.requestAuth(
          params: testAuthRequestParamsValid,
        );

        expect(response.uri != null, true);
        URIParseResult parsed = WalletConnectUtils.parseUri(response.uri!);
        expect(parsed.protocol, 'wc');
        expect(parsed.version, URIVersion.v2);
        expect(parsed.topic, response.pairingTopic);
        expect(parsed.v2Data!.relay.protocol, 'irn');
        if (clientA is IWeb3App) {
          expect(parsed.v2Data!.methods.length, 3);
          expect(parsed.v2Data!.methods[0], MethodConstants.WC_SESSION_PROPOSE);
          expect(parsed.v2Data!.methods[1], MethodConstants.WC_SESSION_REQUEST);
          expect(parsed.v2Data!.methods[2], MethodConstants.WC_AUTH_REQUEST);
        } else {
          expect(parsed.v2Data!.methods.length, 1);
          expect(parsed.v2Data!.methods[0], MethodConstants.WC_AUTH_REQUEST);
        }

        response = await clientA.requestAuth(
          params: testAuthRequestParamsValid,
          methods: [],
        );

        expect(response.uri != null, true);
        parsed = WalletConnectUtils.parseUri(response.uri!);
        expect(parsed.protocol, 'wc');
        expect(parsed.version, URIVersion.v2);
        expect(parsed.v2Data!.relay.protocol, 'irn');
        expect(parsed.v2Data!.methods.length, 0);
      });

      test('invalid request params', () async {
        expect(
          () => clientA.requestAuth(
            params: testAuthRequestParamsInvalidAud,
          ),
          throwsA(
            isA<WalletConnectError>().having(
              (e) => e.message,
              'message',
              'Missing or invalid. requestAuth() invalid aud: ${testAuthRequestParamsInvalidAud.aud}. Must be a valid url.',
            ),
          ),
        );
      });
    });

    group('respondAuth', () {
      test('invalid response params', () async {
        expect(
          () => clientB.respondAuthRequest(
            id: -1,
            iss: TEST_ISSUER_EIP191,
          ),
          throwsA(
            isA<WalletConnectError>().having(
              (e) => e.message,
              'message',
              'Missing or invalid. respondAuth() invalid id: -1. No pending request found.',
            ),
          ),
        );
      });
    });

    group('formatAuthMessage', () {
      test('works', () {
        final String message = clientA.formatAuthMessage(
          iss: TEST_ISSUER_EIP191,
          cacaoPayload: CacaoRequestPayload.fromCacaoPayload(testCacaoPayload),
        );
        expect(message, TEST_FORMATTED_MESSAGE);
      });
    });
  });
}

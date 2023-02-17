import 'dart:async';
import 'dart:convert';
import 'dart:typed_data';

import 'package:eth_sig_util/eth_sig_util.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:walletconnect_flutter_v2/apis/auth_api/auth_engine.dart';
import 'package:walletconnect_flutter_v2/apis/auth_api/i_auth_engine_app.dart';
import 'package:walletconnect_flutter_v2/apis/auth_api/i_auth_engine_wallet.dart';
import 'package:walletconnect_flutter_v2/apis/core/store/generic_store.dart';
import 'package:walletconnect_flutter_v2/apis/auth_api/utils/auth_constants.dart';
import 'package:walletconnect_flutter_v2/walletconnect_flutter_v2.dart';

import '../shared/shared_test_values.dart';
import 'utils/engine_constants.dart';
import 'utils/signature_constants.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  final List<Future<IAuthEngineApp> Function(ICore, PairingMetadata)>
      authAppCreators = [
    (ICore core, PairingMetadata metadata) async =>
        await AuthClient.createInstance(
          core: core,
          metadata: metadata,
        ),
    (ICore core, PairingMetadata? self) async {
      IAuthEngine e = AuthEngine(
        core: core,
        metadata: self ?? PairingMetadata.empty(),
        authKeys: GenericStore(
          core: core,
          context: AuthConstants.CONTEXT_AUTH_KEYS,
          version: AuthConstants.VERSION_AUTH_KEYS,
          toJsonString: (AuthPublicKey value) {
            return jsonEncode(value.toJson());
          },
          fromJsonString: (String value) {
            return AuthPublicKey.fromJson(jsonDecode(value));
          },
        ),
        pairingTopics: GenericStore(
          core: core,
          context: AuthConstants.CONTEXT_PAIRING_TOPICS,
          version: AuthConstants.VERSION_PAIRING_TOPICS,
          toJsonString: (String value) {
            return value;
          },
          fromJsonString: (String value) {
            return value;
          },
        ),
        authRequests: GenericStore(
          core: core,
          context: AuthConstants.CONTEXT_AUTH_REQUESTS,
          version: AuthConstants.VERSION_AUTH_REQUESTS,
          toJsonString: (PendingAuthRequest value) {
            return jsonEncode(value.toJson());
          },
          fromJsonString: (String value) {
            return PendingAuthRequest.fromJson(jsonDecode(value));
          },
        ),
        completeRequests: GenericStore(
          core: core,
          context: AuthConstants.CONTEXT_COMPLETE_REQUESTS,
          version: AuthConstants.VERSION_COMPLETE_REQUESTS,
          toJsonString: (StoredCacao value) {
            return jsonEncode(value.toJson());
          },
          fromJsonString: (String value) {
            return StoredCacao.fromJson(jsonDecode(value));
          },
        ),
      );
      await core.start();
      await e.init();

      return e;
    },
    (ICore core, PairingMetadata metadata) async =>
        await Web3App.createInstance(
          core: core,
          metadata: metadata,
        ),
  ];

  final List<Future<IAuthEngineWallet> Function(ICore, PairingMetadata)>
      authWalletCreators = [
    (ICore core, PairingMetadata metadata) async =>
        await Web3Wallet.createInstance(
          core: core,
          metadata: metadata,
        ),
    (ICore core, PairingMetadata metadata) async {
      IAuthEngine e = AuthEngine(
        core: core,
        metadata: metadata,
        authKeys: GenericStore(
          core: core,
          context: AuthConstants.CONTEXT_AUTH_KEYS,
          version: AuthConstants.VERSION_AUTH_KEYS,
          toJsonString: (AuthPublicKey value) {
            return jsonEncode(value.toJson());
          },
          fromJsonString: (String value) {
            return AuthPublicKey.fromJson(jsonDecode(value));
          },
        ),
        pairingTopics: GenericStore(
          core: core,
          context: AuthConstants.CONTEXT_PAIRING_TOPICS,
          version: AuthConstants.VERSION_PAIRING_TOPICS,
          toJsonString: (String value) {
            return value;
          },
          fromJsonString: (String value) {
            return value;
          },
        ),
        authRequests: GenericStore(
          core: core,
          context: AuthConstants.CONTEXT_AUTH_REQUESTS,
          version: AuthConstants.VERSION_AUTH_REQUESTS,
          toJsonString: (PendingAuthRequest value) {
            return jsonEncode(value.toJson());
          },
          fromJsonString: (String value) {
            return PendingAuthRequest.fromJson(jsonDecode(value));
          },
        ),
        completeRequests: GenericStore(
          core: core,
          context: AuthConstants.CONTEXT_COMPLETE_REQUESTS,
          version: AuthConstants.VERSION_COMPLETE_REQUESTS,
          toJsonString: (StoredCacao value) {
            return jsonEncode(value.toJson());
          },
          fromJsonString: (String value) {
            return StoredCacao.fromJson(jsonDecode(value));
          },
        ),
      );
      await core.start();
      await e.init();

      return e;
    },
    (ICore core, PairingMetadata metadata) async =>
        await Web3Wallet.createInstance(
          core: core,
          metadata: metadata,
        ),
  ];

  final List<String> contexts = ['SignClient', 'SignEngine', 'Web3App/Wallet'];

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
  required Future<IAuthEngineApp> Function(ICore, PairingMetadata)
      engineAppCreator,
  required Future<IAuthEngineWallet> Function(ICore, PairingMetadata)
      engineWalletCreator,
}) {
  group(context, () {
    late IAuthEngineApp clientA;
    late IAuthEngineWallet clientB;

    setUp(() async {
      clientA = await engineAppCreator(
        Core(
          relayUrl: TEST_RELAY_URL,
          projectId: TEST_PROJECT_ID,
          memoryStore: true,
        ),
        TEST_METADATA_REQUESTER,
      );
      clientB = await engineWalletCreator(
        Core(
          relayUrl: TEST_RELAY_URL,
          projectId: TEST_PROJECT_ID,
          memoryStore: true,
        ),
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

        // await Future.delayed(Duration(milliseconds: 100));
        await completerAPairing.future;
        await completerBPairing.future;
        await completerA.future;
        await completerB.future;

        AuthResponse authResponse = await response.completer.future;
        expect(authResponse.result != null, true);

        expect(counterAPairing, 1);
        expect(counterBPairing, 1);

        expect(counterA, 1);
        expect(counterB, 1);

        completerA = Completer();
        completerB = Completer();

        response = await clientA.requestAuth(
          params: defaultRequestParams,
          pairingTopic: pairingTopic,
        );

        expect(response.uri == null, true);

        // await Future.delayed(Duration(milliseconds: 100));
        await completerA.future;
        await completerB.future;

        authResponse = await response.completer.future;
        expect(authResponse.result != null, true);

        // Got the second request and response
        expect(counterA, 2);
        expect(counterB, 2);

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

        // await Future.delayed(Duration(milliseconds: 1000));
        await completerA.future;

        expect(clientB.getPendingAuthRequests().length, 1);

        completerA = Completer();

        response = await clientA.requestAuth(
          params: defaultRequestParams,
          pairingTopic: pairingTopic,
        );

        // await Future.delayed(Duration(milliseconds: 1000));
        await completerA.future;

        expect(clientB.getPendingAuthRequests().length, 2);
      });
    });

    group('requestAuth', () {
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
          cacaoPayload: testCacaoPayload,
        );
        expect(message, TEST_FORMATTED_MESSAGE);
      });
    });
  });
}

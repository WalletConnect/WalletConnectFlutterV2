import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:walletconnect_dart_v2/apis/core/store/generic_store.dart';
import 'package:walletconnect_dart_v2/apis/sign_api/i_sign_engine_wallet.dart';
import 'package:walletconnect_dart_v2/apis/sign_api/sign_engine.dart';
import 'package:walletconnect_dart_v2/apis/sign_api/utils/sign_constants.dart';
import 'package:walletconnect_dart_v2/walletconnect_dart_v2.dart';

import '../shared/shared_test_values.dart';
import 'utils/engine_constants.dart';
import 'utils/sign_client_constants.dart';
import '../shared/sign_client_helpers.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  final List<Future<ISignEngine> Function(ICore, PairingMetadata)>
      signApiCreators = [
    (ICore core, PairingMetadata metadata) async =>
        await SignClient.createInstance(
          core: core,
          metadata: metadata,
        ),
    (ICore core, PairingMetadata metadata) async {
      ISignEngine e = SignEngine(
        core: core,
        metadata: metadata,
        proposals: GenericStore(
          core: core,
          context: SignConstants.CONTEXT_PROPOSALS,
          version: SignConstants.VERSION_PROPOSALS,
          toJsonString: (ProposalData value) {
            return jsonEncode(value.toJson());
          },
          fromJsonString: (String value) {
            return ProposalData.fromJson(jsonDecode(value));
          },
        ),
        sessions: Sessions(core),
        pendingRequests: GenericStore(
          core: core,
          context: SignConstants.CONTEXT_PENDING_REQUESTS,
          version: SignConstants.VERSION_PENDING_REQUESTS,
          toJsonString: (SessionRequest value) {
            return jsonEncode(value.toJson());
          },
          fromJsonString: (String value) {
            return SessionRequest.fromJson(jsonDecode(value));
          },
        ),
      );
      await core.start();
      await e.init();

      return e;
    }
  ];

  final List<Future<ISignEngineWallet> Function(ICore, PairingMetadata)>
      signWalletCreators = [
    (ICore core, PairingMetadata metadata) async =>
        await SignClient.createInstance(
          core: core,
          metadata: metadata,
        ),
    (ICore core, PairingMetadata metadata) async =>
        await Web3Wallet.createInstance(
          core: core,
          metadata: metadata,
        ),
  ];

  final List<String> contexts = ['SignClient', 'SignEngine'];

  for (int i = 0; i < signApiCreators.length; i++) {
    signingEngineTests(
      context: contexts[i],
      clientACreator: signApiCreators[i],
      clientBCreator: signWalletCreators[i],
    );
  }

  group('expiration', () {
    test('deletes session', () async {
      final client = await SignClient.createInstance(
        core: Core(
          relayUrl: TEST_RELAY_URL,
          projectId: TEST_PROJECT_ID,
          memoryStore: true,
        ),
        metadata: PairingMetadata.empty(),
      );

      int counter = 0;
      client.onSessionExpire.subscribe((args) {
        counter++;
      });

      client.sessions.set(TEST_SESSION_TOPIC, testSessionExpired);
      client.core.expirer.set(
        TEST_SESSION_TOPIC.toString(),
        testSessionExpired.expiry,
      );

      client.core.expirer.expire(TEST_SESSION_TOPIC);

      await Future.delayed(Duration(milliseconds: 150));

      expect(client.sessions.has(TEST_SESSION_TOPIC), false);
      expect(counter, 1);
    });

    test('deletes proposal', () async {
      final client = await SignClient.createInstance(
        core: Core(
          relayUrl: TEST_RELAY_URL,
          projectId: TEST_PROJECT_ID,
          memoryStore: true,
        ),
        metadata: PairingMetadata.empty(),
      );
      client.proposals.set(
        TEST_PROPOSAL_EXPIRED_ID.toString(),
        TEST_PROPOSAL_EXPIRED,
      );
      client.core.expirer.set(
        TEST_PROPOSAL_EXPIRED_ID.toString(),
        TEST_PROPOSAL_EXPIRED.expiry,
      );

      client.core.expirer.expire(
        TEST_PROPOSAL_EXPIRED_ID.toString(),
      );

      await Future.delayed(Duration(milliseconds: 150));

      expect(
        client.proposals.has(
          TEST_PROPOSAL_EXPIRED_ID.toString(),
        ),
        false,
      );
    });
  });
}

void signingEngineTests({
  required String context,
  required Future<ISignEngine> Function(ICore, PairingMetadata) clientACreator,
  required Future<ISignEngineWallet> Function(ICore, PairingMetadata)
      clientBCreator,
}) {
  group(context, () {
    late ISignEngine clientA;
    late ISignEngineWallet clientB;
    List<ISignEngineWallet> clients = [];

    setUp(() async {
      clientA = await clientACreator(
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
      clientB = await clientBCreator(
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
      clients.add(clientA);
      clients.add(clientB);
    });

    tearDown(() async {
      clients.clear();
      await clientA.core.relayClient.disconnect();
      await clientB.core.relayClient.disconnect();
    });

    group('happy path', () {
      test('Initializes', () async {
        expect(clientA.core.pairing.getPairings().length, 0);
        expect(clientB.core.pairing.getPairings().length, 0);
      });

      test('connects, reconnects, and emits proper events', () async {
        int counterA = 0;
        int counterB = 0;
        clientA.onSessionConnect.subscribe((args) {
          counterA++;
        });
        clientB.onSessionProposal.subscribe((args) {
          counterB++;
        });

        final connectionInfo = await SignClientHelpers.testConnectPairApprove(
          clientA,
          clientB,
        );

        await Future.delayed(Duration(milliseconds: 100));

        expect(counterA, 1);
        expect(counterB, 1);

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
        final connectionInfo2 = await SignClientHelpers.testConnectPairApprove(
          clientA,
          clientB,
          pairingTopic: connectionInfo.pairing.topic,
        );

        await Future.delayed(Duration(milliseconds: 100));

        expect(counterA, 2);
        expect(counterB, 2);

        clientA.onSessionConnect.unsubscribeAll();
        clientB.onSessionProposal.unsubscribeAll();
      });

      test('connects, and reconnects with scan latency', () async {
        final connectionInfo = await SignClientHelpers.testConnectPairApprove(
          clientA,
          clientB,
          qrCodeScanLatencyMs: 1000,
        );
        expect(
          clientA.pairings.getAll().length,
          clientB.pairings.getAll().length,
        );
        final connectionInfo2 = await SignClientHelpers.testConnectPairApprove(
          clientA,
          clientB,
          pairingTopic: connectionInfo.pairing.topic,
          qrCodeScanLatencyMs: 1000,
        );
      });
    });

    group('connect', () {
      test('process emits proper events', () async {});

      test('invalid topic', () {
        expect(
          () async => await clientA.connect(
            requiredNamespaces: TEST_REQUIRED_NAMESPACES,
            pairingTopic: TEST_TOPIC_INVALID,
          ),
          throwsA(
            isA<WalletConnectError>().having(
              (e) => e.message,
              'message',
              'No matching key. pairing topic doesn\'t exist: abc',
            ),
          ),
        );
      });

      test('invalid required and optional namespaces', () {
        expect(
          () async => await clientA.connect(
            requiredNamespaces: TEST_REQUIRED_NAMESPACES_INVALID_CHAINS_1,
          ),
          throwsA(
            isA<WalletConnectError>().having(
              (e) => e.message,
              'message',
              'Unsupported chains. connect() check requiredNamespaces. requiredNamespace, namespace is a chainId, but chains is not empty',
            ),
          ),
        );
        expect(
          () async => await clientA.connect(
            requiredNamespaces: TEST_REQUIRED_NAMESPACES,
            optionalNamespaces: TEST_REQUIRED_NAMESPACES_INVALID_CHAINS_1,
          ),
          throwsA(
            isA<WalletConnectError>().having(
              (e) => e.message,
              'message',
              'Unsupported chains. connect() check optionalNamespaces. requiredNamespace, namespace is a chainId, but chains is not empty',
            ),
          ),
        );
      });
    });

    group('pair', () {
      test('throws with invalid methods', () {
        final String uriWithMethods = '$TEST_URI&methods=[wc_swag]';
        for (var client in clients) {
          expect(
            () async => await client.pair(uri: Uri.parse(uriWithMethods)),
            throwsA(
              isA<WalletConnectError>().having(
                (e) => e.message,
                'message',
                'Unsupported wc_ method. The following methods are not registered: wc_swag.',
              ),
            ),
          );
        }
      });
    });

    group('approveSession', () {
      for (var client in clients) {
        setUp(() async {
          await client.proposals.set(
            TEST_PROPOSAL_VALID_ID.toString(),
            TEST_PROPOSAL_VALID,
          );
          await client.proposals.set(
            TEST_PROPOSAL_EXPIRED_ID.toString(),
            TEST_PROPOSAL_EXPIRED,
          );
          await client.proposals.set(
            TEST_PROPOSAL_INVALID_REQUIRED_NAMESPACES_ID.toString(),
            TEST_PROPOSAL_INVALID_REQUIRED_NAMESPACES,
          );
          await client.proposals.set(
            TEST_PROPOSAL_INVALID_OPTIONAL_NAMESPACES_ID.toString(),
            TEST_PROPOSAL_INVALID_OPTIONAL_NAMESPACES,
          );
        });

        test('invalid proposal id', () async {
          expect(
            () async => await client.approveSession(
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
          client.core.expirer.onExpire.subscribe((args) {
            counter++;
          });
          expect(
            () async => await client.approveSession(
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

          await Future.delayed(Duration(milliseconds: 150));
          expect(
            client.proposals.has(
              TEST_PROPOSAL_EXPIRED_ID.toString(),
            ),
            false,
          );
          expect(counter, 1);
          client.core.expirer.onExpire.unsubscribeAll();
        });

        test('invalid namespaces', () async {
          for (var client in clients) {
            expect(
              () async => await client.approveSession(
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
              () async => await client.approveSession(
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
              () async => await client.approveSession(
                id: TEST_PROPOSAL_VALID_ID,
                namespaces: TEST_NAMESPACES_NONCONFORMING_KEY_1,
              ),
              throwsA(
                isA<WalletConnectError>().having(
                  (e) => e.message,
                  'message',
                  'Non conforming namespaces. approve() namespaces keys don\'t satisfy requiredNamespaces',
                ),
              ),
            );
          }
        });
      }
    });

    group('rejectSession', () {
      for (var client in clients) {
        setUp(() async {
          await client.proposals.set(
            TEST_PROPOSAL_VALID_ID.toString(),
            TEST_PROPOSAL_VALID,
          );
          await client.proposals.set(
            TEST_PROPOSAL_EXPIRED_ID.toString(),
            TEST_PROPOSAL_EXPIRED,
          );
          await client.proposals.set(
            TEST_PROPOSAL_INVALID_REQUIRED_NAMESPACES_ID.toString(),
            TEST_PROPOSAL_INVALID_REQUIRED_NAMESPACES,
          );
          await client.proposals.set(
            TEST_PROPOSAL_INVALID_OPTIONAL_NAMESPACES_ID.toString(),
            TEST_PROPOSAL_INVALID_OPTIONAL_NAMESPACES,
          );
        });

        test('deletes the proposal', () async {
          await client.proposals.set(
            TEST_PROPOSAL_VALID_ID.toString(),
            TEST_PROPOSAL_VALID,
          );

          await client.rejectSession(
            id: TEST_PROPOSAL_VALID_ID,
            reason: WalletConnectErrorResponse(code: -1, message: 'reason'),
          );

          expect(
            client.proposals.has(
              TEST_PROPOSAL_VALID_ID.toString(),
            ),
            false,
          );
        });

        test('invalid proposal id', () async {
          expect(
            () async => await client.rejectSession(
              id: TEST_APPROVE_ID_INVALID,
              reason: WalletConnectErrorResponse(code: -1, message: 'reason'),
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
          client.core.expirer.onExpire.subscribe((args) {
            counter++;
          });
          expect(
            () async => await client.rejectSession(
              id: TEST_PROPOSAL_EXPIRED_ID,
              reason: WalletConnectErrorResponse(code: -1, message: 'reason'),
            ),
            throwsA(
              isA<WalletConnectError>().having(
                (e) => e.message,
                'message',
                'Expired. proposal id: $TEST_PROPOSAL_EXPIRED_ID',
              ),
            ),
          );

          await Future.delayed(Duration(milliseconds: 150));
          expect(
            client.proposals.has(
              TEST_PROPOSAL_EXPIRED_ID.toString(),
            ),
            false,
          );
          expect(counter, 1);
          client.core.expirer.onExpire.unsubscribeAll();
        });
      }
    });

    group('updateSession', () {
      test('works', () async {
        final connectionInfo = await SignClientHelpers.testConnectPairApprove(
          clientA,
          clientB,
          requiredNamespaces: {
            EVM_NAMESPACE: TEST_ETH_ARB_REQUIRED_NAMESPACE,
          },
        );

        int counter = 0;
        clientA.onSessionUpdate.subscribe((args) {
          counter++;
        });

        await clientB.updateSession(
          topic: connectionInfo.session.topic,
          namespaces: {EVM_NAMESPACE: TEST_ETH_ARB_NAMESPACE},
        );

        await Future.delayed(Duration(milliseconds: 100));

        final resultA =
            clientA.sessions.get(connectionInfo.session.topic)!.namespaces;
        final resultB =
            clientB.sessions.get(connectionInfo.session.topic)!.namespaces;
        expect(resultA, equals({EVM_NAMESPACE: TEST_ETH_ARB_NAMESPACE}));
        expect(resultB, equals({EVM_NAMESPACE: TEST_ETH_ARB_NAMESPACE}));
        expect(counter, 1);

        clientA.onSessionUpdate.unsubscribeAll();
      });

      for (var client in clients) {
        setUp(() async {
          await client.sessions.set(
            TEST_SESSION_VALID_TOPIC,
            testSessionValid,
          );
          await client.sessions.set(
            TEST_SESSION_EXPIRED_TOPIC,
            testSessionExpired,
          );
        });

        test('invalid session topic', () async {
          expect(
            () async => await client.updateSession(
              topic: TEST_SESSION_INVALID_TOPIC,
              namespaces: TEST_NAMESPACES,
            ),
            throwsA(
              isA<WalletConnectError>().having(
                (e) => e.message,
                'message',
                'No matching key. session topic doesn\'t exist: $TEST_SESSION_INVALID_TOPIC',
              ),
            ),
          );

          int counter = 0;
          client.core.expirer.onExpire.subscribe((args) {
            counter++;
          });
          expect(
            () async => await client.updateSession(
              topic: TEST_SESSION_EXPIRED_TOPIC,
              namespaces: TEST_NAMESPACES,
            ),
            throwsA(
              isA<WalletConnectError>().having(
                (e) => e.message,
                'message',
                'Expired. session topic: $TEST_SESSION_EXPIRED_TOPIC',
              ),
            ),
          );
          await Future.delayed(Duration(milliseconds: 150));

          expect(
            client.sessions.has(
              TEST_SESSION_EXPIRED_TOPIC,
            ),
            false,
          );
          expect(counter, 1);
          client.core.expirer.onExpire.unsubscribeAll();
        });

        test('invalid namespaces', () async {
          expect(
            () async => await client.updateSession(
              topic: TEST_SESSION_VALID_TOPIC,
              namespaces: TEST_NAMESPACES_INVALID_ACCOUNTS,
            ),
            throwsA(
              isA<WalletConnectError>().having(
                (e) => e.message,
                'message',
                'Unsupported accounts. update() namespace, account swag should conform to "namespace:chainId:address" format',
              ),
            ),
          );
          expect(
            () async => await client.updateSession(
              topic: TEST_SESSION_VALID_TOPIC,
              namespaces: TEST_NAMESPACES_NONCONFORMING_CHAINS,
            ),
            throwsA(
              isA<WalletConnectError>().having(
                (e) => e.message,
                'message',
                'Non conforming namespaces. update() namespaces accounts don\'t satisfy requiredNamespaces chains for eip155',
              ),
            ),
          );
        });
      }
    });

    group('extendSession', () {
      test('works', () async {
        final connectionInfo = await SignClientHelpers.testConnectPairApprove(
          clientA,
          clientB,
        );

        final startingExpiryA =
            clientA.sessions.get(connectionInfo.session.topic)!.expiry;
        final startingExpiryB =
            clientB.sessions.get(connectionInfo.session.topic)!.expiry;
        // TODO: Figure out why the expirer and session expiry are not the same
        // expect(
        //   clientA.core.expirer.get(connectionInfo.session.topic) ==
        //       startingExpiryA,
        //   true,
        // );
        // expect(
        //   clientB.core.expirer.get(connectionInfo.session.topic) ==
        //       startingExpiryB,
        //   true,
        // );

        int counter = 0;
        clientA.onSessionExtend.subscribe((args) {
          counter++;
        });

        final offset = 100;
        await Future.delayed(Duration(milliseconds: offset));

        await clientB.extendSession(
          topic: connectionInfo.session.topic,
        );

        await Future.delayed(Duration(milliseconds: 100));

        final endingExpiryA =
            clientA.sessions.get(connectionInfo.session.topic)!.expiry;
        final endingExpiryB =
            clientB.sessions.get(connectionInfo.session.topic)!.expiry;

        expect(
          endingExpiryA >= startingExpiryA,
          true,
        );
        expect(
          endingExpiryB >= startingExpiryB,
          true,
        );
        expect(
          clientA.core.expirer.get(connectionInfo.session.topic) ==
              endingExpiryA,
          true,
        );
        expect(
          clientB.core.expirer.get(connectionInfo.session.topic) ==
              endingExpiryB,
          true,
        );
        expect(counter, 1);

        clientA.onSessionExtend.unsubscribeAll();
      });

      for (var client in clients) {
        setUp(() async {
          await client.sessions.set(
            TEST_SESSION_EXPIRED_TOPIC,
            testSessionExpired,
          );
        });

        test('invalid session topic', () async {
          expect(
            () async => await client.extendSession(
              topic: TEST_SESSION_INVALID_TOPIC,
            ),
            throwsA(
              isA<WalletConnectError>().having(
                (e) => e.message,
                'message',
                'No matching key. session topic doesn\'t exist: $TEST_SESSION_INVALID_TOPIC',
              ),
            ),
          );

          int counter = 0;
          client.core.expirer.onExpire.subscribe((args) {
            counter++;
          });
          expect(
            () async => await client.extendSession(
              topic: TEST_SESSION_EXPIRED_TOPIC,
            ),
            throwsA(
              isA<WalletConnectError>().having(
                (e) => e.message,
                'message',
                'Expired. session topic: $TEST_SESSION_EXPIRED_TOPIC',
              ),
            ),
          );

          await Future.delayed(Duration(milliseconds: 150));
          expect(
            client.sessions.has(
              TEST_SESSION_EXPIRED_TOPIC,
            ),
            false,
          );
          expect(counter, 1);
          client.core.expirer.onExpire.unsubscribeAll();
        });
      }
    });

    group('request and handler', () {
      test('register a request handler and recieve method calls with it',
          () async {
        final connectionInfo = await SignClientHelpers.testConnectPairApprove(
          clientA,
          clientB,
        );
        final sessionTopic = connectionInfo.session.topic;

        // No handler
        try {
          final response = await clientA.request(
            topic: connectionInfo.session.topic,
            chainId: TEST_ETHEREUM_CHAIN,
            request: SessionRequestParams(
              method: TEST_METHOD_1,
              params: TEST_MESSAGE_1,
            ),
          );
        } on JsonRpcError catch (e) {
          expect(
            e.toString(),
            JsonRpcError.methodNotFound(
              'No handler found for chainId:method -> $TEST_ETHEREUM_CHAIN:$TEST_METHOD_1',
            ).toString(),
          );
        }
        expect(clientB.getPendingSessionRequests().length, 1);

        // Valid handler
        final requestHandler = (topic, request) async {
          expect(topic, sessionTopic);
          expect(request, TEST_MESSAGE_1);

          expect(clientB.getPendingSessionRequests().length, 2);

          return request;
        };
        clientB.registerRequestHandler(
          chainId: TEST_ETHEREUM_CHAIN,
          method: TEST_METHOD_1,
          handler: requestHandler,
        );

        try {
          final response = await clientA.request(
            topic: connectionInfo.session.topic,
            chainId: TEST_ETHEREUM_CHAIN,
            request: SessionRequestParams(
              method: TEST_METHOD_1,
              params: TEST_MESSAGE_1,
            ),
          );

          expect(response, TEST_MESSAGE_1);
        } on JsonRpcError catch (e) {
          print(e);
          expect(false, true);
        }

        await Future.delayed(Duration(milliseconds: 150));
        expect(clientB.getPendingSessionRequests().length, 1);

        /// Event driven, null handler ///
        clientB.registerRequestHandler(
          chainId: TEST_ETHEREUM_CHAIN,
          method: TEST_METHOD_1,
        );
        clientB.onSessionRequest.subscribe((
          SessionRequestEvent? request,
        ) async {
          expect(request != null, true);
          expect(request!.topic, sessionTopic);
          expect(request.params, TEST_MESSAGE_1);

          expect(clientB.pendingRequests.has(request.id.toString()), true);
          expect(clientB.getPendingSessionRequests().length, 2);

          await clientB.respondSessionRequest(
            topic: request.topic,
            response: JsonRpcResponse<String>(
              id: request.id,
              result: TEST_MESSAGE_1,
            ),
          );

          expect(clientB.pendingRequests.has(request.id.toString()), false);
        });

        try {
          final response = await clientA.request(
            topic: connectionInfo.session.topic,
            chainId: TEST_ETHEREUM_CHAIN,
            request: SessionRequestParams(
              method: TEST_METHOD_1,
              params: TEST_MESSAGE_1,
            ),
          );

          expect(response, TEST_MESSAGE_1);
        } on JsonRpcError catch (e) {
          print(e);
          expect(false, true);
        }

        // Try an error
        clientB.onSessionRequest.unsubscribeAll();
        clientB.onSessionRequest.subscribe((
          SessionRequestEvent? session,
        ) async {
          expect(session != null, true);
          expect(session!.topic, sessionTopic);
          expect(session.params, TEST_MESSAGE_1);

          expect(clientB.pendingRequests.has(session.id.toString()), true);

          await clientB.respondSessionRequest(
            topic: session.topic,
            response: JsonRpcResponse<String>(
              id: session.id,
              error: JsonRpcError.invalidParams(TEST_MESSAGE_1),
            ),
          );

          expect(clientB.pendingRequests.has(session.id.toString()), false);
        });

        try {
          final response = await clientA.request(
            topic: connectionInfo.session.topic,
            chainId: TEST_ETHEREUM_CHAIN,
            request: SessionRequestParams(
              method: TEST_METHOD_1,
              params: TEST_MESSAGE_1,
            ),
          );
        } on JsonRpcError catch (e) {
          expect(e.message, TEST_MESSAGE_1);
        }

        clientB.onSessionRequest.unsubscribeAll();
      });

      setUp(() async {
        await clientA.sessions.set(
          TEST_SESSION_VALID_TOPIC,
          testSessionValid,
        );
        await clientA.sessions.set(
          TEST_SESSION_EXPIRED_TOPIC,
          testSessionExpired,
        );
        await clientA.core.expirer.set(
          TEST_SESSION_EXPIRED_TOPIC,
          -1,
        );
      });

      test('invalid session topic', () async {
        expect(
          () async => await clientA.request(
            topic: TEST_SESSION_INVALID_TOPIC,
            chainId: TEST_ETHEREUM_CHAIN,
            request: SessionRequestParams(
              method: TEST_METHOD_1,
              params: TEST_MESSAGE_1,
            ),
          ),
          throwsA(
            isA<WalletConnectError>().having(
              (e) => e.message,
              'message',
              'No matching key. session topic doesn\'t exist: $TEST_SESSION_INVALID_TOPIC',
            ),
          ),
        );

        int counter = 0;
        clientA.core.expirer.onExpire.subscribe((args) {
          counter++;
        });
        // print(
        //     'clientA.session exiry: ${clientA.sessions.get(TEST_SESSION_EXPIRED_TOPIC)!.expiry}');
        expect(
          () async => await clientA.request(
            topic: TEST_SESSION_EXPIRED_TOPIC,
            chainId: TEST_ETHEREUM_CHAIN,
            request: SessionRequestParams(
              method: TEST_METHOD_1,
              params: TEST_MESSAGE_1,
            ),
          ),
          throwsA(
            isA<WalletConnectError>().having(
              (e) => e.message,
              'message',
              'Expired. session topic: $TEST_SESSION_EXPIRED_TOPIC',
            ),
          ),
        );

        await Future.delayed(Duration(milliseconds: 150));
        expect(
          clientA.sessions.has(
            TEST_SESSION_EXPIRED_TOPIC,
          ),
          false,
        );
        expect(counter, 1);
        clientA.core.expirer.onExpire.unsubscribeAll();
      });

      test('invalid chains or methods', () async {
        expect(
          () async => await clientA.request(
            topic: TEST_SESSION_VALID_TOPIC,
            chainId: TEST_UNINCLUDED_CHAIN,
            request: SessionRequestParams(
              method: TEST_METHOD_1,
              params: TEST_MESSAGE_1,
            ),
          ),
          throwsA(
            isA<WalletConnectError>().having(
              (e) => e.message,
              'message',
              'Unsupported chains. The chain $TEST_UNINCLUDED_CHAIN is not supported',
            ),
          ),
        );
        expect(
          () async => await clientA.request(
            topic: TEST_SESSION_VALID_TOPIC,
            chainId: TEST_ETHEREUM_CHAIN,
            request: SessionRequestParams(
              method: TEST_METHOD_INVALID_1,
              params: TEST_MESSAGE_1,
            ),
          ),
          throwsA(
            isA<WalletConnectError>().having(
              (e) => e.message,
              'message',
              'Unsupported methods. The method $TEST_METHOD_INVALID_1 is not supported',
            ),
          ),
        );
      });
    });

    group('emitSessionEvent and handler', () {
      test('register an event handler and recieve events with it', () async {
        final connectionInfo = await SignClientHelpers.testConnectPairApprove(
          clientA,
          clientB,
        );
        final sessionTopic = connectionInfo.session.topic;

        try {
          await clientB.emitSessionEvent(
            topic: connectionInfo.session.topic,
            chainId: TEST_ETHEREUM_CHAIN,
            event: SessionEventParams(
              name: TEST_EVENT_1,
              data: TEST_MESSAGE_1,
            ),
          );
        } on JsonRpcError catch (e) {
          expect(
            e.toString(),
            JsonRpcError.methodNotFound(
              'No handler found for chainId:event -> $TEST_ETHEREUM_CHAIN:$TEST_EVENT_1',
            ).toString(),
          );
        }

        clientA.onSessionEvent.subscribe((SessionEvent? session) {
          expect(session != null, true);
          expect(session!.topic, sessionTopic);
          expect(session.data, TEST_MESSAGE_1);
        });

        final requestHandler = (topic, request) async {
          expect(topic, sessionTopic);
          expect(request, TEST_MESSAGE_1);

          // Events return no responses
        };
        clientA.registerEventHandler(
          chainId: TEST_ETHEREUM_CHAIN,
          event: TEST_EVENT_1,
          handler: requestHandler,
        );

        try {
          await clientB.emitSessionEvent(
            topic: connectionInfo.session.topic,
            chainId: TEST_ETHEREUM_CHAIN,
            event: SessionEventParams(
              name: TEST_EVENT_1,
              data: TEST_MESSAGE_1,
            ),
          );

          // Events receive no responses
        } on JsonRpcError catch (e) {
          print(e);
          expect(false, true);
        }

        // Wait a second for the event to fire
        await Future.delayed(const Duration(milliseconds: 100));

        clientA.onSessionEvent.unsubscribeAll();
      });

      for (var client in clients) {
        setUp(() async {
          await client.sessions.set(
            TEST_SESSION_VALID_TOPIC,
            testSessionValid,
          );
          await client.sessions.set(
            TEST_SESSION_EXPIRED_TOPIC,
            testSessionExpired,
          );
          await clientA.core.expirer.set(
            TEST_SESSION_EXPIRED_TOPIC,
            -1,
          );
        });

        test('invalid session topic', () async {
          expect(
            () async => await client.emitSessionEvent(
              topic: TEST_SESSION_INVALID_TOPIC,
              chainId: TEST_ETHEREUM_CHAIN,
              event: SessionEventParams(
                name: TEST_EVENT_1,
                data: TEST_MESSAGE_1,
              ),
            ),
            throwsA(
              isA<WalletConnectError>().having(
                (e) => e.message,
                'message',
                'No matching key. session topic doesn\'t exist: $TEST_SESSION_INVALID_TOPIC',
              ),
            ),
          );

          int counter = 0;
          client.core.expirer.onExpire.subscribe((args) {
            counter++;
          });
          expect(
            () async => await client.emitSessionEvent(
              topic: TEST_SESSION_EXPIRED_TOPIC,
              chainId: TEST_ETHEREUM_CHAIN,
              event: SessionEventParams(
                name: TEST_EVENT_1,
                data: TEST_MESSAGE_1,
              ),
            ),
            throwsA(
              isA<WalletConnectError>().having(
                (e) => e.message,
                'message',
                'Expired. session topic: $TEST_SESSION_EXPIRED_TOPIC',
              ),
            ),
          );
          await Future.delayed(Duration(milliseconds: 150));
          expect(
            client.sessions.has(
              TEST_SESSION_EXPIRED_TOPIC,
            ),
            false,
          );
          expect(counter, 1);
          client.core.expirer.onExpire.unsubscribeAll();
        });

        test('invalid chains or events', () async {
          expect(
            () async => await client.emitSessionEvent(
              topic: TEST_SESSION_VALID_TOPIC,
              chainId: TEST_UNINCLUDED_CHAIN,
              event: SessionEventParams(
                name: TEST_EVENT_1,
                data: TEST_MESSAGE_1,
              ),
            ),
            throwsA(
              isA<WalletConnectError>().having(
                (e) => e.message,
                'message',
                'Unsupported chains. The chain $TEST_UNINCLUDED_CHAIN is not supported',
              ),
            ),
          );
          expect(
            () async => await client.emitSessionEvent(
              topic: TEST_SESSION_VALID_TOPIC,
              chainId: TEST_ETHEREUM_CHAIN,
              event: SessionEventParams(
                name: TEST_EVENT_INVALID_1,
                data: TEST_MESSAGE_1,
              ),
            ),
            throwsA(
              isA<WalletConnectError>().having(
                (e) => e.message,
                'message',
                'Unsupported events. The event $TEST_EVENT_INVALID_1 is not supported',
              ),
            ),
          );
        });
      }
    });

    group('ping', () {
      test("works from pairing and session", () async {
        final connectionInfo = await SignClientHelpers.testConnectPairApprove(
          clientA,
          clientB,
        );
        final sessionTopic = connectionInfo.session.topic;
        final pairingTopic = connectionInfo.pairing.topic;

        int counterAP = 0;
        int counterBP = 0;
        clientA.core.pairing.onPairingPing.subscribe((PairingEvent? pairing) {
          expect(pairing != null, true);
          expect(pairing!.topic, pairingTopic);
          counterAP++;
        });
        clientB.core.pairing.onPairingPing.subscribe((PairingEvent? pairing) {
          expect(pairing != null, true);
          expect(pairing!.topic, pairingTopic);
          counterBP++;
        });

        await clientA.ping(topic: sessionTopic);
        await clientA.ping(topic: pairingTopic);

        await Future.delayed(Duration(milliseconds: 150));

        expect(counterAP, 1);
        expect(counterBP, 1);

        clientA.onSessionPing.unsubscribeAll();
        clientA.core.pairing.onPairingPing.unsubscribeAll();
        clientB.core.pairing.onPairingPing.unsubscribeAll();
      });

      setUp(() async {
        await clientA.sessions.set(
          TEST_SESSION_VALID_TOPIC,
          testSessionValid,
        );
        await clientA.sessions.set(
          TEST_SESSION_EXPIRED_TOPIC,
          testSessionExpired,
        );
        await clientA.core.expirer.set(
          TEST_SESSION_EXPIRED_TOPIC,
          -1,
        );
      });

      test('invalid topic', () async {
        expect(
          () async => await clientA.ping(
            topic: TEST_SESSION_INVALID_TOPIC,
          ),
          throwsA(
            isA<WalletConnectError>().having(
              (e) => e.message,
              'message',
              'No matching key. session or pairing topic doesn\'t exist: $TEST_SESSION_INVALID_TOPIC',
            ),
          ),
        );

        int counter = 0;
        clientA.core.expirer.onExpire.subscribe((args) {
          counter++;
        });
        expect(
          () async => await clientA.ping(
            topic: TEST_SESSION_EXPIRED_TOPIC,
          ),
          throwsA(
            isA<WalletConnectError>().having(
              (e) => e.message,
              'message',
              'Expired. session topic: $TEST_SESSION_EXPIRED_TOPIC',
            ),
          ),
        );
        await Future.delayed(Duration(milliseconds: 150));
        expect(
          clientA.sessions.has(
            TEST_SESSION_EXPIRED_TOPIC,
          ),
          false,
        );
        expect(counter, 1);
        clientA.core.expirer.onExpire.unsubscribeAll();
      });
    });

    group("disconnect", () {
      test("using pairing works", () async {
        TestConnectMethodReturn connectionInfo =
            await SignClientHelpers.testConnectPairApprove(
          clientA,
          clientB,
        );
        String pairingATopic = connectionInfo.pairing.topic;

        int counterA = 0;
        int counterB = 0;
        clientA.core.pairing.onPairingDelete.subscribe((PairingEvent? e) {
          expect(e != null, true);
          expect(e!.topic, pairingATopic);
          counterA++;
        });
        clientB.core.pairing.onPairingDelete.subscribe((PairingEvent? e) {
          expect(e != null, true);
          expect(e!.topic, pairingATopic);
          counterB++;
        });

        WalletConnectError reason =
            Errors.getSdkError(Errors.USER_DISCONNECTED);
        await clientA.disconnectSession(
          topic: pairingATopic,
          reason: WalletConnectErrorResponse(
            code: reason.code,
            message: reason.message,
          ),
        );

        await Future.delayed(Duration(milliseconds: 150));

        // TODO: See if this should delete the session as well
        expect(clientA.pairings.get(pairingATopic), null);
        expect(clientB.pairings.get(pairingATopic), null);

        expect(counterA, 1);
        expect(counterB, 1);

        connectionInfo = await SignClientHelpers.testConnectPairApprove(
          clientA,
          clientB,
        );
        pairingATopic = connectionInfo.pairing.topic;

        reason = Errors.getSdkError(Errors.USER_DISCONNECTED);
        await clientB.disconnectSession(
          topic: pairingATopic,
          reason: WalletConnectErrorResponse(
            code: reason.code,
            message: reason.message,
          ),
        );

        await Future.delayed(Duration(milliseconds: 150));

        // TODO: See if this should delete the session as well
        expect(clientA.pairings.get(pairingATopic), null);
        expect(clientB.pairings.get(pairingATopic), null);

        expect(counterA, 2);
        expect(counterB, 2);

        clientA.core.pairing.onPairingDelete.unsubscribeAll();
        clientB.core.pairing.onPairingDelete.unsubscribeAll();
      });

      test("using session works", () async {
        TestConnectMethodReturn connectionInfo =
            await SignClientHelpers.testConnectPairApprove(
          clientA,
          clientB,
        );
        String sessionATopic = connectionInfo.session.topic;

        int counterA = 0;
        int counterB = 0;
        clientA.onSessionDelete.subscribe((SessionDelete? e) {
          expect(e != null, true);
          expect(e!.topic, sessionATopic);
          counterA++;
        });
        clientB.onSessionDelete.subscribe((SessionDelete? e) {
          expect(e != null, true);
          expect(e!.topic, sessionATopic);
          counterB++;
        });

        WalletConnectError reason =
            Errors.getSdkError(Errors.USER_DISCONNECTED);
        await clientA.disconnectSession(
          topic: sessionATopic,
          reason: WalletConnectErrorResponse(
            code: reason.code,
            message: reason.message,
          ),
        );

        await Future.delayed(Duration(milliseconds: 250));

        expect(clientA.sessions.get(sessionATopic), null);
        expect(clientB.sessions.get(sessionATopic), null);

        expect(counterB, 1);

        connectionInfo = await SignClientHelpers.testConnectPairApprove(
          clientA,
          clientB,
        );
        sessionATopic = connectionInfo.session.topic;

        reason = Errors.getSdkError(Errors.USER_DISCONNECTED);
        await clientB.disconnectSession(
          topic: sessionATopic,
          reason: WalletConnectErrorResponse(
            code: reason.code,
            message: reason.message,
          ),
        );

        await Future.delayed(Duration(milliseconds: 150));

        // TODO: See if this should delete the session as well
        expect(clientA.pairings.get(sessionATopic), null);
        expect(clientB.pairings.get(sessionATopic), null);

        expect(counterA, 1);

        clientA.onSessionDelete.unsubscribeAll();
        clientB.onSessionDelete.unsubscribeAll();
      });

      for (var client in clients) {
        setUp(() async {
          await client.sessions.set(
            TEST_SESSION_VALID_TOPIC,
            testSessionValid,
          );
          await client.sessions.set(
            TEST_SESSION_EXPIRED_TOPIC,
            testSessionExpired,
          );
          await clientA.core.expirer.set(
            TEST_SESSION_EXPIRED_TOPIC,
            -1,
          );
        });

        test('invalid topic', () async {
          final reason = Errors.getSdkError(Errors.USER_DISCONNECTED);
          expect(
            () async => await client.disconnectSession(
              topic: TEST_SESSION_INVALID_TOPIC,
              reason: WalletConnectErrorResponse(
                code: reason.code,
                message: reason.message,
              ),
            ),
            throwsA(
              isA<WalletConnectError>().having(
                (e) => e.message,
                'message',
                'No matching key. session or pairing topic doesn\'t exist: $TEST_SESSION_INVALID_TOPIC',
              ),
            ),
          );

          int counter = 0;
          client.core.expirer.onExpire.subscribe((e) {
            counter++;
          });
          expect(
            () async => await client.disconnectSession(
              topic: TEST_SESSION_EXPIRED_TOPIC,
              reason: WalletConnectErrorResponse(
                code: reason.code,
                message: reason.message,
              ),
            ),
            throwsA(
              isA<WalletConnectError>().having(
                (e) => e.message,
                'message',
                'Expired. session topic: $TEST_SESSION_EXPIRED_TOPIC',
              ),
            ),
          );

          await Future.delayed(Duration(milliseconds: 150));
          expect(
            client.sessions.has(
              TEST_SESSION_EXPIRED_TOPIC,
            ),
            false,
          );
          expect(counter, 1);
          client.core.expirer.onExpire.unsubscribeAll();
        });
      }
    });

    group('find', () {
      test('works', () async {
        for (var client in clients) {
          await client.sessions.set(
            TEST_SESSION_VALID_TOPIC,
            testSessionValid,
          );

          final sessionData = client.find(
            requiredNamespaces: TEST_REQUIRED_NAMESPACES,
          );
          expect(sessionData != null, true);
          expect(sessionData!.topic, TEST_SESSION_VALID_TOPIC);

          final sessionData2 = client.find(
            requiredNamespaces: TEST_REQUIRED_NAMESPACES_INVALID_CHAINS_1,
          );
          expect(sessionData2, null);
        }
      });
    });

    group('pairings', () {
      test('works', () async {
        expect(clientA.pairings, clientA.core.pairing.getStore());
        expect(clientB.pairings, clientB.core.pairing.getStore());
      });
    });
  });
}

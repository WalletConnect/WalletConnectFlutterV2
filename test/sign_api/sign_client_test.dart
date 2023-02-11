import 'dart:math';

import 'package:flutter_test/flutter_test.dart';
import 'package:wallet_connect_flutter_v2/apis/core/i_core.dart';
import 'package:wallet_connect_flutter_v2/apis/models/json_rpc_error.dart';
import 'package:wallet_connect_flutter_v2/apis/signing_api/sign_engine.dart';
import 'package:wallet_connect_flutter_v2/apis/signing_api/i_sign_engine.dart';
import 'package:wallet_connect_flutter_v2/apis/signing_api/proposals.dart';
import 'package:wallet_connect_flutter_v2/apis/signing_api/sessions.dart';
import 'package:wallet_connect_flutter_v2/apis/utils/constants.dart';
import 'package:wallet_connect_flutter_v2/wallet_connect_flutter_v2.dart';

import '../shared/shared_test_values.dart';
import 'utils/engine_constants.dart';
import 'utils/sign_client_constants.dart';
import 'sign_client_helpers.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  final List<Future<ISignEngine> Function(ICore, PairingMetadata?)>
      signingApiCreators = [
    (ICore core, PairingMetadata? self) async =>
        await SignClient.createInstance(
          core,
          self: self,
        ),
    (ICore core, PairingMetadata? self) async {
      Proposals p = Proposals(core);
      Sessions s = Sessions(core);
      ISignEngine e = SignEngine(
        core,
        p,
        s,
        selfMetadata: self,
      );
      await core.start();
      await e.init();

      return e;
    }
  ];

  final List<String> contexts = ['SignClient', 'SignEngine'];

  for (int i = 0; i < signingApiCreators.length; i++) {
    signingEngineTests(
      context: contexts[i],
      engineCreator: signingApiCreators[i],
    );
  }

  group('expiration', () {
    test('deletes session', () async {
      final client = await SignClient.createInstance(
        Core(
          relayUrl: TEST_RELAY_URL,
          projectId: TEST_PROJECT_ID,
          memoryStore: true,
        ),
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
        Core(
          relayUrl: TEST_RELAY_URL,
          projectId: TEST_PROJECT_ID,
          memoryStore: true,
        ),
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
  required Function(ICore, PairingMetadata?) engineCreator,
}) {
  group(context, () {
    late ISignEngine clientA;
    late ISignEngine clientB;

    setUp(() async {
      clientA = await engineCreator(
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
      clientB = await engineCreator(
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
        final connectionInfo2 = await SignClientHelpers.testConnectPairApprove(
          clientA,
          clientB,
          pairingTopic: connectionInfo.pairing.topic,
        );

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
            isA<WCError>().having(
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
            isA<WCError>().having(
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
            isA<WCError>().having(
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
        final String uriWithMethods =
            '$TEST_URI&methods=[wc_sessionPropose],[wc_authRequest,wc_authBatchRequest]';
        expect(
          () async => await clientA.pair(uri: Uri.parse(uriWithMethods)),
          throwsA(
            isA<WCError>().having(
              (e) => e.message,
              'message',
              'Unsupported wc_ method. The following methods are not registered: wc_authRequest, wc_authBatchRequest.',
            ),
          ),
        );
      });
    });

    group('approve', () {
      setUp(() async {
        await clientA.proposals.set(
          TEST_PROPOSAL_VALID_ID.toString(),
          TEST_PROPOSAL_VALID,
        );
        await clientA.proposals.set(
          TEST_PROPOSAL_EXPIRED_ID.toString(),
          TEST_PROPOSAL_EXPIRED,
        );
        await clientA.proposals.set(
          TEST_PROPOSAL_INVALID_REQUIRED_NAMESPACES_ID.toString(),
          TEST_PROPOSAL_INVALID_REQUIRED_NAMESPACES,
        );
        await clientA.proposals.set(
          TEST_PROPOSAL_INVALID_OPTIONAL_NAMESPACES_ID.toString(),
          TEST_PROPOSAL_INVALID_OPTIONAL_NAMESPACES,
        );
      });

      test('invalid proposal id', () async {
        expect(
          () async => await clientA.approveSession(
            id: TEST_APPROVE_ID_INVALID,
            namespaces: TEST_NAMESPACES,
          ),
          throwsA(
            isA<WCError>().having(
              (e) => e.message,
              'message',
              'No matching key. proposal id doesn\'t exist: $TEST_APPROVE_ID_INVALID',
            ),
          ),
        );
        expect(
          () async => await clientA.approveSession(
            id: TEST_PROPOSAL_EXPIRED_ID,
            namespaces: TEST_NAMESPACES,
          ),
          throwsA(
            isA<WCError>().having(
              (e) => e.message,
              'message',
              'Expired. proposal id: $TEST_PROPOSAL_EXPIRED_ID',
            ),
          ),
        );
        expect(
          clientA.proposals.has(
            TEST_PROPOSAL_EXPIRED_ID.toString(),
          ),
          false,
        );
      });

      test('invalid namespaces', () async {
        expect(
          () async => await clientA.approveSession(
            id: TEST_PROPOSAL_INVALID_REQUIRED_NAMESPACES_ID,
            namespaces: TEST_NAMESPACES,
          ),
          throwsA(
            isA<WCError>().having(
              (e) => e.message,
              'message',
              'Unsupported chains. approve() check requiredNamespaces. requiredNamespace, namespace is a chainId, but chains is not empty',
            ),
          ),
        );
        expect(
          () async => await clientA.approveSession(
            id: TEST_PROPOSAL_INVALID_OPTIONAL_NAMESPACES_ID,
            namespaces: TEST_NAMESPACES,
          ),
          throwsA(
            isA<WCError>().having(
              (e) => e.message,
              'message',
              'Unsupported chains. approve() check optionalNamespaces. requiredNamespace, namespace is a chainId, but chains is not empty',
            ),
          ),
        );
        expect(
          () async => await clientA.approveSession(
            id: TEST_PROPOSAL_VALID_ID,
            namespaces: TEST_NAMESPACES_NONCONFORMING_KEY_1,
          ),
          throwsA(
            isA<WCError>().having(
              (e) => e.message,
              'message',
              'Non conforming namespaces. approve() namespaces keys don\'t satisfy requiredNamespaces',
            ),
          ),
        );
      });
    });

    group('reject', () {
      test('deletes the proposal', () async {
        await clientA.proposals.set(
          TEST_PROPOSAL_VALID_ID.toString(),
          TEST_PROPOSAL_VALID,
        );

        await clientA.reject(
          id: TEST_PROPOSAL_VALID_ID,
          reason: WCErrorResponse(code: -1, message: 'reason'),
        );

        expect(
          clientA.proposals.has(
            TEST_PROPOSAL_VALID_ID.toString(),
          ),
          false,
        );
      });

      test('invalid proposal id', () async {
        expect(
          () async => await clientA.reject(
            id: TEST_APPROVE_ID_INVALID,
            reason: WCErrorResponse(code: -1, message: 'reason'),
          ),
          throwsA(
            isA<WCError>().having(
              (e) => e.message,
              'message',
              'No matching key. proposal id doesn\'t exist: $TEST_APPROVE_ID_INVALID',
            ),
          ),
        );
      });
    });

    group('update', () {
      setUp(() async {
        await clientA.sessions.set(
          TEST_SESSION_VALID_TOPIC,
          testSessionValid,
        );
        await clientA.sessions.set(
          TEST_SESSION_EXPIRED_TOPIC,
          testSessionExpired,
        );
      });

      test('works', () async {
        final connectionInfo = await SignClientHelpers.testConnectPairApprove(
          clientA,
          clientB,
          requiredNamespaces: {
            EVM_NAMESPACE: TEST_ETH_ARB_REQUIRED_NAMESPACE,
          },
        );

        int counter = 0;
        clientB.onSessionUpdate.subscribe((args) {
          counter++;
        });

        await clientA.update(
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

      test('invalid session topic', () async {
        expect(
          () async => await clientA.update(
            topic: TEST_SESSION_INVALID_TOPIC,
            namespaces: TEST_NAMESPACES,
          ),
          throwsA(
            isA<WCError>().having(
              (e) => e.message,
              'message',
              'No matching key. session topic doesn\'t exist: $TEST_SESSION_INVALID_TOPIC',
            ),
          ),
        );
        expect(
          () async => await clientA.update(
            topic: TEST_SESSION_EXPIRED_TOPIC,
            namespaces: TEST_NAMESPACES,
          ),
          throwsA(
            isA<WCError>().having(
              (e) => e.message,
              'message',
              'Expired. session topic: $TEST_SESSION_EXPIRED_TOPIC',
            ),
          ),
        );
        await Future.delayed(Duration(milliseconds: 100));

        expect(
          clientA.sessions.has(
            TEST_SESSION_EXPIRED_TOPIC,
          ),
          false,
        );
      });

      test('invalid namespaces', () async {
        expect(
          () async => await clientA.update(
            topic: TEST_SESSION_VALID_TOPIC,
            namespaces: TEST_NAMESPACES_INVALID_ACCOUNTS,
          ),
          throwsA(
            isA<WCError>().having(
              (e) => e.message,
              'message',
              'Unsupported accounts. update() namespace, account swag should conform to "namespace:chainId:address" format',
            ),
          ),
        );
        expect(
          () async => await clientA.update(
            topic: TEST_SESSION_VALID_TOPIC,
            namespaces: TEST_NAMESPACES_NONCONFORMING_CHAINS,
          ),
          throwsA(
            isA<WCError>().having(
              (e) => e.message,
              'message',
              'Non conforming namespaces. update() namespaces accounts don\'t satisfy requiredNamespaces chains for eip155',
            ),
          ),
        );
      });
    });

    group('extend', () {
      setUp(() async {
        await clientA.sessions.set(
          TEST_SESSION_EXPIRED_TOPIC,
          testSessionExpired,
        );
      });

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

        await clientB.extend(
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

      test('invalid session topic', () async {
        expect(
          () async => await clientA.extend(
            topic: TEST_SESSION_INVALID_TOPIC,
          ),
          throwsA(
            isA<WCError>().having(
              (e) => e.message,
              'message',
              'No matching key. session topic doesn\'t exist: $TEST_SESSION_INVALID_TOPIC',
            ),
          ),
        );
        expect(
          () async => await clientA.extend(
            topic: TEST_SESSION_EXPIRED_TOPIC,
          ),
          throwsA(
            isA<WCError>().having(
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
      });
    });

    group('request and handler', () {
      setUp(() async {
        await clientA.sessions.set(
          TEST_SESSION_VALID_TOPIC,
          testSessionValid,
        );
        await clientA.sessions.set(
          TEST_SESSION_EXPIRED_TOPIC,
          testSessionExpired,
        );
      });

      test('register a request handler and recieve method calls with it',
          () async {
        final connectionInfo = await SignClientHelpers.testConnectPairApprove(
          clientA,
          clientB,
        );
        final sessionTopic = connectionInfo.session.topic;

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
          // expect(e.code, -32601);
          // expect(e.message, 'Method not found');
        }

        clientB.onSessionRequest.subscribe((SessionRequest? session) {
          expect(session != null, true);
          expect(session!.topic, sessionTopic);
          expect(session.params, TEST_MESSAGE_1);
        });

        final requestHandler = (topic, request) async {
          expect(topic, sessionTopic);
          expect(request, TEST_MESSAGE_1);

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

        // Wait a second for the event to fire
        await Future.delayed(const Duration(milliseconds: 100));

        clientB.onSessionEvent.unsubscribeAll();
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
            isA<WCError>().having(
              (e) => e.message,
              'message',
              'No matching key. session topic doesn\'t exist: $TEST_SESSION_INVALID_TOPIC',
            ),
          ),
        );
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
            isA<WCError>().having(
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
            isA<WCError>().having(
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
            isA<WCError>().having(
              (e) => e.message,
              'message',
              'Unsupported methods. The method $TEST_METHOD_INVALID_1 is not supported',
            ),
          ),
        );
      });
    });

    group('emit and handler', () {
      setUp(() async {
        await clientA.sessions.set(
          TEST_SESSION_VALID_TOPIC,
          testSessionValid,
        );
        await clientA.sessions.set(
          TEST_SESSION_EXPIRED_TOPIC,
          testSessionExpired,
        );
      });

      test('register an event handler and recieve events with it', () async {
        final connectionInfo = await SignClientHelpers.testConnectPairApprove(
          clientA,
          clientB,
        );
        final sessionTopic = connectionInfo.session.topic;

        try {
          await clientA.emit(
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

        clientB.onSessionEvent.subscribe((SessionEvent? session) {
          expect(session != null, true);
          expect(session!.topic, sessionTopic);
          expect(session.data, TEST_MESSAGE_1);
        });

        final requestHandler = (topic, request) async {
          expect(topic, sessionTopic);
          expect(request, TEST_MESSAGE_1);

          // Events return no responses
        };
        clientB.registerEventHandler(
          chainId: TEST_ETHEREUM_CHAIN,
          event: TEST_EVENT_1,
          handler: requestHandler,
        );

        try {
          await clientA.emit(
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

        clientB.onSessionEvent.unsubscribeAll();
      });

      test('invalid session topic', () async {
        expect(
          () async => await clientA.emit(
            topic: TEST_SESSION_INVALID_TOPIC,
            chainId: TEST_ETHEREUM_CHAIN,
            event: SessionEventParams(
              name: TEST_EVENT_1,
              data: TEST_MESSAGE_1,
            ),
          ),
          throwsA(
            isA<WCError>().having(
              (e) => e.message,
              'message',
              'No matching key. session topic doesn\'t exist: $TEST_SESSION_INVALID_TOPIC',
            ),
          ),
        );
        expect(
          () async => await clientA.emit(
            topic: TEST_SESSION_EXPIRED_TOPIC,
            chainId: TEST_ETHEREUM_CHAIN,
            event: SessionEventParams(
              name: TEST_EVENT_1,
              data: TEST_MESSAGE_1,
            ),
          ),
          throwsA(
            isA<WCError>().having(
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
      });

      test('invalid chains or events', () async {
        expect(
          () async => await clientA.emit(
            topic: TEST_SESSION_VALID_TOPIC,
            chainId: TEST_UNINCLUDED_CHAIN,
            event: SessionEventParams(
              name: TEST_EVENT_1,
              data: TEST_MESSAGE_1,
            ),
          ),
          throwsA(
            isA<WCError>().having(
              (e) => e.message,
              'message',
              'Unsupported chains. The chain $TEST_UNINCLUDED_CHAIN is not supported',
            ),
          ),
        );
        expect(
          () async => await clientA.emit(
            topic: TEST_SESSION_VALID_TOPIC,
            chainId: TEST_ETHEREUM_CHAIN,
            event: SessionEventParams(
              name: TEST_EVENT_INVALID_1,
              data: TEST_MESSAGE_1,
            ),
          ),
          throwsA(
            isA<WCError>().having(
              (e) => e.message,
              'message',
              'Unsupported events. The event $TEST_EVENT_INVALID_1 is not supported',
            ),
          ),
        );
      });
    });

    group('ping', () {
      setUp(() async {
        await clientA.sessions.set(
          TEST_SESSION_VALID_TOPIC,
          testSessionValid,
        );
        await clientA.sessions.set(
          TEST_SESSION_EXPIRED_TOPIC,
          testSessionExpired,
        );
      });

      test("works from pairing and session", () async {
        final connectionInfo = await SignClientHelpers.testConnectPairApprove(
          clientA,
          clientB,
        );
        final sessionTopic = connectionInfo.session.topic;
        final pairingTopic = connectionInfo.pairing.topic;

        int counterAS = 0;
        int counterBS = 0;
        int counterAP = 0;
        int counterBP = 0;
        clientA.onSessionPing.subscribe((SessionPing? session) {
          expect(session != null, true);
          expect(session!.topic, sessionTopic);
          counterAS++;
        });
        clientB.onSessionPing.subscribe((SessionPing? session) {
          expect(session != null, true);
          expect(session!.topic, sessionTopic);
          counterBS++;
        });
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
        await clientB.ping(topic: sessionTopic);
        await clientA.ping(topic: pairingTopic);
        await clientB.ping(topic: pairingTopic);

        await Future.delayed(Duration(milliseconds: 150));

        expect(counterAS, 1);
        expect(counterBS, 1);
        expect(counterAP, 2);
        expect(counterBP, 2);

        clientA.onSessionPing.unsubscribeAll();
        clientB.onSessionPing.unsubscribeAll();
        clientA.core.pairing.onPairingPing.unsubscribeAll();
        clientB.core.pairing.onPairingPing.unsubscribeAll();
      });

      test('invalid topic', () async {
        expect(
          () async => await clientA.ping(
            topic: TEST_SESSION_INVALID_TOPIC,
          ),
          throwsA(
            isA<WCError>().having(
              (e) => e.message,
              'message',
              'No matching key. session or pairing topic doesn\'t exist: $TEST_SESSION_INVALID_TOPIC',
            ),
          ),
        );
        expect(
          () async => await clientA.ping(
            topic: TEST_SESSION_EXPIRED_TOPIC,
          ),
          throwsA(
            isA<WCError>().having(
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
      });
    });

    group("disconnect", () {
      setUp(() async {
        await clientA.sessions.set(
          TEST_SESSION_VALID_TOPIC,
          testSessionValid,
        );
        await clientA.sessions.set(
          TEST_SESSION_EXPIRED_TOPIC,
          testSessionExpired,
        );
      });

      test("using pairing works", () async {
        final connectionInfo = await SignClientHelpers.testConnectPairApprove(
          clientA,
          clientB,
        );
        final pairingATopic = connectionInfo.pairing.topic;

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

        final reason = Errors.getSdkError(Errors.USER_DISCONNECTED);
        await clientA.disconnect(
          topic: pairingATopic,
          reason: WCErrorResponse(
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

        clientA.core.pairing.onPairingDelete.unsubscribeAll();
        clientB.core.pairing.onPairingDelete.unsubscribeAll();
      });

      test("using session works", () async {
        final connectionInfo = await SignClientHelpers.testConnectPairApprove(
          clientA,
          clientB,
        );
        final sessionATopic = connectionInfo.session.topic;

        int counterB = 0;
        clientB.onSessionDelete.subscribe((SessionDelete? e) {
          expect(e != null, true);
          expect(e!.topic, sessionATopic);
          counterB++;
        });

        final reason = Errors.getSdkError(Errors.USER_DISCONNECTED);
        await clientA.disconnect(
          topic: sessionATopic,
          reason: WCErrorResponse(
            code: reason.code,
            message: reason.message,
          ),
        );

        await Future.delayed(Duration(milliseconds: 150));

        expect(clientA.sessions.get(sessionATopic), null);
        expect(clientB.sessions.get(sessionATopic), null);

        expect(counterB, 1);

        clientA.onSessionDelete.unsubscribeAll();
        clientB.onSessionDelete.unsubscribeAll();
      });

      test('invalid topic', () async {
        final reason = Errors.getSdkError(Errors.USER_DISCONNECTED);
        expect(
          () async => await clientA.disconnect(
            topic: TEST_SESSION_INVALID_TOPIC,
            reason: WCErrorResponse(
              code: reason.code,
              message: reason.message,
            ),
          ),
          throwsA(
            isA<WCError>().having(
              (e) => e.message,
              'message',
              'No matching key. session or pairing topic doesn\'t exist: $TEST_SESSION_INVALID_TOPIC',
            ),
          ),
        );
        expect(
          () async => await clientA.disconnect(
            topic: TEST_SESSION_EXPIRED_TOPIC,
            reason: WCErrorResponse(
              code: reason.code,
              message: reason.message,
            ),
          ),
          throwsA(
            isA<WCError>().having(
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
      });
    });

    group('find', () {
      test('works', () async {
        await clientA.sessions.set(
          TEST_SESSION_VALID_TOPIC,
          testSessionValid,
        );

        final sessionData = clientA.find(
          requiredNamespaces: TEST_REQUIRED_NAMESPACES,
        );
        expect(sessionData != null, true);
        expect(sessionData!.topic, TEST_SESSION_VALID_TOPIC);

        final sessionData2 = clientA.find(
          requiredNamespaces: TEST_REQUIRED_NAMESPACES_INVALID_CHAINS_1,
        );
        expect(sessionData2, null);
      });
    });

    group('pairings', () {
      test('works', () async {
        expect(clientA.pairings, clientA.core.pairing.getStore());
      });
    });
  });
}

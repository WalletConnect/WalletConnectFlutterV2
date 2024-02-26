// ignore_for_file: avoid_print

import 'dart:async';

import 'package:flutter_test/flutter_test.dart';
import 'package:walletconnect_flutter_v2/apis/sign_api/i_sign_engine_app.dart';
import 'package:walletconnect_flutter_v2/apis/sign_api/i_sign_engine_common.dart';
import 'package:walletconnect_flutter_v2/apis/sign_api/i_sign_engine_wallet.dart';
import 'package:walletconnect_flutter_v2/walletconnect_flutter_v2.dart';

import '../../shared/shared_test_values.dart';
import '../utils/sign_client_constants.dart';
import 'sign_client_helpers.dart';

void signRequestAndHandler({
  required Future<ISignEngineApp> Function(PairingMetadata) clientACreator,
  required Future<ISignEngineWallet> Function(PairingMetadata) clientBCreator,
}) {
  group('request and handler', () {
    late ISignEngineApp clientA;
    late ISignEngineWallet clientB;
    List<ISignEngineCommon> clients = [];

    setUp(() async {
      clientA = await clientACreator(PROPOSER);
      clientB = await clientBCreator(RESPONDER);
      clients.add(clientA);
      clients.add(clientB);

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
        testSessionExpired.expiry,
      );
    });

    tearDown(() async {
      clients.clear();
      await clientA.core.relayClient.disconnect();
      await clientB.core.relayClient.disconnect();
    });

    test('register a request handler and receive method calls with it',
        () async {
      final connectionInfo = await SignClientHelpers.testConnectPairApprove(
        clientA,
        clientB,
      );
      final sessionTopic = connectionInfo.session.topic;

      // No handler
      clientA.core.logger.i('No handler');
      try {
        final _ = await clientA.request(
          topic: connectionInfo.session.topic,
          chainId: TEST_ETHEREUM_CHAIN,
          request: const SessionRequestParams(
            method: 'nonexistant',
            params: TEST_MESSAGE_1,
          ),
        );
      } on WalletConnectError catch (e) {
        expect(
          e.toString(),
          'WalletConnectError(code: 5101, message: Unsupported methods. The method nonexistant is not supported, data: null)',
        );
      }
      expect(clientB.getPendingSessionRequests().length, 0);

      // Valid handler
      Future<dynamic> Function(String, dynamic) requestHandler = (
        String topic,
        dynamic request,
      ) async {
        expect(topic, sessionTopic);
        // expect(request, TEST_MESSAGE_1);
        // print(clientB.getPendingSessionRequests());
        expect(clientB.getPendingSessionRequests().length, 1);
        final pRequest = clientB.pendingRequests.getAll().last;
        return await clientB.respondSessionRequest(
          topic: sessionTopic,
          response: JsonRpcResponse(
            id: pRequest.id,
            result: request,
          ),
        );
      };
      clientB.registerRequestHandler(
        chainId: TEST_ETHEREUM_CHAIN,
        method: TEST_METHOD_1,
        handler: requestHandler,
      );

      Completer clientBReady = Completer();
      clientB.pendingRequests.onSync.subscribe((args) {
        if (clientB.getPendingSessionRequests().isEmpty &&
            !clientBReady.isCompleted) {
          clientBReady.complete();
        }
      });

      try {
        clientA.core.logger.i('Request handler 1');
        final Map<String, dynamic> response = await clientA.request(
          topic: connectionInfo.session.topic,
          chainId: TEST_ETHEREUM_CHAIN,
          request: const SessionRequestParams(
            method: TEST_METHOD_1,
            params: TEST_MESSAGE_1,
          ),
        );

        expect(response, TEST_MESSAGE_1);

        clientA.core.logger.i('Request handler 1, waiting for clientBReady');
        if (clientBReady.isCompleted) {
          clientBReady = Completer();
        } else {
          await clientBReady.future;
          clientBReady = Completer();
        }

        // print('swag 3');
        clientA.core.logger.i('Request handler 2');
        final String response2 = await clientA.request(
          topic: connectionInfo.session.topic,
          chainId: TEST_ETHEREUM_CHAIN,
          request: const SessionRequestParams(
            method: TEST_METHOD_1,
            params: TEST_MESSAGE_2,
          ),
        );

        expect(response2, TEST_MESSAGE_2);

        clientA.core.logger.i('Request handler 2, waiting for clientBReady');
        if (!clientBReady.isCompleted) {
          await clientBReady.future;
        }

        clientB.sessions.onSync.unsubscribeAll();
      } on JsonRpcError catch (e) {
        print(e);
        expect(false, true);
      }

      // Valid handler that throws an error
      requestHandler = (
        String topic,
        dynamic request,
      ) async {
        expect(topic, sessionTopic);
        expect(clientB.getPendingSessionRequests().length, 1);
        if (request == 'silent') {
          throw WalletConnectErrorSilent();
        }
        final pRequest = clientB.pendingRequests.getAll().last;
        late dynamic error = (request is String)
            ? Errors.getSdkError(Errors.USER_REJECTED_SIGN)
            : JsonRpcError.invalidParams('swag');
        return await clientB.respondSessionRequest(
          topic: sessionTopic,
          response: JsonRpcResponse(
            id: pRequest.id,
            error: JsonRpcError(code: error.code, message: error.message),
          ),
        );
      };
      clientB.registerRequestHandler(
        chainId: TEST_ETHEREUM_CHAIN,
        method: TEST_METHOD_1,
        handler: requestHandler,
      );

      try {
        // print('user rejected sign');
        await clientA.request(
          topic: connectionInfo.session.topic,
          chainId: TEST_ETHEREUM_CHAIN,
          request: const SessionRequestParams(
            method: TEST_METHOD_1,
            params: TEST_MESSAGE_2,
          ),
        );

        expect(true, false);
      } on JsonRpcError catch (e) {
        // print('user rejected sign error received');
        expect(
          e.code,
          Errors.getSdkError(Errors.USER_REJECTED_SIGN).code,
        );
        expect(
          e.message,
          Errors.getSdkError(Errors.USER_REJECTED_SIGN).message,
        );
      }

      Completer pendingRequestCompleter = Completer();
      clientB.pendingRequests.onSync.subscribe((_) {
        if (clientB.getPendingSessionRequests().isEmpty) {
          pendingRequestCompleter.complete();
        }
      });
      if (!pendingRequestCompleter.isCompleted) {
        clientA.core.logger.i('waiting pendingRequestCompleter');
        await pendingRequestCompleter.future;
      }
      clientB.pendingRequests.onSync.unsubscribeAll();

      try {
        await clientA.request(
          topic: connectionInfo.session.topic,
          chainId: TEST_ETHEREUM_CHAIN,
          request: const SessionRequestParams(
            method: TEST_METHOD_1,
            params: {'test': 'swag'},
          ),
        );

        expect(true, false);
      } on JsonRpcError catch (e) {
        expect(
          e.code,
          JsonRpcError.invalidParams('swag').code,
        );
      }

      pendingRequestCompleter = Completer();
      clientB.pendingRequests.onSync.subscribe((_) {
        if (clientB.getPendingSessionRequests().isEmpty) {
          pendingRequestCompleter.complete();
        }
      });
      if (!pendingRequestCompleter.isCompleted) {
        clientA.core.logger.i('waiting pendingRequestCompleter');
        await pendingRequestCompleter.future;
      }
      clientB.pendingRequests.onSync.unsubscribeAll();

      clientB.registerRequestHandler(
        chainId: TEST_ETHEREUM_CHAIN,
        method: TEST_METHOD_1,
      );
      clientB.registerRequestHandler(
        chainId: TEST_ETHEREUM_CHAIN,
        method: TEST_METHOD_2,
      );
      clientB.onSessionRequest.subscribe((
        SessionRequestEvent? event,
      ) async {
        expect(event != null, true);
        expect(event!.topic, sessionTopic);
        expect(event.params, TEST_MESSAGE_1);

        if (event.method == TEST_METHOD_1) {
          expect(clientB.pendingRequests.has(event.id.toString()), true);
          expect(clientB.getPendingSessionRequests().length, 1);

          await clientB.respondSessionRequest(
            topic: event.topic,
            response: JsonRpcResponse<Map<String, String>>(
              id: event.id,
              result: TEST_MESSAGE_1,
            ),
          );

          expect(clientB.pendingRequests.has(event.id.toString()), false);
        } else if (event.method == TEST_METHOD_2) {
          await clientB.respondSessionRequest(
            topic: event.topic,
            response: JsonRpcResponse(
              id: event.id,
              error: JsonRpcError.invalidParams(event.params.toString()),
            ),
          );
        }
      });

      try {
        Map<String, dynamic> response = await clientA.request(
          topic: connectionInfo.session.topic,
          chainId: TEST_ETHEREUM_CHAIN,
          request: const SessionRequestParams(
            method: TEST_METHOD_1,
            params: TEST_MESSAGE_1,
          ),
        );

        expect(response, TEST_MESSAGE_1);

        Map<String, dynamic> _ = await clientA.request(
          topic: connectionInfo.session.topic,
          chainId: TEST_ETHEREUM_CHAIN,
          request: const SessionRequestParams(
            method: TEST_METHOD_2,
            params: TEST_MESSAGE_1,
          ),
        );

        expect(true, false);
      } on JsonRpcError catch (e) {
        // print(e);
        expect(
          e.code,
          JsonRpcError.invalidParams('swag').code,
        );
        expect(e.message!.contains(TEST_MESSAGE_1.toString()), true);
      }

      // Try an error
      clientB.onSessionRequest.unsubscribeAll();
      clientB.onSessionRequest.subscribe((
        SessionRequestEvent? event,
      ) async {
        expect(event != null, true);
        expect(event!.topic, sessionTopic);
        expect(event.params, TEST_MESSAGE_1);

        expect(clientB.pendingRequests.has(event.id.toString()), true);

        await clientB.respondSessionRequest(
          topic: event.topic,
          response: JsonRpcResponse<String>(
            id: event.id,
            error: JsonRpcError.invalidParams('invalid'),
          ),
        );

        expect(clientB.pendingRequests.has(event.id.toString()), false);
      });

      try {
        final _ = await clientA.request(
          topic: connectionInfo.session.topic,
          chainId: TEST_ETHEREUM_CHAIN,
          request: const SessionRequestParams(
            method: TEST_METHOD_1,
            params: TEST_MESSAGE_1,
          ),
        );
      } on JsonRpcError catch (e) {
        expect(e.message, 'invalid');
      }

      clientB.onSessionRequest.unsubscribeAll();
    });

    test('invalid session topic', () async {
      expect(
        () async => await clientA.request(
          topic: TEST_SESSION_INVALID_TOPIC,
          chainId: TEST_ETHEREUM_CHAIN,
          request: const SessionRequestParams(
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
      Completer completer = Completer();
      clientA.core.expirer.onExpire.subscribe((args) {
        counter++;
        completer.complete();
      });
      int counterSession = 0;
      Completer completerSession = Completer();
      clientA.onSessionExpire.subscribe((args) {
        counterSession++;
        completerSession.complete();
      });
      // print(
      //     'clientA.session exiry: ${clientA.sessions.get(TEST_SESSION_EXPIRED_TOPIC)!.expiry}');
      expect(
        () async => await clientA.request(
          topic: TEST_SESSION_EXPIRED_TOPIC,
          chainId: TEST_ETHEREUM_CHAIN,
          request: const SessionRequestParams(
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

      // await Future.delayed(Duration(milliseconds: 150));
      await completer.future;
      await completerSession.future;

      expect(
        clientA.sessions.has(
          TEST_SESSION_EXPIRED_TOPIC,
        ),
        false,
      );
      expect(counter, 1);
      expect(counterSession, 1);
      clientA.core.expirer.onExpire.unsubscribeAll();
      clientB.onSessionExpire.unsubscribeAll();
    });

    test('invalid chains or methods', () async {
      expect(
        () async => await clientA.request(
          topic: TEST_SESSION_VALID_TOPIC,
          chainId: TEST_UNINCLUDED_CHAIN,
          request: const SessionRequestParams(
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
          request: const SessionRequestParams(
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
}

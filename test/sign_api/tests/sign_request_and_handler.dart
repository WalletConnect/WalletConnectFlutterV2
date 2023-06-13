// ignore_for_file: avoid_print

import 'dart:async';

import 'package:test/test.dart';
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
          request: SessionRequestParams(
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

        return request;
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
          request: SessionRequestParams(
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
          request: SessionRequestParams(
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
        if (request is String) {
          if (request == TEST_MESSAGE_2) {
            throw Errors.getSdkError(Errors.USER_REJECTED_SIGN);
          } else {
            throw WalletConnectErrorSilent();
          }
        } else {
          return request['try']!;
        }
      };
      clientB.registerRequestHandler(
        chainId: TEST_ETHEREUM_CHAIN,
        method: TEST_METHOD_1,
        handler: requestHandler,
      );

      try {
        // print('silent error');
        clientA.request(
          topic: connectionInfo.session.topic,
          chainId: TEST_ETHEREUM_CHAIN,
          request: SessionRequestParams(
            method: TEST_METHOD_1,
            params: 'silent',
          ),
        );

        // print('user rejected sign');
        await clientA.request(
          topic: connectionInfo.session.topic,
          chainId: TEST_ETHEREUM_CHAIN,
          request: SessionRequestParams(
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

      try {
        final _ = await clientA.request(
          topic: connectionInfo.session.topic,
          chainId: TEST_ETHEREUM_CHAIN,
          request: SessionRequestParams(
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

      Completer pendingRequestCompleter = Completer();
      Completer sessionRequestCompleter = Completer();
      clientB.pendingRequests.onSync.subscribe((_) {
        if (clientB.getPendingSessionRequests().isEmpty) {
          pendingRequestCompleter.complete();
        }
      });
      clientB.onSessionRequest.subscribe((args) {
        sessionRequestCompleter.complete();
        sessionRequestCompleter = Completer();
      });

      if (!pendingRequestCompleter.isCompleted) {
        clientA.core.logger.i('waiting pendingRequestCompleter');
        await pendingRequestCompleter.future;
      }
      if (!sessionRequestCompleter.isCompleted) {
        clientA.core.logger.i('waiting sessionRequestComplete');
        await sessionRequestCompleter.future;
      }
      clientB.pendingRequests.onSync.unsubscribeAll();
      clientB.onSessionRequest.unsubscribeAll();
      expect(clientB.getPendingSessionRequests().length, 0);

      /// Event driven, null handler ///
      clientB.registerRequestHandler(
        chainId: TEST_ETHEREUM_CHAIN,
        method: TEST_METHOD_1,
      );
      clientB.registerRequestHandler(
        chainId: TEST_ETHEREUM_CHAIN,
        method: TEST_METHOD_2,
      );
      clientB.onSessionRequest.subscribe((
        SessionRequestEvent? request,
      ) async {
        expect(request != null, true);
        expect(request!.topic, sessionTopic);
        expect(request.params, TEST_MESSAGE_1);

        if (request.method == TEST_METHOD_1) {
          expect(clientB.pendingRequests.has(request.id.toString()), true);
          expect(clientB.getPendingSessionRequests().length, 1);

          await clientB.respondSessionRequest(
            topic: request.topic,
            response: JsonRpcResponse<Map<String, String>>(
              id: request.id,
              result: TEST_MESSAGE_1,
            ),
          );

          expect(clientB.pendingRequests.has(request.id.toString()), false);
        } else if (request.method == TEST_METHOD_2) {
          await clientB.respondSessionRequest(
            topic: request.topic,
            response: JsonRpcResponse(
              id: request.id,
              error: JsonRpcError.invalidParams(request.params.toString()),
            ),
          );
        }
      });

      try {
        Map<String, dynamic> response = await clientA.request(
          topic: connectionInfo.session.topic,
          chainId: TEST_ETHEREUM_CHAIN,
          request: SessionRequestParams(
            method: TEST_METHOD_1,
            params: TEST_MESSAGE_1,
          ),
        );

        expect(response, TEST_MESSAGE_1);

        Map<String, dynamic> _ = await clientA.request(
          topic: connectionInfo.session.topic,
          chainId: TEST_ETHEREUM_CHAIN,
          request: SessionRequestParams(
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
        expect(e.message.contains(TEST_MESSAGE_1.toString()), true);
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
            error: JsonRpcError.invalidParams('invalid'),
          ),
        );

        expect(clientB.pendingRequests.has(session.id.toString()), false);
      });

      try {
        final _ = await clientA.request(
          topic: connectionInfo.session.topic,
          chainId: TEST_ETHEREUM_CHAIN,
          request: SessionRequestParams(
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
}

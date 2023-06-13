import 'package:http/http.dart';
import 'package:mockito/mockito.dart';
import 'package:test/test.dart';
import 'package:walletconnect_flutter_v2/apis/core/crypto/i_crypto.dart';
import 'package:walletconnect_flutter_v2/apis/core/echo/echo.dart';
import 'package:walletconnect_flutter_v2/apis/core/echo/echo_client.dart';
import 'package:walletconnect_flutter_v2/apis/core/echo/i_echo_client.dart';
import 'package:walletconnect_flutter_v2/walletconnect_flutter_v2.dart';

import '../shared/shared_test_utils.mocks.dart';

void main() {
  const baseUrl = 'https://echo.walletconnect.org';
  const testFcmToken = 'fcmToken';
  const errorResponse =
      '{"errors":[{"message":"The provided Tenant ID, projectId, is invalid. Please ensure it\'s valid and the url is in the format /:tenant_id/...path","name":"tenant"}],"fields":[{"description":"Invalid Tenant ID, projectId","field":"tenant_id","location":"path"}],"status":"FAILURE"}';

  late ICore core;
  late ICrypto crypto;
  late MockHttpWrapper http;
  late IEchoClient echoClient;

  setUp(() {
    core = MockCore();
    crypto = MockCrypto();
    http = MockHttpWrapper();
    echoClient = EchoClient(
      baseUrl: baseUrl,
      httpClient: http,
    );

    when(core.projectId).thenReturn('projectId');
    when(core.crypto).thenReturn(crypto);
    when(crypto.getClientId()).thenAnswer((_) async => 'clientId');
  });

  group('register -', () {
    test('should successfully register the fcm token', () async {
      when(http.post(any, headers: anyNamed('headers'), body: anyNamed('body')))
          .thenAnswer((_) async => Response('{"status": "SUCCESS"}', 200));

      final echo = Echo(core: core, echoClient: echoClient);
      await echo.register(testFcmToken);

      verify(core.projectId).called(1);
      verify(crypto.getClientId()).called(1);
      verify(
        http.post(any, headers: anyNamed('headers'), body: anyNamed('body')),
      ).called(1);
    });

    test('should return an error on register', () async {
      when(http.post(any, headers: anyNamed('headers'), body: anyNamed('body')))
          .thenAnswer((_) async => Response(errorResponse, 400));

      final echo = Echo(core: core, echoClient: echoClient);
      await expectLater(
        echo.register(testFcmToken),
        throwsA(isInstanceOf<ArgumentError>()),
      );

      verify(core.projectId).called(1);
      verify(crypto.getClientId()).called(1);
      verify(
        http.post(any, headers: anyNamed('headers'), body: anyNamed('body')),
      ).called(1);
    });
  });

  group('unregister -', () {
    test('should successfully unregister the fcm token', () async {
      when(http.delete(any, headers: anyNamed('headers')))
          .thenAnswer((_) async => Response('{"status": "SUCCESS"}', 200));

      final echo = Echo(core: core, echoClient: echoClient);
      await echo.unregister();

      verify(core.projectId).called(1);
      verify(crypto.getClientId()).called(1);
      verify(
        http.delete(any, headers: anyNamed('headers')),
      ).called(1);
    });

    test('should return an error on unregister', () async {
      when(http.delete(any, headers: anyNamed('headers')))
          .thenAnswer((_) async => Response(errorResponse, 400));

      final echo = Echo(core: core, echoClient: echoClient);
      await expectLater(
        echo.unregister(),
        throwsA(isInstanceOf<ArgumentError>()),
      );

      verify(core.projectId).called(1);
      verify(crypto.getClientId()).called(1);
      verify(
        http.delete(any, headers: anyNamed('headers')),
      ).called(1);
    });
  });
}

import 'package:flutter_test/flutter_test.dart';
import 'package:walletconnect_flutter_v2/apis/sign_api/utils/auth/auth_constants.dart';
import 'package:walletconnect_flutter_v2/walletconnect_flutter_v2.dart';

import 'utils/engine_constants.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  group('AuthValidators', () {
    test('isValidRequestExpiry', () {
      final List<int> expiries = [
        AuthConstants.AUTH_REQUEST_EXPIRY_MIN - 1,
        AuthConstants.AUTH_REQUEST_EXPIRY_MIN,
        AuthConstants.AUTH_REQUEST_EXPIRY_MIN + 1,
        AuthConstants.AUTH_REQUEST_EXPIRY_MAX - 1,
        AuthConstants.AUTH_REQUEST_EXPIRY_MAX,
        AuthConstants.AUTH_REQUEST_EXPIRY_MAX + 1,
      ];
      final List<bool> expiryResults = [
        false,
        true,
        true,
        true,
        true,
        false,
      ];

      // Loop through the expiries and expect the results
      for (var i = 0; i < expiries.length; i++) {
        final expiry = expiries[i];
        final result = expiryResults[i];

        expect(AuthApiValidators.isValidRequestExpiry(expiry), result);
      }
    });

    test('isValidRequest', () {
      expect(
        AuthApiValidators.isValidRequest(testAuthRequestParamsValid),
        true,
      );
      expect(
        () => AuthApiValidators.isValidRequest(testAuthRequestParamsInvalidAud),
        throwsA(
          isA<WalletConnectError>().having(
            (e) => e.message,
            'message',
            'Missing or invalid. requestAuth() invalid aud: ${testAuthRequestParamsInvalidAud.aud}. Must be a valid url.',
          ),
        ),
      );
      expect(
        () => AuthApiValidators.isValidRequest(
          testAuthRequestParamsInvalidNonce,
        ),
        throwsA(
          isA<WalletConnectError>().having(
            (e) => e.message,
            'message',
            'Missing or invalid. requestAuth() nonce must be nonempty.',
          ),
        ),
      );
      expect(
        () =>
            AuthApiValidators.isValidRequest(testAuthRequestParamsInvalidType),
        throwsA(
          isA<WalletConnectError>().having(
            (e) => e.message,
            'message',
            'Missing or invalid. requestAuth() type must null or ${CacaoHeader.EIP4361}.',
          ),
        ),
      );
      expect(
        () => AuthApiValidators.isValidRequest(
            testAuthRequestParamsInvalidExpiry),
        throwsA(
          isA<WalletConnectError>().having(
            (e) => e.message,
            'message',
            'Missing or invalid. requestAuth() expiry: ${testAuthRequestParamsInvalidExpiry.expiry}. Expiry must be a number (in seconds) between ${AuthConstants.AUTH_REQUEST_EXPIRY_MIN} and ${AuthConstants.AUTH_REQUEST_EXPIRY_MAX}',
          ),
        ),
      );
    });

    test('isValidRespond', () {
      expect(
        AuthApiValidators.isValidRespond(
          id: TEST_PENDING_REQUEST_ID,
          pendingRequests: testPendingRequests,
          signature: const CacaoSignature(t: '', s: ''),
        ),
        true,
      );
      expect(
        () => AuthApiValidators.isValidRespond(
          id: TEST_PENDING_REQUEST_ID_INVALID,
          pendingRequests: testPendingRequests,
        ),
        throwsA(
          isA<WalletConnectError>().having(
            (e) => e.message,
            'message',
            'Missing or invalid. respondAuth() invalid id: $TEST_PENDING_REQUEST_ID_INVALID. No pending request found.',
          ),
        ),
      );
      expect(
        () => AuthApiValidators.isValidRespond(
          id: TEST_PENDING_REQUEST_ID,
          pendingRequests: testPendingRequests,
        ),
        throwsA(
          isA<WalletConnectError>().having(
            (e) => e.message,
            'message',
            'Missing or invalid. respondAuth() invalid response. Must contain either signature or error.',
          ),
        ),
      );
    });
  });
}

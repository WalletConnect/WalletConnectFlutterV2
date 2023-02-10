import 'package:flutter_test/flutter_test.dart';
import 'package:wallet_connect_flutter_v2/apis/auth_api/models/auth_client_models.dart';
import 'package:wallet_connect_flutter_v2/apis/auth_api/utils/auth_signature.dart';

import '../shared/shared_test_values.dart';
import 'utils/signature_constants.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  group('AuthSignature', () {
    test('isValidEip191Signature', () {
      final cacaoSig = CacaoSignature(
        t: CacaoSignature.EIP191,
        s: TEST_SIG_3,
      );

      final bool = AuthSignature.verifySignature(
        TEST_ADDRESS_3,
        TEST_MESSAGE_3,
        cacaoSig,
        TEST_ETHEREUM_CHAIN,
        TEST_PROJECT_ID,
      );

      // print(bool);
      expect(bool, true);
    });
  });
}

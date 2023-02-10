import 'package:flutter_test/flutter_test.dart';
import 'package:wallet_connect_flutter_v2/apis/auth_api/models/auth_client_models.dart';
import 'package:wallet_connect_flutter_v2/apis/auth_api/utils/auth_signature.dart';

import '../shared/shared_test_values.dart';
import 'utils/signature_constants.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  group('AuthSignature', () {
    test('isValidEip191Signature', () async {
      final cacaoSig = CacaoSignature(
        t: CacaoSignature.EIP191,
        s: TEST_SIG_EIP191,
      );

      final bool = await AuthSignature.verifySignature(
        TEST_ADDRESS_EIP191,
        TEST_MESSAGE_EIP191,
        cacaoSig,
        TEST_ETHEREUM_CHAIN,
        TEST_PROJECT_ID,
      );

      // print(bool);
      expect(bool, true);

      final cacaoSig2 = CacaoSignature(
        t: CacaoSignature.EIP191,
        s: TEST_SIGNATURE_FAIL,
      );

      final bool2 = await AuthSignature.verifySignature(
        TEST_ADDRESS_EIP191,
        TEST_MESSAGE_EIP191,
        cacaoSig2,
        TEST_ETHEREUM_CHAIN,
        TEST_PROJECT_ID,
      );

      // print(bool);
      expect(bool2, false);
    });

    // TODO: Fix this test, can't call http requests from within the test
    // test('isValidEip1271Signature', () async {
    //   final cacaoSig = CacaoSignature(
    //     t: CacaoSignature.EIP1271,
    //     s: TEST_SIG_EIP1271,
    //   );

    //   final bool = await AuthSignature.verifySignature(
    //     TEST_ADDRESS_EIP1271,
    //     TEST_MESSAGE_EIP1271,
    //     cacaoSig,
    //     TEST_ETHEREUM_CHAIN,
    //     TEST_PROJECT_ID,
    //   );

    //   // print(bool);
    //   expect(bool, true);

    //   final cacaoSig2 = CacaoSignature(
    //     t: CacaoSignature.EIP1271,
    //     s: TEST_SIGNATURE_FAIL,
    //   );

    //   final bool2 = await AuthSignature.verifySignature(
    //     TEST_ADDRESS_EIP1271,
    //     TEST_MESSAGE_EIP1271,
    //     cacaoSig2,
    //     TEST_ETHEREUM_CHAIN,
    //     TEST_PROJECT_ID,
    //   );

    //   // print(bool);
    //   expect(bool2, false);
    // });
  });
}

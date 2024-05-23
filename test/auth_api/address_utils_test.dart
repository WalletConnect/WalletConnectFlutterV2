import 'package:flutter_test/flutter_test.dart';
import 'package:walletconnect_flutter_v2/apis/sign_api/utils/auth/address_utils.dart';

import '../shared/shared_test_values.dart';
import 'utils/signature_constants.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  group('AddressUtils', () {
    test('getDidAddress', () async {
      expect(
        AddressUtils.getDidAddress(TEST_ISSUER_EIP191),
        TEST_ADDRESS_EIP191,
      );
    });

    test('getDidChainId', () async {
      expect(
        AddressUtils.getDidChainId(TEST_ISSUER_EIP191),
        TEST_ETHEREUM_CHAIN.split(':')[1],
      );
    });
  });
}

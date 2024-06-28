import 'dart:convert';

import 'package:convert/convert.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:walletconnect_flutter_v2/walletconnect_flutter_v2.dart';

import '../shared/shared_test_values.dart';
import 'utils/engine_constants.dart';
import 'utils/signature_constants.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  group('AuthSignature', () {
    test('Test EIP-191 Personal Message Hash', () {
      final messages = [
        'Hello World',
        utf8.decode([0x42, 0x43]),
        '0x4243',
      ];
      final hashes = [
        '0xa1de988600a42c4b4ab089b619297c17d53cffae5d5120d82d8a92d0bb3b78f2',
        '0x0d3abc18ec299cf9b42ba439ac6f7e3e6ec9f5c048943704e30fc2d9c7981438',
        '0x6d91b221f765224b256762dcba32d62209cf78e9bebb0a1b758ca26c76db3af4',
      ];

      for (int i = 0; i < messages.length; i++) {
        final hash = AuthSignature.hashMessage(messages[i]);
        expect(
          '0x${hex.encode(hash)}',
          hashes[i],
        );
      }
    });

    test('isValidEip191Signature', () async {
      // print('Actual Sig: ${EthSigUtil.signPersonalMessage(
      //   message: Uint8List.fromList(TEST_MESSAGE_EIP191.codeUnits),
      //   privateKey: TEST_PRIVATE_KEY_EIP191,
      // )}');

      const cacaoSig = CacaoSignature(
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

      const cacaoSig2 = CacaoSignature(
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

    test('getAddressFromMessage', () {
      final address = AuthSignature.getAddressFromMessage(
        TEST_MESSAGE_EIP1271,
      );
      expect(address, TEST_ADDRESS_EIP1271);

      final address2 = AuthSignature.getAddressFromMessage(
        TEST_FORMATTED_MESSAGE,
      );
      expect(address2, '0x06C6A22feB5f8CcEDA0db0D593e6F26A3611d5fa');

      final address3 = AuthSignature.getAddressFromMessage(
        TEST_MESSAGE_EIP1271_2,
      );
      expect(address3, '0x59e2f66C0E96803206B6486cDb39029abAE834c0');
    });

    test('getChainIdFromMessage', () {
      final chainId = AuthSignature.getChainIdFromMessage(
        TEST_MESSAGE_EIP1271,
      );
      expect(chainId, '1');

      final chainId2 = AuthSignature.getChainIdFromMessage(
        TEST_FORMATTED_MESSAGE,
      );
      expect(chainId2, '1');

      final chainId3 = AuthSignature.getChainIdFromMessage(
        TEST_MESSAGE_EIP1271_2,
      );
      expect(chainId3, '465321');
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

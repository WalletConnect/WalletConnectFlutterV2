import 'package:flutter_test/flutter_test.dart';
import 'package:walletconnect_flutter_v2/walletconnect_flutter_v2.dart';

import '../shared/shared_test_values.dart';
import 'utils/signature_constants.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  group('AuthSignature', () {
    // test('signatures recover the public key of the signer', () {
    //   final messages = [
    //     'Hello world',
    //     'UTF8 chars ©âèíöu ∂øµ€',
    //     '🚀✨🌎',
    //     DateTime.now().toString()
    //   ];
    //   final privateKeys = [
    //     '3c9229289a6125f7fdf1885a77bb12c37a8d3b4962d936f7e3084dece32a3ca1',
    //     'a69ab6a98f9c6a98b9a6b8e9b6a8e69c6ea96b5050eb77a17e3ba685805aeb88',
    //     'ca7eb9798e79c8799ea79aec7be98a7b9a7c98ae7b98061a53be764a85b8e785',
    //     '192b519765c9589a6b8c9a486ab938cba9638ab876056237649264b9cb96d88f',
    //     'b6a8f6a96931ad89d3a98e69ad6b98794673615b74675d7b5a674ba82b648a6d'
    //   ];

    //   for (final message in messages) {
    //     final messageHash = keccak256(Uint8List.fromList(utf8.encode(message)));

    //     for (final privateKey in privateKeys) {
    //       final publicKey = privateKeyBytesToPublic(hexToBytes(privateKey));
    //       final signature = sign(messageHash, hexToBytes(privateKey));

    //       final recoveredPublicKey = ecRecover(messageHash, signature);
    //       expect(bytesToHex(publicKey), bytesToHex(recoveredPublicKey));
    //     }
    //   }
    // });
    test('isValidEip191Signature', () async {
      // print('Actual Sig: ${EthSigUtil.signPersonalMessage(
      //   message: Uint8List.fromList(TEST_MESSAGE_EIP191.codeUnits),
      //   privateKey: TEST_PRIVATE_KEY_EIP191,
      // )}');

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

import 'dart:convert';
import 'dart:typed_data';
import 'package:http/http.dart' as http;

import 'package:hex/hex.dart';
import 'package:pointycastle/digests/keccak.dart';
import 'package:walletconnect_flutter_v2/apis/auth_api/models/auth_client_models.dart';
import 'package:walletconnect_flutter_v2/apis/auth_api/utils/auth_constants.dart';
import 'package:walletconnect_flutter_v2/apis/auth_api/utils/secp256k1/auth_secp256k1.dart';
import 'package:walletconnect_flutter_v2/apis/core/pairing/utils/pairing_utils.dart';

class AuthSignature {
  static final KeccakDigest keccakDigest = KeccakDigest(256);
  static Uint8List keccak256(Uint8List input) {
    keccakDigest.reset();
    return keccakDigest.process(input);
  }

  static Uint8List hashMessage(String message) {
    return keccak256(
      Uint8List.fromList(
        utf8.encode(
          [
            '\x19Ethereum Signed Message:\n',
            message.length,
            message,
          ].join(),
        ),
      ),
    );
  }

  static int getNormalizedV(int v) {
    if (v == 0 || v == 27) {
      return 27;
    }
    if (v == 1 || v == 28) {
      return 28;
    }
    return v & 1 == 1 ? 27 : 28;
  }

  static bool isValidEip191Signature(
    String address,
    String message,
    String sig,
  ) {
    // Get the sig bytes
    final sigBytes = Uint8List.fromList(
      HEX.decode(
        sig.substring(2),
      ),
    );

    // Get the r and s values from the sig bytes
    final r = BigInt.parse(
      HEX.encode(
        sigBytes.sublist(0, 32),
      ),
      radix: 16,
    );
    late BigInt s;
    late int v;

    // Depending on the length of the sig bytes, we can determine the v value
    if (sigBytes.length == 64) {
      Uint8List sBytes = sigBytes.sublist(32, 64);
      sBytes[0] &= 0x7f;
      v = (sBytes[0] & 0x80 == 0) ? 27 : 28;
      s = BigInt.parse(HEX.encode(sBytes), radix: 16);
    } else {
      Uint8List sBytes = sigBytes.sublist(32, 64);
      v = getNormalizedV(sigBytes[64]);
      s = BigInt.parse(HEX.encode(sBytes), radix: 16);
    }

    // Recover the public key from the signature
    Uint8List? publicKeyBytes = AuthSecp256k1.recoverPublicKeyFromSignature(
      v - 27,
      r,
      s,
      hashMessage(message),
    );

    // If the public key is null, return false
    if (publicKeyBytes == null) {
      return false;
    }

    // Convert the public key to an address
    final hashedPubKeyBytes = keccak256(publicKeyBytes);
    final addressBytes = hashedPubKeyBytes.sublist(12, 32);
    final recoveredAddress = '0x${HEX.encode(addressBytes)}';

    return recoveredAddress.toLowerCase() == address.toLowerCase();
  }

  static Future<bool> isValidEip1271Signature(
    String address,
    String reconstructedMessage,
    String cacaoSignature,
    String chainId,
    String projectId,
  ) async {
    try {
      final String eip1271MagicValue = "0x1626ba7e";
      final String dynamicTypeOffset =
          "0000000000000000000000000000000000000000000000000000000000000040";
      final String dynamicTypeLength =
          "0000000000000000000000000000000000000000000000000000000000000041";
      final String nonPrefixedSignature = cacaoSignature.substring(2);
      final String nonPrefixedHashedMessage =
          HEX.encode(hashMessage(reconstructedMessage)).substring(2);

      final String data = eip1271MagicValue +
          nonPrefixedHashedMessage +
          dynamicTypeOffset +
          dynamicTypeLength +
          nonPrefixedSignature;

      final Uri url = Uri.parse(
        '${AuthConstants.AUTH_DEFAULT_URL}/?chainId=$chainId&projectId=$projectId',
      );
      final Map<String, dynamic> body = PairingUtils.formatJsonRpcRequest(
        "eth_call",
        {
          "to": address,
          "data": data,
        },
      );

      final http.Response response = await http.post(
        url,
        body: body,
      );

      print(response.body);
      // final jsonBody = jsonDecode(response.body);
      final String recoveredValue =
          response.body.substring(0, eip1271MagicValue.length);
      return recoveredValue.toLowerCase() == eip1271MagicValue.toLowerCase();
    } catch (e) {
      return false;
    }
  }

  static Future<bool> verifySignature(
    String address,
    String reconstructedMessage,
    CacaoSignature cacaoSignature,
    String chainId,
    String projectId,
  ) async {
    if (cacaoSignature.t == "eip191") {
      return isValidEip191Signature(
        address,
        reconstructedMessage,
        cacaoSignature.s,
      );
    } else if (cacaoSignature.t == "eip1271") {
      return await isValidEip1271Signature(
        address,
        reconstructedMessage,
        cacaoSignature.s,
        chainId,
        projectId,
      );
    } else {
      throw Exception(
        "verifySignature failed: Attempted to verify CacaoSignature with unknown type: ${cacaoSignature.t}",
      );
    }
  }
}

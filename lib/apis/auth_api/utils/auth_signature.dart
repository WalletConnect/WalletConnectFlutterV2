import 'dart:convert';
import 'dart:math';

import 'package:flutter/foundation.dart';
import 'package:hex/hex.dart';
import 'package:pointycastle/digests/keccak.dart';
import 'package:pointycastle/ecc/curves/secp256k1.dart';
import 'package:pointycastle/ecc/api.dart';
import 'package:pointycastle/pointycastle.dart';
import 'package:wallet_connect_flutter_v2/apis/auth_api/models/auth_client_models.dart';
// import 'package:web3dart/crypto.dart';

enum Endian {
  be,
}

class AuthSignature {
  static final ECDomainParameters _params = ECCurve_secp256k1();
  static final BigInt _byteMask = new BigInt.from(0xff);

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

  static BigInt decodeBigInt(List<int> bytes) {
    BigInt result = new BigInt.from(0);
    for (int i = 0; i < bytes.length; i++) {
      result += new BigInt.from(bytes[bytes.length - i - 1]) << (8 * i);
    }
    return result;
  }

  static Uint8List encodeBigInt(BigInt input, {Endian endian = Endian.be, int length = 0}) {
    int byteLength = (input.bitLength + 7) >> 3;
    int reqLength = length > 0 ? length : max(1, byteLength);
    assert(byteLength <= reqLength, 'byte array longer than desired length');
    assert(reqLength > 0, 'Requested array length <= 0');

    var res = Uint8List(reqLength);
    res.fillRange(0, reqLength - byteLength, 0);

    var q = input;
    if (endian == Endian.be) {
      for (int i = 0; i < byteLength; i++) {
        res[reqLength - i - 1] = (q & _byteMask).toInt();
        q = q >> 8;
      }
      return res;
    }

    return Uint8List(0);
  }

  static ECPoint _decompressKey(BigInt xBN, bool yBit, ECCurve c) {
    List<int> x9IntegerToBytes(BigInt s, int qLength) {
      //https://github.com/bcgit/bc-java/blob/master/core/src/main/java/org/bouncycastle/asn1/x9/X9IntegerConverter.java#L45
      final bytes = HEX.decode(s.toRadixString(16));

      if (qLength < bytes.length) {
        return bytes.sublist(0, bytes.length - qLength);
      } else if (qLength > bytes.length) {
        final tmp = List<int>.filled(qLength, 0);

        final offset = qLength - bytes.length;
        for (var i = 0; i < bytes.length; i++) {
          tmp[i + offset] = bytes[i];
        }

        return tmp;
      }

      return bytes;
    }

    final compEnc = x9IntegerToBytes(xBN, 1 + ((c.fieldSize + 7) ~/ 8));
    compEnc[0] = yBit ? 0x03 : 0x02;
    return c.decodePoint(compEnc)!;
  }

  static Uint8List? _recoverPublicKeyFromSignature(
    int recId,
    BigInt r,
    BigInt s,
    Uint8List message,
  ) {
    final n = _params.n;
    final i = BigInt.from(recId ~/ 2);
    final x = r + (i * n);

    //Parameter q of curve
    final prime = BigInt.parse('fffffffffffffffffffffffffffffffffffffffffffffffffffffffefffffc2f', radix: 16);
    if (x.compareTo(prime) >= 0) return null;

    final R = _decompressKey(x, (recId & 1) == 1, _params.curve);
    final ECPoint? ecPoint = R * n;
    if (ecPoint == null || !ecPoint.isInfinity) return null;

    // print(bytesToHex(message));
    // final e = BigInt.parse(bytesToHex(message).substring(1));
    final e = decodeBigInt(message.toList());

    final eInv = (BigInt.zero - e) % n;
    final rInv = r.modInverse(n);
    final srInv = (rInv * s) % n;
    final eInvrInv = (rInv * eInv) % n;

    final preQ = (_params.G * eInvrInv);
    if (preQ == null) return null;
    final q = preQ + (R * srInv);

    final bytes = q?.getEncoded(false);
    return bytes?.sublist(1);
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
    Uint8List? publicKeyBytes = _recoverPublicKeyFromSignature(
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

    return recoveredAddress == address;
  }

  static bool isValidEip1271Signature(
    String address,
    String reconstructedMessage,
    String cacaoSignature,
    String chainId,
    String projectId,
  ) {
    return false;
  }

  static bool verifySignature(
    String address,
    String reconstructedMessage,
    CacaoSignature cacaoSignature,
    String chainId,
    String projectId,
  ) {
    if (cacaoSignature.t == "eip191") {
      return isValidEip191Signature(
        address,
        reconstructedMessage,
        cacaoSignature.s,
      );
    } else if (cacaoSignature.t == "eip1271") {
      return isValidEip1271Signature(
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

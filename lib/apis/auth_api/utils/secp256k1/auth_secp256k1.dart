import 'dart:math';
import 'dart:typed_data';

import 'package:convert/convert.dart';
import 'package:pointycastle/ecc/api.dart';
import 'package:pointycastle/ecc/curves/secp256k1.dart';

enum Endian {
  be,
}

class AuthSecp256k1 {
  static final ECDomainParameters _params = ECCurve_secp256k1();
  static final BigInt _byteMask = BigInt.from(0xff);

  static BigInt decodeBigInt(List<int> bytes) {
    BigInt result = BigInt.from(0);
    for (int i = 0; i < bytes.length; i++) {
      result += BigInt.from(bytes[bytes.length - i - 1]) << (8 * i);
    }
    return result;
  }

  static Uint8List encodeBigInt(
    BigInt input, {
    Endian endian = Endian.be,
    int length = 0,
  }) {
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
      String hexString = s.toRadixString(16);
      if (hexString.length % 2 == 1) {
        hexString = '0$hexString';
      }
      final bytes = hex.decode(hexString);

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

  static Uint8List? recoverPublicKeyFromSignature(
    int recId,
    BigInt r,
    BigInt s,
    Uint8List message,
  ) {
    final n = _params.n;
    final i = BigInt.from(recId ~/ 2);
    final x = r + (i * n);

    //Parameter q of curve
    final prime = BigInt.parse(
        'fffffffffffffffffffffffffffffffffffffffffffffffffffffffefffffc2f',
        radix: 16);
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
}

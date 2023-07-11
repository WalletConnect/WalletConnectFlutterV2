import 'dart:convert';
import 'dart:math';
import 'dart:typed_data';

import 'package:convert/convert.dart';
import 'package:cryptography/cryptography.dart' as dc;
import 'package:pointycastle/digests/sha256.dart';
import 'package:pointycastle/key_derivators/hkdf.dart';
import 'package:pointycastle/pointycastle.dart' show HkdfParameters;
import 'package:walletconnect_flutter_v2/apis/core/crypto/crypto_models.dart';
import 'package:walletconnect_flutter_v2/apis/core/crypto/i_crypto_utils.dart';
import 'package:walletconnect_flutter_v2/apis/models/basic_models.dart';
import 'package:x25519/x25519.dart' as x;

class CryptoUtils extends ICryptoUtils {
  static final _random = Random.secure();

  static const IV_LENGTH = 12;
  static const KEY_LENGTH = 32;

  static const TYPE_LENGTH = 1;

  @override
  CryptoKeyPair generateKeyPair() {
    final kp = x.generateKeyPair();

    return CryptoKeyPair(
      hex.encode(kp.privateKey),
      hex.encode(kp.publicKey),
    );
  }

  @override
  Uint8List randomBytes(int length) {
    final Uint8List random = Uint8List(length);
    for (int i = 0; i < length; i++) {
      random[i] = _random.nextInt(256);
    }
    return random;
  }

  @override
  String generateRandomBytes32() {
    return hex.encode(randomBytes(32));
  }

  @override
  Future<String> deriveSymKey(String privKeyA, String pubKeyB) async {
    final Uint8List sharedKey1 = x.X25519(
      hex.decode(privKeyA),
      hex.decode(pubKeyB),
    );

    Uint8List out = Uint8List(KEY_LENGTH);

    final HKDFKeyDerivator hkdf = HKDFKeyDerivator(SHA256Digest());
    final HkdfParameters params = HkdfParameters(
      sharedKey1,
      KEY_LENGTH,
    );
    hkdf.init(params);
    // final pc.KeyParameter keyParam = hkdf.extract(null, sharedKey1);
    hkdf.deriveKey(null, 0, out, 0);
    return hex.encode(out);
  }

  @override
  String hashKey(String key) {
    return hex.encode(
      SHA256Digest().process(
        Uint8List.fromList(
          hex.decode(key),
        ),
      ),
    );
    // return hex.encode(Hash.sha256(hex.decode(key)));
  }

  @override
  String hashMessage(String message) {
    return hex.encode(
      SHA256Digest().process(
        Uint8List.fromList(
          utf8.encode(message),
        ),
      ),
    );
  }

  @override
  Future<String> encrypt(
    String message,
    String symKey, {
    int? type,
    String? iv,
    String? senderPublicKey,
  }) async {
    final int decodedType = type ?? EncodeOptions.TYPE_0;
    // print(message);
    // print(symKey);

    // Check for type 1 envelope, throw an error if data is invalid
    if (decodedType == EncodeOptions.TYPE_1 && senderPublicKey == null) {
      throw const WalletConnectError(
        code: -1,
        message: 'Missing sender public key for type 1 envelope',
      );
    }

    // final String senderPublicKey = senderPublicKey !=
    final Uint8List usedIV =
        (iv != null ? hex.decode(iv) : randomBytes(IV_LENGTH)) as Uint8List;

    final chacha = dc.Chacha20.poly1305Aead();
    dc.SecretBox b = await chacha.encrypt(
      utf8.encode(message),
      secretKey: dc.SecretKey(
        hex.decode(symKey),
      ),
      nonce: usedIV,
    );

    return serialize(
      decodedType,
      b.concatenation(),
      usedIV,
      senderPublicKey: senderPublicKey != null
          ? hex.decode(senderPublicKey) as Uint8List
          : null,
    );
  }

  @override
  Future<String> decrypt(String symKey, String encoded) async {
    final chacha = dc.Chacha20.poly1305Aead();
    final dc.SecretKey secretKey = dc.SecretKey(
      hex.decode(symKey),
    );
    final EncodingParams encodedData = deserialize(encoded);
    final dc.SecretBox b = dc.SecretBox.fromConcatenation(
      encodedData.ivSealed,
      nonceLength: 12,
      macLength: 16,
    );
    List<int> data = await chacha.decrypt(b, secretKey: secretKey);
    return utf8.decode(data);
  }

  @override
  String serialize(
    int type,
    Uint8List sealed,
    Uint8List iv, {
    Uint8List? senderPublicKey,
  }) {
    List<int> l = [type];

    if (type == EncodeOptions.TYPE_1) {
      if (senderPublicKey == null) {
        throw const WalletConnectError(
          code: -1,
          message: 'Missing sender public key for type 1 envelope',
        );
      }

      l.addAll(senderPublicKey);
    }

    // l.addAll(iv);
    l.addAll(sealed);

    return base64Encode(l);
  }

  @override
  EncodingParams deserialize(String encoded) {
    final Uint8List bytes = base64Decode(encoded);
    final int type = bytes[0];

    int index = TYPE_LENGTH;
    Uint8List? senderPublicKey;
    if (type == EncodeOptions.TYPE_1) {
      senderPublicKey = bytes.sublist(
        index,
        index + KEY_LENGTH,
      );
      index += KEY_LENGTH;
    }
    Uint8List iv = bytes.sublist(index, index + IV_LENGTH);
    Uint8List ivSealed = bytes.sublist(index);
    index += IV_LENGTH;
    Uint8List sealed = bytes.sublist(index);

    return EncodingParams(
      type,
      sealed,
      iv,
      ivSealed,
      senderPublicKey: senderPublicKey,
    );
  }

  @override
  EncodingValidation validateDecoding(
    String encoded, {
    String? receiverPublicKey,
  }) {
    final EncodingParams deserialized = deserialize(encoded);
    final String? senderPublicKey = deserialized.senderPublicKey != null
        ? hex.encode(deserialized.senderPublicKey!)
        : null;
    return validateEncoding(
      type: deserialized.type,
      senderPublicKey: senderPublicKey,
      receiverPublicKey: receiverPublicKey,
    );
  }

  @override
  EncodingValidation validateEncoding({
    int? type,
    String? senderPublicKey,
    String? receiverPublicKey,
  }) {
    final int t = type ?? EncodeOptions.TYPE_0;
    if (t == EncodeOptions.TYPE_1) {
      if (senderPublicKey == null) {
        throw const WalletConnectError(
            code: -1, message: 'Missing sender public key');
      }
      if (receiverPublicKey == null) {
        throw const WalletConnectError(
            code: -1, message: 'Missing receiver public key');
      }
    }
    return EncodingValidation(
      t,
      senderPublicKey: senderPublicKey,
      receiverPublicKey: receiverPublicKey,
    );
  }

  @override
  bool isTypeOneEnvelope(
    EncodingValidation result,
  ) {
    return result.type == EncodeOptions.TYPE_1 &&
        result.senderPublicKey != null &&
        result.receiverPublicKey != null;
  }
}

import 'dart:typed_data';

import 'package:convert/convert.dart';

class CryptoKeyPair {
  final String privateKey;
  final String publicKey;

  const CryptoKeyPair(this.privateKey, this.publicKey);

  Uint8List getPrivateKeyBytes() {
    return Uint8List.fromList(hex.decode(privateKey));
  }

  Uint8List getPublicKeyBytes() {
    return Uint8List.fromList(hex.decode(publicKey));
  }
}

class EncryptParams {
  String message;
  String symKey;
  int? type;
  String? iv;
  String? senderPublicKey;

  EncryptParams(
    this.message,
    this.symKey, {
    this.type,
    this.iv,
    this.senderPublicKey,
  });
}

class EncodingParams {
  int type;
  Uint8List sealed;
  Uint8List iv;
  Uint8List ivSealed;
  Uint8List? senderPublicKey;

  EncodingParams(
    this.type,
    this.sealed,
    this.iv,
    this.ivSealed, {
    this.senderPublicKey,
  });
}

class EncodingValidation {
  int type;
  String? senderPublicKey;
  String? receiverPublicKey;

  EncodingValidation(
    this.type, {
    this.senderPublicKey,
    this.receiverPublicKey,
  });
}

class EncodeOptions {
  static const TYPE_0 = 0;
  static const TYPE_1 = 1;
  static const TYPE_2 = 2;

  int? type;
  String? senderPublicKey;
  String? receiverPublicKey;

  EncodeOptions({
    this.type,
    this.senderPublicKey,
    this.receiverPublicKey,
  });
}

class DecodeOptions {
  String? receiverPublicKey;

  DecodeOptions({
    this.receiverPublicKey,
  });
}

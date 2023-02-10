import 'dart:typed_data';

import 'package:wallet_connect_flutter_v2/apis/core/crypto/crypto_models.dart';

abstract class ICryptoUtils {
  CryptoKeyPair generateKeyPair();
  Uint8List randomBytes(int length);
  String generateRandomBytes32();
  Future<String> deriveSymKey(String privKeyA, String pubKeyB);
  String hashKey(String key);
  String hashMessage(String message);
  Future<String> encrypt(
    String message,
    String symKey, {
    int? type,
    String? iv,
    String? senderPublicKey,
  });
  Future<String> decrypt(String symKey, String encoded);
  String serialize(
    int type,
    Uint8List sealed,
    Uint8List iv, {
    Uint8List? senderPublicKey,
  });
  EncodingParams deserialize(String encoded);
  EncodingValidation validateDecoding(
    String encoded, {
    String? receiverPublicKey,
  });
  EncodingValidation validateEncoding({
    int? type,
    String? senderPublicKey,
    String? receiverPublicKey,
  });
  bool isTypeOneEnvelope(EncodingValidation result);
}

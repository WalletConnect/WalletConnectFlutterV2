// ignore_for_file: depend_on_referenced_packages, non_constant_identifier_names

import 'dart:typed_data';
import 'package:pointycastle/digests/sha512.dart';
import 'package:pointycastle/api.dart';
import 'package:pointycastle/macs/hmac.dart';
import 'package:pointycastle/digests/ripemd160.dart';
import 'package:pointycastle/digests/sha256.dart';

final ONE1 = Uint8List.fromList([1]);
final ZERO1 = Uint8List.fromList([0]);

Uint8List hash160(Uint8List buffer) {
  Uint8List tmp = SHA256Digest().process(buffer);
  return RIPEMD160Digest().process(tmp);
}

Uint8List hmacSHA512(Uint8List key, Uint8List data) {
  final tmp = HMac(SHA512Digest(), 128)..init(KeyParameter(key));
  return tmp.process(data);
}

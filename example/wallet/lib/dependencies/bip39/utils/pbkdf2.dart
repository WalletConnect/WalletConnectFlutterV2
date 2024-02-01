// ignore_for_file: depend_on_referenced_packages

import 'dart:convert';
import 'dart:typed_data';

import 'package:pointycastle/digests/sha512.dart';
import 'package:pointycastle/key_derivators/api.dart';
import 'package:pointycastle/key_derivators/pbkdf2.dart';
import 'package:pointycastle/macs/hmac.dart';

class PBKDF2 {
  final int blockLength;
  final int iterationCount;
  final int desiredKeyLength;
  final String saltPrefix = 'mnemonic';

  final PBKDF2KeyDerivator _derivator;

  PBKDF2({
    this.blockLength = 128,
    this.iterationCount = 2048,
    this.desiredKeyLength = 64,
  }) : _derivator = PBKDF2KeyDerivator(HMac(SHA512Digest(), blockLength));

  Uint8List process(String mnemonic, {passphrase = ''}) {
    final salt = Uint8List.fromList(utf8.encode(saltPrefix + passphrase));
    _derivator.reset();
    _derivator.init(Pbkdf2Parameters(salt, iterationCount, desiredKeyLength));
    return _derivator.process(Uint8List.fromList(mnemonic.codeUnits));
  }
}

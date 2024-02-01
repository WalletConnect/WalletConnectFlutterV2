// ignore_for_file: depend_on_referenced_packages

import 'dart:typed_data';
import 'package:bs58/bs58.dart';

class WIF {
  int version;
  Uint8List privateKey;
  bool compressed;
  WIF(
      {required this.version,
      required this.privateKey,
      required this.compressed});
}

WIF decodeRaw(Uint8List buffer, [int? version]) {
  if (version != null && buffer[0] != version) {
    throw ArgumentError('Invalid network version');
  }
  if (buffer.length == 33) {
    return WIF(
        version: buffer[0],
        privateKey: buffer.sublist(1, 33),
        compressed: false);
  }
  if (buffer.length != 34) {
    throw ArgumentError('Invalid WIF length');
  }
  if (buffer[33] != 0x01) {
    throw ArgumentError('Invalid compression flag');
  }
  return WIF(
      version: buffer[0], privateKey: buffer.sublist(1, 33), compressed: true);
}

Uint8List encodeRaw(int version, Uint8List privateKey, bool compressed) {
  if (privateKey.length != 32) {
    throw ArgumentError('Invalid privateKey length');
  }
  Uint8List result = Uint8List(compressed ? 34 : 33);
  ByteData bytes = result.buffer.asByteData();
  bytes.setUint8(0, version);
  result.setRange(1, 33, privateKey);
  if (compressed) {
    result[33] = 0x01;
  }
  return result;
}

WIF decode(String string, [int? version]) {
  return decodeRaw(base58.decode(string), version);
}

String encode(WIF wif) {
  return base58.encode(encodeRaw(wif.version, wif.privateKey, wif.compressed));
}

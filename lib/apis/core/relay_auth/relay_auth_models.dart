import 'dart:typed_data';

import 'package:convert/convert.dart';
import 'package:json_annotation/json_annotation.dart';

part 'relay_auth_models.g.dart';

class RelayAuthKeyPair {
  final Uint8List privateKeyBytes;
  final Uint8List publicKeyBytes;
  final String privateKey;
  final String publicKey;

  RelayAuthKeyPair(
    this.privateKeyBytes,
    this.publicKeyBytes,
  )   : privateKey = hex.encode(privateKeyBytes),
        publicKey = hex.encode(publicKeyBytes);

  RelayAuthKeyPair.fromStrings(
    this.privateKey,
    this.publicKey,
  )   : privateKeyBytes = Uint8List.fromList(hex.decode(privateKey)),
        publicKeyBytes = Uint8List.fromList(hex.decode(publicKey));
}

@JsonSerializable()
class JWTHeader {
  static const JWT_ALG = 'EdDSA';
  static const JWT_TYP = 'JWT';

  String alg;
  String typ;

  JWTHeader({
    this.alg = 'EdDSA',
    this.typ = 'JWT',
  });

  factory JWTHeader.fromJson(Map<String, dynamic> json) =>
      _$JWTHeaderFromJson(json);

  Map<String, dynamic> toJson() => _$JWTHeaderToJson(this);
}

@JsonSerializable()
class JWTPayload {
  String iss;
  String sub;
  String aud;
  int iat;
  int exp;

  JWTPayload(
    this.iss,
    this.sub,
    this.aud,
    this.iat,
    this.exp,
  );

  factory JWTPayload.fromJson(Map<String, dynamic> json) =>
      _$JWTPayloadFromJson(json);

  Map<String, dynamic> toJson() => _$JWTPayloadToJson(this);
}

class JWTData {
  JWTHeader header;
  JWTPayload payload;

  JWTData(this.header, this.payload);
}

class JWTSigned extends JWTData {
  List<int> signature;

  JWTSigned(
    this.signature,
    JWTPayload payload, {
    JWTHeader? header,
  }) : super(header ?? JWTHeader(), payload);
}

class JWTDecoded extends JWTSigned {
  List<int> data;

  JWTDecoded(
    this.data,
    List<int> signature,
    JWTPayload payload, {
    JWTHeader? header,
  }) : super(signature, payload, header: header);
}

class IssuerDecodeError {
  String received;
  String message;

  IssuerDecodeError(
    this.received,
    this.message,
  );
}

class VerifyJWTError {
  String jwt;
  String message;

  VerifyJWTError(
    this.jwt,
    this.message,
  );
}

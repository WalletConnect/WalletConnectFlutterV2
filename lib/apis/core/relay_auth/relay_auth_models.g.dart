// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'relay_auth_models.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

JWTHeader _$JWTHeaderFromJson(Map<String, dynamic> json) => JWTHeader(
      alg: json['alg'] as String? ?? 'EdDSA',
      typ: json['typ'] as String? ?? 'JWT',
    );

Map<String, dynamic> _$JWTHeaderToJson(JWTHeader instance) => <String, dynamic>{
      'alg': instance.alg,
      'typ': instance.typ,
    };

JWTPayload _$JWTPayloadFromJson(Map<String, dynamic> json) => JWTPayload(
      json['iss'] as String,
      json['sub'] as String,
      json['aud'] as String,
      (json['iat'] as num).toInt(),
      (json['exp'] as num).toInt(),
    );

Map<String, dynamic> _$JWTPayloadToJson(JWTPayload instance) =>
    <String, dynamic>{
      'iss': instance.iss,
      'sub': instance.sub,
      'aud': instance.aud,
      'iat': instance.iat,
      'exp': instance.exp,
    };

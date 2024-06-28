// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'common_auth_models.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$AuthPublicKeyImpl _$$AuthPublicKeyImplFromJson(Map<String, dynamic> json) =>
    _$AuthPublicKeyImpl(
      publicKey: json['publicKey'] as String,
    );

Map<String, dynamic> _$$AuthPublicKeyImplToJson(_$AuthPublicKeyImpl instance) =>
    <String, dynamic>{
      'publicKey': instance.publicKey,
    };

_$CacaoRequestPayloadImpl _$$CacaoRequestPayloadImplFromJson(
        Map<String, dynamic> json) =>
    _$CacaoRequestPayloadImpl(
      domain: json['domain'] as String,
      aud: json['aud'] as String,
      version: json['version'] as String,
      nonce: json['nonce'] as String,
      iat: json['iat'] as String,
      nbf: json['nbf'] as String?,
      exp: json['exp'] as String?,
      statement: json['statement'] as String?,
      requestId: json['requestId'] as String?,
      resources: (json['resources'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
    );

Map<String, dynamic> _$$CacaoRequestPayloadImplToJson(
    _$CacaoRequestPayloadImpl instance) {
  final val = <String, dynamic>{
    'domain': instance.domain,
    'aud': instance.aud,
    'version': instance.version,
    'nonce': instance.nonce,
    'iat': instance.iat,
  };

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('nbf', instance.nbf);
  writeNotNull('exp', instance.exp);
  writeNotNull('statement', instance.statement);
  writeNotNull('requestId', instance.requestId);
  writeNotNull('resources', instance.resources);
  return val;
}

_$CacaoPayloadImpl _$$CacaoPayloadImplFromJson(Map<String, dynamic> json) =>
    _$CacaoPayloadImpl(
      iss: json['iss'] as String,
      domain: json['domain'] as String,
      aud: json['aud'] as String,
      version: json['version'] as String,
      nonce: json['nonce'] as String,
      iat: json['iat'] as String,
      nbf: json['nbf'] as String?,
      exp: json['exp'] as String?,
      statement: json['statement'] as String?,
      requestId: json['requestId'] as String?,
      resources: (json['resources'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
    );

Map<String, dynamic> _$$CacaoPayloadImplToJson(_$CacaoPayloadImpl instance) {
  final val = <String, dynamic>{
    'iss': instance.iss,
    'domain': instance.domain,
    'aud': instance.aud,
    'version': instance.version,
    'nonce': instance.nonce,
    'iat': instance.iat,
  };

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('nbf', instance.nbf);
  writeNotNull('exp', instance.exp);
  writeNotNull('statement', instance.statement);
  writeNotNull('requestId', instance.requestId);
  writeNotNull('resources', instance.resources);
  return val;
}

_$CacaoHeaderImpl _$$CacaoHeaderImplFromJson(Map<String, dynamic> json) =>
    _$CacaoHeaderImpl(
      t: json['t'] as String? ?? 'eip4361',
    );

Map<String, dynamic> _$$CacaoHeaderImplToJson(_$CacaoHeaderImpl instance) =>
    <String, dynamic>{
      't': instance.t,
    };

_$CacaoSignatureImpl _$$CacaoSignatureImplFromJson(Map<String, dynamic> json) =>
    _$CacaoSignatureImpl(
      t: json['t'] as String,
      s: json['s'] as String,
      m: json['m'] as String?,
    );

Map<String, dynamic> _$$CacaoSignatureImplToJson(
    _$CacaoSignatureImpl instance) {
  final val = <String, dynamic>{
    't': instance.t,
    's': instance.s,
  };

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('m', instance.m);
  return val;
}

_$CacaoImpl _$$CacaoImplFromJson(Map<String, dynamic> json) => _$CacaoImpl(
      h: CacaoHeader.fromJson(json['h'] as Map<String, dynamic>),
      p: CacaoPayload.fromJson(json['p'] as Map<String, dynamic>),
      s: CacaoSignature.fromJson(json['s'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$$CacaoImplToJson(_$CacaoImpl instance) =>
    <String, dynamic>{
      'h': instance.h.toJson(),
      'p': instance.p.toJson(),
      's': instance.s.toJson(),
    };

_$StoredCacaoImpl _$$StoredCacaoImplFromJson(Map<String, dynamic> json) =>
    _$StoredCacaoImpl(
      id: json['id'] as int,
      pairingTopic: json['pairingTopic'] as String,
      h: CacaoHeader.fromJson(json['h'] as Map<String, dynamic>),
      p: CacaoPayload.fromJson(json['p'] as Map<String, dynamic>),
      s: CacaoSignature.fromJson(json['s'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$$StoredCacaoImplToJson(_$StoredCacaoImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'pairingTopic': instance.pairingTopic,
      'h': instance.h.toJson(),
      'p': instance.p.toJson(),
      's': instance.s.toJson(),
    };

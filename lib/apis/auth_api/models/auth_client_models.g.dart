// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'auth_client_models.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_AuthPublicKey _$$_AuthPublicKeyFromJson(Map<String, dynamic> json) =>
    _$_AuthPublicKey(
      publicKey: json['publicKey'] as String,
    );

Map<String, dynamic> _$$_AuthPublicKeyToJson(_$_AuthPublicKey instance) =>
    <String, dynamic>{
      'publicKey': instance.publicKey,
    };

_$_AuthPayloadParams _$$_AuthPayloadParamsFromJson(Map<String, dynamic> json) =>
    _$_AuthPayloadParams(
      type: json['type'] as String,
      chainId: json['chainId'] as String,
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

Map<String, dynamic> _$$_AuthPayloadParamsToJson(
    _$_AuthPayloadParams instance) {
  final val = <String, dynamic>{
    'type': instance.type,
    'chainId': instance.chainId,
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

_$_CacaoRequestPayload _$$_CacaoRequestPayloadFromJson(
        Map<String, dynamic> json) =>
    _$_CacaoRequestPayload(
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

Map<String, dynamic> _$$_CacaoRequestPayloadToJson(
    _$_CacaoRequestPayload instance) {
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

_$_CacaoPayload _$$_CacaoPayloadFromJson(Map<String, dynamic> json) =>
    _$_CacaoPayload(
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

Map<String, dynamic> _$$_CacaoPayloadToJson(_$_CacaoPayload instance) {
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

_$_CacaoHeader _$$_CacaoHeaderFromJson(Map<String, dynamic> json) =>
    _$_CacaoHeader(
      t: json['t'] as String? ?? 'eip4361',
    );

Map<String, dynamic> _$$_CacaoHeaderToJson(_$_CacaoHeader instance) =>
    <String, dynamic>{
      't': instance.t,
    };

_$_CacaoSignature _$$_CacaoSignatureFromJson(Map<String, dynamic> json) =>
    _$_CacaoSignature(
      t: json['t'] as String,
      s: json['s'] as String,
      m: json['m'] as String?,
    );

Map<String, dynamic> _$$_CacaoSignatureToJson(_$_CacaoSignature instance) {
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

_$_Cacao _$$_CacaoFromJson(Map<String, dynamic> json) => _$_Cacao(
      h: CacaoHeader.fromJson(json['h'] as Map<String, dynamic>),
      p: CacaoPayload.fromJson(json['p'] as Map<String, dynamic>),
      s: CacaoSignature.fromJson(json['s'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$$_CacaoToJson(_$_Cacao instance) => <String, dynamic>{
      'h': instance.h.toJson(),
      'p': instance.p.toJson(),
      's': instance.s.toJson(),
    };

_$_StoredCacao _$$_StoredCacaoFromJson(Map<String, dynamic> json) =>
    _$_StoredCacao(
      id: json['id'] as int,
      pairingTopic: json['pairingTopic'] as String,
      h: CacaoHeader.fromJson(json['h'] as Map<String, dynamic>),
      p: CacaoPayload.fromJson(json['p'] as Map<String, dynamic>),
      s: CacaoSignature.fromJson(json['s'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$$_StoredCacaoToJson(_$_StoredCacao instance) =>
    <String, dynamic>{
      'id': instance.id,
      'pairingTopic': instance.pairingTopic,
      'h': instance.h.toJson(),
      'p': instance.p.toJson(),
      's': instance.s.toJson(),
    };

_$_PendingAuthRequest _$$_PendingAuthRequestFromJson(
        Map<String, dynamic> json) =>
    _$_PendingAuthRequest(
      id: json['id'] as int,
      pairingTopic: json['pairingTopic'] as String,
      metadata:
          ConnectionMetadata.fromJson(json['metadata'] as Map<String, dynamic>),
      cacaoPayload: CacaoRequestPayload.fromJson(
          json['cacaoPayload'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$$_PendingAuthRequestToJson(
        _$_PendingAuthRequest instance) =>
    <String, dynamic>{
      'id': instance.id,
      'pairingTopic': instance.pairingTopic,
      'metadata': instance.metadata.toJson(),
      'cacaoPayload': instance.cacaoPayload.toJson(),
    };

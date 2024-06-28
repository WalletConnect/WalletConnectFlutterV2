// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'session_auth_models.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$SessionAuthRequestParamsImpl _$$SessionAuthRequestParamsImplFromJson(
        Map<String, dynamic> json) =>
    _$SessionAuthRequestParamsImpl(
      chains:
          (json['chains'] as List<dynamic>).map((e) => e as String).toList(),
      domain: json['domain'] as String,
      nonce: json['nonce'] as String,
      uri: json['uri'] as String,
      type: json['type'] == null
          ? null
          : CacaoHeader.fromJson(json['type'] as Map<String, dynamic>),
      nbf: json['nbf'] as String?,
      exp: json['exp'] as String?,
      statement: json['statement'] as String?,
      requestId: json['requestId'] as String?,
      resources: (json['resources'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      expiry: json['expiry'] as int?,
      methods: (json['methods'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const <String>[],
    );

Map<String, dynamic> _$$SessionAuthRequestParamsImplToJson(
    _$SessionAuthRequestParamsImpl instance) {
  final val = <String, dynamic>{
    'chains': instance.chains,
    'domain': instance.domain,
    'nonce': instance.nonce,
    'uri': instance.uri,
  };

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('type', instance.type?.toJson());
  writeNotNull('nbf', instance.nbf);
  writeNotNull('exp', instance.exp);
  writeNotNull('statement', instance.statement);
  writeNotNull('requestId', instance.requestId);
  writeNotNull('resources', instance.resources);
  writeNotNull('expiry', instance.expiry);
  writeNotNull('methods', instance.methods);
  return val;
}

_$SessionAuthPayloadImpl _$$SessionAuthPayloadImplFromJson(
        Map<String, dynamic> json) =>
    _$SessionAuthPayloadImpl(
      chains:
          (json['chains'] as List<dynamic>).map((e) => e as String).toList(),
      domain: json['domain'] as String,
      nonce: json['nonce'] as String,
      aud: json['aud'] as String,
      type: json['type'] as String,
      version: json['version'] as String,
      iat: json['iat'] as String,
      nbf: json['nbf'] as String?,
      exp: json['exp'] as String?,
      statement: json['statement'] as String?,
      requestId: json['requestId'] as String?,
      resources: (json['resources'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
    );

Map<String, dynamic> _$$SessionAuthPayloadImplToJson(
    _$SessionAuthPayloadImpl instance) {
  final val = <String, dynamic>{
    'chains': instance.chains,
    'domain': instance.domain,
    'nonce': instance.nonce,
    'aud': instance.aud,
    'type': instance.type,
    'version': instance.version,
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

_$PendingSessionAuthRequestImpl _$$PendingSessionAuthRequestImplFromJson(
        Map<String, dynamic> json) =>
    _$PendingSessionAuthRequestImpl(
      id: json['id'] as int,
      pairingTopic: json['pairingTopic'] as String,
      requester: ConnectionMetadata.fromJson(
          json['requester'] as Map<String, dynamic>),
      expiryTimestamp: json['expiryTimestamp'] as int,
      authPayload: CacaoRequestPayload.fromJson(
          json['authPayload'] as Map<String, dynamic>),
      verifyContext:
          VerifyContext.fromJson(json['verifyContext'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$$PendingSessionAuthRequestImplToJson(
        _$PendingSessionAuthRequestImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'pairingTopic': instance.pairingTopic,
      'requester': instance.requester.toJson(),
      'expiryTimestamp': instance.expiryTimestamp,
      'authPayload': instance.authPayload.toJson(),
      'verifyContext': instance.verifyContext.toJson(),
    };

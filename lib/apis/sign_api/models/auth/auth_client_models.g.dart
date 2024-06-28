// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'auth_client_models.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$AuthPayloadParamsImpl _$$AuthPayloadParamsImplFromJson(
        Map<String, dynamic> json) =>
    _$AuthPayloadParamsImpl(
      chainId: json['chainId'] as String,
      aud: json['aud'] as String,
      domain: json['domain'] as String,
      nonce: json['nonce'] as String,
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

Map<String, dynamic> _$$AuthPayloadParamsImplToJson(
    _$AuthPayloadParamsImpl instance) {
  final val = <String, dynamic>{
    'chainId': instance.chainId,
    'aud': instance.aud,
    'domain': instance.domain,
    'nonce': instance.nonce,
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

_$PendingAuthRequestImpl _$$PendingAuthRequestImplFromJson(
        Map<String, dynamic> json) =>
    _$PendingAuthRequestImpl(
      id: json['id'] as int,
      pairingTopic: json['pairingTopic'] as String,
      metadata:
          ConnectionMetadata.fromJson(json['metadata'] as Map<String, dynamic>),
      cacaoPayload: CacaoRequestPayload.fromJson(
          json['cacaoPayload'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$$PendingAuthRequestImplToJson(
        _$PendingAuthRequestImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'pairingTopic': instance.pairingTopic,
      'metadata': instance.metadata.toJson(),
      'cacaoPayload': instance.cacaoPayload.toJson(),
    };

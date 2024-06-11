// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ocauth_models.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$OCAPayloadParamsImpl _$$OCAPayloadParamsImplFromJson(
        Map<String, dynamic> json) =>
    _$OCAPayloadParamsImpl(
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

Map<String, dynamic> _$$OCAPayloadParamsImplToJson(
    _$OCAPayloadParamsImpl instance) {
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

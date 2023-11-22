// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'verify_context.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$VerifyContextImpl _$$VerifyContextImplFromJson(Map<String, dynamic> json) =>
    _$VerifyContextImpl(
      origin: json['origin'] as String,
      validation: $enumDecode(_$ValidationEnumMap, json['validation']),
      verifyUrl: json['verifyUrl'] as String,
      isScam: json['isScam'] as bool?,
    );

Map<String, dynamic> _$$VerifyContextImplToJson(_$VerifyContextImpl instance) =>
    <String, dynamic>{
      'origin': instance.origin,
      'validation': _$ValidationEnumMap[instance.validation]!,
      'verifyUrl': instance.verifyUrl,
      'isScam': instance.isScam,
    };

const _$ValidationEnumMap = {
  Validation.UNKNOWN: 'UNKNOWN',
  Validation.VALID: 'VALID',
  Validation.INVALID: 'INVALID',
  Validation.SCAM: 'SCAM',
};

_$AttestationResponseImpl _$$AttestationResponseImplFromJson(
        Map<String, dynamic> json) =>
    _$AttestationResponseImpl(
      origin: json['origin'] as String,
      attestationId: json['attestationId'] as String,
      isScam: json['isScam'] as bool?,
    );

Map<String, dynamic> _$$AttestationResponseImplToJson(
        _$AttestationResponseImpl instance) =>
    <String, dynamic>{
      'origin': instance.origin,
      'attestationId': instance.attestationId,
      'isScam': instance.isScam,
    };

// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'json_rpc_models.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$WcAuthRequestRequestImpl _$$WcAuthRequestRequestImplFromJson(
        Map<String, dynamic> json) =>
    _$WcAuthRequestRequestImpl(
      payloadParams: AuthPayloadParams.fromJson(
          json['payloadParams'] as Map<String, dynamic>),
      requester: ConnectionMetadata.fromJson(
          json['requester'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$$WcAuthRequestRequestImplToJson(
        _$WcAuthRequestRequestImpl instance) =>
    <String, dynamic>{
      'payloadParams': instance.payloadParams.toJson(),
      'requester': instance.requester.toJson(),
    };

_$WcAuthRequestResultImpl _$$WcAuthRequestResultImplFromJson(
        Map<String, dynamic> json) =>
    _$WcAuthRequestResultImpl(
      cacao: Cacao.fromJson(json['cacao'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$$WcAuthRequestResultImplToJson(
        _$WcAuthRequestResultImpl instance) =>
    <String, dynamic>{
      'cacao': instance.cacao.toJson(),
    };

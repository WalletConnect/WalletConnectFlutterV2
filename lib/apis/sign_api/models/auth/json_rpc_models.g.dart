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

_$WcOCARequestParamsImpl _$$WcOCARequestParamsImplFromJson(
        Map<String, dynamic> json) =>
    _$WcOCARequestParamsImpl(
      authPayload: OCAPayloadParams.fromJson(
          json['authPayload'] as Map<String, dynamic>),
      requester: ConnectionMetadata.fromJson(
          json['requester'] as Map<String, dynamic>),
      expiryTimestamp: json['expiryTimestamp'] as int,
    );

Map<String, dynamic> _$$WcOCARequestParamsImplToJson(
        _$WcOCARequestParamsImpl instance) =>
    <String, dynamic>{
      'authPayload': instance.authPayload.toJson(),
      'requester': instance.requester.toJson(),
      'expiryTimestamp': instance.expiryTimestamp,
    };

_$WcOCARequestResultImpl _$$WcOCARequestResultImplFromJson(
        Map<String, dynamic> json) =>
    _$WcOCARequestResultImpl(
      cacaos: (json['cacaos'] as List<dynamic>)
          .map((e) => Cacao.fromJson(e as Map<String, dynamic>))
          .toList(),
      responder: ConnectionMetadata.fromJson(
          json['responder'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$$WcOCARequestResultImplToJson(
        _$WcOCARequestResultImpl instance) =>
    <String, dynamic>{
      'cacaos': instance.cacaos.map((e) => e.toJson()).toList(),
      'responder': instance.responder.toJson(),
    };

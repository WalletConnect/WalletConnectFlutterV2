// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'json_rpc_models.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_WcAuthRequestRequest _$$_WcAuthRequestRequestFromJson(
        Map<String, dynamic> json) =>
    _$_WcAuthRequestRequest(
      payloadParams: AuthPayloadParams.fromJson(
          json['payloadParams'] as Map<String, dynamic>),
      requester: ConnectionMetadata.fromJson(
          json['requester'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$$_WcAuthRequestRequestToJson(
        _$_WcAuthRequestRequest instance) =>
    <String, dynamic>{
      'payloadParams': instance.payloadParams.toJson(),
      'requester': instance.requester.toJson(),
    };

_$_WcAuthRequestResult _$$_WcAuthRequestResultFromJson(
        Map<String, dynamic> json) =>
    _$_WcAuthRequestResult(
      cacao: Cacao.fromJson(json['cacao'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$$_WcAuthRequestResultToJson(
        _$_WcAuthRequestResult instance) =>
    <String, dynamic>{
      'cacao': instance.cacao.toJson(),
    };

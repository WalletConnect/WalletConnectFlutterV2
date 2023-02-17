// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'json_rpc_models.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

WcAuthRequestRequest _$WcAuthRequestRequestFromJson(
        Map<String, dynamic> json) =>
    WcAuthRequestRequest(
      payloadParams: AuthPayloadParams.fromJson(
          json['payloadParams'] as Map<String, dynamic>),
      requester: ConnectionMetadata.fromJson(
          json['requester'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$WcAuthRequestRequestToJson(
        WcAuthRequestRequest instance) =>
    <String, dynamic>{
      'payloadParams': instance.payloadParams,
      'requester': instance.requester,
    };

WcAuthRequestResult _$WcAuthRequestResultFromJson(Map<String, dynamic> json) =>
    WcAuthRequestResult(
      cacao: Cacao.fromJson(json['cacao'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$WcAuthRequestResultToJson(
        WcAuthRequestResult instance) =>
    <String, dynamic>{
      'cacao': instance.cacao,
    };

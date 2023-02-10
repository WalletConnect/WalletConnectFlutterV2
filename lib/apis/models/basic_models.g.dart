// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'basic_models.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

WCError _$WCErrorFromJson(Map<String, dynamic> json) => WCError(
      code: json['code'] as int,
      message: json['message'] as String,
    );

Map<String, dynamic> _$WCErrorToJson(WCError instance) => <String, dynamic>{
      'code': instance.code,
      'message': instance.message,
    };

WCErrorResponse _$WCErrorResponseFromJson(Map<String, dynamic> json) =>
    WCErrorResponse(
      code: json['code'] as int,
      message: json['message'] as String,
      data: json['data'] as String?,
    );

Map<String, dynamic> _$WCErrorResponseToJson(WCErrorResponse instance) =>
    <String, dynamic>{
      'code': instance.code,
      'message': instance.message,
      'data': instance.data,
    };

ConnectionMetadata _$ConnectionMetadataFromJson(Map<String, dynamic> json) =>
    ConnectionMetadata(
      publicKey: json['publicKey'] as String,
      metadata:
          PairingMetadata.fromJson(json['metadata'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$ConnectionMetadataToJson(ConnectionMetadata instance) =>
    <String, dynamic>{
      'publicKey': instance.publicKey,
      'metadata': instance.metadata,
    };

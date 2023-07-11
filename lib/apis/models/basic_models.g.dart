// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'basic_models.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_WalletConnectError _$$_WalletConnectErrorFromJson(
        Map<String, dynamic> json) =>
    _$_WalletConnectError(
      code: json['code'] as int,
      message: json['message'] as String,
      data: json['data'] as String?,
    );

Map<String, dynamic> _$$_WalletConnectErrorToJson(
        _$_WalletConnectError instance) =>
    <String, dynamic>{
      'code': instance.code,
      'message': instance.message,
      'data': instance.data,
    };

_$_ConnectionMetadata _$$_ConnectionMetadataFromJson(
        Map<String, dynamic> json) =>
    _$_ConnectionMetadata(
      publicKey: json['publicKey'] as String,
      metadata:
          PairingMetadata.fromJson(json['metadata'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$$_ConnectionMetadataToJson(
        _$_ConnectionMetadata instance) =>
    <String, dynamic>{
      'publicKey': instance.publicKey,
      'metadata': instance.metadata.toJson(),
    };

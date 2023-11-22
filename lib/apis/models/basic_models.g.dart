// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'basic_models.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$WalletConnectErrorImpl _$$WalletConnectErrorImplFromJson(
        Map<String, dynamic> json) =>
    _$WalletConnectErrorImpl(
      code: json['code'] as int,
      message: json['message'] as String,
      data: json['data'] as String?,
    );

Map<String, dynamic> _$$WalletConnectErrorImplToJson(
        _$WalletConnectErrorImpl instance) =>
    <String, dynamic>{
      'code': instance.code,
      'message': instance.message,
      'data': instance.data,
    };

_$ConnectionMetadataImpl _$$ConnectionMetadataImplFromJson(
        Map<String, dynamic> json) =>
    _$ConnectionMetadataImpl(
      publicKey: json['publicKey'] as String,
      metadata:
          PairingMetadata.fromJson(json['metadata'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$$ConnectionMetadataImplToJson(
        _$ConnectionMetadataImpl instance) =>
    <String, dynamic>{
      'publicKey': instance.publicKey,
      'metadata': instance.metadata.toJson(),
    };

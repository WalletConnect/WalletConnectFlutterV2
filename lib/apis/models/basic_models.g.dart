// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'basic_models.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

WalletConnectError _$WalletConnectErrorFromJson(Map<String, dynamic> json) =>
    WalletConnectError(
      code: json['code'] as int,
      message: json['message'] as String,
      data: json['data'] as String?,
    );

Map<String, dynamic> _$WalletConnectErrorToJson(WalletConnectError instance) {
  final val = <String, dynamic>{
    'code': instance.code,
    'message': instance.message,
  };

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('data', instance.data);
  return val;
}

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

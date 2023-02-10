// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'relay_client_models.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Relay _$RelayFromJson(Map<String, dynamic> json) => Relay(
      json['protocol'] as String,
      data: json['data'] as String?,
    );

Map<String, dynamic> _$RelayToJson(Relay instance) => <String, dynamic>{
      'protocol': instance.protocol,
      'data': instance.data,
    };

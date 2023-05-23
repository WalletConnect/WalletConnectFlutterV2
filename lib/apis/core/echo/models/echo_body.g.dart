// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'echo_body.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

EchoBody _$EchoBodyFromJson(Map<String, dynamic> json) => EchoBody(
      clientId: json['client_id'] as String,
      token: json['token'] as String,
      type: json['type'] as String? ?? 'fcm',
    );

Map<String, dynamic> _$EchoBodyToJson(EchoBody instance) => <String, dynamic>{
      'client_id': instance.clientId,
      'token': instance.token,
      'type': instance.type,
    };

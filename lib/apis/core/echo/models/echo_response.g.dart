// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'echo_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

EchoResponse _$EchoResponseFromJson(Map<String, dynamic> json) => EchoResponse(
      errors: (json['errors'] as List<dynamic>?)
          ?.map((e) => ResponseError.fromJson(e as Map<String, dynamic>))
          .toList(),
      fields: (json['fields'] as List<dynamic>?)
          ?.map((e) => Field.fromJson(e as Map<String, dynamic>))
          .toList(),
      status: json['status'] as String,
    );

Map<String, dynamic> _$EchoResponseToJson(EchoResponse instance) =>
    <String, dynamic>{
      'errors': instance.errors?.map((e) => e.toJson()).toList(),
      'fields': instance.fields?.map((e) => e.toJson()).toList(),
      'status': instance.status,
    };

ResponseError _$ResponseErrorFromJson(Map<String, dynamic> json) =>
    ResponseError(
      message: json['message'] as String,
      name: json['name'] as String,
    );

Map<String, dynamic> _$ResponseErrorToJson(ResponseError instance) =>
    <String, dynamic>{
      'message': instance.message,
      'name': instance.name,
    };

Field _$FieldFromJson(Map<String, dynamic> json) => Field(
      description: json['description'] as String,
      field: json['field'] as String,
      location: json['location'] as String,
    );

Map<String, dynamic> _$FieldToJson(Field instance) => <String, dynamic>{
      'description': instance.description,
      'field': instance.field,
      'location': instance.location,
    };

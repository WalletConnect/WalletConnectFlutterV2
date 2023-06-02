import 'package:json_annotation/json_annotation.dart';

part 'echo_response.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class EchoResponse {
  final List<ResponseError>? errors;
  final List<Field>? fields;
  final String status;

  EchoResponse({
    this.errors,
    this.fields,
    required this.status,
  });

  factory EchoResponse.fromJson(Map<String, dynamic> json) =>
      _$EchoResponseFromJson(json);

  Map<String, dynamic> toJson() => _$EchoResponseToJson(this);
}

@JsonSerializable(fieldRename: FieldRename.snake)
class ResponseError {
  final String message;
  final String name;

  ResponseError({required this.message, required this.name});

  factory ResponseError.fromJson(Map<String, dynamic> json) =>
      _$ResponseErrorFromJson(json);

  Map<String, dynamic> toJson() => _$ResponseErrorToJson(this);
}

@JsonSerializable(fieldRename: FieldRename.snake)
class Field {
  final String description;
  final String field;
  final String location;

  Field({
    required this.description,
    required this.field,
    required this.location,
  });

  factory Field.fromJson(Map<String, dynamic> json) => _$FieldFromJson(json);

  Map<String, dynamic> toJson() => _$FieldToJson(this);
}

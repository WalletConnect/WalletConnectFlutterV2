import 'package:json_annotation/json_annotation.dart';

part 'echo_body.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class EchoBody {
  final String clientId;
  final String token;
  final String type;

  EchoBody({
    required this.clientId,
    required this.token,
    this.type = 'fcm',
  });

  factory EchoBody.fromJson(Map<String, dynamic> json) =>
      _$EchoBodyFromJson(json);

  Map<String, dynamic> toJson() => _$EchoBodyToJson(this);
}

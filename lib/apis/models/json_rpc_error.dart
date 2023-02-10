import 'package:json_annotation/json_annotation.dart';

part 'json_rpc_error.g.dart';

@JsonSerializable()
class JsonRpcError {
  final int code;
  final String message;

  JsonRpcError({
    required this.code,
    required this.message,
  });

  factory JsonRpcError.serverError(String message) => JsonRpcError(code: -32000, message: message);
  factory JsonRpcError.invalidParams(String message) => JsonRpcError(code: -32602, message: message);
  factory JsonRpcError.invalidRequest(String message) => JsonRpcError(code: -32600, message: message);
  factory JsonRpcError.parseError(String message) => JsonRpcError(code: -32700, message: message);
  factory JsonRpcError.methodNotFound(String message) => JsonRpcError(code: -32601, message: message);

  factory JsonRpcError.fromJson(Map<String, dynamic> json) => _$JsonRpcErrorFromJson(json);
  Map<String, dynamic> toJson() => _$JsonRpcErrorToJson(this);

  @override
  String toString() => 'JsonRpcError(code: $code, message: $message)';
}

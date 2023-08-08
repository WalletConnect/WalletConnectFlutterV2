import 'package:freezed_annotation/freezed_annotation.dart';

part 'json_rpc_error.g.dart';
part 'json_rpc_error.freezed.dart';

@freezed
class JsonRpcError with _$JsonRpcError {
  @JsonSerializable(includeIfNull: false)
  const factory JsonRpcError({
    int? code,
    String? message,
  }) = _JsonRpcError;

  factory JsonRpcError.serverError(String message) =>
      JsonRpcError(code: -32000, message: message);
  factory JsonRpcError.invalidParams(String message) =>
      JsonRpcError(code: -32602, message: message);
  factory JsonRpcError.invalidRequest(String message) =>
      JsonRpcError(code: -32600, message: message);
  factory JsonRpcError.parseError(String message) =>
      JsonRpcError(code: -32700, message: message);
  factory JsonRpcError.methodNotFound(String message) =>
      JsonRpcError(code: -32601, message: message);

  factory JsonRpcError.fromJson(Map<String, dynamic> json) =>
      _$JsonRpcErrorFromJson(json);
}

import 'package:json_annotation/json_annotation.dart';
import 'package:walletconnect_flutter_v2/apis/models/json_rpc_error.dart';

part 'json_rpc_response.g.dart';

@JsonSerializable(genericArgumentFactories: true)
class JsonRpcResponse<T> {
  final int id;
  final String jsonrpc;
  final JsonRpcError? error;
  final T? result;

  JsonRpcResponse({
    required this.id,
    this.jsonrpc = '2.0',
    this.error,
    this.result,
  });

  factory JsonRpcResponse.fromJson(Map<String, dynamic> json) =>
      _$JsonRpcResponseFromJson(json, (object) => object as T);
  Map<String, dynamic> toJson() => _$JsonRpcResponseToJson(this, (t) => t);

  @override
  String toString() =>
      'JsonRpcResponse(id: $id, jsonrpc: $jsonrpc, result: $result, error: $error)';
}

import 'package:json_annotation/json_annotation.dart';

part 'json_rpc_response.g.dart';

@JsonSerializable(genericArgumentFactories: true)
class JsonRpcResponse<T> {
  final int id;
  final String jsonrpc;
  final T result;

  JsonRpcResponse({
    required this.id,
    this.jsonrpc = '2.0',
    required this.result,
  });

  factory JsonRpcResponse.fromJson(Map<String, dynamic> json) =>
      _$JsonRpcResponseFromJson(json, (object) => object as T);
  Map<String, dynamic> toJson() => _$JsonRpcResponseToJson(this, (t) => t);

  @override
  String toString() => 'JsonRpcResponse(id: $id, jsonrpc: $jsonrpc, result: $result)';
}

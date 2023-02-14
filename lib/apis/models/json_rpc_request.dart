import 'package:json_annotation/json_annotation.dart';

part 'json_rpc_request.g.dart';

@JsonSerializable()
class JsonRpcRequest {
  final int id;
  final String jsonrpc;
  final String method;
  final dynamic params;

  JsonRpcRequest({
    required this.id,
    this.jsonrpc = '2.0',
    required this.method,
    this.params,
  });

  factory JsonRpcRequest.fromJson(Map<String, dynamic> json) =>
      _$JsonRpcRequestFromJson(json);
  Map<String, dynamic> toJson() => _$JsonRpcRequestToJson(this);

  @override
  String toString() =>
      'JsonRpcRequest(id: $id, jsonrpc: $jsonrpc, method: $method, params: $params)';
}

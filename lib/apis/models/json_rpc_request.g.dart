// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'json_rpc_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_JsonRpcRequest _$$_JsonRpcRequestFromJson(Map<String, dynamic> json) =>
    _$_JsonRpcRequest(
      id: json['id'] as int,
      jsonrpc: json['jsonrpc'] as String? ?? '2.0',
      method: json['method'] as String,
      params: json['params'],
    );

Map<String, dynamic> _$$_JsonRpcRequestToJson(_$_JsonRpcRequest instance) =>
    <String, dynamic>{
      'id': instance.id,
      'jsonrpc': instance.jsonrpc,
      'method': instance.method,
      'params': instance.params,
    };

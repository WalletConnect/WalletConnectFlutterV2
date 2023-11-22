// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'json_rpc_error.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$JsonRpcErrorImpl _$$JsonRpcErrorImplFromJson(Map<String, dynamic> json) =>
    _$JsonRpcErrorImpl(
      code: json['code'] as int?,
      message: json['message'] as String?,
    );

Map<String, dynamic> _$$JsonRpcErrorImplToJson(_$JsonRpcErrorImpl instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('code', instance.code);
  writeNotNull('message', instance.message);
  return val;
}

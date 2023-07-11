import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:walletconnect_flutter_v2/apis/models/json_rpc_error.dart';

part 'json_rpc_response.g.dart';
part 'json_rpc_response.freezed.dart';

@Freezed(genericArgumentFactories: true)
class JsonRpcResponse<T> with _$JsonRpcResponse<T> {
  // @JsonSerializable(genericArgumentFactories: true)
  const factory JsonRpcResponse({
    required int id,
    @Default('2.0') String jsonrpc,
    JsonRpcError? error,
    T? result,
  }) = _JsonRpcResponse<T>;

  factory JsonRpcResponse.fromJson(Map<String, dynamic> json) =>
      _$JsonRpcResponseFromJson(json, (object) => object as T);
}

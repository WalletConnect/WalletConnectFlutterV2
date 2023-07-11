// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'json_rpc_request.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

JsonRpcRequest _$JsonRpcRequestFromJson(Map<String, dynamic> json) {
  return _JsonRpcRequest.fromJson(json);
}

/// @nodoc
mixin _$JsonRpcRequest {
  int get id => throw _privateConstructorUsedError;
  String get jsonrpc => throw _privateConstructorUsedError;
  String get method => throw _privateConstructorUsedError;
  dynamic get params => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $JsonRpcRequestCopyWith<JsonRpcRequest> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $JsonRpcRequestCopyWith<$Res> {
  factory $JsonRpcRequestCopyWith(
          JsonRpcRequest value, $Res Function(JsonRpcRequest) then) =
      _$JsonRpcRequestCopyWithImpl<$Res, JsonRpcRequest>;
  @useResult
  $Res call({int id, String jsonrpc, String method, dynamic params});
}

/// @nodoc
class _$JsonRpcRequestCopyWithImpl<$Res, $Val extends JsonRpcRequest>
    implements $JsonRpcRequestCopyWith<$Res> {
  _$JsonRpcRequestCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? jsonrpc = null,
    Object? method = null,
    Object? params = freezed,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      jsonrpc: null == jsonrpc
          ? _value.jsonrpc
          : jsonrpc // ignore: cast_nullable_to_non_nullable
              as String,
      method: null == method
          ? _value.method
          : method // ignore: cast_nullable_to_non_nullable
              as String,
      params: freezed == params
          ? _value.params
          : params // ignore: cast_nullable_to_non_nullable
              as dynamic,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_JsonRpcRequestCopyWith<$Res>
    implements $JsonRpcRequestCopyWith<$Res> {
  factory _$$_JsonRpcRequestCopyWith(
          _$_JsonRpcRequest value, $Res Function(_$_JsonRpcRequest) then) =
      __$$_JsonRpcRequestCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({int id, String jsonrpc, String method, dynamic params});
}

/// @nodoc
class __$$_JsonRpcRequestCopyWithImpl<$Res>
    extends _$JsonRpcRequestCopyWithImpl<$Res, _$_JsonRpcRequest>
    implements _$$_JsonRpcRequestCopyWith<$Res> {
  __$$_JsonRpcRequestCopyWithImpl(
      _$_JsonRpcRequest _value, $Res Function(_$_JsonRpcRequest) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? jsonrpc = null,
    Object? method = null,
    Object? params = freezed,
  }) {
    return _then(_$_JsonRpcRequest(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      jsonrpc: null == jsonrpc
          ? _value.jsonrpc
          : jsonrpc // ignore: cast_nullable_to_non_nullable
              as String,
      method: null == method
          ? _value.method
          : method // ignore: cast_nullable_to_non_nullable
              as String,
      params: freezed == params
          ? _value.params
          : params // ignore: cast_nullable_to_non_nullable
              as dynamic,
    ));
  }
}

/// @nodoc

@JsonSerializable()
class _$_JsonRpcRequest implements _JsonRpcRequest {
  const _$_JsonRpcRequest(
      {required this.id,
      this.jsonrpc = '2.0',
      required this.method,
      this.params});

  factory _$_JsonRpcRequest.fromJson(Map<String, dynamic> json) =>
      _$$_JsonRpcRequestFromJson(json);

  @override
  final int id;
  @override
  @JsonKey()
  final String jsonrpc;
  @override
  final String method;
  @override
  final dynamic params;

  @override
  String toString() {
    return 'JsonRpcRequest(id: $id, jsonrpc: $jsonrpc, method: $method, params: $params)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_JsonRpcRequest &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.jsonrpc, jsonrpc) || other.jsonrpc == jsonrpc) &&
            (identical(other.method, method) || other.method == method) &&
            const DeepCollectionEquality().equals(other.params, params));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, id, jsonrpc, method,
      const DeepCollectionEquality().hash(params));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_JsonRpcRequestCopyWith<_$_JsonRpcRequest> get copyWith =>
      __$$_JsonRpcRequestCopyWithImpl<_$_JsonRpcRequest>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_JsonRpcRequestToJson(
      this,
    );
  }
}

abstract class _JsonRpcRequest implements JsonRpcRequest {
  const factory _JsonRpcRequest(
      {required final int id,
      final String jsonrpc,
      required final String method,
      final dynamic params}) = _$_JsonRpcRequest;

  factory _JsonRpcRequest.fromJson(Map<String, dynamic> json) =
      _$_JsonRpcRequest.fromJson;

  @override
  int get id;
  @override
  String get jsonrpc;
  @override
  String get method;
  @override
  dynamic get params;
  @override
  @JsonKey(ignore: true)
  _$$_JsonRpcRequestCopyWith<_$_JsonRpcRequest> get copyWith =>
      throw _privateConstructorUsedError;
}

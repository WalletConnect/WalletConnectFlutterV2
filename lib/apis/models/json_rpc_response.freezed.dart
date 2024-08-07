// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'json_rpc_response.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

JsonRpcResponse<T> _$JsonRpcResponseFromJson<T>(
    Map<String, dynamic> json, T Function(Object?) fromJsonT) {
  return _JsonRpcResponse<T>.fromJson(json, fromJsonT);
}

/// @nodoc
mixin _$JsonRpcResponse<T> {
  int get id => throw _privateConstructorUsedError;
  String get jsonrpc => throw _privateConstructorUsedError;
  JsonRpcError? get error => throw _privateConstructorUsedError;
  T? get result => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson(Object? Function(T) toJsonT) =>
      throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $JsonRpcResponseCopyWith<T, JsonRpcResponse<T>> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $JsonRpcResponseCopyWith<T, $Res> {
  factory $JsonRpcResponseCopyWith(
          JsonRpcResponse<T> value, $Res Function(JsonRpcResponse<T>) then) =
      _$JsonRpcResponseCopyWithImpl<T, $Res, JsonRpcResponse<T>>;
  @useResult
  $Res call({int id, String jsonrpc, JsonRpcError? error, T? result});

  $JsonRpcErrorCopyWith<$Res>? get error;
}

/// @nodoc
class _$JsonRpcResponseCopyWithImpl<T, $Res, $Val extends JsonRpcResponse<T>>
    implements $JsonRpcResponseCopyWith<T, $Res> {
  _$JsonRpcResponseCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? jsonrpc = null,
    Object? error = freezed,
    Object? result = freezed,
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
      error: freezed == error
          ? _value.error
          : error // ignore: cast_nullable_to_non_nullable
              as JsonRpcError?,
      result: freezed == result
          ? _value.result
          : result // ignore: cast_nullable_to_non_nullable
              as T?,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $JsonRpcErrorCopyWith<$Res>? get error {
    if (_value.error == null) {
      return null;
    }

    return $JsonRpcErrorCopyWith<$Res>(_value.error!, (value) {
      return _then(_value.copyWith(error: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$JsonRpcResponseImplCopyWith<T, $Res>
    implements $JsonRpcResponseCopyWith<T, $Res> {
  factory _$$JsonRpcResponseImplCopyWith(_$JsonRpcResponseImpl<T> value,
          $Res Function(_$JsonRpcResponseImpl<T>) then) =
      __$$JsonRpcResponseImplCopyWithImpl<T, $Res>;
  @override
  @useResult
  $Res call({int id, String jsonrpc, JsonRpcError? error, T? result});

  @override
  $JsonRpcErrorCopyWith<$Res>? get error;
}

/// @nodoc
class __$$JsonRpcResponseImplCopyWithImpl<T, $Res>
    extends _$JsonRpcResponseCopyWithImpl<T, $Res, _$JsonRpcResponseImpl<T>>
    implements _$$JsonRpcResponseImplCopyWith<T, $Res> {
  __$$JsonRpcResponseImplCopyWithImpl(_$JsonRpcResponseImpl<T> _value,
      $Res Function(_$JsonRpcResponseImpl<T>) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? jsonrpc = null,
    Object? error = freezed,
    Object? result = freezed,
  }) {
    return _then(_$JsonRpcResponseImpl<T>(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      jsonrpc: null == jsonrpc
          ? _value.jsonrpc
          : jsonrpc // ignore: cast_nullable_to_non_nullable
              as String,
      error: freezed == error
          ? _value.error
          : error // ignore: cast_nullable_to_non_nullable
              as JsonRpcError?,
      result: freezed == result
          ? _value.result
          : result // ignore: cast_nullable_to_non_nullable
              as T?,
    ));
  }
}

/// @nodoc
@JsonSerializable(genericArgumentFactories: true)
class _$JsonRpcResponseImpl<T> implements _JsonRpcResponse<T> {
  const _$JsonRpcResponseImpl(
      {required this.id, this.jsonrpc = '2.0', this.error, this.result});

  factory _$JsonRpcResponseImpl.fromJson(
          Map<String, dynamic> json, T Function(Object?) fromJsonT) =>
      _$$JsonRpcResponseImplFromJson(json, fromJsonT);

  @override
  final int id;
  @override
  @JsonKey()
  final String jsonrpc;
  @override
  final JsonRpcError? error;
  @override
  final T? result;

  @override
  String toString() {
    return 'JsonRpcResponse<$T>(id: $id, jsonrpc: $jsonrpc, error: $error, result: $result)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$JsonRpcResponseImpl<T> &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.jsonrpc, jsonrpc) || other.jsonrpc == jsonrpc) &&
            (identical(other.error, error) || other.error == error) &&
            const DeepCollectionEquality().equals(other.result, result));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, id, jsonrpc, error,
      const DeepCollectionEquality().hash(result));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$JsonRpcResponseImplCopyWith<T, _$JsonRpcResponseImpl<T>> get copyWith =>
      __$$JsonRpcResponseImplCopyWithImpl<T, _$JsonRpcResponseImpl<T>>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson(Object? Function(T) toJsonT) {
    return _$$JsonRpcResponseImplToJson<T>(this, toJsonT);
  }
}

abstract class _JsonRpcResponse<T> implements JsonRpcResponse<T> {
  const factory _JsonRpcResponse(
      {required final int id,
      final String jsonrpc,
      final JsonRpcError? error,
      final T? result}) = _$JsonRpcResponseImpl<T>;

  factory _JsonRpcResponse.fromJson(
          Map<String, dynamic> json, T Function(Object?) fromJsonT) =
      _$JsonRpcResponseImpl<T>.fromJson;

  @override
  int get id;
  @override
  String get jsonrpc;
  @override
  JsonRpcError? get error;
  @override
  T? get result;
  @override
  @JsonKey(ignore: true)
  _$$JsonRpcResponseImplCopyWith<T, _$JsonRpcResponseImpl<T>> get copyWith =>
      throw _privateConstructorUsedError;
}

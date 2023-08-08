// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'json_rpc_error.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

JsonRpcError _$JsonRpcErrorFromJson(Map<String, dynamic> json) {
  return _JsonRpcError.fromJson(json);
}

/// @nodoc
mixin _$JsonRpcError {
  int? get code => throw _privateConstructorUsedError;
  String? get message => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $JsonRpcErrorCopyWith<JsonRpcError> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $JsonRpcErrorCopyWith<$Res> {
  factory $JsonRpcErrorCopyWith(
          JsonRpcError value, $Res Function(JsonRpcError) then) =
      _$JsonRpcErrorCopyWithImpl<$Res, JsonRpcError>;
  @useResult
  $Res call({int? code, String? message});
}

/// @nodoc
class _$JsonRpcErrorCopyWithImpl<$Res, $Val extends JsonRpcError>
    implements $JsonRpcErrorCopyWith<$Res> {
  _$JsonRpcErrorCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? code = freezed,
    Object? message = freezed,
  }) {
    return _then(_value.copyWith(
      code: freezed == code
          ? _value.code
          : code // ignore: cast_nullable_to_non_nullable
              as int?,
      message: freezed == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_JsonRpcErrorCopyWith<$Res>
    implements $JsonRpcErrorCopyWith<$Res> {
  factory _$$_JsonRpcErrorCopyWith(
          _$_JsonRpcError value, $Res Function(_$_JsonRpcError) then) =
      __$$_JsonRpcErrorCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({int? code, String? message});
}

/// @nodoc
class __$$_JsonRpcErrorCopyWithImpl<$Res>
    extends _$JsonRpcErrorCopyWithImpl<$Res, _$_JsonRpcError>
    implements _$$_JsonRpcErrorCopyWith<$Res> {
  __$$_JsonRpcErrorCopyWithImpl(
      _$_JsonRpcError _value, $Res Function(_$_JsonRpcError) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? code = freezed,
    Object? message = freezed,
  }) {
    return _then(_$_JsonRpcError(
      code: freezed == code
          ? _value.code
          : code // ignore: cast_nullable_to_non_nullable
              as int?,
      message: freezed == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc

@JsonSerializable(includeIfNull: false)
class _$_JsonRpcError implements _JsonRpcError {
  const _$_JsonRpcError({this.code, this.message});

  factory _$_JsonRpcError.fromJson(Map<String, dynamic> json) =>
      _$$_JsonRpcErrorFromJson(json);

  @override
  final int? code;
  @override
  final String? message;

  @override
  String toString() {
    return 'JsonRpcError(code: $code, message: $message)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_JsonRpcError &&
            (identical(other.code, code) || other.code == code) &&
            (identical(other.message, message) || other.message == message));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, code, message);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_JsonRpcErrorCopyWith<_$_JsonRpcError> get copyWith =>
      __$$_JsonRpcErrorCopyWithImpl<_$_JsonRpcError>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_JsonRpcErrorToJson(
      this,
    );
  }
}

abstract class _JsonRpcError implements JsonRpcError {
  const factory _JsonRpcError({final int? code, final String? message}) =
      _$_JsonRpcError;

  factory _JsonRpcError.fromJson(Map<String, dynamic> json) =
      _$_JsonRpcError.fromJson;

  @override
  int? get code;
  @override
  String? get message;
  @override
  @JsonKey(ignore: true)
  _$$_JsonRpcErrorCopyWith<_$_JsonRpcError> get copyWith =>
      throw _privateConstructorUsedError;
}

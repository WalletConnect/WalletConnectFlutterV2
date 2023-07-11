// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'basic_models.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

WalletConnectError _$WalletConnectErrorFromJson(Map<String, dynamic> json) {
  return _WalletConnectError.fromJson(json);
}

/// @nodoc
mixin _$WalletConnectError {
  int get code => throw _privateConstructorUsedError;
  String get message => throw _privateConstructorUsedError;
  String? get data => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $WalletConnectErrorCopyWith<WalletConnectError> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $WalletConnectErrorCopyWith<$Res> {
  factory $WalletConnectErrorCopyWith(
          WalletConnectError value, $Res Function(WalletConnectError) then) =
      _$WalletConnectErrorCopyWithImpl<$Res, WalletConnectError>;
  @useResult
  $Res call({int code, String message, String? data});
}

/// @nodoc
class _$WalletConnectErrorCopyWithImpl<$Res, $Val extends WalletConnectError>
    implements $WalletConnectErrorCopyWith<$Res> {
  _$WalletConnectErrorCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? code = null,
    Object? message = null,
    Object? data = freezed,
  }) {
    return _then(_value.copyWith(
      code: null == code
          ? _value.code
          : code // ignore: cast_nullable_to_non_nullable
              as int,
      message: null == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String,
      data: freezed == data
          ? _value.data
          : data // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_WalletConnectErrorCopyWith<$Res>
    implements $WalletConnectErrorCopyWith<$Res> {
  factory _$$_WalletConnectErrorCopyWith(_$_WalletConnectError value,
          $Res Function(_$_WalletConnectError) then) =
      __$$_WalletConnectErrorCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({int code, String message, String? data});
}

/// @nodoc
class __$$_WalletConnectErrorCopyWithImpl<$Res>
    extends _$WalletConnectErrorCopyWithImpl<$Res, _$_WalletConnectError>
    implements _$$_WalletConnectErrorCopyWith<$Res> {
  __$$_WalletConnectErrorCopyWithImpl(
      _$_WalletConnectError _value, $Res Function(_$_WalletConnectError) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? code = null,
    Object? message = null,
    Object? data = freezed,
  }) {
    return _then(_$_WalletConnectError(
      code: null == code
          ? _value.code
          : code // ignore: cast_nullable_to_non_nullable
              as int,
      message: null == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String,
      data: freezed == data
          ? _value.data
          : data // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_WalletConnectError implements _WalletConnectError {
  const _$_WalletConnectError(
      {required this.code, required this.message, this.data});

  factory _$_WalletConnectError.fromJson(Map<String, dynamic> json) =>
      _$$_WalletConnectErrorFromJson(json);

  @override
  final int code;
  @override
  final String message;
  @override
  final String? data;

  @override
  String toString() {
    return 'WalletConnectError(code: $code, message: $message, data: $data)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_WalletConnectError &&
            (identical(other.code, code) || other.code == code) &&
            (identical(other.message, message) || other.message == message) &&
            (identical(other.data, data) || other.data == data));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, code, message, data);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_WalletConnectErrorCopyWith<_$_WalletConnectError> get copyWith =>
      __$$_WalletConnectErrorCopyWithImpl<_$_WalletConnectError>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_WalletConnectErrorToJson(
      this,
    );
  }
}

abstract class _WalletConnectError implements WalletConnectError {
  const factory _WalletConnectError(
      {required final int code,
      required final String message,
      final String? data}) = _$_WalletConnectError;

  factory _WalletConnectError.fromJson(Map<String, dynamic> json) =
      _$_WalletConnectError.fromJson;

  @override
  int get code;
  @override
  String get message;
  @override
  String? get data;
  @override
  @JsonKey(ignore: true)
  _$$_WalletConnectErrorCopyWith<_$_WalletConnectError> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
mixin _$RpcOptions {
  int get ttl => throw _privateConstructorUsedError;
  bool get prompt => throw _privateConstructorUsedError;
  int get tag => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $RpcOptionsCopyWith<RpcOptions> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $RpcOptionsCopyWith<$Res> {
  factory $RpcOptionsCopyWith(
          RpcOptions value, $Res Function(RpcOptions) then) =
      _$RpcOptionsCopyWithImpl<$Res, RpcOptions>;
  @useResult
  $Res call({int ttl, bool prompt, int tag});
}

/// @nodoc
class _$RpcOptionsCopyWithImpl<$Res, $Val extends RpcOptions>
    implements $RpcOptionsCopyWith<$Res> {
  _$RpcOptionsCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? ttl = null,
    Object? prompt = null,
    Object? tag = null,
  }) {
    return _then(_value.copyWith(
      ttl: null == ttl
          ? _value.ttl
          : ttl // ignore: cast_nullable_to_non_nullable
              as int,
      prompt: null == prompt
          ? _value.prompt
          : prompt // ignore: cast_nullable_to_non_nullable
              as bool,
      tag: null == tag
          ? _value.tag
          : tag // ignore: cast_nullable_to_non_nullable
              as int,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_RpcOptionsCopyWith<$Res>
    implements $RpcOptionsCopyWith<$Res> {
  factory _$$_RpcOptionsCopyWith(
          _$_RpcOptions value, $Res Function(_$_RpcOptions) then) =
      __$$_RpcOptionsCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({int ttl, bool prompt, int tag});
}

/// @nodoc
class __$$_RpcOptionsCopyWithImpl<$Res>
    extends _$RpcOptionsCopyWithImpl<$Res, _$_RpcOptions>
    implements _$$_RpcOptionsCopyWith<$Res> {
  __$$_RpcOptionsCopyWithImpl(
      _$_RpcOptions _value, $Res Function(_$_RpcOptions) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? ttl = null,
    Object? prompt = null,
    Object? tag = null,
  }) {
    return _then(_$_RpcOptions(
      ttl: null == ttl
          ? _value.ttl
          : ttl // ignore: cast_nullable_to_non_nullable
              as int,
      prompt: null == prompt
          ? _value.prompt
          : prompt // ignore: cast_nullable_to_non_nullable
              as bool,
      tag: null == tag
          ? _value.tag
          : tag // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc

class _$_RpcOptions implements _RpcOptions {
  const _$_RpcOptions(
      {required this.ttl, required this.prompt, required this.tag});

  @override
  final int ttl;
  @override
  final bool prompt;
  @override
  final int tag;

  @override
  String toString() {
    return 'RpcOptions(ttl: $ttl, prompt: $prompt, tag: $tag)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_RpcOptions &&
            (identical(other.ttl, ttl) || other.ttl == ttl) &&
            (identical(other.prompt, prompt) || other.prompt == prompt) &&
            (identical(other.tag, tag) || other.tag == tag));
  }

  @override
  int get hashCode => Object.hash(runtimeType, ttl, prompt, tag);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_RpcOptionsCopyWith<_$_RpcOptions> get copyWith =>
      __$$_RpcOptionsCopyWithImpl<_$_RpcOptions>(this, _$identity);
}

abstract class _RpcOptions implements RpcOptions {
  const factory _RpcOptions(
      {required final int ttl,
      required final bool prompt,
      required final int tag}) = _$_RpcOptions;

  @override
  int get ttl;
  @override
  bool get prompt;
  @override
  int get tag;
  @override
  @JsonKey(ignore: true)
  _$$_RpcOptionsCopyWith<_$_RpcOptions> get copyWith =>
      throw _privateConstructorUsedError;
}

ConnectionMetadata _$ConnectionMetadataFromJson(Map<String, dynamic> json) {
  return _ConnectionMetadata.fromJson(json);
}

/// @nodoc
mixin _$ConnectionMetadata {
  String get publicKey => throw _privateConstructorUsedError;
  PairingMetadata get metadata => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $ConnectionMetadataCopyWith<ConnectionMetadata> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ConnectionMetadataCopyWith<$Res> {
  factory $ConnectionMetadataCopyWith(
          ConnectionMetadata value, $Res Function(ConnectionMetadata) then) =
      _$ConnectionMetadataCopyWithImpl<$Res, ConnectionMetadata>;
  @useResult
  $Res call({String publicKey, PairingMetadata metadata});

  $PairingMetadataCopyWith<$Res> get metadata;
}

/// @nodoc
class _$ConnectionMetadataCopyWithImpl<$Res, $Val extends ConnectionMetadata>
    implements $ConnectionMetadataCopyWith<$Res> {
  _$ConnectionMetadataCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? publicKey = null,
    Object? metadata = null,
  }) {
    return _then(_value.copyWith(
      publicKey: null == publicKey
          ? _value.publicKey
          : publicKey // ignore: cast_nullable_to_non_nullable
              as String,
      metadata: null == metadata
          ? _value.metadata
          : metadata // ignore: cast_nullable_to_non_nullable
              as PairingMetadata,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $PairingMetadataCopyWith<$Res> get metadata {
    return $PairingMetadataCopyWith<$Res>(_value.metadata, (value) {
      return _then(_value.copyWith(metadata: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$_ConnectionMetadataCopyWith<$Res>
    implements $ConnectionMetadataCopyWith<$Res> {
  factory _$$_ConnectionMetadataCopyWith(_$_ConnectionMetadata value,
          $Res Function(_$_ConnectionMetadata) then) =
      __$$_ConnectionMetadataCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String publicKey, PairingMetadata metadata});

  @override
  $PairingMetadataCopyWith<$Res> get metadata;
}

/// @nodoc
class __$$_ConnectionMetadataCopyWithImpl<$Res>
    extends _$ConnectionMetadataCopyWithImpl<$Res, _$_ConnectionMetadata>
    implements _$$_ConnectionMetadataCopyWith<$Res> {
  __$$_ConnectionMetadataCopyWithImpl(
      _$_ConnectionMetadata _value, $Res Function(_$_ConnectionMetadata) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? publicKey = null,
    Object? metadata = null,
  }) {
    return _then(_$_ConnectionMetadata(
      publicKey: null == publicKey
          ? _value.publicKey
          : publicKey // ignore: cast_nullable_to_non_nullable
              as String,
      metadata: null == metadata
          ? _value.metadata
          : metadata // ignore: cast_nullable_to_non_nullable
              as PairingMetadata,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_ConnectionMetadata implements _ConnectionMetadata {
  const _$_ConnectionMetadata(
      {required this.publicKey, required this.metadata});

  factory _$_ConnectionMetadata.fromJson(Map<String, dynamic> json) =>
      _$$_ConnectionMetadataFromJson(json);

  @override
  final String publicKey;
  @override
  final PairingMetadata metadata;

  @override
  String toString() {
    return 'ConnectionMetadata(publicKey: $publicKey, metadata: $metadata)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_ConnectionMetadata &&
            (identical(other.publicKey, publicKey) ||
                other.publicKey == publicKey) &&
            (identical(other.metadata, metadata) ||
                other.metadata == metadata));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, publicKey, metadata);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_ConnectionMetadataCopyWith<_$_ConnectionMetadata> get copyWith =>
      __$$_ConnectionMetadataCopyWithImpl<_$_ConnectionMetadata>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_ConnectionMetadataToJson(
      this,
    );
  }
}

abstract class _ConnectionMetadata implements ConnectionMetadata {
  const factory _ConnectionMetadata(
      {required final String publicKey,
      required final PairingMetadata metadata}) = _$_ConnectionMetadata;

  factory _ConnectionMetadata.fromJson(Map<String, dynamic> json) =
      _$_ConnectionMetadata.fromJson;

  @override
  String get publicKey;
  @override
  PairingMetadata get metadata;
  @override
  @JsonKey(ignore: true)
  _$$_ConnectionMetadataCopyWith<_$_ConnectionMetadata> get copyWith =>
      throw _privateConstructorUsedError;
}

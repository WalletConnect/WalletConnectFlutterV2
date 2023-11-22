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
abstract class _$$WalletConnectErrorImplCopyWith<$Res>
    implements $WalletConnectErrorCopyWith<$Res> {
  factory _$$WalletConnectErrorImplCopyWith(_$WalletConnectErrorImpl value,
          $Res Function(_$WalletConnectErrorImpl) then) =
      __$$WalletConnectErrorImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({int code, String message, String? data});
}

/// @nodoc
class __$$WalletConnectErrorImplCopyWithImpl<$Res>
    extends _$WalletConnectErrorCopyWithImpl<$Res, _$WalletConnectErrorImpl>
    implements _$$WalletConnectErrorImplCopyWith<$Res> {
  __$$WalletConnectErrorImplCopyWithImpl(_$WalletConnectErrorImpl _value,
      $Res Function(_$WalletConnectErrorImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? code = null,
    Object? message = null,
    Object? data = freezed,
  }) {
    return _then(_$WalletConnectErrorImpl(
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
class _$WalletConnectErrorImpl implements _WalletConnectError {
  const _$WalletConnectErrorImpl(
      {required this.code, required this.message, this.data});

  factory _$WalletConnectErrorImpl.fromJson(Map<String, dynamic> json) =>
      _$$WalletConnectErrorImplFromJson(json);

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
            other is _$WalletConnectErrorImpl &&
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
  _$$WalletConnectErrorImplCopyWith<_$WalletConnectErrorImpl> get copyWith =>
      __$$WalletConnectErrorImplCopyWithImpl<_$WalletConnectErrorImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$WalletConnectErrorImplToJson(
      this,
    );
  }
}

abstract class _WalletConnectError implements WalletConnectError {
  const factory _WalletConnectError(
      {required final int code,
      required final String message,
      final String? data}) = _$WalletConnectErrorImpl;

  factory _WalletConnectError.fromJson(Map<String, dynamic> json) =
      _$WalletConnectErrorImpl.fromJson;

  @override
  int get code;
  @override
  String get message;
  @override
  String? get data;
  @override
  @JsonKey(ignore: true)
  _$$WalletConnectErrorImplCopyWith<_$WalletConnectErrorImpl> get copyWith =>
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
abstract class _$$RpcOptionsImplCopyWith<$Res>
    implements $RpcOptionsCopyWith<$Res> {
  factory _$$RpcOptionsImplCopyWith(
          _$RpcOptionsImpl value, $Res Function(_$RpcOptionsImpl) then) =
      __$$RpcOptionsImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({int ttl, bool prompt, int tag});
}

/// @nodoc
class __$$RpcOptionsImplCopyWithImpl<$Res>
    extends _$RpcOptionsCopyWithImpl<$Res, _$RpcOptionsImpl>
    implements _$$RpcOptionsImplCopyWith<$Res> {
  __$$RpcOptionsImplCopyWithImpl(
      _$RpcOptionsImpl _value, $Res Function(_$RpcOptionsImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? ttl = null,
    Object? prompt = null,
    Object? tag = null,
  }) {
    return _then(_$RpcOptionsImpl(
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

class _$RpcOptionsImpl implements _RpcOptions {
  const _$RpcOptionsImpl(
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
            other is _$RpcOptionsImpl &&
            (identical(other.ttl, ttl) || other.ttl == ttl) &&
            (identical(other.prompt, prompt) || other.prompt == prompt) &&
            (identical(other.tag, tag) || other.tag == tag));
  }

  @override
  int get hashCode => Object.hash(runtimeType, ttl, prompt, tag);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$RpcOptionsImplCopyWith<_$RpcOptionsImpl> get copyWith =>
      __$$RpcOptionsImplCopyWithImpl<_$RpcOptionsImpl>(this, _$identity);
}

abstract class _RpcOptions implements RpcOptions {
  const factory _RpcOptions(
      {required final int ttl,
      required final bool prompt,
      required final int tag}) = _$RpcOptionsImpl;

  @override
  int get ttl;
  @override
  bool get prompt;
  @override
  int get tag;
  @override
  @JsonKey(ignore: true)
  _$$RpcOptionsImplCopyWith<_$RpcOptionsImpl> get copyWith =>
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
abstract class _$$ConnectionMetadataImplCopyWith<$Res>
    implements $ConnectionMetadataCopyWith<$Res> {
  factory _$$ConnectionMetadataImplCopyWith(_$ConnectionMetadataImpl value,
          $Res Function(_$ConnectionMetadataImpl) then) =
      __$$ConnectionMetadataImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String publicKey, PairingMetadata metadata});

  @override
  $PairingMetadataCopyWith<$Res> get metadata;
}

/// @nodoc
class __$$ConnectionMetadataImplCopyWithImpl<$Res>
    extends _$ConnectionMetadataCopyWithImpl<$Res, _$ConnectionMetadataImpl>
    implements _$$ConnectionMetadataImplCopyWith<$Res> {
  __$$ConnectionMetadataImplCopyWithImpl(_$ConnectionMetadataImpl _value,
      $Res Function(_$ConnectionMetadataImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? publicKey = null,
    Object? metadata = null,
  }) {
    return _then(_$ConnectionMetadataImpl(
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
class _$ConnectionMetadataImpl implements _ConnectionMetadata {
  const _$ConnectionMetadataImpl(
      {required this.publicKey, required this.metadata});

  factory _$ConnectionMetadataImpl.fromJson(Map<String, dynamic> json) =>
      _$$ConnectionMetadataImplFromJson(json);

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
            other is _$ConnectionMetadataImpl &&
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
  _$$ConnectionMetadataImplCopyWith<_$ConnectionMetadataImpl> get copyWith =>
      __$$ConnectionMetadataImplCopyWithImpl<_$ConnectionMetadataImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ConnectionMetadataImplToJson(
      this,
    );
  }
}

abstract class _ConnectionMetadata implements ConnectionMetadata {
  const factory _ConnectionMetadata(
      {required final String publicKey,
      required final PairingMetadata metadata}) = _$ConnectionMetadataImpl;

  factory _ConnectionMetadata.fromJson(Map<String, dynamic> json) =
      _$ConnectionMetadataImpl.fromJson;

  @override
  String get publicKey;
  @override
  PairingMetadata get metadata;
  @override
  @JsonKey(ignore: true)
  _$$ConnectionMetadataImplCopyWith<_$ConnectionMetadataImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

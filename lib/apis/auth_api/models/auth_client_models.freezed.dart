// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'auth_client_models.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

AuthPublicKey _$AuthPublicKeyFromJson(Map<String, dynamic> json) {
  return _AuthPublicKey.fromJson(json);
}

/// @nodoc
mixin _$AuthPublicKey {
  String get publicKey => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $AuthPublicKeyCopyWith<AuthPublicKey> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AuthPublicKeyCopyWith<$Res> {
  factory $AuthPublicKeyCopyWith(
          AuthPublicKey value, $Res Function(AuthPublicKey) then) =
      _$AuthPublicKeyCopyWithImpl<$Res, AuthPublicKey>;
  @useResult
  $Res call({String publicKey});
}

/// @nodoc
class _$AuthPublicKeyCopyWithImpl<$Res, $Val extends AuthPublicKey>
    implements $AuthPublicKeyCopyWith<$Res> {
  _$AuthPublicKeyCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? publicKey = null,
  }) {
    return _then(_value.copyWith(
      publicKey: null == publicKey
          ? _value.publicKey
          : publicKey // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$AuthPublicKeyImplCopyWith<$Res>
    implements $AuthPublicKeyCopyWith<$Res> {
  factory _$$AuthPublicKeyImplCopyWith(
          _$AuthPublicKeyImpl value, $Res Function(_$AuthPublicKeyImpl) then) =
      __$$AuthPublicKeyImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String publicKey});
}

/// @nodoc
class __$$AuthPublicKeyImplCopyWithImpl<$Res>
    extends _$AuthPublicKeyCopyWithImpl<$Res, _$AuthPublicKeyImpl>
    implements _$$AuthPublicKeyImplCopyWith<$Res> {
  __$$AuthPublicKeyImplCopyWithImpl(
      _$AuthPublicKeyImpl _value, $Res Function(_$AuthPublicKeyImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? publicKey = null,
  }) {
    return _then(_$AuthPublicKeyImpl(
      publicKey: null == publicKey
          ? _value.publicKey
          : publicKey // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

@JsonSerializable(includeIfNull: false)
class _$AuthPublicKeyImpl implements _AuthPublicKey {
  const _$AuthPublicKeyImpl({required this.publicKey});

  factory _$AuthPublicKeyImpl.fromJson(Map<String, dynamic> json) =>
      _$$AuthPublicKeyImplFromJson(json);

  @override
  final String publicKey;

  @override
  String toString() {
    return 'AuthPublicKey(publicKey: $publicKey)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AuthPublicKeyImpl &&
            (identical(other.publicKey, publicKey) ||
                other.publicKey == publicKey));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, publicKey);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$AuthPublicKeyImplCopyWith<_$AuthPublicKeyImpl> get copyWith =>
      __$$AuthPublicKeyImplCopyWithImpl<_$AuthPublicKeyImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$AuthPublicKeyImplToJson(
      this,
    );
  }
}

abstract class _AuthPublicKey implements AuthPublicKey {
  const factory _AuthPublicKey({required final String publicKey}) =
      _$AuthPublicKeyImpl;

  factory _AuthPublicKey.fromJson(Map<String, dynamic> json) =
      _$AuthPublicKeyImpl.fromJson;

  @override
  String get publicKey;
  @override
  @JsonKey(ignore: true)
  _$$AuthPublicKeyImplCopyWith<_$AuthPublicKeyImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

AuthPayloadParams _$AuthPayloadParamsFromJson(Map<String, dynamic> json) {
  return _AuthPayloadParams.fromJson(json);
}

/// @nodoc
mixin _$AuthPayloadParams {
  String get type => throw _privateConstructorUsedError;
  String get chainId => throw _privateConstructorUsedError;
  String get domain => throw _privateConstructorUsedError;
  String get aud => throw _privateConstructorUsedError;
  String get version => throw _privateConstructorUsedError;
  String get nonce => throw _privateConstructorUsedError;
  String get iat => throw _privateConstructorUsedError;
  String? get nbf => throw _privateConstructorUsedError;
  String? get exp => throw _privateConstructorUsedError;
  String? get statement => throw _privateConstructorUsedError;
  String? get requestId => throw _privateConstructorUsedError;
  List<String>? get resources => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $AuthPayloadParamsCopyWith<AuthPayloadParams> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AuthPayloadParamsCopyWith<$Res> {
  factory $AuthPayloadParamsCopyWith(
          AuthPayloadParams value, $Res Function(AuthPayloadParams) then) =
      _$AuthPayloadParamsCopyWithImpl<$Res, AuthPayloadParams>;
  @useResult
  $Res call(
      {String type,
      String chainId,
      String domain,
      String aud,
      String version,
      String nonce,
      String iat,
      String? nbf,
      String? exp,
      String? statement,
      String? requestId,
      List<String>? resources});
}

/// @nodoc
class _$AuthPayloadParamsCopyWithImpl<$Res, $Val extends AuthPayloadParams>
    implements $AuthPayloadParamsCopyWith<$Res> {
  _$AuthPayloadParamsCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? type = null,
    Object? chainId = null,
    Object? domain = null,
    Object? aud = null,
    Object? version = null,
    Object? nonce = null,
    Object? iat = null,
    Object? nbf = freezed,
    Object? exp = freezed,
    Object? statement = freezed,
    Object? requestId = freezed,
    Object? resources = freezed,
  }) {
    return _then(_value.copyWith(
      type: null == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as String,
      chainId: null == chainId
          ? _value.chainId
          : chainId // ignore: cast_nullable_to_non_nullable
              as String,
      domain: null == domain
          ? _value.domain
          : domain // ignore: cast_nullable_to_non_nullable
              as String,
      aud: null == aud
          ? _value.aud
          : aud // ignore: cast_nullable_to_non_nullable
              as String,
      version: null == version
          ? _value.version
          : version // ignore: cast_nullable_to_non_nullable
              as String,
      nonce: null == nonce
          ? _value.nonce
          : nonce // ignore: cast_nullable_to_non_nullable
              as String,
      iat: null == iat
          ? _value.iat
          : iat // ignore: cast_nullable_to_non_nullable
              as String,
      nbf: freezed == nbf
          ? _value.nbf
          : nbf // ignore: cast_nullable_to_non_nullable
              as String?,
      exp: freezed == exp
          ? _value.exp
          : exp // ignore: cast_nullable_to_non_nullable
              as String?,
      statement: freezed == statement
          ? _value.statement
          : statement // ignore: cast_nullable_to_non_nullable
              as String?,
      requestId: freezed == requestId
          ? _value.requestId
          : requestId // ignore: cast_nullable_to_non_nullable
              as String?,
      resources: freezed == resources
          ? _value.resources
          : resources // ignore: cast_nullable_to_non_nullable
              as List<String>?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$AuthPayloadParamsImplCopyWith<$Res>
    implements $AuthPayloadParamsCopyWith<$Res> {
  factory _$$AuthPayloadParamsImplCopyWith(_$AuthPayloadParamsImpl value,
          $Res Function(_$AuthPayloadParamsImpl) then) =
      __$$AuthPayloadParamsImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String type,
      String chainId,
      String domain,
      String aud,
      String version,
      String nonce,
      String iat,
      String? nbf,
      String? exp,
      String? statement,
      String? requestId,
      List<String>? resources});
}

/// @nodoc
class __$$AuthPayloadParamsImplCopyWithImpl<$Res>
    extends _$AuthPayloadParamsCopyWithImpl<$Res, _$AuthPayloadParamsImpl>
    implements _$$AuthPayloadParamsImplCopyWith<$Res> {
  __$$AuthPayloadParamsImplCopyWithImpl(_$AuthPayloadParamsImpl _value,
      $Res Function(_$AuthPayloadParamsImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? type = null,
    Object? chainId = null,
    Object? domain = null,
    Object? aud = null,
    Object? version = null,
    Object? nonce = null,
    Object? iat = null,
    Object? nbf = freezed,
    Object? exp = freezed,
    Object? statement = freezed,
    Object? requestId = freezed,
    Object? resources = freezed,
  }) {
    return _then(_$AuthPayloadParamsImpl(
      type: null == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as String,
      chainId: null == chainId
          ? _value.chainId
          : chainId // ignore: cast_nullable_to_non_nullable
              as String,
      domain: null == domain
          ? _value.domain
          : domain // ignore: cast_nullable_to_non_nullable
              as String,
      aud: null == aud
          ? _value.aud
          : aud // ignore: cast_nullable_to_non_nullable
              as String,
      version: null == version
          ? _value.version
          : version // ignore: cast_nullable_to_non_nullable
              as String,
      nonce: null == nonce
          ? _value.nonce
          : nonce // ignore: cast_nullable_to_non_nullable
              as String,
      iat: null == iat
          ? _value.iat
          : iat // ignore: cast_nullable_to_non_nullable
              as String,
      nbf: freezed == nbf
          ? _value.nbf
          : nbf // ignore: cast_nullable_to_non_nullable
              as String?,
      exp: freezed == exp
          ? _value.exp
          : exp // ignore: cast_nullable_to_non_nullable
              as String?,
      statement: freezed == statement
          ? _value.statement
          : statement // ignore: cast_nullable_to_non_nullable
              as String?,
      requestId: freezed == requestId
          ? _value.requestId
          : requestId // ignore: cast_nullable_to_non_nullable
              as String?,
      resources: freezed == resources
          ? _value._resources
          : resources // ignore: cast_nullable_to_non_nullable
              as List<String>?,
    ));
  }
}

/// @nodoc

@JsonSerializable(includeIfNull: false)
class _$AuthPayloadParamsImpl implements _AuthPayloadParams {
  const _$AuthPayloadParamsImpl(
      {required this.type,
      required this.chainId,
      required this.domain,
      required this.aud,
      required this.version,
      required this.nonce,
      required this.iat,
      this.nbf,
      this.exp,
      this.statement,
      this.requestId,
      final List<String>? resources})
      : _resources = resources;

  factory _$AuthPayloadParamsImpl.fromJson(Map<String, dynamic> json) =>
      _$$AuthPayloadParamsImplFromJson(json);

  @override
  final String type;
  @override
  final String chainId;
  @override
  final String domain;
  @override
  final String aud;
  @override
  final String version;
  @override
  final String nonce;
  @override
  final String iat;
  @override
  final String? nbf;
  @override
  final String? exp;
  @override
  final String? statement;
  @override
  final String? requestId;
  final List<String>? _resources;
  @override
  List<String>? get resources {
    final value = _resources;
    if (value == null) return null;
    if (_resources is EqualUnmodifiableListView) return _resources;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  @override
  String toString() {
    return 'AuthPayloadParams(type: $type, chainId: $chainId, domain: $domain, aud: $aud, version: $version, nonce: $nonce, iat: $iat, nbf: $nbf, exp: $exp, statement: $statement, requestId: $requestId, resources: $resources)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AuthPayloadParamsImpl &&
            (identical(other.type, type) || other.type == type) &&
            (identical(other.chainId, chainId) || other.chainId == chainId) &&
            (identical(other.domain, domain) || other.domain == domain) &&
            (identical(other.aud, aud) || other.aud == aud) &&
            (identical(other.version, version) || other.version == version) &&
            (identical(other.nonce, nonce) || other.nonce == nonce) &&
            (identical(other.iat, iat) || other.iat == iat) &&
            (identical(other.nbf, nbf) || other.nbf == nbf) &&
            (identical(other.exp, exp) || other.exp == exp) &&
            (identical(other.statement, statement) ||
                other.statement == statement) &&
            (identical(other.requestId, requestId) ||
                other.requestId == requestId) &&
            const DeepCollectionEquality()
                .equals(other._resources, _resources));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      type,
      chainId,
      domain,
      aud,
      version,
      nonce,
      iat,
      nbf,
      exp,
      statement,
      requestId,
      const DeepCollectionEquality().hash(_resources));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$AuthPayloadParamsImplCopyWith<_$AuthPayloadParamsImpl> get copyWith =>
      __$$AuthPayloadParamsImplCopyWithImpl<_$AuthPayloadParamsImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$AuthPayloadParamsImplToJson(
      this,
    );
  }
}

abstract class _AuthPayloadParams implements AuthPayloadParams {
  const factory _AuthPayloadParams(
      {required final String type,
      required final String chainId,
      required final String domain,
      required final String aud,
      required final String version,
      required final String nonce,
      required final String iat,
      final String? nbf,
      final String? exp,
      final String? statement,
      final String? requestId,
      final List<String>? resources}) = _$AuthPayloadParamsImpl;

  factory _AuthPayloadParams.fromJson(Map<String, dynamic> json) =
      _$AuthPayloadParamsImpl.fromJson;

  @override
  String get type;
  @override
  String get chainId;
  @override
  String get domain;
  @override
  String get aud;
  @override
  String get version;
  @override
  String get nonce;
  @override
  String get iat;
  @override
  String? get nbf;
  @override
  String? get exp;
  @override
  String? get statement;
  @override
  String? get requestId;
  @override
  List<String>? get resources;
  @override
  @JsonKey(ignore: true)
  _$$AuthPayloadParamsImplCopyWith<_$AuthPayloadParamsImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

CacaoRequestPayload _$CacaoRequestPayloadFromJson(Map<String, dynamic> json) {
  return _CacaoRequestPayload.fromJson(json);
}

/// @nodoc
mixin _$CacaoRequestPayload {
  String get domain => throw _privateConstructorUsedError;
  String get aud => throw _privateConstructorUsedError;
  String get version => throw _privateConstructorUsedError;
  String get nonce => throw _privateConstructorUsedError;
  String get iat => throw _privateConstructorUsedError;
  String? get nbf => throw _privateConstructorUsedError;
  String? get exp => throw _privateConstructorUsedError;
  String? get statement => throw _privateConstructorUsedError;
  String? get requestId => throw _privateConstructorUsedError;
  List<String>? get resources => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $CacaoRequestPayloadCopyWith<CacaoRequestPayload> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CacaoRequestPayloadCopyWith<$Res> {
  factory $CacaoRequestPayloadCopyWith(
          CacaoRequestPayload value, $Res Function(CacaoRequestPayload) then) =
      _$CacaoRequestPayloadCopyWithImpl<$Res, CacaoRequestPayload>;
  @useResult
  $Res call(
      {String domain,
      String aud,
      String version,
      String nonce,
      String iat,
      String? nbf,
      String? exp,
      String? statement,
      String? requestId,
      List<String>? resources});
}

/// @nodoc
class _$CacaoRequestPayloadCopyWithImpl<$Res, $Val extends CacaoRequestPayload>
    implements $CacaoRequestPayloadCopyWith<$Res> {
  _$CacaoRequestPayloadCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? domain = null,
    Object? aud = null,
    Object? version = null,
    Object? nonce = null,
    Object? iat = null,
    Object? nbf = freezed,
    Object? exp = freezed,
    Object? statement = freezed,
    Object? requestId = freezed,
    Object? resources = freezed,
  }) {
    return _then(_value.copyWith(
      domain: null == domain
          ? _value.domain
          : domain // ignore: cast_nullable_to_non_nullable
              as String,
      aud: null == aud
          ? _value.aud
          : aud // ignore: cast_nullable_to_non_nullable
              as String,
      version: null == version
          ? _value.version
          : version // ignore: cast_nullable_to_non_nullable
              as String,
      nonce: null == nonce
          ? _value.nonce
          : nonce // ignore: cast_nullable_to_non_nullable
              as String,
      iat: null == iat
          ? _value.iat
          : iat // ignore: cast_nullable_to_non_nullable
              as String,
      nbf: freezed == nbf
          ? _value.nbf
          : nbf // ignore: cast_nullable_to_non_nullable
              as String?,
      exp: freezed == exp
          ? _value.exp
          : exp // ignore: cast_nullable_to_non_nullable
              as String?,
      statement: freezed == statement
          ? _value.statement
          : statement // ignore: cast_nullable_to_non_nullable
              as String?,
      requestId: freezed == requestId
          ? _value.requestId
          : requestId // ignore: cast_nullable_to_non_nullable
              as String?,
      resources: freezed == resources
          ? _value.resources
          : resources // ignore: cast_nullable_to_non_nullable
              as List<String>?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$CacaoRequestPayloadImplCopyWith<$Res>
    implements $CacaoRequestPayloadCopyWith<$Res> {
  factory _$$CacaoRequestPayloadImplCopyWith(_$CacaoRequestPayloadImpl value,
          $Res Function(_$CacaoRequestPayloadImpl) then) =
      __$$CacaoRequestPayloadImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String domain,
      String aud,
      String version,
      String nonce,
      String iat,
      String? nbf,
      String? exp,
      String? statement,
      String? requestId,
      List<String>? resources});
}

/// @nodoc
class __$$CacaoRequestPayloadImplCopyWithImpl<$Res>
    extends _$CacaoRequestPayloadCopyWithImpl<$Res, _$CacaoRequestPayloadImpl>
    implements _$$CacaoRequestPayloadImplCopyWith<$Res> {
  __$$CacaoRequestPayloadImplCopyWithImpl(_$CacaoRequestPayloadImpl _value,
      $Res Function(_$CacaoRequestPayloadImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? domain = null,
    Object? aud = null,
    Object? version = null,
    Object? nonce = null,
    Object? iat = null,
    Object? nbf = freezed,
    Object? exp = freezed,
    Object? statement = freezed,
    Object? requestId = freezed,
    Object? resources = freezed,
  }) {
    return _then(_$CacaoRequestPayloadImpl(
      domain: null == domain
          ? _value.domain
          : domain // ignore: cast_nullable_to_non_nullable
              as String,
      aud: null == aud
          ? _value.aud
          : aud // ignore: cast_nullable_to_non_nullable
              as String,
      version: null == version
          ? _value.version
          : version // ignore: cast_nullable_to_non_nullable
              as String,
      nonce: null == nonce
          ? _value.nonce
          : nonce // ignore: cast_nullable_to_non_nullable
              as String,
      iat: null == iat
          ? _value.iat
          : iat // ignore: cast_nullable_to_non_nullable
              as String,
      nbf: freezed == nbf
          ? _value.nbf
          : nbf // ignore: cast_nullable_to_non_nullable
              as String?,
      exp: freezed == exp
          ? _value.exp
          : exp // ignore: cast_nullable_to_non_nullable
              as String?,
      statement: freezed == statement
          ? _value.statement
          : statement // ignore: cast_nullable_to_non_nullable
              as String?,
      requestId: freezed == requestId
          ? _value.requestId
          : requestId // ignore: cast_nullable_to_non_nullable
              as String?,
      resources: freezed == resources
          ? _value._resources
          : resources // ignore: cast_nullable_to_non_nullable
              as List<String>?,
    ));
  }
}

/// @nodoc

@JsonSerializable(includeIfNull: false)
class _$CacaoRequestPayloadImpl implements _CacaoRequestPayload {
  const _$CacaoRequestPayloadImpl(
      {required this.domain,
      required this.aud,
      required this.version,
      required this.nonce,
      required this.iat,
      this.nbf,
      this.exp,
      this.statement,
      this.requestId,
      final List<String>? resources})
      : _resources = resources;

  factory _$CacaoRequestPayloadImpl.fromJson(Map<String, dynamic> json) =>
      _$$CacaoRequestPayloadImplFromJson(json);

  @override
  final String domain;
  @override
  final String aud;
  @override
  final String version;
  @override
  final String nonce;
  @override
  final String iat;
  @override
  final String? nbf;
  @override
  final String? exp;
  @override
  final String? statement;
  @override
  final String? requestId;
  final List<String>? _resources;
  @override
  List<String>? get resources {
    final value = _resources;
    if (value == null) return null;
    if (_resources is EqualUnmodifiableListView) return _resources;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  @override
  String toString() {
    return 'CacaoRequestPayload(domain: $domain, aud: $aud, version: $version, nonce: $nonce, iat: $iat, nbf: $nbf, exp: $exp, statement: $statement, requestId: $requestId, resources: $resources)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CacaoRequestPayloadImpl &&
            (identical(other.domain, domain) || other.domain == domain) &&
            (identical(other.aud, aud) || other.aud == aud) &&
            (identical(other.version, version) || other.version == version) &&
            (identical(other.nonce, nonce) || other.nonce == nonce) &&
            (identical(other.iat, iat) || other.iat == iat) &&
            (identical(other.nbf, nbf) || other.nbf == nbf) &&
            (identical(other.exp, exp) || other.exp == exp) &&
            (identical(other.statement, statement) ||
                other.statement == statement) &&
            (identical(other.requestId, requestId) ||
                other.requestId == requestId) &&
            const DeepCollectionEquality()
                .equals(other._resources, _resources));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      domain,
      aud,
      version,
      nonce,
      iat,
      nbf,
      exp,
      statement,
      requestId,
      const DeepCollectionEquality().hash(_resources));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$CacaoRequestPayloadImplCopyWith<_$CacaoRequestPayloadImpl> get copyWith =>
      __$$CacaoRequestPayloadImplCopyWithImpl<_$CacaoRequestPayloadImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$CacaoRequestPayloadImplToJson(
      this,
    );
  }
}

abstract class _CacaoRequestPayload implements CacaoRequestPayload {
  const factory _CacaoRequestPayload(
      {required final String domain,
      required final String aud,
      required final String version,
      required final String nonce,
      required final String iat,
      final String? nbf,
      final String? exp,
      final String? statement,
      final String? requestId,
      final List<String>? resources}) = _$CacaoRequestPayloadImpl;

  factory _CacaoRequestPayload.fromJson(Map<String, dynamic> json) =
      _$CacaoRequestPayloadImpl.fromJson;

  @override
  String get domain;
  @override
  String get aud;
  @override
  String get version;
  @override
  String get nonce;
  @override
  String get iat;
  @override
  String? get nbf;
  @override
  String? get exp;
  @override
  String? get statement;
  @override
  String? get requestId;
  @override
  List<String>? get resources;
  @override
  @JsonKey(ignore: true)
  _$$CacaoRequestPayloadImplCopyWith<_$CacaoRequestPayloadImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

CacaoPayload _$CacaoPayloadFromJson(Map<String, dynamic> json) {
  return _CacaoPayload.fromJson(json);
}

/// @nodoc
mixin _$CacaoPayload {
  String get iss => throw _privateConstructorUsedError;
  String get domain => throw _privateConstructorUsedError;
  String get aud => throw _privateConstructorUsedError;
  String get version => throw _privateConstructorUsedError;
  String get nonce => throw _privateConstructorUsedError;
  String get iat => throw _privateConstructorUsedError;
  String? get nbf => throw _privateConstructorUsedError;
  String? get exp => throw _privateConstructorUsedError;
  String? get statement => throw _privateConstructorUsedError;
  String? get requestId => throw _privateConstructorUsedError;
  List<String>? get resources => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $CacaoPayloadCopyWith<CacaoPayload> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CacaoPayloadCopyWith<$Res> {
  factory $CacaoPayloadCopyWith(
          CacaoPayload value, $Res Function(CacaoPayload) then) =
      _$CacaoPayloadCopyWithImpl<$Res, CacaoPayload>;
  @useResult
  $Res call(
      {String iss,
      String domain,
      String aud,
      String version,
      String nonce,
      String iat,
      String? nbf,
      String? exp,
      String? statement,
      String? requestId,
      List<String>? resources});
}

/// @nodoc
class _$CacaoPayloadCopyWithImpl<$Res, $Val extends CacaoPayload>
    implements $CacaoPayloadCopyWith<$Res> {
  _$CacaoPayloadCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? iss = null,
    Object? domain = null,
    Object? aud = null,
    Object? version = null,
    Object? nonce = null,
    Object? iat = null,
    Object? nbf = freezed,
    Object? exp = freezed,
    Object? statement = freezed,
    Object? requestId = freezed,
    Object? resources = freezed,
  }) {
    return _then(_value.copyWith(
      iss: null == iss
          ? _value.iss
          : iss // ignore: cast_nullable_to_non_nullable
              as String,
      domain: null == domain
          ? _value.domain
          : domain // ignore: cast_nullable_to_non_nullable
              as String,
      aud: null == aud
          ? _value.aud
          : aud // ignore: cast_nullable_to_non_nullable
              as String,
      version: null == version
          ? _value.version
          : version // ignore: cast_nullable_to_non_nullable
              as String,
      nonce: null == nonce
          ? _value.nonce
          : nonce // ignore: cast_nullable_to_non_nullable
              as String,
      iat: null == iat
          ? _value.iat
          : iat // ignore: cast_nullable_to_non_nullable
              as String,
      nbf: freezed == nbf
          ? _value.nbf
          : nbf // ignore: cast_nullable_to_non_nullable
              as String?,
      exp: freezed == exp
          ? _value.exp
          : exp // ignore: cast_nullable_to_non_nullable
              as String?,
      statement: freezed == statement
          ? _value.statement
          : statement // ignore: cast_nullable_to_non_nullable
              as String?,
      requestId: freezed == requestId
          ? _value.requestId
          : requestId // ignore: cast_nullable_to_non_nullable
              as String?,
      resources: freezed == resources
          ? _value.resources
          : resources // ignore: cast_nullable_to_non_nullable
              as List<String>?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$CacaoPayloadImplCopyWith<$Res>
    implements $CacaoPayloadCopyWith<$Res> {
  factory _$$CacaoPayloadImplCopyWith(
          _$CacaoPayloadImpl value, $Res Function(_$CacaoPayloadImpl) then) =
      __$$CacaoPayloadImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String iss,
      String domain,
      String aud,
      String version,
      String nonce,
      String iat,
      String? nbf,
      String? exp,
      String? statement,
      String? requestId,
      List<String>? resources});
}

/// @nodoc
class __$$CacaoPayloadImplCopyWithImpl<$Res>
    extends _$CacaoPayloadCopyWithImpl<$Res, _$CacaoPayloadImpl>
    implements _$$CacaoPayloadImplCopyWith<$Res> {
  __$$CacaoPayloadImplCopyWithImpl(
      _$CacaoPayloadImpl _value, $Res Function(_$CacaoPayloadImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? iss = null,
    Object? domain = null,
    Object? aud = null,
    Object? version = null,
    Object? nonce = null,
    Object? iat = null,
    Object? nbf = freezed,
    Object? exp = freezed,
    Object? statement = freezed,
    Object? requestId = freezed,
    Object? resources = freezed,
  }) {
    return _then(_$CacaoPayloadImpl(
      iss: null == iss
          ? _value.iss
          : iss // ignore: cast_nullable_to_non_nullable
              as String,
      domain: null == domain
          ? _value.domain
          : domain // ignore: cast_nullable_to_non_nullable
              as String,
      aud: null == aud
          ? _value.aud
          : aud // ignore: cast_nullable_to_non_nullable
              as String,
      version: null == version
          ? _value.version
          : version // ignore: cast_nullable_to_non_nullable
              as String,
      nonce: null == nonce
          ? _value.nonce
          : nonce // ignore: cast_nullable_to_non_nullable
              as String,
      iat: null == iat
          ? _value.iat
          : iat // ignore: cast_nullable_to_non_nullable
              as String,
      nbf: freezed == nbf
          ? _value.nbf
          : nbf // ignore: cast_nullable_to_non_nullable
              as String?,
      exp: freezed == exp
          ? _value.exp
          : exp // ignore: cast_nullable_to_non_nullable
              as String?,
      statement: freezed == statement
          ? _value.statement
          : statement // ignore: cast_nullable_to_non_nullable
              as String?,
      requestId: freezed == requestId
          ? _value.requestId
          : requestId // ignore: cast_nullable_to_non_nullable
              as String?,
      resources: freezed == resources
          ? _value._resources
          : resources // ignore: cast_nullable_to_non_nullable
              as List<String>?,
    ));
  }
}

/// @nodoc

@JsonSerializable(includeIfNull: false)
class _$CacaoPayloadImpl implements _CacaoPayload {
  const _$CacaoPayloadImpl(
      {required this.iss,
      required this.domain,
      required this.aud,
      required this.version,
      required this.nonce,
      required this.iat,
      this.nbf,
      this.exp,
      this.statement,
      this.requestId,
      final List<String>? resources})
      : _resources = resources;

  factory _$CacaoPayloadImpl.fromJson(Map<String, dynamic> json) =>
      _$$CacaoPayloadImplFromJson(json);

  @override
  final String iss;
  @override
  final String domain;
  @override
  final String aud;
  @override
  final String version;
  @override
  final String nonce;
  @override
  final String iat;
  @override
  final String? nbf;
  @override
  final String? exp;
  @override
  final String? statement;
  @override
  final String? requestId;
  final List<String>? _resources;
  @override
  List<String>? get resources {
    final value = _resources;
    if (value == null) return null;
    if (_resources is EqualUnmodifiableListView) return _resources;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  @override
  String toString() {
    return 'CacaoPayload(iss: $iss, domain: $domain, aud: $aud, version: $version, nonce: $nonce, iat: $iat, nbf: $nbf, exp: $exp, statement: $statement, requestId: $requestId, resources: $resources)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CacaoPayloadImpl &&
            (identical(other.iss, iss) || other.iss == iss) &&
            (identical(other.domain, domain) || other.domain == domain) &&
            (identical(other.aud, aud) || other.aud == aud) &&
            (identical(other.version, version) || other.version == version) &&
            (identical(other.nonce, nonce) || other.nonce == nonce) &&
            (identical(other.iat, iat) || other.iat == iat) &&
            (identical(other.nbf, nbf) || other.nbf == nbf) &&
            (identical(other.exp, exp) || other.exp == exp) &&
            (identical(other.statement, statement) ||
                other.statement == statement) &&
            (identical(other.requestId, requestId) ||
                other.requestId == requestId) &&
            const DeepCollectionEquality()
                .equals(other._resources, _resources));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      iss,
      domain,
      aud,
      version,
      nonce,
      iat,
      nbf,
      exp,
      statement,
      requestId,
      const DeepCollectionEquality().hash(_resources));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$CacaoPayloadImplCopyWith<_$CacaoPayloadImpl> get copyWith =>
      __$$CacaoPayloadImplCopyWithImpl<_$CacaoPayloadImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$CacaoPayloadImplToJson(
      this,
    );
  }
}

abstract class _CacaoPayload implements CacaoPayload {
  const factory _CacaoPayload(
      {required final String iss,
      required final String domain,
      required final String aud,
      required final String version,
      required final String nonce,
      required final String iat,
      final String? nbf,
      final String? exp,
      final String? statement,
      final String? requestId,
      final List<String>? resources}) = _$CacaoPayloadImpl;

  factory _CacaoPayload.fromJson(Map<String, dynamic> json) =
      _$CacaoPayloadImpl.fromJson;

  @override
  String get iss;
  @override
  String get domain;
  @override
  String get aud;
  @override
  String get version;
  @override
  String get nonce;
  @override
  String get iat;
  @override
  String? get nbf;
  @override
  String? get exp;
  @override
  String? get statement;
  @override
  String? get requestId;
  @override
  List<String>? get resources;
  @override
  @JsonKey(ignore: true)
  _$$CacaoPayloadImplCopyWith<_$CacaoPayloadImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

CacaoHeader _$CacaoHeaderFromJson(Map<String, dynamic> json) {
  return _CacaoHeader.fromJson(json);
}

/// @nodoc
mixin _$CacaoHeader {
  String get t => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $CacaoHeaderCopyWith<CacaoHeader> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CacaoHeaderCopyWith<$Res> {
  factory $CacaoHeaderCopyWith(
          CacaoHeader value, $Res Function(CacaoHeader) then) =
      _$CacaoHeaderCopyWithImpl<$Res, CacaoHeader>;
  @useResult
  $Res call({String t});
}

/// @nodoc
class _$CacaoHeaderCopyWithImpl<$Res, $Val extends CacaoHeader>
    implements $CacaoHeaderCopyWith<$Res> {
  _$CacaoHeaderCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? t = null,
  }) {
    return _then(_value.copyWith(
      t: null == t
          ? _value.t
          : t // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$CacaoHeaderImplCopyWith<$Res>
    implements $CacaoHeaderCopyWith<$Res> {
  factory _$$CacaoHeaderImplCopyWith(
          _$CacaoHeaderImpl value, $Res Function(_$CacaoHeaderImpl) then) =
      __$$CacaoHeaderImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String t});
}

/// @nodoc
class __$$CacaoHeaderImplCopyWithImpl<$Res>
    extends _$CacaoHeaderCopyWithImpl<$Res, _$CacaoHeaderImpl>
    implements _$$CacaoHeaderImplCopyWith<$Res> {
  __$$CacaoHeaderImplCopyWithImpl(
      _$CacaoHeaderImpl _value, $Res Function(_$CacaoHeaderImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? t = null,
  }) {
    return _then(_$CacaoHeaderImpl(
      t: null == t
          ? _value.t
          : t // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

@JsonSerializable(includeIfNull: false)
class _$CacaoHeaderImpl implements _CacaoHeader {
  const _$CacaoHeaderImpl({this.t = 'eip4361'});

  factory _$CacaoHeaderImpl.fromJson(Map<String, dynamic> json) =>
      _$$CacaoHeaderImplFromJson(json);

  @override
  @JsonKey()
  final String t;

  @override
  String toString() {
    return 'CacaoHeader(t: $t)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CacaoHeaderImpl &&
            (identical(other.t, t) || other.t == t));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, t);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$CacaoHeaderImplCopyWith<_$CacaoHeaderImpl> get copyWith =>
      __$$CacaoHeaderImplCopyWithImpl<_$CacaoHeaderImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$CacaoHeaderImplToJson(
      this,
    );
  }
}

abstract class _CacaoHeader implements CacaoHeader {
  const factory _CacaoHeader({final String t}) = _$CacaoHeaderImpl;

  factory _CacaoHeader.fromJson(Map<String, dynamic> json) =
      _$CacaoHeaderImpl.fromJson;

  @override
  String get t;
  @override
  @JsonKey(ignore: true)
  _$$CacaoHeaderImplCopyWith<_$CacaoHeaderImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

CacaoSignature _$CacaoSignatureFromJson(Map<String, dynamic> json) {
  return _CacaoSignature.fromJson(json);
}

/// @nodoc
mixin _$CacaoSignature {
  String get t => throw _privateConstructorUsedError;
  String get s => throw _privateConstructorUsedError;
  String? get m => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $CacaoSignatureCopyWith<CacaoSignature> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CacaoSignatureCopyWith<$Res> {
  factory $CacaoSignatureCopyWith(
          CacaoSignature value, $Res Function(CacaoSignature) then) =
      _$CacaoSignatureCopyWithImpl<$Res, CacaoSignature>;
  @useResult
  $Res call({String t, String s, String? m});
}

/// @nodoc
class _$CacaoSignatureCopyWithImpl<$Res, $Val extends CacaoSignature>
    implements $CacaoSignatureCopyWith<$Res> {
  _$CacaoSignatureCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? t = null,
    Object? s = null,
    Object? m = freezed,
  }) {
    return _then(_value.copyWith(
      t: null == t
          ? _value.t
          : t // ignore: cast_nullable_to_non_nullable
              as String,
      s: null == s
          ? _value.s
          : s // ignore: cast_nullable_to_non_nullable
              as String,
      m: freezed == m
          ? _value.m
          : m // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$CacaoSignatureImplCopyWith<$Res>
    implements $CacaoSignatureCopyWith<$Res> {
  factory _$$CacaoSignatureImplCopyWith(_$CacaoSignatureImpl value,
          $Res Function(_$CacaoSignatureImpl) then) =
      __$$CacaoSignatureImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String t, String s, String? m});
}

/// @nodoc
class __$$CacaoSignatureImplCopyWithImpl<$Res>
    extends _$CacaoSignatureCopyWithImpl<$Res, _$CacaoSignatureImpl>
    implements _$$CacaoSignatureImplCopyWith<$Res> {
  __$$CacaoSignatureImplCopyWithImpl(
      _$CacaoSignatureImpl _value, $Res Function(_$CacaoSignatureImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? t = null,
    Object? s = null,
    Object? m = freezed,
  }) {
    return _then(_$CacaoSignatureImpl(
      t: null == t
          ? _value.t
          : t // ignore: cast_nullable_to_non_nullable
              as String,
      s: null == s
          ? _value.s
          : s // ignore: cast_nullable_to_non_nullable
              as String,
      m: freezed == m
          ? _value.m
          : m // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc

@JsonSerializable(includeIfNull: false)
class _$CacaoSignatureImpl implements _CacaoSignature {
  const _$CacaoSignatureImpl({required this.t, required this.s, this.m});

  factory _$CacaoSignatureImpl.fromJson(Map<String, dynamic> json) =>
      _$$CacaoSignatureImplFromJson(json);

  @override
  final String t;
  @override
  final String s;
  @override
  final String? m;

  @override
  String toString() {
    return 'CacaoSignature(t: $t, s: $s, m: $m)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CacaoSignatureImpl &&
            (identical(other.t, t) || other.t == t) &&
            (identical(other.s, s) || other.s == s) &&
            (identical(other.m, m) || other.m == m));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, t, s, m);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$CacaoSignatureImplCopyWith<_$CacaoSignatureImpl> get copyWith =>
      __$$CacaoSignatureImplCopyWithImpl<_$CacaoSignatureImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$CacaoSignatureImplToJson(
      this,
    );
  }
}

abstract class _CacaoSignature implements CacaoSignature {
  const factory _CacaoSignature(
      {required final String t,
      required final String s,
      final String? m}) = _$CacaoSignatureImpl;

  factory _CacaoSignature.fromJson(Map<String, dynamic> json) =
      _$CacaoSignatureImpl.fromJson;

  @override
  String get t;
  @override
  String get s;
  @override
  String? get m;
  @override
  @JsonKey(ignore: true)
  _$$CacaoSignatureImplCopyWith<_$CacaoSignatureImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

Cacao _$CacaoFromJson(Map<String, dynamic> json) {
  return _Cacao.fromJson(json);
}

/// @nodoc
mixin _$Cacao {
  CacaoHeader get h => throw _privateConstructorUsedError;
  CacaoPayload get p => throw _privateConstructorUsedError;
  CacaoSignature get s => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $CacaoCopyWith<Cacao> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CacaoCopyWith<$Res> {
  factory $CacaoCopyWith(Cacao value, $Res Function(Cacao) then) =
      _$CacaoCopyWithImpl<$Res, Cacao>;
  @useResult
  $Res call({CacaoHeader h, CacaoPayload p, CacaoSignature s});

  $CacaoHeaderCopyWith<$Res> get h;
  $CacaoPayloadCopyWith<$Res> get p;
  $CacaoSignatureCopyWith<$Res> get s;
}

/// @nodoc
class _$CacaoCopyWithImpl<$Res, $Val extends Cacao>
    implements $CacaoCopyWith<$Res> {
  _$CacaoCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? h = null,
    Object? p = null,
    Object? s = null,
  }) {
    return _then(_value.copyWith(
      h: null == h
          ? _value.h
          : h // ignore: cast_nullable_to_non_nullable
              as CacaoHeader,
      p: null == p
          ? _value.p
          : p // ignore: cast_nullable_to_non_nullable
              as CacaoPayload,
      s: null == s
          ? _value.s
          : s // ignore: cast_nullable_to_non_nullable
              as CacaoSignature,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $CacaoHeaderCopyWith<$Res> get h {
    return $CacaoHeaderCopyWith<$Res>(_value.h, (value) {
      return _then(_value.copyWith(h: value) as $Val);
    });
  }

  @override
  @pragma('vm:prefer-inline')
  $CacaoPayloadCopyWith<$Res> get p {
    return $CacaoPayloadCopyWith<$Res>(_value.p, (value) {
      return _then(_value.copyWith(p: value) as $Val);
    });
  }

  @override
  @pragma('vm:prefer-inline')
  $CacaoSignatureCopyWith<$Res> get s {
    return $CacaoSignatureCopyWith<$Res>(_value.s, (value) {
      return _then(_value.copyWith(s: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$CacaoImplCopyWith<$Res> implements $CacaoCopyWith<$Res> {
  factory _$$CacaoImplCopyWith(
          _$CacaoImpl value, $Res Function(_$CacaoImpl) then) =
      __$$CacaoImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({CacaoHeader h, CacaoPayload p, CacaoSignature s});

  @override
  $CacaoHeaderCopyWith<$Res> get h;
  @override
  $CacaoPayloadCopyWith<$Res> get p;
  @override
  $CacaoSignatureCopyWith<$Res> get s;
}

/// @nodoc
class __$$CacaoImplCopyWithImpl<$Res>
    extends _$CacaoCopyWithImpl<$Res, _$CacaoImpl>
    implements _$$CacaoImplCopyWith<$Res> {
  __$$CacaoImplCopyWithImpl(
      _$CacaoImpl _value, $Res Function(_$CacaoImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? h = null,
    Object? p = null,
    Object? s = null,
  }) {
    return _then(_$CacaoImpl(
      h: null == h
          ? _value.h
          : h // ignore: cast_nullable_to_non_nullable
              as CacaoHeader,
      p: null == p
          ? _value.p
          : p // ignore: cast_nullable_to_non_nullable
              as CacaoPayload,
      s: null == s
          ? _value.s
          : s // ignore: cast_nullable_to_non_nullable
              as CacaoSignature,
    ));
  }
}

/// @nodoc

@JsonSerializable(includeIfNull: false)
class _$CacaoImpl implements _Cacao {
  const _$CacaoImpl({required this.h, required this.p, required this.s});

  factory _$CacaoImpl.fromJson(Map<String, dynamic> json) =>
      _$$CacaoImplFromJson(json);

  @override
  final CacaoHeader h;
  @override
  final CacaoPayload p;
  @override
  final CacaoSignature s;

  @override
  String toString() {
    return 'Cacao(h: $h, p: $p, s: $s)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CacaoImpl &&
            (identical(other.h, h) || other.h == h) &&
            (identical(other.p, p) || other.p == p) &&
            (identical(other.s, s) || other.s == s));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, h, p, s);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$CacaoImplCopyWith<_$CacaoImpl> get copyWith =>
      __$$CacaoImplCopyWithImpl<_$CacaoImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$CacaoImplToJson(
      this,
    );
  }
}

abstract class _Cacao implements Cacao {
  const factory _Cacao(
      {required final CacaoHeader h,
      required final CacaoPayload p,
      required final CacaoSignature s}) = _$CacaoImpl;

  factory _Cacao.fromJson(Map<String, dynamic> json) = _$CacaoImpl.fromJson;

  @override
  CacaoHeader get h;
  @override
  CacaoPayload get p;
  @override
  CacaoSignature get s;
  @override
  @JsonKey(ignore: true)
  _$$CacaoImplCopyWith<_$CacaoImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

StoredCacao _$StoredCacaoFromJson(Map<String, dynamic> json) {
  return _StoredCacao.fromJson(json);
}

/// @nodoc
mixin _$StoredCacao {
  int get id => throw _privateConstructorUsedError;
  String get pairingTopic => throw _privateConstructorUsedError;
  CacaoHeader get h => throw _privateConstructorUsedError;
  CacaoPayload get p => throw _privateConstructorUsedError;
  CacaoSignature get s => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $StoredCacaoCopyWith<StoredCacao> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $StoredCacaoCopyWith<$Res> {
  factory $StoredCacaoCopyWith(
          StoredCacao value, $Res Function(StoredCacao) then) =
      _$StoredCacaoCopyWithImpl<$Res, StoredCacao>;
  @useResult
  $Res call(
      {int id,
      String pairingTopic,
      CacaoHeader h,
      CacaoPayload p,
      CacaoSignature s});

  $CacaoHeaderCopyWith<$Res> get h;
  $CacaoPayloadCopyWith<$Res> get p;
  $CacaoSignatureCopyWith<$Res> get s;
}

/// @nodoc
class _$StoredCacaoCopyWithImpl<$Res, $Val extends StoredCacao>
    implements $StoredCacaoCopyWith<$Res> {
  _$StoredCacaoCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? pairingTopic = null,
    Object? h = null,
    Object? p = null,
    Object? s = null,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      pairingTopic: null == pairingTopic
          ? _value.pairingTopic
          : pairingTopic // ignore: cast_nullable_to_non_nullable
              as String,
      h: null == h
          ? _value.h
          : h // ignore: cast_nullable_to_non_nullable
              as CacaoHeader,
      p: null == p
          ? _value.p
          : p // ignore: cast_nullable_to_non_nullable
              as CacaoPayload,
      s: null == s
          ? _value.s
          : s // ignore: cast_nullable_to_non_nullable
              as CacaoSignature,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $CacaoHeaderCopyWith<$Res> get h {
    return $CacaoHeaderCopyWith<$Res>(_value.h, (value) {
      return _then(_value.copyWith(h: value) as $Val);
    });
  }

  @override
  @pragma('vm:prefer-inline')
  $CacaoPayloadCopyWith<$Res> get p {
    return $CacaoPayloadCopyWith<$Res>(_value.p, (value) {
      return _then(_value.copyWith(p: value) as $Val);
    });
  }

  @override
  @pragma('vm:prefer-inline')
  $CacaoSignatureCopyWith<$Res> get s {
    return $CacaoSignatureCopyWith<$Res>(_value.s, (value) {
      return _then(_value.copyWith(s: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$StoredCacaoImplCopyWith<$Res>
    implements $StoredCacaoCopyWith<$Res> {
  factory _$$StoredCacaoImplCopyWith(
          _$StoredCacaoImpl value, $Res Function(_$StoredCacaoImpl) then) =
      __$$StoredCacaoImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {int id,
      String pairingTopic,
      CacaoHeader h,
      CacaoPayload p,
      CacaoSignature s});

  @override
  $CacaoHeaderCopyWith<$Res> get h;
  @override
  $CacaoPayloadCopyWith<$Res> get p;
  @override
  $CacaoSignatureCopyWith<$Res> get s;
}

/// @nodoc
class __$$StoredCacaoImplCopyWithImpl<$Res>
    extends _$StoredCacaoCopyWithImpl<$Res, _$StoredCacaoImpl>
    implements _$$StoredCacaoImplCopyWith<$Res> {
  __$$StoredCacaoImplCopyWithImpl(
      _$StoredCacaoImpl _value, $Res Function(_$StoredCacaoImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? pairingTopic = null,
    Object? h = null,
    Object? p = null,
    Object? s = null,
  }) {
    return _then(_$StoredCacaoImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      pairingTopic: null == pairingTopic
          ? _value.pairingTopic
          : pairingTopic // ignore: cast_nullable_to_non_nullable
              as String,
      h: null == h
          ? _value.h
          : h // ignore: cast_nullable_to_non_nullable
              as CacaoHeader,
      p: null == p
          ? _value.p
          : p // ignore: cast_nullable_to_non_nullable
              as CacaoPayload,
      s: null == s
          ? _value.s
          : s // ignore: cast_nullable_to_non_nullable
              as CacaoSignature,
    ));
  }
}

/// @nodoc

@JsonSerializable(includeIfNull: false)
class _$StoredCacaoImpl implements _StoredCacao {
  const _$StoredCacaoImpl(
      {required this.id,
      required this.pairingTopic,
      required this.h,
      required this.p,
      required this.s});

  factory _$StoredCacaoImpl.fromJson(Map<String, dynamic> json) =>
      _$$StoredCacaoImplFromJson(json);

  @override
  final int id;
  @override
  final String pairingTopic;
  @override
  final CacaoHeader h;
  @override
  final CacaoPayload p;
  @override
  final CacaoSignature s;

  @override
  String toString() {
    return 'StoredCacao(id: $id, pairingTopic: $pairingTopic, h: $h, p: $p, s: $s)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$StoredCacaoImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.pairingTopic, pairingTopic) ||
                other.pairingTopic == pairingTopic) &&
            (identical(other.h, h) || other.h == h) &&
            (identical(other.p, p) || other.p == p) &&
            (identical(other.s, s) || other.s == s));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, id, pairingTopic, h, p, s);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$StoredCacaoImplCopyWith<_$StoredCacaoImpl> get copyWith =>
      __$$StoredCacaoImplCopyWithImpl<_$StoredCacaoImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$StoredCacaoImplToJson(
      this,
    );
  }
}

abstract class _StoredCacao implements StoredCacao {
  const factory _StoredCacao(
      {required final int id,
      required final String pairingTopic,
      required final CacaoHeader h,
      required final CacaoPayload p,
      required final CacaoSignature s}) = _$StoredCacaoImpl;

  factory _StoredCacao.fromJson(Map<String, dynamic> json) =
      _$StoredCacaoImpl.fromJson;

  @override
  int get id;
  @override
  String get pairingTopic;
  @override
  CacaoHeader get h;
  @override
  CacaoPayload get p;
  @override
  CacaoSignature get s;
  @override
  @JsonKey(ignore: true)
  _$$StoredCacaoImplCopyWith<_$StoredCacaoImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

PendingAuthRequest _$PendingAuthRequestFromJson(Map<String, dynamic> json) {
  return _PendingAuthRequest.fromJson(json);
}

/// @nodoc
mixin _$PendingAuthRequest {
  int get id => throw _privateConstructorUsedError;
  String get pairingTopic => throw _privateConstructorUsedError;
  ConnectionMetadata get metadata => throw _privateConstructorUsedError;
  CacaoRequestPayload get cacaoPayload => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $PendingAuthRequestCopyWith<PendingAuthRequest> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PendingAuthRequestCopyWith<$Res> {
  factory $PendingAuthRequestCopyWith(
          PendingAuthRequest value, $Res Function(PendingAuthRequest) then) =
      _$PendingAuthRequestCopyWithImpl<$Res, PendingAuthRequest>;
  @useResult
  $Res call(
      {int id,
      String pairingTopic,
      ConnectionMetadata metadata,
      CacaoRequestPayload cacaoPayload});

  $ConnectionMetadataCopyWith<$Res> get metadata;
  $CacaoRequestPayloadCopyWith<$Res> get cacaoPayload;
}

/// @nodoc
class _$PendingAuthRequestCopyWithImpl<$Res, $Val extends PendingAuthRequest>
    implements $PendingAuthRequestCopyWith<$Res> {
  _$PendingAuthRequestCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? pairingTopic = null,
    Object? metadata = null,
    Object? cacaoPayload = null,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      pairingTopic: null == pairingTopic
          ? _value.pairingTopic
          : pairingTopic // ignore: cast_nullable_to_non_nullable
              as String,
      metadata: null == metadata
          ? _value.metadata
          : metadata // ignore: cast_nullable_to_non_nullable
              as ConnectionMetadata,
      cacaoPayload: null == cacaoPayload
          ? _value.cacaoPayload
          : cacaoPayload // ignore: cast_nullable_to_non_nullable
              as CacaoRequestPayload,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $ConnectionMetadataCopyWith<$Res> get metadata {
    return $ConnectionMetadataCopyWith<$Res>(_value.metadata, (value) {
      return _then(_value.copyWith(metadata: value) as $Val);
    });
  }

  @override
  @pragma('vm:prefer-inline')
  $CacaoRequestPayloadCopyWith<$Res> get cacaoPayload {
    return $CacaoRequestPayloadCopyWith<$Res>(_value.cacaoPayload, (value) {
      return _then(_value.copyWith(cacaoPayload: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$PendingAuthRequestImplCopyWith<$Res>
    implements $PendingAuthRequestCopyWith<$Res> {
  factory _$$PendingAuthRequestImplCopyWith(_$PendingAuthRequestImpl value,
          $Res Function(_$PendingAuthRequestImpl) then) =
      __$$PendingAuthRequestImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {int id,
      String pairingTopic,
      ConnectionMetadata metadata,
      CacaoRequestPayload cacaoPayload});

  @override
  $ConnectionMetadataCopyWith<$Res> get metadata;
  @override
  $CacaoRequestPayloadCopyWith<$Res> get cacaoPayload;
}

/// @nodoc
class __$$PendingAuthRequestImplCopyWithImpl<$Res>
    extends _$PendingAuthRequestCopyWithImpl<$Res, _$PendingAuthRequestImpl>
    implements _$$PendingAuthRequestImplCopyWith<$Res> {
  __$$PendingAuthRequestImplCopyWithImpl(_$PendingAuthRequestImpl _value,
      $Res Function(_$PendingAuthRequestImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? pairingTopic = null,
    Object? metadata = null,
    Object? cacaoPayload = null,
  }) {
    return _then(_$PendingAuthRequestImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      pairingTopic: null == pairingTopic
          ? _value.pairingTopic
          : pairingTopic // ignore: cast_nullable_to_non_nullable
              as String,
      metadata: null == metadata
          ? _value.metadata
          : metadata // ignore: cast_nullable_to_non_nullable
              as ConnectionMetadata,
      cacaoPayload: null == cacaoPayload
          ? _value.cacaoPayload
          : cacaoPayload // ignore: cast_nullable_to_non_nullable
              as CacaoRequestPayload,
    ));
  }
}

/// @nodoc

@JsonSerializable(includeIfNull: false)
class _$PendingAuthRequestImpl implements _PendingAuthRequest {
  const _$PendingAuthRequestImpl(
      {required this.id,
      required this.pairingTopic,
      required this.metadata,
      required this.cacaoPayload});

  factory _$PendingAuthRequestImpl.fromJson(Map<String, dynamic> json) =>
      _$$PendingAuthRequestImplFromJson(json);

  @override
  final int id;
  @override
  final String pairingTopic;
  @override
  final ConnectionMetadata metadata;
  @override
  final CacaoRequestPayload cacaoPayload;

  @override
  String toString() {
    return 'PendingAuthRequest(id: $id, pairingTopic: $pairingTopic, metadata: $metadata, cacaoPayload: $cacaoPayload)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$PendingAuthRequestImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.pairingTopic, pairingTopic) ||
                other.pairingTopic == pairingTopic) &&
            (identical(other.metadata, metadata) ||
                other.metadata == metadata) &&
            (identical(other.cacaoPayload, cacaoPayload) ||
                other.cacaoPayload == cacaoPayload));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode =>
      Object.hash(runtimeType, id, pairingTopic, metadata, cacaoPayload);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$PendingAuthRequestImplCopyWith<_$PendingAuthRequestImpl> get copyWith =>
      __$$PendingAuthRequestImplCopyWithImpl<_$PendingAuthRequestImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$PendingAuthRequestImplToJson(
      this,
    );
  }
}

abstract class _PendingAuthRequest implements PendingAuthRequest {
  const factory _PendingAuthRequest(
          {required final int id,
          required final String pairingTopic,
          required final ConnectionMetadata metadata,
          required final CacaoRequestPayload cacaoPayload}) =
      _$PendingAuthRequestImpl;

  factory _PendingAuthRequest.fromJson(Map<String, dynamic> json) =
      _$PendingAuthRequestImpl.fromJson;

  @override
  int get id;
  @override
  String get pairingTopic;
  @override
  ConnectionMetadata get metadata;
  @override
  CacaoRequestPayload get cacaoPayload;
  @override
  @JsonKey(ignore: true)
  _$$PendingAuthRequestImplCopyWith<_$PendingAuthRequestImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

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
abstract class _$$_AuthPublicKeyCopyWith<$Res>
    implements $AuthPublicKeyCopyWith<$Res> {
  factory _$$_AuthPublicKeyCopyWith(
          _$_AuthPublicKey value, $Res Function(_$_AuthPublicKey) then) =
      __$$_AuthPublicKeyCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String publicKey});
}

/// @nodoc
class __$$_AuthPublicKeyCopyWithImpl<$Res>
    extends _$AuthPublicKeyCopyWithImpl<$Res, _$_AuthPublicKey>
    implements _$$_AuthPublicKeyCopyWith<$Res> {
  __$$_AuthPublicKeyCopyWithImpl(
      _$_AuthPublicKey _value, $Res Function(_$_AuthPublicKey) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? publicKey = null,
  }) {
    return _then(_$_AuthPublicKey(
      publicKey: null == publicKey
          ? _value.publicKey
          : publicKey // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

@JsonSerializable(includeIfNull: false)
class _$_AuthPublicKey implements _AuthPublicKey {
  const _$_AuthPublicKey({required this.publicKey});

  factory _$_AuthPublicKey.fromJson(Map<String, dynamic> json) =>
      _$$_AuthPublicKeyFromJson(json);

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
            other is _$_AuthPublicKey &&
            (identical(other.publicKey, publicKey) ||
                other.publicKey == publicKey));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, publicKey);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_AuthPublicKeyCopyWith<_$_AuthPublicKey> get copyWith =>
      __$$_AuthPublicKeyCopyWithImpl<_$_AuthPublicKey>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_AuthPublicKeyToJson(
      this,
    );
  }
}

abstract class _AuthPublicKey implements AuthPublicKey {
  const factory _AuthPublicKey({required final String publicKey}) =
      _$_AuthPublicKey;

  factory _AuthPublicKey.fromJson(Map<String, dynamic> json) =
      _$_AuthPublicKey.fromJson;

  @override
  String get publicKey;
  @override
  @JsonKey(ignore: true)
  _$$_AuthPublicKeyCopyWith<_$_AuthPublicKey> get copyWith =>
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
abstract class _$$_AuthPayloadParamsCopyWith<$Res>
    implements $AuthPayloadParamsCopyWith<$Res> {
  factory _$$_AuthPayloadParamsCopyWith(_$_AuthPayloadParams value,
          $Res Function(_$_AuthPayloadParams) then) =
      __$$_AuthPayloadParamsCopyWithImpl<$Res>;
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
class __$$_AuthPayloadParamsCopyWithImpl<$Res>
    extends _$AuthPayloadParamsCopyWithImpl<$Res, _$_AuthPayloadParams>
    implements _$$_AuthPayloadParamsCopyWith<$Res> {
  __$$_AuthPayloadParamsCopyWithImpl(
      _$_AuthPayloadParams _value, $Res Function(_$_AuthPayloadParams) _then)
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
    return _then(_$_AuthPayloadParams(
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
class _$_AuthPayloadParams implements _AuthPayloadParams {
  const _$_AuthPayloadParams(
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

  factory _$_AuthPayloadParams.fromJson(Map<String, dynamic> json) =>
      _$$_AuthPayloadParamsFromJson(json);

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
            other is _$_AuthPayloadParams &&
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
  _$$_AuthPayloadParamsCopyWith<_$_AuthPayloadParams> get copyWith =>
      __$$_AuthPayloadParamsCopyWithImpl<_$_AuthPayloadParams>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_AuthPayloadParamsToJson(
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
      final List<String>? resources}) = _$_AuthPayloadParams;

  factory _AuthPayloadParams.fromJson(Map<String, dynamic> json) =
      _$_AuthPayloadParams.fromJson;

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
  _$$_AuthPayloadParamsCopyWith<_$_AuthPayloadParams> get copyWith =>
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
abstract class _$$_CacaoRequestPayloadCopyWith<$Res>
    implements $CacaoRequestPayloadCopyWith<$Res> {
  factory _$$_CacaoRequestPayloadCopyWith(_$_CacaoRequestPayload value,
          $Res Function(_$_CacaoRequestPayload) then) =
      __$$_CacaoRequestPayloadCopyWithImpl<$Res>;
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
class __$$_CacaoRequestPayloadCopyWithImpl<$Res>
    extends _$CacaoRequestPayloadCopyWithImpl<$Res, _$_CacaoRequestPayload>
    implements _$$_CacaoRequestPayloadCopyWith<$Res> {
  __$$_CacaoRequestPayloadCopyWithImpl(_$_CacaoRequestPayload _value,
      $Res Function(_$_CacaoRequestPayload) _then)
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
    return _then(_$_CacaoRequestPayload(
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
class _$_CacaoRequestPayload implements _CacaoRequestPayload {
  const _$_CacaoRequestPayload(
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

  factory _$_CacaoRequestPayload.fromJson(Map<String, dynamic> json) =>
      _$$_CacaoRequestPayloadFromJson(json);

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
            other is _$_CacaoRequestPayload &&
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
  _$$_CacaoRequestPayloadCopyWith<_$_CacaoRequestPayload> get copyWith =>
      __$$_CacaoRequestPayloadCopyWithImpl<_$_CacaoRequestPayload>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_CacaoRequestPayloadToJson(
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
      final List<String>? resources}) = _$_CacaoRequestPayload;

  factory _CacaoRequestPayload.fromJson(Map<String, dynamic> json) =
      _$_CacaoRequestPayload.fromJson;

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
  _$$_CacaoRequestPayloadCopyWith<_$_CacaoRequestPayload> get copyWith =>
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
abstract class _$$_CacaoPayloadCopyWith<$Res>
    implements $CacaoPayloadCopyWith<$Res> {
  factory _$$_CacaoPayloadCopyWith(
          _$_CacaoPayload value, $Res Function(_$_CacaoPayload) then) =
      __$$_CacaoPayloadCopyWithImpl<$Res>;
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
class __$$_CacaoPayloadCopyWithImpl<$Res>
    extends _$CacaoPayloadCopyWithImpl<$Res, _$_CacaoPayload>
    implements _$$_CacaoPayloadCopyWith<$Res> {
  __$$_CacaoPayloadCopyWithImpl(
      _$_CacaoPayload _value, $Res Function(_$_CacaoPayload) _then)
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
    return _then(_$_CacaoPayload(
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
class _$_CacaoPayload implements _CacaoPayload {
  const _$_CacaoPayload(
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

  factory _$_CacaoPayload.fromJson(Map<String, dynamic> json) =>
      _$$_CacaoPayloadFromJson(json);

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
            other is _$_CacaoPayload &&
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
  _$$_CacaoPayloadCopyWith<_$_CacaoPayload> get copyWith =>
      __$$_CacaoPayloadCopyWithImpl<_$_CacaoPayload>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_CacaoPayloadToJson(
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
      final List<String>? resources}) = _$_CacaoPayload;

  factory _CacaoPayload.fromJson(Map<String, dynamic> json) =
      _$_CacaoPayload.fromJson;

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
  _$$_CacaoPayloadCopyWith<_$_CacaoPayload> get copyWith =>
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
abstract class _$$_CacaoHeaderCopyWith<$Res>
    implements $CacaoHeaderCopyWith<$Res> {
  factory _$$_CacaoHeaderCopyWith(
          _$_CacaoHeader value, $Res Function(_$_CacaoHeader) then) =
      __$$_CacaoHeaderCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String t});
}

/// @nodoc
class __$$_CacaoHeaderCopyWithImpl<$Res>
    extends _$CacaoHeaderCopyWithImpl<$Res, _$_CacaoHeader>
    implements _$$_CacaoHeaderCopyWith<$Res> {
  __$$_CacaoHeaderCopyWithImpl(
      _$_CacaoHeader _value, $Res Function(_$_CacaoHeader) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? t = null,
  }) {
    return _then(_$_CacaoHeader(
      t: null == t
          ? _value.t
          : t // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

@JsonSerializable(includeIfNull: false)
class _$_CacaoHeader implements _CacaoHeader {
  const _$_CacaoHeader({this.t = 'eip4361'});

  factory _$_CacaoHeader.fromJson(Map<String, dynamic> json) =>
      _$$_CacaoHeaderFromJson(json);

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
            other is _$_CacaoHeader &&
            (identical(other.t, t) || other.t == t));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, t);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_CacaoHeaderCopyWith<_$_CacaoHeader> get copyWith =>
      __$$_CacaoHeaderCopyWithImpl<_$_CacaoHeader>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_CacaoHeaderToJson(
      this,
    );
  }
}

abstract class _CacaoHeader implements CacaoHeader {
  const factory _CacaoHeader({final String t}) = _$_CacaoHeader;

  factory _CacaoHeader.fromJson(Map<String, dynamic> json) =
      _$_CacaoHeader.fromJson;

  @override
  String get t;
  @override
  @JsonKey(ignore: true)
  _$$_CacaoHeaderCopyWith<_$_CacaoHeader> get copyWith =>
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
abstract class _$$_CacaoSignatureCopyWith<$Res>
    implements $CacaoSignatureCopyWith<$Res> {
  factory _$$_CacaoSignatureCopyWith(
          _$_CacaoSignature value, $Res Function(_$_CacaoSignature) then) =
      __$$_CacaoSignatureCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String t, String s, String? m});
}

/// @nodoc
class __$$_CacaoSignatureCopyWithImpl<$Res>
    extends _$CacaoSignatureCopyWithImpl<$Res, _$_CacaoSignature>
    implements _$$_CacaoSignatureCopyWith<$Res> {
  __$$_CacaoSignatureCopyWithImpl(
      _$_CacaoSignature _value, $Res Function(_$_CacaoSignature) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? t = null,
    Object? s = null,
    Object? m = freezed,
  }) {
    return _then(_$_CacaoSignature(
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
class _$_CacaoSignature implements _CacaoSignature {
  const _$_CacaoSignature({required this.t, required this.s, this.m});

  factory _$_CacaoSignature.fromJson(Map<String, dynamic> json) =>
      _$$_CacaoSignatureFromJson(json);

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
            other is _$_CacaoSignature &&
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
  _$$_CacaoSignatureCopyWith<_$_CacaoSignature> get copyWith =>
      __$$_CacaoSignatureCopyWithImpl<_$_CacaoSignature>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_CacaoSignatureToJson(
      this,
    );
  }
}

abstract class _CacaoSignature implements CacaoSignature {
  const factory _CacaoSignature(
      {required final String t,
      required final String s,
      final String? m}) = _$_CacaoSignature;

  factory _CacaoSignature.fromJson(Map<String, dynamic> json) =
      _$_CacaoSignature.fromJson;

  @override
  String get t;
  @override
  String get s;
  @override
  String? get m;
  @override
  @JsonKey(ignore: true)
  _$$_CacaoSignatureCopyWith<_$_CacaoSignature> get copyWith =>
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
abstract class _$$_CacaoCopyWith<$Res> implements $CacaoCopyWith<$Res> {
  factory _$$_CacaoCopyWith(_$_Cacao value, $Res Function(_$_Cacao) then) =
      __$$_CacaoCopyWithImpl<$Res>;
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
class __$$_CacaoCopyWithImpl<$Res> extends _$CacaoCopyWithImpl<$Res, _$_Cacao>
    implements _$$_CacaoCopyWith<$Res> {
  __$$_CacaoCopyWithImpl(_$_Cacao _value, $Res Function(_$_Cacao) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? h = null,
    Object? p = null,
    Object? s = null,
  }) {
    return _then(_$_Cacao(
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
class _$_Cacao implements _Cacao {
  const _$_Cacao({required this.h, required this.p, required this.s});

  factory _$_Cacao.fromJson(Map<String, dynamic> json) =>
      _$$_CacaoFromJson(json);

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
            other is _$_Cacao &&
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
  _$$_CacaoCopyWith<_$_Cacao> get copyWith =>
      __$$_CacaoCopyWithImpl<_$_Cacao>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_CacaoToJson(
      this,
    );
  }
}

abstract class _Cacao implements Cacao {
  const factory _Cacao(
      {required final CacaoHeader h,
      required final CacaoPayload p,
      required final CacaoSignature s}) = _$_Cacao;

  factory _Cacao.fromJson(Map<String, dynamic> json) = _$_Cacao.fromJson;

  @override
  CacaoHeader get h;
  @override
  CacaoPayload get p;
  @override
  CacaoSignature get s;
  @override
  @JsonKey(ignore: true)
  _$$_CacaoCopyWith<_$_Cacao> get copyWith =>
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
abstract class _$$_StoredCacaoCopyWith<$Res>
    implements $StoredCacaoCopyWith<$Res> {
  factory _$$_StoredCacaoCopyWith(
          _$_StoredCacao value, $Res Function(_$_StoredCacao) then) =
      __$$_StoredCacaoCopyWithImpl<$Res>;
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
class __$$_StoredCacaoCopyWithImpl<$Res>
    extends _$StoredCacaoCopyWithImpl<$Res, _$_StoredCacao>
    implements _$$_StoredCacaoCopyWith<$Res> {
  __$$_StoredCacaoCopyWithImpl(
      _$_StoredCacao _value, $Res Function(_$_StoredCacao) _then)
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
    return _then(_$_StoredCacao(
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
class _$_StoredCacao implements _StoredCacao {
  const _$_StoredCacao(
      {required this.id,
      required this.pairingTopic,
      required this.h,
      required this.p,
      required this.s});

  factory _$_StoredCacao.fromJson(Map<String, dynamic> json) =>
      _$$_StoredCacaoFromJson(json);

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
            other is _$_StoredCacao &&
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
  _$$_StoredCacaoCopyWith<_$_StoredCacao> get copyWith =>
      __$$_StoredCacaoCopyWithImpl<_$_StoredCacao>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_StoredCacaoToJson(
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
      required final CacaoSignature s}) = _$_StoredCacao;

  factory _StoredCacao.fromJson(Map<String, dynamic> json) =
      _$_StoredCacao.fromJson;

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
  _$$_StoredCacaoCopyWith<_$_StoredCacao> get copyWith =>
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
abstract class _$$_PendingAuthRequestCopyWith<$Res>
    implements $PendingAuthRequestCopyWith<$Res> {
  factory _$$_PendingAuthRequestCopyWith(_$_PendingAuthRequest value,
          $Res Function(_$_PendingAuthRequest) then) =
      __$$_PendingAuthRequestCopyWithImpl<$Res>;
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
class __$$_PendingAuthRequestCopyWithImpl<$Res>
    extends _$PendingAuthRequestCopyWithImpl<$Res, _$_PendingAuthRequest>
    implements _$$_PendingAuthRequestCopyWith<$Res> {
  __$$_PendingAuthRequestCopyWithImpl(
      _$_PendingAuthRequest _value, $Res Function(_$_PendingAuthRequest) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? pairingTopic = null,
    Object? metadata = null,
    Object? cacaoPayload = null,
  }) {
    return _then(_$_PendingAuthRequest(
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
class _$_PendingAuthRequest implements _PendingAuthRequest {
  const _$_PendingAuthRequest(
      {required this.id,
      required this.pairingTopic,
      required this.metadata,
      required this.cacaoPayload});

  factory _$_PendingAuthRequest.fromJson(Map<String, dynamic> json) =>
      _$$_PendingAuthRequestFromJson(json);

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
            other is _$_PendingAuthRequest &&
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
  _$$_PendingAuthRequestCopyWith<_$_PendingAuthRequest> get copyWith =>
      __$$_PendingAuthRequestCopyWithImpl<_$_PendingAuthRequest>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_PendingAuthRequestToJson(
      this,
    );
  }
}

abstract class _PendingAuthRequest implements PendingAuthRequest {
  const factory _PendingAuthRequest(
      {required final int id,
      required final String pairingTopic,
      required final ConnectionMetadata metadata,
      required final CacaoRequestPayload cacaoPayload}) = _$_PendingAuthRequest;

  factory _PendingAuthRequest.fromJson(Map<String, dynamic> json) =
      _$_PendingAuthRequest.fromJson;

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
  _$$_PendingAuthRequestCopyWith<_$_PendingAuthRequest> get copyWith =>
      throw _privateConstructorUsedError;
}

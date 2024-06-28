// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'session_auth_models.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

SessionAuthRequestParams _$SessionAuthRequestParamsFromJson(
    Map<String, dynamic> json) {
  return _SessionAuthRequestParams.fromJson(json);
}

/// @nodoc
mixin _$SessionAuthRequestParams {
  List<String> get chains => throw _privateConstructorUsedError;
  String get domain => throw _privateConstructorUsedError;
  String get nonce => throw _privateConstructorUsedError;
  String get uri => throw _privateConstructorUsedError; //
  CacaoHeader? get type => throw _privateConstructorUsedError;
  String? get nbf => throw _privateConstructorUsedError;
  String? get exp => throw _privateConstructorUsedError;
  String? get statement => throw _privateConstructorUsedError;
  String? get requestId => throw _privateConstructorUsedError;
  List<String>? get resources => throw _privateConstructorUsedError;
  int? get expiry => throw _privateConstructorUsedError;
  List<String>? get methods => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $SessionAuthRequestParamsCopyWith<SessionAuthRequestParams> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SessionAuthRequestParamsCopyWith<$Res> {
  factory $SessionAuthRequestParamsCopyWith(SessionAuthRequestParams value,
          $Res Function(SessionAuthRequestParams) then) =
      _$SessionAuthRequestParamsCopyWithImpl<$Res, SessionAuthRequestParams>;
  @useResult
  $Res call(
      {List<String> chains,
      String domain,
      String nonce,
      String uri,
      CacaoHeader? type,
      String? nbf,
      String? exp,
      String? statement,
      String? requestId,
      List<String>? resources,
      int? expiry,
      List<String>? methods});

  $CacaoHeaderCopyWith<$Res>? get type;
}

/// @nodoc
class _$SessionAuthRequestParamsCopyWithImpl<$Res,
        $Val extends SessionAuthRequestParams>
    implements $SessionAuthRequestParamsCopyWith<$Res> {
  _$SessionAuthRequestParamsCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? chains = null,
    Object? domain = null,
    Object? nonce = null,
    Object? uri = null,
    Object? type = freezed,
    Object? nbf = freezed,
    Object? exp = freezed,
    Object? statement = freezed,
    Object? requestId = freezed,
    Object? resources = freezed,
    Object? expiry = freezed,
    Object? methods = freezed,
  }) {
    return _then(_value.copyWith(
      chains: null == chains
          ? _value.chains
          : chains // ignore: cast_nullable_to_non_nullable
              as List<String>,
      domain: null == domain
          ? _value.domain
          : domain // ignore: cast_nullable_to_non_nullable
              as String,
      nonce: null == nonce
          ? _value.nonce
          : nonce // ignore: cast_nullable_to_non_nullable
              as String,
      uri: null == uri
          ? _value.uri
          : uri // ignore: cast_nullable_to_non_nullable
              as String,
      type: freezed == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as CacaoHeader?,
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
      expiry: freezed == expiry
          ? _value.expiry
          : expiry // ignore: cast_nullable_to_non_nullable
              as int?,
      methods: freezed == methods
          ? _value.methods
          : methods // ignore: cast_nullable_to_non_nullable
              as List<String>?,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $CacaoHeaderCopyWith<$Res>? get type {
    if (_value.type == null) {
      return null;
    }

    return $CacaoHeaderCopyWith<$Res>(_value.type!, (value) {
      return _then(_value.copyWith(type: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$SessionAuthRequestParamsImplCopyWith<$Res>
    implements $SessionAuthRequestParamsCopyWith<$Res> {
  factory _$$SessionAuthRequestParamsImplCopyWith(
          _$SessionAuthRequestParamsImpl value,
          $Res Function(_$SessionAuthRequestParamsImpl) then) =
      __$$SessionAuthRequestParamsImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {List<String> chains,
      String domain,
      String nonce,
      String uri,
      CacaoHeader? type,
      String? nbf,
      String? exp,
      String? statement,
      String? requestId,
      List<String>? resources,
      int? expiry,
      List<String>? methods});

  @override
  $CacaoHeaderCopyWith<$Res>? get type;
}

/// @nodoc
class __$$SessionAuthRequestParamsImplCopyWithImpl<$Res>
    extends _$SessionAuthRequestParamsCopyWithImpl<$Res,
        _$SessionAuthRequestParamsImpl>
    implements _$$SessionAuthRequestParamsImplCopyWith<$Res> {
  __$$SessionAuthRequestParamsImplCopyWithImpl(
      _$SessionAuthRequestParamsImpl _value,
      $Res Function(_$SessionAuthRequestParamsImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? chains = null,
    Object? domain = null,
    Object? nonce = null,
    Object? uri = null,
    Object? type = freezed,
    Object? nbf = freezed,
    Object? exp = freezed,
    Object? statement = freezed,
    Object? requestId = freezed,
    Object? resources = freezed,
    Object? expiry = freezed,
    Object? methods = freezed,
  }) {
    return _then(_$SessionAuthRequestParamsImpl(
      chains: null == chains
          ? _value._chains
          : chains // ignore: cast_nullable_to_non_nullable
              as List<String>,
      domain: null == domain
          ? _value.domain
          : domain // ignore: cast_nullable_to_non_nullable
              as String,
      nonce: null == nonce
          ? _value.nonce
          : nonce // ignore: cast_nullable_to_non_nullable
              as String,
      uri: null == uri
          ? _value.uri
          : uri // ignore: cast_nullable_to_non_nullable
              as String,
      type: freezed == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as CacaoHeader?,
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
      expiry: freezed == expiry
          ? _value.expiry
          : expiry // ignore: cast_nullable_to_non_nullable
              as int?,
      methods: freezed == methods
          ? _value._methods
          : methods // ignore: cast_nullable_to_non_nullable
              as List<String>?,
    ));
  }
}

/// @nodoc

@JsonSerializable(includeIfNull: false)
class _$SessionAuthRequestParamsImpl implements _SessionAuthRequestParams {
  const _$SessionAuthRequestParamsImpl(
      {required final List<String> chains,
      required this.domain,
      required this.nonce,
      required this.uri,
      this.type,
      this.nbf,
      this.exp,
      this.statement,
      this.requestId,
      final List<String>? resources,
      this.expiry,
      final List<String>? methods = const <String>[]})
      : _chains = chains,
        _resources = resources,
        _methods = methods;

  factory _$SessionAuthRequestParamsImpl.fromJson(Map<String, dynamic> json) =>
      _$$SessionAuthRequestParamsImplFromJson(json);

  final List<String> _chains;
  @override
  List<String> get chains {
    if (_chains is EqualUnmodifiableListView) return _chains;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_chains);
  }

  @override
  final String domain;
  @override
  final String nonce;
  @override
  final String uri;
//
  @override
  final CacaoHeader? type;
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
  final int? expiry;
  final List<String>? _methods;
  @override
  @JsonKey()
  List<String>? get methods {
    final value = _methods;
    if (value == null) return null;
    if (_methods is EqualUnmodifiableListView) return _methods;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  @override
  String toString() {
    return 'SessionAuthRequestParams(chains: $chains, domain: $domain, nonce: $nonce, uri: $uri, type: $type, nbf: $nbf, exp: $exp, statement: $statement, requestId: $requestId, resources: $resources, expiry: $expiry, methods: $methods)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SessionAuthRequestParamsImpl &&
            const DeepCollectionEquality().equals(other._chains, _chains) &&
            (identical(other.domain, domain) || other.domain == domain) &&
            (identical(other.nonce, nonce) || other.nonce == nonce) &&
            (identical(other.uri, uri) || other.uri == uri) &&
            (identical(other.type, type) || other.type == type) &&
            (identical(other.nbf, nbf) || other.nbf == nbf) &&
            (identical(other.exp, exp) || other.exp == exp) &&
            (identical(other.statement, statement) ||
                other.statement == statement) &&
            (identical(other.requestId, requestId) ||
                other.requestId == requestId) &&
            const DeepCollectionEquality()
                .equals(other._resources, _resources) &&
            (identical(other.expiry, expiry) || other.expiry == expiry) &&
            const DeepCollectionEquality().equals(other._methods, _methods));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(_chains),
      domain,
      nonce,
      uri,
      type,
      nbf,
      exp,
      statement,
      requestId,
      const DeepCollectionEquality().hash(_resources),
      expiry,
      const DeepCollectionEquality().hash(_methods));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$SessionAuthRequestParamsImplCopyWith<_$SessionAuthRequestParamsImpl>
      get copyWith => __$$SessionAuthRequestParamsImplCopyWithImpl<
          _$SessionAuthRequestParamsImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$SessionAuthRequestParamsImplToJson(
      this,
    );
  }
}

abstract class _SessionAuthRequestParams implements SessionAuthRequestParams {
  const factory _SessionAuthRequestParams(
      {required final List<String> chains,
      required final String domain,
      required final String nonce,
      required final String uri,
      final CacaoHeader? type,
      final String? nbf,
      final String? exp,
      final String? statement,
      final String? requestId,
      final List<String>? resources,
      final int? expiry,
      final List<String>? methods}) = _$SessionAuthRequestParamsImpl;

  factory _SessionAuthRequestParams.fromJson(Map<String, dynamic> json) =
      _$SessionAuthRequestParamsImpl.fromJson;

  @override
  List<String> get chains;
  @override
  String get domain;
  @override
  String get nonce;
  @override
  String get uri;
  @override //
  CacaoHeader? get type;
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
  int? get expiry;
  @override
  List<String>? get methods;
  @override
  @JsonKey(ignore: true)
  _$$SessionAuthRequestParamsImplCopyWith<_$SessionAuthRequestParamsImpl>
      get copyWith => throw _privateConstructorUsedError;
}

SessionAuthPayload _$SessionAuthPayloadFromJson(Map<String, dynamic> json) {
  return _SessionAuthPayload.fromJson(json);
}

/// @nodoc
mixin _$SessionAuthPayload {
  List<String> get chains => throw _privateConstructorUsedError;
  String get domain => throw _privateConstructorUsedError;
  String get nonce => throw _privateConstructorUsedError;
  String get aud => throw _privateConstructorUsedError;
  String get type => throw _privateConstructorUsedError; //
  String get version => throw _privateConstructorUsedError;
  String get iat => throw _privateConstructorUsedError; //
  String? get nbf => throw _privateConstructorUsedError;
  String? get exp => throw _privateConstructorUsedError;
  String? get statement => throw _privateConstructorUsedError;
  String? get requestId => throw _privateConstructorUsedError;
  List<String>? get resources => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $SessionAuthPayloadCopyWith<SessionAuthPayload> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SessionAuthPayloadCopyWith<$Res> {
  factory $SessionAuthPayloadCopyWith(
          SessionAuthPayload value, $Res Function(SessionAuthPayload) then) =
      _$SessionAuthPayloadCopyWithImpl<$Res, SessionAuthPayload>;
  @useResult
  $Res call(
      {List<String> chains,
      String domain,
      String nonce,
      String aud,
      String type,
      String version,
      String iat,
      String? nbf,
      String? exp,
      String? statement,
      String? requestId,
      List<String>? resources});
}

/// @nodoc
class _$SessionAuthPayloadCopyWithImpl<$Res, $Val extends SessionAuthPayload>
    implements $SessionAuthPayloadCopyWith<$Res> {
  _$SessionAuthPayloadCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? chains = null,
    Object? domain = null,
    Object? nonce = null,
    Object? aud = null,
    Object? type = null,
    Object? version = null,
    Object? iat = null,
    Object? nbf = freezed,
    Object? exp = freezed,
    Object? statement = freezed,
    Object? requestId = freezed,
    Object? resources = freezed,
  }) {
    return _then(_value.copyWith(
      chains: null == chains
          ? _value.chains
          : chains // ignore: cast_nullable_to_non_nullable
              as List<String>,
      domain: null == domain
          ? _value.domain
          : domain // ignore: cast_nullable_to_non_nullable
              as String,
      nonce: null == nonce
          ? _value.nonce
          : nonce // ignore: cast_nullable_to_non_nullable
              as String,
      aud: null == aud
          ? _value.aud
          : aud // ignore: cast_nullable_to_non_nullable
              as String,
      type: null == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as String,
      version: null == version
          ? _value.version
          : version // ignore: cast_nullable_to_non_nullable
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
abstract class _$$SessionAuthPayloadImplCopyWith<$Res>
    implements $SessionAuthPayloadCopyWith<$Res> {
  factory _$$SessionAuthPayloadImplCopyWith(_$SessionAuthPayloadImpl value,
          $Res Function(_$SessionAuthPayloadImpl) then) =
      __$$SessionAuthPayloadImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {List<String> chains,
      String domain,
      String nonce,
      String aud,
      String type,
      String version,
      String iat,
      String? nbf,
      String? exp,
      String? statement,
      String? requestId,
      List<String>? resources});
}

/// @nodoc
class __$$SessionAuthPayloadImplCopyWithImpl<$Res>
    extends _$SessionAuthPayloadCopyWithImpl<$Res, _$SessionAuthPayloadImpl>
    implements _$$SessionAuthPayloadImplCopyWith<$Res> {
  __$$SessionAuthPayloadImplCopyWithImpl(_$SessionAuthPayloadImpl _value,
      $Res Function(_$SessionAuthPayloadImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? chains = null,
    Object? domain = null,
    Object? nonce = null,
    Object? aud = null,
    Object? type = null,
    Object? version = null,
    Object? iat = null,
    Object? nbf = freezed,
    Object? exp = freezed,
    Object? statement = freezed,
    Object? requestId = freezed,
    Object? resources = freezed,
  }) {
    return _then(_$SessionAuthPayloadImpl(
      chains: null == chains
          ? _value._chains
          : chains // ignore: cast_nullable_to_non_nullable
              as List<String>,
      domain: null == domain
          ? _value.domain
          : domain // ignore: cast_nullable_to_non_nullable
              as String,
      nonce: null == nonce
          ? _value.nonce
          : nonce // ignore: cast_nullable_to_non_nullable
              as String,
      aud: null == aud
          ? _value.aud
          : aud // ignore: cast_nullable_to_non_nullable
              as String,
      type: null == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as String,
      version: null == version
          ? _value.version
          : version // ignore: cast_nullable_to_non_nullable
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
class _$SessionAuthPayloadImpl implements _SessionAuthPayload {
  const _$SessionAuthPayloadImpl(
      {required final List<String> chains,
      required this.domain,
      required this.nonce,
      required this.aud,
      required this.type,
      required this.version,
      required this.iat,
      this.nbf,
      this.exp,
      this.statement,
      this.requestId,
      final List<String>? resources})
      : _chains = chains,
        _resources = resources;

  factory _$SessionAuthPayloadImpl.fromJson(Map<String, dynamic> json) =>
      _$$SessionAuthPayloadImplFromJson(json);

  final List<String> _chains;
  @override
  List<String> get chains {
    if (_chains is EqualUnmodifiableListView) return _chains;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_chains);
  }

  @override
  final String domain;
  @override
  final String nonce;
  @override
  final String aud;
  @override
  final String type;
//
  @override
  final String version;
  @override
  final String iat;
//
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
    return 'SessionAuthPayload(chains: $chains, domain: $domain, nonce: $nonce, aud: $aud, type: $type, version: $version, iat: $iat, nbf: $nbf, exp: $exp, statement: $statement, requestId: $requestId, resources: $resources)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SessionAuthPayloadImpl &&
            const DeepCollectionEquality().equals(other._chains, _chains) &&
            (identical(other.domain, domain) || other.domain == domain) &&
            (identical(other.nonce, nonce) || other.nonce == nonce) &&
            (identical(other.aud, aud) || other.aud == aud) &&
            (identical(other.type, type) || other.type == type) &&
            (identical(other.version, version) || other.version == version) &&
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
      const DeepCollectionEquality().hash(_chains),
      domain,
      nonce,
      aud,
      type,
      version,
      iat,
      nbf,
      exp,
      statement,
      requestId,
      const DeepCollectionEquality().hash(_resources));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$SessionAuthPayloadImplCopyWith<_$SessionAuthPayloadImpl> get copyWith =>
      __$$SessionAuthPayloadImplCopyWithImpl<_$SessionAuthPayloadImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$SessionAuthPayloadImplToJson(
      this,
    );
  }
}

abstract class _SessionAuthPayload implements SessionAuthPayload {
  const factory _SessionAuthPayload(
      {required final List<String> chains,
      required final String domain,
      required final String nonce,
      required final String aud,
      required final String type,
      required final String version,
      required final String iat,
      final String? nbf,
      final String? exp,
      final String? statement,
      final String? requestId,
      final List<String>? resources}) = _$SessionAuthPayloadImpl;

  factory _SessionAuthPayload.fromJson(Map<String, dynamic> json) =
      _$SessionAuthPayloadImpl.fromJson;

  @override
  List<String> get chains;
  @override
  String get domain;
  @override
  String get nonce;
  @override
  String get aud;
  @override
  String get type;
  @override //
  String get version;
  @override
  String get iat;
  @override //
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
  _$$SessionAuthPayloadImplCopyWith<_$SessionAuthPayloadImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

PendingSessionAuthRequest _$PendingSessionAuthRequestFromJson(
    Map<String, dynamic> json) {
  return _PendingSessionAuthRequest.fromJson(json);
}

/// @nodoc
mixin _$PendingSessionAuthRequest {
  int get id => throw _privateConstructorUsedError;
  String get pairingTopic => throw _privateConstructorUsedError;
  ConnectionMetadata get requester => throw _privateConstructorUsedError;
  int get expiryTimestamp => throw _privateConstructorUsedError;
  CacaoRequestPayload get authPayload => throw _privateConstructorUsedError;
  VerifyContext get verifyContext => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $PendingSessionAuthRequestCopyWith<PendingSessionAuthRequest> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PendingSessionAuthRequestCopyWith<$Res> {
  factory $PendingSessionAuthRequestCopyWith(PendingSessionAuthRequest value,
          $Res Function(PendingSessionAuthRequest) then) =
      _$PendingSessionAuthRequestCopyWithImpl<$Res, PendingSessionAuthRequest>;
  @useResult
  $Res call(
      {int id,
      String pairingTopic,
      ConnectionMetadata requester,
      int expiryTimestamp,
      CacaoRequestPayload authPayload,
      VerifyContext verifyContext});

  $ConnectionMetadataCopyWith<$Res> get requester;
  $CacaoRequestPayloadCopyWith<$Res> get authPayload;
  $VerifyContextCopyWith<$Res> get verifyContext;
}

/// @nodoc
class _$PendingSessionAuthRequestCopyWithImpl<$Res,
        $Val extends PendingSessionAuthRequest>
    implements $PendingSessionAuthRequestCopyWith<$Res> {
  _$PendingSessionAuthRequestCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? pairingTopic = null,
    Object? requester = null,
    Object? expiryTimestamp = null,
    Object? authPayload = null,
    Object? verifyContext = null,
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
      requester: null == requester
          ? _value.requester
          : requester // ignore: cast_nullable_to_non_nullable
              as ConnectionMetadata,
      expiryTimestamp: null == expiryTimestamp
          ? _value.expiryTimestamp
          : expiryTimestamp // ignore: cast_nullable_to_non_nullable
              as int,
      authPayload: null == authPayload
          ? _value.authPayload
          : authPayload // ignore: cast_nullable_to_non_nullable
              as CacaoRequestPayload,
      verifyContext: null == verifyContext
          ? _value.verifyContext
          : verifyContext // ignore: cast_nullable_to_non_nullable
              as VerifyContext,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $ConnectionMetadataCopyWith<$Res> get requester {
    return $ConnectionMetadataCopyWith<$Res>(_value.requester, (value) {
      return _then(_value.copyWith(requester: value) as $Val);
    });
  }

  @override
  @pragma('vm:prefer-inline')
  $CacaoRequestPayloadCopyWith<$Res> get authPayload {
    return $CacaoRequestPayloadCopyWith<$Res>(_value.authPayload, (value) {
      return _then(_value.copyWith(authPayload: value) as $Val);
    });
  }

  @override
  @pragma('vm:prefer-inline')
  $VerifyContextCopyWith<$Res> get verifyContext {
    return $VerifyContextCopyWith<$Res>(_value.verifyContext, (value) {
      return _then(_value.copyWith(verifyContext: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$PendingSessionAuthRequestImplCopyWith<$Res>
    implements $PendingSessionAuthRequestCopyWith<$Res> {
  factory _$$PendingSessionAuthRequestImplCopyWith(
          _$PendingSessionAuthRequestImpl value,
          $Res Function(_$PendingSessionAuthRequestImpl) then) =
      __$$PendingSessionAuthRequestImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {int id,
      String pairingTopic,
      ConnectionMetadata requester,
      int expiryTimestamp,
      CacaoRequestPayload authPayload,
      VerifyContext verifyContext});

  @override
  $ConnectionMetadataCopyWith<$Res> get requester;
  @override
  $CacaoRequestPayloadCopyWith<$Res> get authPayload;
  @override
  $VerifyContextCopyWith<$Res> get verifyContext;
}

/// @nodoc
class __$$PendingSessionAuthRequestImplCopyWithImpl<$Res>
    extends _$PendingSessionAuthRequestCopyWithImpl<$Res,
        _$PendingSessionAuthRequestImpl>
    implements _$$PendingSessionAuthRequestImplCopyWith<$Res> {
  __$$PendingSessionAuthRequestImplCopyWithImpl(
      _$PendingSessionAuthRequestImpl _value,
      $Res Function(_$PendingSessionAuthRequestImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? pairingTopic = null,
    Object? requester = null,
    Object? expiryTimestamp = null,
    Object? authPayload = null,
    Object? verifyContext = null,
  }) {
    return _then(_$PendingSessionAuthRequestImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      pairingTopic: null == pairingTopic
          ? _value.pairingTopic
          : pairingTopic // ignore: cast_nullable_to_non_nullable
              as String,
      requester: null == requester
          ? _value.requester
          : requester // ignore: cast_nullable_to_non_nullable
              as ConnectionMetadata,
      expiryTimestamp: null == expiryTimestamp
          ? _value.expiryTimestamp
          : expiryTimestamp // ignore: cast_nullable_to_non_nullable
              as int,
      authPayload: null == authPayload
          ? _value.authPayload
          : authPayload // ignore: cast_nullable_to_non_nullable
              as CacaoRequestPayload,
      verifyContext: null == verifyContext
          ? _value.verifyContext
          : verifyContext // ignore: cast_nullable_to_non_nullable
              as VerifyContext,
    ));
  }
}

/// @nodoc

@JsonSerializable(includeIfNull: false)
class _$PendingSessionAuthRequestImpl implements _PendingSessionAuthRequest {
  const _$PendingSessionAuthRequestImpl(
      {required this.id,
      required this.pairingTopic,
      required this.requester,
      required this.expiryTimestamp,
      required this.authPayload,
      required this.verifyContext});

  factory _$PendingSessionAuthRequestImpl.fromJson(Map<String, dynamic> json) =>
      _$$PendingSessionAuthRequestImplFromJson(json);

  @override
  final int id;
  @override
  final String pairingTopic;
  @override
  final ConnectionMetadata requester;
  @override
  final int expiryTimestamp;
  @override
  final CacaoRequestPayload authPayload;
  @override
  final VerifyContext verifyContext;

  @override
  String toString() {
    return 'PendingSessionAuthRequest(id: $id, pairingTopic: $pairingTopic, requester: $requester, expiryTimestamp: $expiryTimestamp, authPayload: $authPayload, verifyContext: $verifyContext)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$PendingSessionAuthRequestImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.pairingTopic, pairingTopic) ||
                other.pairingTopic == pairingTopic) &&
            (identical(other.requester, requester) ||
                other.requester == requester) &&
            (identical(other.expiryTimestamp, expiryTimestamp) ||
                other.expiryTimestamp == expiryTimestamp) &&
            (identical(other.authPayload, authPayload) ||
                other.authPayload == authPayload) &&
            (identical(other.verifyContext, verifyContext) ||
                other.verifyContext == verifyContext));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, id, pairingTopic, requester,
      expiryTimestamp, authPayload, verifyContext);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$PendingSessionAuthRequestImplCopyWith<_$PendingSessionAuthRequestImpl>
      get copyWith => __$$PendingSessionAuthRequestImplCopyWithImpl<
          _$PendingSessionAuthRequestImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$PendingSessionAuthRequestImplToJson(
      this,
    );
  }
}

abstract class _PendingSessionAuthRequest implements PendingSessionAuthRequest {
  const factory _PendingSessionAuthRequest(
          {required final int id,
          required final String pairingTopic,
          required final ConnectionMetadata requester,
          required final int expiryTimestamp,
          required final CacaoRequestPayload authPayload,
          required final VerifyContext verifyContext}) =
      _$PendingSessionAuthRequestImpl;

  factory _PendingSessionAuthRequest.fromJson(Map<String, dynamic> json) =
      _$PendingSessionAuthRequestImpl.fromJson;

  @override
  int get id;
  @override
  String get pairingTopic;
  @override
  ConnectionMetadata get requester;
  @override
  int get expiryTimestamp;
  @override
  CacaoRequestPayload get authPayload;
  @override
  VerifyContext get verifyContext;
  @override
  @JsonKey(ignore: true)
  _$$PendingSessionAuthRequestImplCopyWith<_$PendingSessionAuthRequestImpl>
      get copyWith => throw _privateConstructorUsedError;
}

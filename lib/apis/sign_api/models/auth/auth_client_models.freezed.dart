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

AuthPayloadParams _$AuthPayloadParamsFromJson(Map<String, dynamic> json) {
  return _AuthPayloadParams.fromJson(json);
}

/// @nodoc
mixin _$AuthPayloadParams {
  String get chainId => throw _privateConstructorUsedError;
  String get aud => throw _privateConstructorUsedError;
  String get domain => throw _privateConstructorUsedError;
  String get nonce => throw _privateConstructorUsedError;
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
      {String chainId,
      String aud,
      String domain,
      String nonce,
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
    Object? chainId = null,
    Object? aud = null,
    Object? domain = null,
    Object? nonce = null,
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
      chainId: null == chainId
          ? _value.chainId
          : chainId // ignore: cast_nullable_to_non_nullable
              as String,
      aud: null == aud
          ? _value.aud
          : aud // ignore: cast_nullable_to_non_nullable
              as String,
      domain: null == domain
          ? _value.domain
          : domain // ignore: cast_nullable_to_non_nullable
              as String,
      nonce: null == nonce
          ? _value.nonce
          : nonce // ignore: cast_nullable_to_non_nullable
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
abstract class _$$AuthPayloadParamsImplCopyWith<$Res>
    implements $AuthPayloadParamsCopyWith<$Res> {
  factory _$$AuthPayloadParamsImplCopyWith(_$AuthPayloadParamsImpl value,
          $Res Function(_$AuthPayloadParamsImpl) then) =
      __$$AuthPayloadParamsImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String chainId,
      String aud,
      String domain,
      String nonce,
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
class __$$AuthPayloadParamsImplCopyWithImpl<$Res>
    extends _$AuthPayloadParamsCopyWithImpl<$Res, _$AuthPayloadParamsImpl>
    implements _$$AuthPayloadParamsImplCopyWith<$Res> {
  __$$AuthPayloadParamsImplCopyWithImpl(_$AuthPayloadParamsImpl _value,
      $Res Function(_$AuthPayloadParamsImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? chainId = null,
    Object? aud = null,
    Object? domain = null,
    Object? nonce = null,
    Object? type = null,
    Object? version = null,
    Object? iat = null,
    Object? nbf = freezed,
    Object? exp = freezed,
    Object? statement = freezed,
    Object? requestId = freezed,
    Object? resources = freezed,
  }) {
    return _then(_$AuthPayloadParamsImpl(
      chainId: null == chainId
          ? _value.chainId
          : chainId // ignore: cast_nullable_to_non_nullable
              as String,
      aud: null == aud
          ? _value.aud
          : aud // ignore: cast_nullable_to_non_nullable
              as String,
      domain: null == domain
          ? _value.domain
          : domain // ignore: cast_nullable_to_non_nullable
              as String,
      nonce: null == nonce
          ? _value.nonce
          : nonce // ignore: cast_nullable_to_non_nullable
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
class _$AuthPayloadParamsImpl implements _AuthPayloadParams {
  const _$AuthPayloadParamsImpl(
      {required this.chainId,
      required this.aud,
      required this.domain,
      required this.nonce,
      required this.type,
      required this.version,
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
  final String chainId;
  @override
  final String aud;
  @override
  final String domain;
  @override
  final String nonce;
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
    return 'AuthPayloadParams(chainId: $chainId, aud: $aud, domain: $domain, nonce: $nonce, type: $type, version: $version, iat: $iat, nbf: $nbf, exp: $exp, statement: $statement, requestId: $requestId, resources: $resources)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AuthPayloadParamsImpl &&
            (identical(other.chainId, chainId) || other.chainId == chainId) &&
            (identical(other.aud, aud) || other.aud == aud) &&
            (identical(other.domain, domain) || other.domain == domain) &&
            (identical(other.nonce, nonce) || other.nonce == nonce) &&
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
      chainId,
      aud,
      domain,
      nonce,
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
      {required final String chainId,
      required final String aud,
      required final String domain,
      required final String nonce,
      required final String type,
      required final String version,
      required final String iat,
      final String? nbf,
      final String? exp,
      final String? statement,
      final String? requestId,
      final List<String>? resources}) = _$AuthPayloadParamsImpl;

  factory _AuthPayloadParams.fromJson(Map<String, dynamic> json) =
      _$AuthPayloadParamsImpl.fromJson;

  @override
  String get chainId;
  @override
  String get aud;
  @override
  String get domain;
  @override
  String get nonce;
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
  _$$AuthPayloadParamsImplCopyWith<_$AuthPayloadParamsImpl> get copyWith =>
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

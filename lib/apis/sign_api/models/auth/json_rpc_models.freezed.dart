// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'json_rpc_models.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

WcAuthRequestRequest _$WcAuthRequestRequestFromJson(Map<String, dynamic> json) {
  return _WcAuthRequestRequest.fromJson(json);
}

/// @nodoc
mixin _$WcAuthRequestRequest {
  AuthPayloadParams get payloadParams => throw _privateConstructorUsedError;
  ConnectionMetadata get requester => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $WcAuthRequestRequestCopyWith<WcAuthRequestRequest> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $WcAuthRequestRequestCopyWith<$Res> {
  factory $WcAuthRequestRequestCopyWith(WcAuthRequestRequest value,
          $Res Function(WcAuthRequestRequest) then) =
      _$WcAuthRequestRequestCopyWithImpl<$Res, WcAuthRequestRequest>;
  @useResult
  $Res call({AuthPayloadParams payloadParams, ConnectionMetadata requester});

  $AuthPayloadParamsCopyWith<$Res> get payloadParams;
  $ConnectionMetadataCopyWith<$Res> get requester;
}

/// @nodoc
class _$WcAuthRequestRequestCopyWithImpl<$Res,
        $Val extends WcAuthRequestRequest>
    implements $WcAuthRequestRequestCopyWith<$Res> {
  _$WcAuthRequestRequestCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? payloadParams = null,
    Object? requester = null,
  }) {
    return _then(_value.copyWith(
      payloadParams: null == payloadParams
          ? _value.payloadParams
          : payloadParams // ignore: cast_nullable_to_non_nullable
              as AuthPayloadParams,
      requester: null == requester
          ? _value.requester
          : requester // ignore: cast_nullable_to_non_nullable
              as ConnectionMetadata,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $AuthPayloadParamsCopyWith<$Res> get payloadParams {
    return $AuthPayloadParamsCopyWith<$Res>(_value.payloadParams, (value) {
      return _then(_value.copyWith(payloadParams: value) as $Val);
    });
  }

  @override
  @pragma('vm:prefer-inline')
  $ConnectionMetadataCopyWith<$Res> get requester {
    return $ConnectionMetadataCopyWith<$Res>(_value.requester, (value) {
      return _then(_value.copyWith(requester: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$WcAuthRequestRequestImplCopyWith<$Res>
    implements $WcAuthRequestRequestCopyWith<$Res> {
  factory _$$WcAuthRequestRequestImplCopyWith(_$WcAuthRequestRequestImpl value,
          $Res Function(_$WcAuthRequestRequestImpl) then) =
      __$$WcAuthRequestRequestImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({AuthPayloadParams payloadParams, ConnectionMetadata requester});

  @override
  $AuthPayloadParamsCopyWith<$Res> get payloadParams;
  @override
  $ConnectionMetadataCopyWith<$Res> get requester;
}

/// @nodoc
class __$$WcAuthRequestRequestImplCopyWithImpl<$Res>
    extends _$WcAuthRequestRequestCopyWithImpl<$Res, _$WcAuthRequestRequestImpl>
    implements _$$WcAuthRequestRequestImplCopyWith<$Res> {
  __$$WcAuthRequestRequestImplCopyWithImpl(_$WcAuthRequestRequestImpl _value,
      $Res Function(_$WcAuthRequestRequestImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? payloadParams = null,
    Object? requester = null,
  }) {
    return _then(_$WcAuthRequestRequestImpl(
      payloadParams: null == payloadParams
          ? _value.payloadParams
          : payloadParams // ignore: cast_nullable_to_non_nullable
              as AuthPayloadParams,
      requester: null == requester
          ? _value.requester
          : requester // ignore: cast_nullable_to_non_nullable
              as ConnectionMetadata,
    ));
  }
}

/// @nodoc

@JsonSerializable()
class _$WcAuthRequestRequestImpl implements _WcAuthRequestRequest {
  const _$WcAuthRequestRequestImpl(
      {required this.payloadParams, required this.requester});

  factory _$WcAuthRequestRequestImpl.fromJson(Map<String, dynamic> json) =>
      _$$WcAuthRequestRequestImplFromJson(json);

  @override
  final AuthPayloadParams payloadParams;
  @override
  final ConnectionMetadata requester;

  @override
  String toString() {
    return 'WcAuthRequestRequest(payloadParams: $payloadParams, requester: $requester)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$WcAuthRequestRequestImpl &&
            (identical(other.payloadParams, payloadParams) ||
                other.payloadParams == payloadParams) &&
            (identical(other.requester, requester) ||
                other.requester == requester));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, payloadParams, requester);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$WcAuthRequestRequestImplCopyWith<_$WcAuthRequestRequestImpl>
      get copyWith =>
          __$$WcAuthRequestRequestImplCopyWithImpl<_$WcAuthRequestRequestImpl>(
              this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$WcAuthRequestRequestImplToJson(
      this,
    );
  }
}

abstract class _WcAuthRequestRequest implements WcAuthRequestRequest {
  const factory _WcAuthRequestRequest(
          {required final AuthPayloadParams payloadParams,
          required final ConnectionMetadata requester}) =
      _$WcAuthRequestRequestImpl;

  factory _WcAuthRequestRequest.fromJson(Map<String, dynamic> json) =
      _$WcAuthRequestRequestImpl.fromJson;

  @override
  AuthPayloadParams get payloadParams;
  @override
  ConnectionMetadata get requester;
  @override
  @JsonKey(ignore: true)
  _$$WcAuthRequestRequestImplCopyWith<_$WcAuthRequestRequestImpl>
      get copyWith => throw _privateConstructorUsedError;
}

WcAuthRequestResult _$WcAuthRequestResultFromJson(Map<String, dynamic> json) {
  return _WcAuthRequestResult.fromJson(json);
}

/// @nodoc
mixin _$WcAuthRequestResult {
  Cacao get cacao => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $WcAuthRequestResultCopyWith<WcAuthRequestResult> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $WcAuthRequestResultCopyWith<$Res> {
  factory $WcAuthRequestResultCopyWith(
          WcAuthRequestResult value, $Res Function(WcAuthRequestResult) then) =
      _$WcAuthRequestResultCopyWithImpl<$Res, WcAuthRequestResult>;
  @useResult
  $Res call({Cacao cacao});

  $CacaoCopyWith<$Res> get cacao;
}

/// @nodoc
class _$WcAuthRequestResultCopyWithImpl<$Res, $Val extends WcAuthRequestResult>
    implements $WcAuthRequestResultCopyWith<$Res> {
  _$WcAuthRequestResultCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? cacao = null,
  }) {
    return _then(_value.copyWith(
      cacao: null == cacao
          ? _value.cacao
          : cacao // ignore: cast_nullable_to_non_nullable
              as Cacao,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $CacaoCopyWith<$Res> get cacao {
    return $CacaoCopyWith<$Res>(_value.cacao, (value) {
      return _then(_value.copyWith(cacao: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$WcAuthRequestResultImplCopyWith<$Res>
    implements $WcAuthRequestResultCopyWith<$Res> {
  factory _$$WcAuthRequestResultImplCopyWith(_$WcAuthRequestResultImpl value,
          $Res Function(_$WcAuthRequestResultImpl) then) =
      __$$WcAuthRequestResultImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({Cacao cacao});

  @override
  $CacaoCopyWith<$Res> get cacao;
}

/// @nodoc
class __$$WcAuthRequestResultImplCopyWithImpl<$Res>
    extends _$WcAuthRequestResultCopyWithImpl<$Res, _$WcAuthRequestResultImpl>
    implements _$$WcAuthRequestResultImplCopyWith<$Res> {
  __$$WcAuthRequestResultImplCopyWithImpl(_$WcAuthRequestResultImpl _value,
      $Res Function(_$WcAuthRequestResultImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? cacao = null,
  }) {
    return _then(_$WcAuthRequestResultImpl(
      cacao: null == cacao
          ? _value.cacao
          : cacao // ignore: cast_nullable_to_non_nullable
              as Cacao,
    ));
  }
}

/// @nodoc

@JsonSerializable()
class _$WcAuthRequestResultImpl implements _WcAuthRequestResult {
  const _$WcAuthRequestResultImpl({required this.cacao});

  factory _$WcAuthRequestResultImpl.fromJson(Map<String, dynamic> json) =>
      _$$WcAuthRequestResultImplFromJson(json);

  @override
  final Cacao cacao;

  @override
  String toString() {
    return 'WcAuthRequestResult(cacao: $cacao)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$WcAuthRequestResultImpl &&
            (identical(other.cacao, cacao) || other.cacao == cacao));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, cacao);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$WcAuthRequestResultImplCopyWith<_$WcAuthRequestResultImpl> get copyWith =>
      __$$WcAuthRequestResultImplCopyWithImpl<_$WcAuthRequestResultImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$WcAuthRequestResultImplToJson(
      this,
    );
  }
}

abstract class _WcAuthRequestResult implements WcAuthRequestResult {
  const factory _WcAuthRequestResult({required final Cacao cacao}) =
      _$WcAuthRequestResultImpl;

  factory _WcAuthRequestResult.fromJson(Map<String, dynamic> json) =
      _$WcAuthRequestResultImpl.fromJson;

  @override
  Cacao get cacao;
  @override
  @JsonKey(ignore: true)
  _$$WcAuthRequestResultImplCopyWith<_$WcAuthRequestResultImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

WcOCARequestRequest _$WcOCARequestRequestFromJson(Map<String, dynamic> json) {
  return _WcOCARequestRequest.fromJson(json);
}

/// @nodoc
mixin _$WcOCARequestRequest {
  OCAPayloadParams get authPayload => throw _privateConstructorUsedError;
  ConnectionMetadata get requester => throw _privateConstructorUsedError;
  int get expiryTimestamp => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $WcOCARequestRequestCopyWith<WcOCARequestRequest> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $WcOCARequestRequestCopyWith<$Res> {
  factory $WcOCARequestRequestCopyWith(
          WcOCARequestRequest value, $Res Function(WcOCARequestRequest) then) =
      _$WcOCARequestRequestCopyWithImpl<$Res, WcOCARequestRequest>;
  @useResult
  $Res call(
      {OCAPayloadParams authPayload,
      ConnectionMetadata requester,
      int expiryTimestamp});

  $OCAPayloadParamsCopyWith<$Res> get authPayload;
  $ConnectionMetadataCopyWith<$Res> get requester;
}

/// @nodoc
class _$WcOCARequestRequestCopyWithImpl<$Res, $Val extends WcOCARequestRequest>
    implements $WcOCARequestRequestCopyWith<$Res> {
  _$WcOCARequestRequestCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? authPayload = null,
    Object? requester = null,
    Object? expiryTimestamp = null,
  }) {
    return _then(_value.copyWith(
      authPayload: null == authPayload
          ? _value.authPayload
          : authPayload // ignore: cast_nullable_to_non_nullable
              as OCAPayloadParams,
      requester: null == requester
          ? _value.requester
          : requester // ignore: cast_nullable_to_non_nullable
              as ConnectionMetadata,
      expiryTimestamp: null == expiryTimestamp
          ? _value.expiryTimestamp
          : expiryTimestamp // ignore: cast_nullable_to_non_nullable
              as int,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $OCAPayloadParamsCopyWith<$Res> get authPayload {
    return $OCAPayloadParamsCopyWith<$Res>(_value.authPayload, (value) {
      return _then(_value.copyWith(authPayload: value) as $Val);
    });
  }

  @override
  @pragma('vm:prefer-inline')
  $ConnectionMetadataCopyWith<$Res> get requester {
    return $ConnectionMetadataCopyWith<$Res>(_value.requester, (value) {
      return _then(_value.copyWith(requester: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$WcOCARequestRequestImplCopyWith<$Res>
    implements $WcOCARequestRequestCopyWith<$Res> {
  factory _$$WcOCARequestRequestImplCopyWith(_$WcOCARequestRequestImpl value,
          $Res Function(_$WcOCARequestRequestImpl) then) =
      __$$WcOCARequestRequestImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {OCAPayloadParams authPayload,
      ConnectionMetadata requester,
      int expiryTimestamp});

  @override
  $OCAPayloadParamsCopyWith<$Res> get authPayload;
  @override
  $ConnectionMetadataCopyWith<$Res> get requester;
}

/// @nodoc
class __$$WcOCARequestRequestImplCopyWithImpl<$Res>
    extends _$WcOCARequestRequestCopyWithImpl<$Res, _$WcOCARequestRequestImpl>
    implements _$$WcOCARequestRequestImplCopyWith<$Res> {
  __$$WcOCARequestRequestImplCopyWithImpl(_$WcOCARequestRequestImpl _value,
      $Res Function(_$WcOCARequestRequestImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? authPayload = null,
    Object? requester = null,
    Object? expiryTimestamp = null,
  }) {
    return _then(_$WcOCARequestRequestImpl(
      authPayload: null == authPayload
          ? _value.authPayload
          : authPayload // ignore: cast_nullable_to_non_nullable
              as OCAPayloadParams,
      requester: null == requester
          ? _value.requester
          : requester // ignore: cast_nullable_to_non_nullable
              as ConnectionMetadata,
      expiryTimestamp: null == expiryTimestamp
          ? _value.expiryTimestamp
          : expiryTimestamp // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc

@JsonSerializable()
class _$WcOCARequestRequestImpl implements _WcOCARequestRequest {
  const _$WcOCARequestRequestImpl(
      {required this.authPayload,
      required this.requester,
      required this.expiryTimestamp});

  factory _$WcOCARequestRequestImpl.fromJson(Map<String, dynamic> json) =>
      _$$WcOCARequestRequestImplFromJson(json);

  @override
  final OCAPayloadParams authPayload;
  @override
  final ConnectionMetadata requester;
  @override
  final int expiryTimestamp;

  @override
  String toString() {
    return 'WcOCARequestRequest(authPayload: $authPayload, requester: $requester, expiryTimestamp: $expiryTimestamp)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$WcOCARequestRequestImpl &&
            (identical(other.authPayload, authPayload) ||
                other.authPayload == authPayload) &&
            (identical(other.requester, requester) ||
                other.requester == requester) &&
            (identical(other.expiryTimestamp, expiryTimestamp) ||
                other.expiryTimestamp == expiryTimestamp));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode =>
      Object.hash(runtimeType, authPayload, requester, expiryTimestamp);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$WcOCARequestRequestImplCopyWith<_$WcOCARequestRequestImpl> get copyWith =>
      __$$WcOCARequestRequestImplCopyWithImpl<_$WcOCARequestRequestImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$WcOCARequestRequestImplToJson(
      this,
    );
  }
}

abstract class _WcOCARequestRequest implements WcOCARequestRequest {
  const factory _WcOCARequestRequest(
      {required final OCAPayloadParams authPayload,
      required final ConnectionMetadata requester,
      required final int expiryTimestamp}) = _$WcOCARequestRequestImpl;

  factory _WcOCARequestRequest.fromJson(Map<String, dynamic> json) =
      _$WcOCARequestRequestImpl.fromJson;

  @override
  OCAPayloadParams get authPayload;
  @override
  ConnectionMetadata get requester;
  @override
  int get expiryTimestamp;
  @override
  @JsonKey(ignore: true)
  _$$WcOCARequestRequestImplCopyWith<_$WcOCARequestRequestImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

WcOCARequestResult _$WcOCARequestResultFromJson(Map<String, dynamic> json) {
  return _WcOCARequestResult.fromJson(json);
}

/// @nodoc
mixin _$WcOCARequestResult {
  List<Cacao> get cacaos => throw _privateConstructorUsedError;
  ConnectionMetadata get responder => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $WcOCARequestResultCopyWith<WcOCARequestResult> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $WcOCARequestResultCopyWith<$Res> {
  factory $WcOCARequestResultCopyWith(
          WcOCARequestResult value, $Res Function(WcOCARequestResult) then) =
      _$WcOCARequestResultCopyWithImpl<$Res, WcOCARequestResult>;
  @useResult
  $Res call({List<Cacao> cacaos, ConnectionMetadata responder});

  $ConnectionMetadataCopyWith<$Res> get responder;
}

/// @nodoc
class _$WcOCARequestResultCopyWithImpl<$Res, $Val extends WcOCARequestResult>
    implements $WcOCARequestResultCopyWith<$Res> {
  _$WcOCARequestResultCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? cacaos = null,
    Object? responder = null,
  }) {
    return _then(_value.copyWith(
      cacaos: null == cacaos
          ? _value.cacaos
          : cacaos // ignore: cast_nullable_to_non_nullable
              as List<Cacao>,
      responder: null == responder
          ? _value.responder
          : responder // ignore: cast_nullable_to_non_nullable
              as ConnectionMetadata,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $ConnectionMetadataCopyWith<$Res> get responder {
    return $ConnectionMetadataCopyWith<$Res>(_value.responder, (value) {
      return _then(_value.copyWith(responder: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$WcOCARequestResultImplCopyWith<$Res>
    implements $WcOCARequestResultCopyWith<$Res> {
  factory _$$WcOCARequestResultImplCopyWith(_$WcOCARequestResultImpl value,
          $Res Function(_$WcOCARequestResultImpl) then) =
      __$$WcOCARequestResultImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({List<Cacao> cacaos, ConnectionMetadata responder});

  @override
  $ConnectionMetadataCopyWith<$Res> get responder;
}

/// @nodoc
class __$$WcOCARequestResultImplCopyWithImpl<$Res>
    extends _$WcOCARequestResultCopyWithImpl<$Res, _$WcOCARequestResultImpl>
    implements _$$WcOCARequestResultImplCopyWith<$Res> {
  __$$WcOCARequestResultImplCopyWithImpl(_$WcOCARequestResultImpl _value,
      $Res Function(_$WcOCARequestResultImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? cacaos = null,
    Object? responder = null,
  }) {
    return _then(_$WcOCARequestResultImpl(
      cacaos: null == cacaos
          ? _value._cacaos
          : cacaos // ignore: cast_nullable_to_non_nullable
              as List<Cacao>,
      responder: null == responder
          ? _value.responder
          : responder // ignore: cast_nullable_to_non_nullable
              as ConnectionMetadata,
    ));
  }
}

/// @nodoc

@JsonSerializable()
class _$WcOCARequestResultImpl implements _WcOCARequestResult {
  const _$WcOCARequestResultImpl(
      {required final List<Cacao> cacaos, required this.responder})
      : _cacaos = cacaos;

  factory _$WcOCARequestResultImpl.fromJson(Map<String, dynamic> json) =>
      _$$WcOCARequestResultImplFromJson(json);

  final List<Cacao> _cacaos;
  @override
  List<Cacao> get cacaos {
    if (_cacaos is EqualUnmodifiableListView) return _cacaos;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_cacaos);
  }

  @override
  final ConnectionMetadata responder;

  @override
  String toString() {
    return 'WcOCARequestResult(cacaos: $cacaos, responder: $responder)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$WcOCARequestResultImpl &&
            const DeepCollectionEquality().equals(other._cacaos, _cacaos) &&
            (identical(other.responder, responder) ||
                other.responder == responder));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType, const DeepCollectionEquality().hash(_cacaos), responder);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$WcOCARequestResultImplCopyWith<_$WcOCARequestResultImpl> get copyWith =>
      __$$WcOCARequestResultImplCopyWithImpl<_$WcOCARequestResultImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$WcOCARequestResultImplToJson(
      this,
    );
  }
}

abstract class _WcOCARequestResult implements WcOCARequestResult {
  const factory _WcOCARequestResult(
      {required final List<Cacao> cacaos,
      required final ConnectionMetadata responder}) = _$WcOCARequestResultImpl;

  factory _WcOCARequestResult.fromJson(Map<String, dynamic> json) =
      _$WcOCARequestResultImpl.fromJson;

  @override
  List<Cacao> get cacaos;
  @override
  ConnectionMetadata get responder;
  @override
  @JsonKey(ignore: true)
  _$$WcOCARequestResultImplCopyWith<_$WcOCARequestResultImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

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

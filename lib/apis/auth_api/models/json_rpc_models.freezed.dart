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
abstract class _$$_WcAuthRequestRequestCopyWith<$Res>
    implements $WcAuthRequestRequestCopyWith<$Res> {
  factory _$$_WcAuthRequestRequestCopyWith(_$_WcAuthRequestRequest value,
          $Res Function(_$_WcAuthRequestRequest) then) =
      __$$_WcAuthRequestRequestCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({AuthPayloadParams payloadParams, ConnectionMetadata requester});

  @override
  $AuthPayloadParamsCopyWith<$Res> get payloadParams;
  @override
  $ConnectionMetadataCopyWith<$Res> get requester;
}

/// @nodoc
class __$$_WcAuthRequestRequestCopyWithImpl<$Res>
    extends _$WcAuthRequestRequestCopyWithImpl<$Res, _$_WcAuthRequestRequest>
    implements _$$_WcAuthRequestRequestCopyWith<$Res> {
  __$$_WcAuthRequestRequestCopyWithImpl(_$_WcAuthRequestRequest _value,
      $Res Function(_$_WcAuthRequestRequest) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? payloadParams = null,
    Object? requester = null,
  }) {
    return _then(_$_WcAuthRequestRequest(
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
class _$_WcAuthRequestRequest implements _WcAuthRequestRequest {
  const _$_WcAuthRequestRequest(
      {required this.payloadParams, required this.requester});

  factory _$_WcAuthRequestRequest.fromJson(Map<String, dynamic> json) =>
      _$$_WcAuthRequestRequestFromJson(json);

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
            other is _$_WcAuthRequestRequest &&
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
  _$$_WcAuthRequestRequestCopyWith<_$_WcAuthRequestRequest> get copyWith =>
      __$$_WcAuthRequestRequestCopyWithImpl<_$_WcAuthRequestRequest>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_WcAuthRequestRequestToJson(
      this,
    );
  }
}

abstract class _WcAuthRequestRequest implements WcAuthRequestRequest {
  const factory _WcAuthRequestRequest(
      {required final AuthPayloadParams payloadParams,
      required final ConnectionMetadata requester}) = _$_WcAuthRequestRequest;

  factory _WcAuthRequestRequest.fromJson(Map<String, dynamic> json) =
      _$_WcAuthRequestRequest.fromJson;

  @override
  AuthPayloadParams get payloadParams;
  @override
  ConnectionMetadata get requester;
  @override
  @JsonKey(ignore: true)
  _$$_WcAuthRequestRequestCopyWith<_$_WcAuthRequestRequest> get copyWith =>
      throw _privateConstructorUsedError;
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
abstract class _$$_WcAuthRequestResultCopyWith<$Res>
    implements $WcAuthRequestResultCopyWith<$Res> {
  factory _$$_WcAuthRequestResultCopyWith(_$_WcAuthRequestResult value,
          $Res Function(_$_WcAuthRequestResult) then) =
      __$$_WcAuthRequestResultCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({Cacao cacao});

  @override
  $CacaoCopyWith<$Res> get cacao;
}

/// @nodoc
class __$$_WcAuthRequestResultCopyWithImpl<$Res>
    extends _$WcAuthRequestResultCopyWithImpl<$Res, _$_WcAuthRequestResult>
    implements _$$_WcAuthRequestResultCopyWith<$Res> {
  __$$_WcAuthRequestResultCopyWithImpl(_$_WcAuthRequestResult _value,
      $Res Function(_$_WcAuthRequestResult) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? cacao = null,
  }) {
    return _then(_$_WcAuthRequestResult(
      cacao: null == cacao
          ? _value.cacao
          : cacao // ignore: cast_nullable_to_non_nullable
              as Cacao,
    ));
  }
}

/// @nodoc

@JsonSerializable()
class _$_WcAuthRequestResult implements _WcAuthRequestResult {
  const _$_WcAuthRequestResult({required this.cacao});

  factory _$_WcAuthRequestResult.fromJson(Map<String, dynamic> json) =>
      _$$_WcAuthRequestResultFromJson(json);

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
            other is _$_WcAuthRequestResult &&
            (identical(other.cacao, cacao) || other.cacao == cacao));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, cacao);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_WcAuthRequestResultCopyWith<_$_WcAuthRequestResult> get copyWith =>
      __$$_WcAuthRequestResultCopyWithImpl<_$_WcAuthRequestResult>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_WcAuthRequestResultToJson(
      this,
    );
  }
}

abstract class _WcAuthRequestResult implements WcAuthRequestResult {
  const factory _WcAuthRequestResult({required final Cacao cacao}) =
      _$_WcAuthRequestResult;

  factory _WcAuthRequestResult.fromJson(Map<String, dynamic> json) =
      _$_WcAuthRequestResult.fromJson;

  @override
  Cacao get cacao;
  @override
  @JsonKey(ignore: true)
  _$$_WcAuthRequestResultCopyWith<_$_WcAuthRequestResult> get copyWith =>
      throw _privateConstructorUsedError;
}

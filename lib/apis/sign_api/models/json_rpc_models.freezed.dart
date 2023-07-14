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

WcPairingDeleteRequest _$WcPairingDeleteRequestFromJson(
    Map<String, dynamic> json) {
  return _WcPairingDeleteRequest.fromJson(json);
}

/// @nodoc
mixin _$WcPairingDeleteRequest {
  int get code => throw _privateConstructorUsedError;
  String get message => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $WcPairingDeleteRequestCopyWith<WcPairingDeleteRequest> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $WcPairingDeleteRequestCopyWith<$Res> {
  factory $WcPairingDeleteRequestCopyWith(WcPairingDeleteRequest value,
          $Res Function(WcPairingDeleteRequest) then) =
      _$WcPairingDeleteRequestCopyWithImpl<$Res, WcPairingDeleteRequest>;
  @useResult
  $Res call({int code, String message});
}

/// @nodoc
class _$WcPairingDeleteRequestCopyWithImpl<$Res,
        $Val extends WcPairingDeleteRequest>
    implements $WcPairingDeleteRequestCopyWith<$Res> {
  _$WcPairingDeleteRequestCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? code = null,
    Object? message = null,
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
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_WcPairingDeleteRequestCopyWith<$Res>
    implements $WcPairingDeleteRequestCopyWith<$Res> {
  factory _$$_WcPairingDeleteRequestCopyWith(_$_WcPairingDeleteRequest value,
          $Res Function(_$_WcPairingDeleteRequest) then) =
      __$$_WcPairingDeleteRequestCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({int code, String message});
}

/// @nodoc
class __$$_WcPairingDeleteRequestCopyWithImpl<$Res>
    extends _$WcPairingDeleteRequestCopyWithImpl<$Res,
        _$_WcPairingDeleteRequest>
    implements _$$_WcPairingDeleteRequestCopyWith<$Res> {
  __$$_WcPairingDeleteRequestCopyWithImpl(_$_WcPairingDeleteRequest _value,
      $Res Function(_$_WcPairingDeleteRequest) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? code = null,
    Object? message = null,
  }) {
    return _then(_$_WcPairingDeleteRequest(
      code: null == code
          ? _value.code
          : code // ignore: cast_nullable_to_non_nullable
              as int,
      message: null == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

@JsonSerializable()
class _$_WcPairingDeleteRequest implements _WcPairingDeleteRequest {
  const _$_WcPairingDeleteRequest({required this.code, required this.message});

  factory _$_WcPairingDeleteRequest.fromJson(Map<String, dynamic> json) =>
      _$$_WcPairingDeleteRequestFromJson(json);

  @override
  final int code;
  @override
  final String message;

  @override
  String toString() {
    return 'WcPairingDeleteRequest(code: $code, message: $message)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_WcPairingDeleteRequest &&
            (identical(other.code, code) || other.code == code) &&
            (identical(other.message, message) || other.message == message));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, code, message);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_WcPairingDeleteRequestCopyWith<_$_WcPairingDeleteRequest> get copyWith =>
      __$$_WcPairingDeleteRequestCopyWithImpl<_$_WcPairingDeleteRequest>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_WcPairingDeleteRequestToJson(
      this,
    );
  }
}

abstract class _WcPairingDeleteRequest implements WcPairingDeleteRequest {
  const factory _WcPairingDeleteRequest(
      {required final int code,
      required final String message}) = _$_WcPairingDeleteRequest;

  factory _WcPairingDeleteRequest.fromJson(Map<String, dynamic> json) =
      _$_WcPairingDeleteRequest.fromJson;

  @override
  int get code;
  @override
  String get message;
  @override
  @JsonKey(ignore: true)
  _$$_WcPairingDeleteRequestCopyWith<_$_WcPairingDeleteRequest> get copyWith =>
      throw _privateConstructorUsedError;
}

WcPairingPingRequest _$WcPairingPingRequestFromJson(Map<String, dynamic> json) {
  return _WcPairingPingRequest.fromJson(json);
}

/// @nodoc
mixin _$WcPairingPingRequest {
  Map<String, dynamic> get data => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $WcPairingPingRequestCopyWith<WcPairingPingRequest> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $WcPairingPingRequestCopyWith<$Res> {
  factory $WcPairingPingRequestCopyWith(WcPairingPingRequest value,
          $Res Function(WcPairingPingRequest) then) =
      _$WcPairingPingRequestCopyWithImpl<$Res, WcPairingPingRequest>;
  @useResult
  $Res call({Map<String, dynamic> data});
}

/// @nodoc
class _$WcPairingPingRequestCopyWithImpl<$Res,
        $Val extends WcPairingPingRequest>
    implements $WcPairingPingRequestCopyWith<$Res> {
  _$WcPairingPingRequestCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? data = null,
  }) {
    return _then(_value.copyWith(
      data: null == data
          ? _value.data
          : data // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_WcPairingPingRequestCopyWith<$Res>
    implements $WcPairingPingRequestCopyWith<$Res> {
  factory _$$_WcPairingPingRequestCopyWith(_$_WcPairingPingRequest value,
          $Res Function(_$_WcPairingPingRequest) then) =
      __$$_WcPairingPingRequestCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({Map<String, dynamic> data});
}

/// @nodoc
class __$$_WcPairingPingRequestCopyWithImpl<$Res>
    extends _$WcPairingPingRequestCopyWithImpl<$Res, _$_WcPairingPingRequest>
    implements _$$_WcPairingPingRequestCopyWith<$Res> {
  __$$_WcPairingPingRequestCopyWithImpl(_$_WcPairingPingRequest _value,
      $Res Function(_$_WcPairingPingRequest) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? data = null,
  }) {
    return _then(_$_WcPairingPingRequest(
      data: null == data
          ? _value._data
          : data // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>,
    ));
  }
}

/// @nodoc

@JsonSerializable()
class _$_WcPairingPingRequest implements _WcPairingPingRequest {
  const _$_WcPairingPingRequest({required final Map<String, dynamic> data})
      : _data = data;

  factory _$_WcPairingPingRequest.fromJson(Map<String, dynamic> json) =>
      _$$_WcPairingPingRequestFromJson(json);

  final Map<String, dynamic> _data;
  @override
  Map<String, dynamic> get data {
    if (_data is EqualUnmodifiableMapView) return _data;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_data);
  }

  @override
  String toString() {
    return 'WcPairingPingRequest(data: $data)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_WcPairingPingRequest &&
            const DeepCollectionEquality().equals(other._data, _data));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode =>
      Object.hash(runtimeType, const DeepCollectionEquality().hash(_data));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_WcPairingPingRequestCopyWith<_$_WcPairingPingRequest> get copyWith =>
      __$$_WcPairingPingRequestCopyWithImpl<_$_WcPairingPingRequest>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_WcPairingPingRequestToJson(
      this,
    );
  }
}

abstract class _WcPairingPingRequest implements WcPairingPingRequest {
  const factory _WcPairingPingRequest(
      {required final Map<String, dynamic> data}) = _$_WcPairingPingRequest;

  factory _WcPairingPingRequest.fromJson(Map<String, dynamic> json) =
      _$_WcPairingPingRequest.fromJson;

  @override
  Map<String, dynamic> get data;
  @override
  @JsonKey(ignore: true)
  _$$_WcPairingPingRequestCopyWith<_$_WcPairingPingRequest> get copyWith =>
      throw _privateConstructorUsedError;
}

WcSessionProposeRequest _$WcSessionProposeRequestFromJson(
    Map<String, dynamic> json) {
  return _WcSessionProposeRequest.fromJson(json);
}

/// @nodoc
mixin _$WcSessionProposeRequest {
  List<Relay> get relays => throw _privateConstructorUsedError;
  Map<String, RequiredNamespace> get requiredNamespaces =>
      throw _privateConstructorUsedError;
  Map<String, RequiredNamespace>? get optionalNamespaces =>
      throw _privateConstructorUsedError;
  Map<String, String>? get sessionProperties =>
      throw _privateConstructorUsedError;
  ConnectionMetadata get proposer => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $WcSessionProposeRequestCopyWith<WcSessionProposeRequest> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $WcSessionProposeRequestCopyWith<$Res> {
  factory $WcSessionProposeRequestCopyWith(WcSessionProposeRequest value,
          $Res Function(WcSessionProposeRequest) then) =
      _$WcSessionProposeRequestCopyWithImpl<$Res, WcSessionProposeRequest>;
  @useResult
  $Res call(
      {List<Relay> relays,
      Map<String, RequiredNamespace> requiredNamespaces,
      Map<String, RequiredNamespace>? optionalNamespaces,
      Map<String, String>? sessionProperties,
      ConnectionMetadata proposer});

  $ConnectionMetadataCopyWith<$Res> get proposer;
}

/// @nodoc
class _$WcSessionProposeRequestCopyWithImpl<$Res,
        $Val extends WcSessionProposeRequest>
    implements $WcSessionProposeRequestCopyWith<$Res> {
  _$WcSessionProposeRequestCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? relays = null,
    Object? requiredNamespaces = null,
    Object? optionalNamespaces = freezed,
    Object? sessionProperties = freezed,
    Object? proposer = null,
  }) {
    return _then(_value.copyWith(
      relays: null == relays
          ? _value.relays
          : relays // ignore: cast_nullable_to_non_nullable
              as List<Relay>,
      requiredNamespaces: null == requiredNamespaces
          ? _value.requiredNamespaces
          : requiredNamespaces // ignore: cast_nullable_to_non_nullable
              as Map<String, RequiredNamespace>,
      optionalNamespaces: freezed == optionalNamespaces
          ? _value.optionalNamespaces
          : optionalNamespaces // ignore: cast_nullable_to_non_nullable
              as Map<String, RequiredNamespace>?,
      sessionProperties: freezed == sessionProperties
          ? _value.sessionProperties
          : sessionProperties // ignore: cast_nullable_to_non_nullable
              as Map<String, String>?,
      proposer: null == proposer
          ? _value.proposer
          : proposer // ignore: cast_nullable_to_non_nullable
              as ConnectionMetadata,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $ConnectionMetadataCopyWith<$Res> get proposer {
    return $ConnectionMetadataCopyWith<$Res>(_value.proposer, (value) {
      return _then(_value.copyWith(proposer: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$_WcSessionProposeRequestCopyWith<$Res>
    implements $WcSessionProposeRequestCopyWith<$Res> {
  factory _$$_WcSessionProposeRequestCopyWith(_$_WcSessionProposeRequest value,
          $Res Function(_$_WcSessionProposeRequest) then) =
      __$$_WcSessionProposeRequestCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {List<Relay> relays,
      Map<String, RequiredNamespace> requiredNamespaces,
      Map<String, RequiredNamespace>? optionalNamespaces,
      Map<String, String>? sessionProperties,
      ConnectionMetadata proposer});

  @override
  $ConnectionMetadataCopyWith<$Res> get proposer;
}

/// @nodoc
class __$$_WcSessionProposeRequestCopyWithImpl<$Res>
    extends _$WcSessionProposeRequestCopyWithImpl<$Res,
        _$_WcSessionProposeRequest>
    implements _$$_WcSessionProposeRequestCopyWith<$Res> {
  __$$_WcSessionProposeRequestCopyWithImpl(_$_WcSessionProposeRequest _value,
      $Res Function(_$_WcSessionProposeRequest) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? relays = null,
    Object? requiredNamespaces = null,
    Object? optionalNamespaces = freezed,
    Object? sessionProperties = freezed,
    Object? proposer = null,
  }) {
    return _then(_$_WcSessionProposeRequest(
      relays: null == relays
          ? _value._relays
          : relays // ignore: cast_nullable_to_non_nullable
              as List<Relay>,
      requiredNamespaces: null == requiredNamespaces
          ? _value._requiredNamespaces
          : requiredNamespaces // ignore: cast_nullable_to_non_nullable
              as Map<String, RequiredNamespace>,
      optionalNamespaces: freezed == optionalNamespaces
          ? _value._optionalNamespaces
          : optionalNamespaces // ignore: cast_nullable_to_non_nullable
              as Map<String, RequiredNamespace>?,
      sessionProperties: freezed == sessionProperties
          ? _value._sessionProperties
          : sessionProperties // ignore: cast_nullable_to_non_nullable
              as Map<String, String>?,
      proposer: null == proposer
          ? _value.proposer
          : proposer // ignore: cast_nullable_to_non_nullable
              as ConnectionMetadata,
    ));
  }
}

/// @nodoc

@JsonSerializable(includeIfNull: false)
class _$_WcSessionProposeRequest implements _WcSessionProposeRequest {
  const _$_WcSessionProposeRequest(
      {required final List<Relay> relays,
      required final Map<String, RequiredNamespace> requiredNamespaces,
      final Map<String, RequiredNamespace>? optionalNamespaces,
      final Map<String, String>? sessionProperties,
      required this.proposer})
      : _relays = relays,
        _requiredNamespaces = requiredNamespaces,
        _optionalNamespaces = optionalNamespaces,
        _sessionProperties = sessionProperties;

  factory _$_WcSessionProposeRequest.fromJson(Map<String, dynamic> json) =>
      _$$_WcSessionProposeRequestFromJson(json);

  final List<Relay> _relays;
  @override
  List<Relay> get relays {
    if (_relays is EqualUnmodifiableListView) return _relays;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_relays);
  }

  final Map<String, RequiredNamespace> _requiredNamespaces;
  @override
  Map<String, RequiredNamespace> get requiredNamespaces {
    if (_requiredNamespaces is EqualUnmodifiableMapView)
      return _requiredNamespaces;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_requiredNamespaces);
  }

  final Map<String, RequiredNamespace>? _optionalNamespaces;
  @override
  Map<String, RequiredNamespace>? get optionalNamespaces {
    final value = _optionalNamespaces;
    if (value == null) return null;
    if (_optionalNamespaces is EqualUnmodifiableMapView)
      return _optionalNamespaces;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(value);
  }

  final Map<String, String>? _sessionProperties;
  @override
  Map<String, String>? get sessionProperties {
    final value = _sessionProperties;
    if (value == null) return null;
    if (_sessionProperties is EqualUnmodifiableMapView)
      return _sessionProperties;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(value);
  }

  @override
  final ConnectionMetadata proposer;

  @override
  String toString() {
    return 'WcSessionProposeRequest(relays: $relays, requiredNamespaces: $requiredNamespaces, optionalNamespaces: $optionalNamespaces, sessionProperties: $sessionProperties, proposer: $proposer)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_WcSessionProposeRequest &&
            const DeepCollectionEquality().equals(other._relays, _relays) &&
            const DeepCollectionEquality()
                .equals(other._requiredNamespaces, _requiredNamespaces) &&
            const DeepCollectionEquality()
                .equals(other._optionalNamespaces, _optionalNamespaces) &&
            const DeepCollectionEquality()
                .equals(other._sessionProperties, _sessionProperties) &&
            (identical(other.proposer, proposer) ||
                other.proposer == proposer));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(_relays),
      const DeepCollectionEquality().hash(_requiredNamespaces),
      const DeepCollectionEquality().hash(_optionalNamespaces),
      const DeepCollectionEquality().hash(_sessionProperties),
      proposer);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_WcSessionProposeRequestCopyWith<_$_WcSessionProposeRequest>
      get copyWith =>
          __$$_WcSessionProposeRequestCopyWithImpl<_$_WcSessionProposeRequest>(
              this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_WcSessionProposeRequestToJson(
      this,
    );
  }
}

abstract class _WcSessionProposeRequest implements WcSessionProposeRequest {
  const factory _WcSessionProposeRequest(
      {required final List<Relay> relays,
      required final Map<String, RequiredNamespace> requiredNamespaces,
      final Map<String, RequiredNamespace>? optionalNamespaces,
      final Map<String, String>? sessionProperties,
      required final ConnectionMetadata proposer}) = _$_WcSessionProposeRequest;

  factory _WcSessionProposeRequest.fromJson(Map<String, dynamic> json) =
      _$_WcSessionProposeRequest.fromJson;

  @override
  List<Relay> get relays;
  @override
  Map<String, RequiredNamespace> get requiredNamespaces;
  @override
  Map<String, RequiredNamespace>? get optionalNamespaces;
  @override
  Map<String, String>? get sessionProperties;
  @override
  ConnectionMetadata get proposer;
  @override
  @JsonKey(ignore: true)
  _$$_WcSessionProposeRequestCopyWith<_$_WcSessionProposeRequest>
      get copyWith => throw _privateConstructorUsedError;
}

WcSessionProposeResponse _$WcSessionProposeResponseFromJson(
    Map<String, dynamic> json) {
  return _WcSessionProposeResponse.fromJson(json);
}

/// @nodoc
mixin _$WcSessionProposeResponse {
  Relay get relay => throw _privateConstructorUsedError;
  String get responderPublicKey => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $WcSessionProposeResponseCopyWith<WcSessionProposeResponse> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $WcSessionProposeResponseCopyWith<$Res> {
  factory $WcSessionProposeResponseCopyWith(WcSessionProposeResponse value,
          $Res Function(WcSessionProposeResponse) then) =
      _$WcSessionProposeResponseCopyWithImpl<$Res, WcSessionProposeResponse>;
  @useResult
  $Res call({Relay relay, String responderPublicKey});
}

/// @nodoc
class _$WcSessionProposeResponseCopyWithImpl<$Res,
        $Val extends WcSessionProposeResponse>
    implements $WcSessionProposeResponseCopyWith<$Res> {
  _$WcSessionProposeResponseCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? relay = null,
    Object? responderPublicKey = null,
  }) {
    return _then(_value.copyWith(
      relay: null == relay
          ? _value.relay
          : relay // ignore: cast_nullable_to_non_nullable
              as Relay,
      responderPublicKey: null == responderPublicKey
          ? _value.responderPublicKey
          : responderPublicKey // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_WcSessionProposeResponseCopyWith<$Res>
    implements $WcSessionProposeResponseCopyWith<$Res> {
  factory _$$_WcSessionProposeResponseCopyWith(
          _$_WcSessionProposeResponse value,
          $Res Function(_$_WcSessionProposeResponse) then) =
      __$$_WcSessionProposeResponseCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({Relay relay, String responderPublicKey});
}

/// @nodoc
class __$$_WcSessionProposeResponseCopyWithImpl<$Res>
    extends _$WcSessionProposeResponseCopyWithImpl<$Res,
        _$_WcSessionProposeResponse>
    implements _$$_WcSessionProposeResponseCopyWith<$Res> {
  __$$_WcSessionProposeResponseCopyWithImpl(_$_WcSessionProposeResponse _value,
      $Res Function(_$_WcSessionProposeResponse) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? relay = null,
    Object? responderPublicKey = null,
  }) {
    return _then(_$_WcSessionProposeResponse(
      relay: null == relay
          ? _value.relay
          : relay // ignore: cast_nullable_to_non_nullable
              as Relay,
      responderPublicKey: null == responderPublicKey
          ? _value.responderPublicKey
          : responderPublicKey // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

@JsonSerializable()
class _$_WcSessionProposeResponse implements _WcSessionProposeResponse {
  const _$_WcSessionProposeResponse(
      {required this.relay, required this.responderPublicKey});

  factory _$_WcSessionProposeResponse.fromJson(Map<String, dynamic> json) =>
      _$$_WcSessionProposeResponseFromJson(json);

  @override
  final Relay relay;
  @override
  final String responderPublicKey;

  @override
  String toString() {
    return 'WcSessionProposeResponse(relay: $relay, responderPublicKey: $responderPublicKey)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_WcSessionProposeResponse &&
            (identical(other.relay, relay) || other.relay == relay) &&
            (identical(other.responderPublicKey, responderPublicKey) ||
                other.responderPublicKey == responderPublicKey));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, relay, responderPublicKey);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_WcSessionProposeResponseCopyWith<_$_WcSessionProposeResponse>
      get copyWith => __$$_WcSessionProposeResponseCopyWithImpl<
          _$_WcSessionProposeResponse>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_WcSessionProposeResponseToJson(
      this,
    );
  }
}

abstract class _WcSessionProposeResponse implements WcSessionProposeResponse {
  const factory _WcSessionProposeResponse(
      {required final Relay relay,
      required final String responderPublicKey}) = _$_WcSessionProposeResponse;

  factory _WcSessionProposeResponse.fromJson(Map<String, dynamic> json) =
      _$_WcSessionProposeResponse.fromJson;

  @override
  Relay get relay;
  @override
  String get responderPublicKey;
  @override
  @JsonKey(ignore: true)
  _$$_WcSessionProposeResponseCopyWith<_$_WcSessionProposeResponse>
      get copyWith => throw _privateConstructorUsedError;
}

WcSessionSettleRequest _$WcSessionSettleRequestFromJson(
    Map<String, dynamic> json) {
  return _WcSessionSettleRequest.fromJson(json);
}

/// @nodoc
mixin _$WcSessionSettleRequest {
  Relay get relay => throw _privateConstructorUsedError;
  Map<String, Namespace> get namespaces => throw _privateConstructorUsedError;
  Map<String, RequiredNamespace>? get requiredNamespaces =>
      throw _privateConstructorUsedError;
  Map<String, RequiredNamespace>? get optionalNamespaces =>
      throw _privateConstructorUsedError;
  Map<String, String>? get sessionProperties =>
      throw _privateConstructorUsedError;
  int get expiry => throw _privateConstructorUsedError;
  ConnectionMetadata get controller => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $WcSessionSettleRequestCopyWith<WcSessionSettleRequest> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $WcSessionSettleRequestCopyWith<$Res> {
  factory $WcSessionSettleRequestCopyWith(WcSessionSettleRequest value,
          $Res Function(WcSessionSettleRequest) then) =
      _$WcSessionSettleRequestCopyWithImpl<$Res, WcSessionSettleRequest>;
  @useResult
  $Res call(
      {Relay relay,
      Map<String, Namespace> namespaces,
      Map<String, RequiredNamespace>? requiredNamespaces,
      Map<String, RequiredNamespace>? optionalNamespaces,
      Map<String, String>? sessionProperties,
      int expiry,
      ConnectionMetadata controller});

  $ConnectionMetadataCopyWith<$Res> get controller;
}

/// @nodoc
class _$WcSessionSettleRequestCopyWithImpl<$Res,
        $Val extends WcSessionSettleRequest>
    implements $WcSessionSettleRequestCopyWith<$Res> {
  _$WcSessionSettleRequestCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? relay = null,
    Object? namespaces = null,
    Object? requiredNamespaces = freezed,
    Object? optionalNamespaces = freezed,
    Object? sessionProperties = freezed,
    Object? expiry = null,
    Object? controller = null,
  }) {
    return _then(_value.copyWith(
      relay: null == relay
          ? _value.relay
          : relay // ignore: cast_nullable_to_non_nullable
              as Relay,
      namespaces: null == namespaces
          ? _value.namespaces
          : namespaces // ignore: cast_nullable_to_non_nullable
              as Map<String, Namespace>,
      requiredNamespaces: freezed == requiredNamespaces
          ? _value.requiredNamespaces
          : requiredNamespaces // ignore: cast_nullable_to_non_nullable
              as Map<String, RequiredNamespace>?,
      optionalNamespaces: freezed == optionalNamespaces
          ? _value.optionalNamespaces
          : optionalNamespaces // ignore: cast_nullable_to_non_nullable
              as Map<String, RequiredNamespace>?,
      sessionProperties: freezed == sessionProperties
          ? _value.sessionProperties
          : sessionProperties // ignore: cast_nullable_to_non_nullable
              as Map<String, String>?,
      expiry: null == expiry
          ? _value.expiry
          : expiry // ignore: cast_nullable_to_non_nullable
              as int,
      controller: null == controller
          ? _value.controller
          : controller // ignore: cast_nullable_to_non_nullable
              as ConnectionMetadata,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $ConnectionMetadataCopyWith<$Res> get controller {
    return $ConnectionMetadataCopyWith<$Res>(_value.controller, (value) {
      return _then(_value.copyWith(controller: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$_WcSessionSettleRequestCopyWith<$Res>
    implements $WcSessionSettleRequestCopyWith<$Res> {
  factory _$$_WcSessionSettleRequestCopyWith(_$_WcSessionSettleRequest value,
          $Res Function(_$_WcSessionSettleRequest) then) =
      __$$_WcSessionSettleRequestCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {Relay relay,
      Map<String, Namespace> namespaces,
      Map<String, RequiredNamespace>? requiredNamespaces,
      Map<String, RequiredNamespace>? optionalNamespaces,
      Map<String, String>? sessionProperties,
      int expiry,
      ConnectionMetadata controller});

  @override
  $ConnectionMetadataCopyWith<$Res> get controller;
}

/// @nodoc
class __$$_WcSessionSettleRequestCopyWithImpl<$Res>
    extends _$WcSessionSettleRequestCopyWithImpl<$Res,
        _$_WcSessionSettleRequest>
    implements _$$_WcSessionSettleRequestCopyWith<$Res> {
  __$$_WcSessionSettleRequestCopyWithImpl(_$_WcSessionSettleRequest _value,
      $Res Function(_$_WcSessionSettleRequest) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? relay = null,
    Object? namespaces = null,
    Object? requiredNamespaces = freezed,
    Object? optionalNamespaces = freezed,
    Object? sessionProperties = freezed,
    Object? expiry = null,
    Object? controller = null,
  }) {
    return _then(_$_WcSessionSettleRequest(
      relay: null == relay
          ? _value.relay
          : relay // ignore: cast_nullable_to_non_nullable
              as Relay,
      namespaces: null == namespaces
          ? _value._namespaces
          : namespaces // ignore: cast_nullable_to_non_nullable
              as Map<String, Namespace>,
      requiredNamespaces: freezed == requiredNamespaces
          ? _value._requiredNamespaces
          : requiredNamespaces // ignore: cast_nullable_to_non_nullable
              as Map<String, RequiredNamespace>?,
      optionalNamespaces: freezed == optionalNamespaces
          ? _value._optionalNamespaces
          : optionalNamespaces // ignore: cast_nullable_to_non_nullable
              as Map<String, RequiredNamespace>?,
      sessionProperties: freezed == sessionProperties
          ? _value._sessionProperties
          : sessionProperties // ignore: cast_nullable_to_non_nullable
              as Map<String, String>?,
      expiry: null == expiry
          ? _value.expiry
          : expiry // ignore: cast_nullable_to_non_nullable
              as int,
      controller: null == controller
          ? _value.controller
          : controller // ignore: cast_nullable_to_non_nullable
              as ConnectionMetadata,
    ));
  }
}

/// @nodoc

@JsonSerializable(includeIfNull: false)
class _$_WcSessionSettleRequest implements _WcSessionSettleRequest {
  const _$_WcSessionSettleRequest(
      {required this.relay,
      required final Map<String, Namespace> namespaces,
      final Map<String, RequiredNamespace>? requiredNamespaces,
      final Map<String, RequiredNamespace>? optionalNamespaces,
      final Map<String, String>? sessionProperties,
      required this.expiry,
      required this.controller})
      : _namespaces = namespaces,
        _requiredNamespaces = requiredNamespaces,
        _optionalNamespaces = optionalNamespaces,
        _sessionProperties = sessionProperties;

  factory _$_WcSessionSettleRequest.fromJson(Map<String, dynamic> json) =>
      _$$_WcSessionSettleRequestFromJson(json);

  @override
  final Relay relay;
  final Map<String, Namespace> _namespaces;
  @override
  Map<String, Namespace> get namespaces {
    if (_namespaces is EqualUnmodifiableMapView) return _namespaces;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_namespaces);
  }

  final Map<String, RequiredNamespace>? _requiredNamespaces;
  @override
  Map<String, RequiredNamespace>? get requiredNamespaces {
    final value = _requiredNamespaces;
    if (value == null) return null;
    if (_requiredNamespaces is EqualUnmodifiableMapView)
      return _requiredNamespaces;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(value);
  }

  final Map<String, RequiredNamespace>? _optionalNamespaces;
  @override
  Map<String, RequiredNamespace>? get optionalNamespaces {
    final value = _optionalNamespaces;
    if (value == null) return null;
    if (_optionalNamespaces is EqualUnmodifiableMapView)
      return _optionalNamespaces;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(value);
  }

  final Map<String, String>? _sessionProperties;
  @override
  Map<String, String>? get sessionProperties {
    final value = _sessionProperties;
    if (value == null) return null;
    if (_sessionProperties is EqualUnmodifiableMapView)
      return _sessionProperties;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(value);
  }

  @override
  final int expiry;
  @override
  final ConnectionMetadata controller;

  @override
  String toString() {
    return 'WcSessionSettleRequest(relay: $relay, namespaces: $namespaces, requiredNamespaces: $requiredNamespaces, optionalNamespaces: $optionalNamespaces, sessionProperties: $sessionProperties, expiry: $expiry, controller: $controller)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_WcSessionSettleRequest &&
            (identical(other.relay, relay) || other.relay == relay) &&
            const DeepCollectionEquality()
                .equals(other._namespaces, _namespaces) &&
            const DeepCollectionEquality()
                .equals(other._requiredNamespaces, _requiredNamespaces) &&
            const DeepCollectionEquality()
                .equals(other._optionalNamespaces, _optionalNamespaces) &&
            const DeepCollectionEquality()
                .equals(other._sessionProperties, _sessionProperties) &&
            (identical(other.expiry, expiry) || other.expiry == expiry) &&
            (identical(other.controller, controller) ||
                other.controller == controller));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      relay,
      const DeepCollectionEquality().hash(_namespaces),
      const DeepCollectionEquality().hash(_requiredNamespaces),
      const DeepCollectionEquality().hash(_optionalNamespaces),
      const DeepCollectionEquality().hash(_sessionProperties),
      expiry,
      controller);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_WcSessionSettleRequestCopyWith<_$_WcSessionSettleRequest> get copyWith =>
      __$$_WcSessionSettleRequestCopyWithImpl<_$_WcSessionSettleRequest>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_WcSessionSettleRequestToJson(
      this,
    );
  }
}

abstract class _WcSessionSettleRequest implements WcSessionSettleRequest {
  const factory _WcSessionSettleRequest(
          {required final Relay relay,
          required final Map<String, Namespace> namespaces,
          final Map<String, RequiredNamespace>? requiredNamespaces,
          final Map<String, RequiredNamespace>? optionalNamespaces,
          final Map<String, String>? sessionProperties,
          required final int expiry,
          required final ConnectionMetadata controller}) =
      _$_WcSessionSettleRequest;

  factory _WcSessionSettleRequest.fromJson(Map<String, dynamic> json) =
      _$_WcSessionSettleRequest.fromJson;

  @override
  Relay get relay;
  @override
  Map<String, Namespace> get namespaces;
  @override
  Map<String, RequiredNamespace>? get requiredNamespaces;
  @override
  Map<String, RequiredNamespace>? get optionalNamespaces;
  @override
  Map<String, String>? get sessionProperties;
  @override
  int get expiry;
  @override
  ConnectionMetadata get controller;
  @override
  @JsonKey(ignore: true)
  _$$_WcSessionSettleRequestCopyWith<_$_WcSessionSettleRequest> get copyWith =>
      throw _privateConstructorUsedError;
}

WcSessionUpdateRequest _$WcSessionUpdateRequestFromJson(
    Map<String, dynamic> json) {
  return _WcSessionUpdateRequest.fromJson(json);
}

/// @nodoc
mixin _$WcSessionUpdateRequest {
  Map<String, Namespace> get namespaces => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $WcSessionUpdateRequestCopyWith<WcSessionUpdateRequest> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $WcSessionUpdateRequestCopyWith<$Res> {
  factory $WcSessionUpdateRequestCopyWith(WcSessionUpdateRequest value,
          $Res Function(WcSessionUpdateRequest) then) =
      _$WcSessionUpdateRequestCopyWithImpl<$Res, WcSessionUpdateRequest>;
  @useResult
  $Res call({Map<String, Namespace> namespaces});
}

/// @nodoc
class _$WcSessionUpdateRequestCopyWithImpl<$Res,
        $Val extends WcSessionUpdateRequest>
    implements $WcSessionUpdateRequestCopyWith<$Res> {
  _$WcSessionUpdateRequestCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? namespaces = null,
  }) {
    return _then(_value.copyWith(
      namespaces: null == namespaces
          ? _value.namespaces
          : namespaces // ignore: cast_nullable_to_non_nullable
              as Map<String, Namespace>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_WcSessionUpdateRequestCopyWith<$Res>
    implements $WcSessionUpdateRequestCopyWith<$Res> {
  factory _$$_WcSessionUpdateRequestCopyWith(_$_WcSessionUpdateRequest value,
          $Res Function(_$_WcSessionUpdateRequest) then) =
      __$$_WcSessionUpdateRequestCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({Map<String, Namespace> namespaces});
}

/// @nodoc
class __$$_WcSessionUpdateRequestCopyWithImpl<$Res>
    extends _$WcSessionUpdateRequestCopyWithImpl<$Res,
        _$_WcSessionUpdateRequest>
    implements _$$_WcSessionUpdateRequestCopyWith<$Res> {
  __$$_WcSessionUpdateRequestCopyWithImpl(_$_WcSessionUpdateRequest _value,
      $Res Function(_$_WcSessionUpdateRequest) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? namespaces = null,
  }) {
    return _then(_$_WcSessionUpdateRequest(
      namespaces: null == namespaces
          ? _value._namespaces
          : namespaces // ignore: cast_nullable_to_non_nullable
              as Map<String, Namespace>,
    ));
  }
}

/// @nodoc

@JsonSerializable()
class _$_WcSessionUpdateRequest implements _WcSessionUpdateRequest {
  const _$_WcSessionUpdateRequest(
      {required final Map<String, Namespace> namespaces})
      : _namespaces = namespaces;

  factory _$_WcSessionUpdateRequest.fromJson(Map<String, dynamic> json) =>
      _$$_WcSessionUpdateRequestFromJson(json);

  final Map<String, Namespace> _namespaces;
  @override
  Map<String, Namespace> get namespaces {
    if (_namespaces is EqualUnmodifiableMapView) return _namespaces;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_namespaces);
  }

  @override
  String toString() {
    return 'WcSessionUpdateRequest(namespaces: $namespaces)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_WcSessionUpdateRequest &&
            const DeepCollectionEquality()
                .equals(other._namespaces, _namespaces));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType, const DeepCollectionEquality().hash(_namespaces));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_WcSessionUpdateRequestCopyWith<_$_WcSessionUpdateRequest> get copyWith =>
      __$$_WcSessionUpdateRequestCopyWithImpl<_$_WcSessionUpdateRequest>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_WcSessionUpdateRequestToJson(
      this,
    );
  }
}

abstract class _WcSessionUpdateRequest implements WcSessionUpdateRequest {
  const factory _WcSessionUpdateRequest(
          {required final Map<String, Namespace> namespaces}) =
      _$_WcSessionUpdateRequest;

  factory _WcSessionUpdateRequest.fromJson(Map<String, dynamic> json) =
      _$_WcSessionUpdateRequest.fromJson;

  @override
  Map<String, Namespace> get namespaces;
  @override
  @JsonKey(ignore: true)
  _$$_WcSessionUpdateRequestCopyWith<_$_WcSessionUpdateRequest> get copyWith =>
      throw _privateConstructorUsedError;
}

WcSessionExtendRequest _$WcSessionExtendRequestFromJson(
    Map<String, dynamic> json) {
  return _WcSessionExtendRequest.fromJson(json);
}

/// @nodoc
mixin _$WcSessionExtendRequest {
  Map<String, dynamic>? get data => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $WcSessionExtendRequestCopyWith<WcSessionExtendRequest> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $WcSessionExtendRequestCopyWith<$Res> {
  factory $WcSessionExtendRequestCopyWith(WcSessionExtendRequest value,
          $Res Function(WcSessionExtendRequest) then) =
      _$WcSessionExtendRequestCopyWithImpl<$Res, WcSessionExtendRequest>;
  @useResult
  $Res call({Map<String, dynamic>? data});
}

/// @nodoc
class _$WcSessionExtendRequestCopyWithImpl<$Res,
        $Val extends WcSessionExtendRequest>
    implements $WcSessionExtendRequestCopyWith<$Res> {
  _$WcSessionExtendRequestCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? data = freezed,
  }) {
    return _then(_value.copyWith(
      data: freezed == data
          ? _value.data
          : data // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_WcSessionExtendRequestCopyWith<$Res>
    implements $WcSessionExtendRequestCopyWith<$Res> {
  factory _$$_WcSessionExtendRequestCopyWith(_$_WcSessionExtendRequest value,
          $Res Function(_$_WcSessionExtendRequest) then) =
      __$$_WcSessionExtendRequestCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({Map<String, dynamic>? data});
}

/// @nodoc
class __$$_WcSessionExtendRequestCopyWithImpl<$Res>
    extends _$WcSessionExtendRequestCopyWithImpl<$Res,
        _$_WcSessionExtendRequest>
    implements _$$_WcSessionExtendRequestCopyWith<$Res> {
  __$$_WcSessionExtendRequestCopyWithImpl(_$_WcSessionExtendRequest _value,
      $Res Function(_$_WcSessionExtendRequest) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? data = freezed,
  }) {
    return _then(_$_WcSessionExtendRequest(
      data: freezed == data
          ? _value._data
          : data // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>?,
    ));
  }
}

/// @nodoc

@JsonSerializable(includeIfNull: false)
class _$_WcSessionExtendRequest implements _WcSessionExtendRequest {
  const _$_WcSessionExtendRequest({final Map<String, dynamic>? data})
      : _data = data;

  factory _$_WcSessionExtendRequest.fromJson(Map<String, dynamic> json) =>
      _$$_WcSessionExtendRequestFromJson(json);

  final Map<String, dynamic>? _data;
  @override
  Map<String, dynamic>? get data {
    final value = _data;
    if (value == null) return null;
    if (_data is EqualUnmodifiableMapView) return _data;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(value);
  }

  @override
  String toString() {
    return 'WcSessionExtendRequest(data: $data)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_WcSessionExtendRequest &&
            const DeepCollectionEquality().equals(other._data, _data));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode =>
      Object.hash(runtimeType, const DeepCollectionEquality().hash(_data));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_WcSessionExtendRequestCopyWith<_$_WcSessionExtendRequest> get copyWith =>
      __$$_WcSessionExtendRequestCopyWithImpl<_$_WcSessionExtendRequest>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_WcSessionExtendRequestToJson(
      this,
    );
  }
}

abstract class _WcSessionExtendRequest implements WcSessionExtendRequest {
  const factory _WcSessionExtendRequest({final Map<String, dynamic>? data}) =
      _$_WcSessionExtendRequest;

  factory _WcSessionExtendRequest.fromJson(Map<String, dynamic> json) =
      _$_WcSessionExtendRequest.fromJson;

  @override
  Map<String, dynamic>? get data;
  @override
  @JsonKey(ignore: true)
  _$$_WcSessionExtendRequestCopyWith<_$_WcSessionExtendRequest> get copyWith =>
      throw _privateConstructorUsedError;
}

WcSessionDeleteRequest _$WcSessionDeleteRequestFromJson(
    Map<String, dynamic> json) {
  return _WcSessionDeleteRequest.fromJson(json);
}

/// @nodoc
mixin _$WcSessionDeleteRequest {
  int get code => throw _privateConstructorUsedError;
  String get message => throw _privateConstructorUsedError;
  String? get data => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $WcSessionDeleteRequestCopyWith<WcSessionDeleteRequest> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $WcSessionDeleteRequestCopyWith<$Res> {
  factory $WcSessionDeleteRequestCopyWith(WcSessionDeleteRequest value,
          $Res Function(WcSessionDeleteRequest) then) =
      _$WcSessionDeleteRequestCopyWithImpl<$Res, WcSessionDeleteRequest>;
  @useResult
  $Res call({int code, String message, String? data});
}

/// @nodoc
class _$WcSessionDeleteRequestCopyWithImpl<$Res,
        $Val extends WcSessionDeleteRequest>
    implements $WcSessionDeleteRequestCopyWith<$Res> {
  _$WcSessionDeleteRequestCopyWithImpl(this._value, this._then);

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
abstract class _$$_WcSessionDeleteRequestCopyWith<$Res>
    implements $WcSessionDeleteRequestCopyWith<$Res> {
  factory _$$_WcSessionDeleteRequestCopyWith(_$_WcSessionDeleteRequest value,
          $Res Function(_$_WcSessionDeleteRequest) then) =
      __$$_WcSessionDeleteRequestCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({int code, String message, String? data});
}

/// @nodoc
class __$$_WcSessionDeleteRequestCopyWithImpl<$Res>
    extends _$WcSessionDeleteRequestCopyWithImpl<$Res,
        _$_WcSessionDeleteRequest>
    implements _$$_WcSessionDeleteRequestCopyWith<$Res> {
  __$$_WcSessionDeleteRequestCopyWithImpl(_$_WcSessionDeleteRequest _value,
      $Res Function(_$_WcSessionDeleteRequest) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? code = null,
    Object? message = null,
    Object? data = freezed,
  }) {
    return _then(_$_WcSessionDeleteRequest(
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

@JsonSerializable(includeIfNull: false)
class _$_WcSessionDeleteRequest implements _WcSessionDeleteRequest {
  const _$_WcSessionDeleteRequest(
      {required this.code, required this.message, this.data});

  factory _$_WcSessionDeleteRequest.fromJson(Map<String, dynamic> json) =>
      _$$_WcSessionDeleteRequestFromJson(json);

  @override
  final int code;
  @override
  final String message;
  @override
  final String? data;

  @override
  String toString() {
    return 'WcSessionDeleteRequest(code: $code, message: $message, data: $data)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_WcSessionDeleteRequest &&
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
  _$$_WcSessionDeleteRequestCopyWith<_$_WcSessionDeleteRequest> get copyWith =>
      __$$_WcSessionDeleteRequestCopyWithImpl<_$_WcSessionDeleteRequest>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_WcSessionDeleteRequestToJson(
      this,
    );
  }
}

abstract class _WcSessionDeleteRequest implements WcSessionDeleteRequest {
  const factory _WcSessionDeleteRequest(
      {required final int code,
      required final String message,
      final String? data}) = _$_WcSessionDeleteRequest;

  factory _WcSessionDeleteRequest.fromJson(Map<String, dynamic> json) =
      _$_WcSessionDeleteRequest.fromJson;

  @override
  int get code;
  @override
  String get message;
  @override
  String? get data;
  @override
  @JsonKey(ignore: true)
  _$$_WcSessionDeleteRequestCopyWith<_$_WcSessionDeleteRequest> get copyWith =>
      throw _privateConstructorUsedError;
}

WcSessionPingRequest _$WcSessionPingRequestFromJson(Map<String, dynamic> json) {
  return _WcSessionPingRequest.fromJson(json);
}

/// @nodoc
mixin _$WcSessionPingRequest {
  Map<String, dynamic>? get data => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $WcSessionPingRequestCopyWith<WcSessionPingRequest> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $WcSessionPingRequestCopyWith<$Res> {
  factory $WcSessionPingRequestCopyWith(WcSessionPingRequest value,
          $Res Function(WcSessionPingRequest) then) =
      _$WcSessionPingRequestCopyWithImpl<$Res, WcSessionPingRequest>;
  @useResult
  $Res call({Map<String, dynamic>? data});
}

/// @nodoc
class _$WcSessionPingRequestCopyWithImpl<$Res,
        $Val extends WcSessionPingRequest>
    implements $WcSessionPingRequestCopyWith<$Res> {
  _$WcSessionPingRequestCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? data = freezed,
  }) {
    return _then(_value.copyWith(
      data: freezed == data
          ? _value.data
          : data // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_WcSessionPingRequestCopyWith<$Res>
    implements $WcSessionPingRequestCopyWith<$Res> {
  factory _$$_WcSessionPingRequestCopyWith(_$_WcSessionPingRequest value,
          $Res Function(_$_WcSessionPingRequest) then) =
      __$$_WcSessionPingRequestCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({Map<String, dynamic>? data});
}

/// @nodoc
class __$$_WcSessionPingRequestCopyWithImpl<$Res>
    extends _$WcSessionPingRequestCopyWithImpl<$Res, _$_WcSessionPingRequest>
    implements _$$_WcSessionPingRequestCopyWith<$Res> {
  __$$_WcSessionPingRequestCopyWithImpl(_$_WcSessionPingRequest _value,
      $Res Function(_$_WcSessionPingRequest) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? data = freezed,
  }) {
    return _then(_$_WcSessionPingRequest(
      data: freezed == data
          ? _value._data
          : data // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>?,
    ));
  }
}

/// @nodoc

@JsonSerializable(includeIfNull: false)
class _$_WcSessionPingRequest implements _WcSessionPingRequest {
  const _$_WcSessionPingRequest({final Map<String, dynamic>? data})
      : _data = data;

  factory _$_WcSessionPingRequest.fromJson(Map<String, dynamic> json) =>
      _$$_WcSessionPingRequestFromJson(json);

  final Map<String, dynamic>? _data;
  @override
  Map<String, dynamic>? get data {
    final value = _data;
    if (value == null) return null;
    if (_data is EqualUnmodifiableMapView) return _data;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(value);
  }

  @override
  String toString() {
    return 'WcSessionPingRequest(data: $data)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_WcSessionPingRequest &&
            const DeepCollectionEquality().equals(other._data, _data));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode =>
      Object.hash(runtimeType, const DeepCollectionEquality().hash(_data));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_WcSessionPingRequestCopyWith<_$_WcSessionPingRequest> get copyWith =>
      __$$_WcSessionPingRequestCopyWithImpl<_$_WcSessionPingRequest>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_WcSessionPingRequestToJson(
      this,
    );
  }
}

abstract class _WcSessionPingRequest implements WcSessionPingRequest {
  const factory _WcSessionPingRequest({final Map<String, dynamic>? data}) =
      _$_WcSessionPingRequest;

  factory _WcSessionPingRequest.fromJson(Map<String, dynamic> json) =
      _$_WcSessionPingRequest.fromJson;

  @override
  Map<String, dynamic>? get data;
  @override
  @JsonKey(ignore: true)
  _$$_WcSessionPingRequestCopyWith<_$_WcSessionPingRequest> get copyWith =>
      throw _privateConstructorUsedError;
}

WcSessionRequestRequest _$WcSessionRequestRequestFromJson(
    Map<String, dynamic> json) {
  return _WcSessionRequestRequest.fromJson(json);
}

/// @nodoc
mixin _$WcSessionRequestRequest {
  String get chainId => throw _privateConstructorUsedError;
  SessionRequestParams get request => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $WcSessionRequestRequestCopyWith<WcSessionRequestRequest> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $WcSessionRequestRequestCopyWith<$Res> {
  factory $WcSessionRequestRequestCopyWith(WcSessionRequestRequest value,
          $Res Function(WcSessionRequestRequest) then) =
      _$WcSessionRequestRequestCopyWithImpl<$Res, WcSessionRequestRequest>;
  @useResult
  $Res call({String chainId, SessionRequestParams request});

  $SessionRequestParamsCopyWith<$Res> get request;
}

/// @nodoc
class _$WcSessionRequestRequestCopyWithImpl<$Res,
        $Val extends WcSessionRequestRequest>
    implements $WcSessionRequestRequestCopyWith<$Res> {
  _$WcSessionRequestRequestCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? chainId = null,
    Object? request = null,
  }) {
    return _then(_value.copyWith(
      chainId: null == chainId
          ? _value.chainId
          : chainId // ignore: cast_nullable_to_non_nullable
              as String,
      request: null == request
          ? _value.request
          : request // ignore: cast_nullable_to_non_nullable
              as SessionRequestParams,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $SessionRequestParamsCopyWith<$Res> get request {
    return $SessionRequestParamsCopyWith<$Res>(_value.request, (value) {
      return _then(_value.copyWith(request: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$_WcSessionRequestRequestCopyWith<$Res>
    implements $WcSessionRequestRequestCopyWith<$Res> {
  factory _$$_WcSessionRequestRequestCopyWith(_$_WcSessionRequestRequest value,
          $Res Function(_$_WcSessionRequestRequest) then) =
      __$$_WcSessionRequestRequestCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String chainId, SessionRequestParams request});

  @override
  $SessionRequestParamsCopyWith<$Res> get request;
}

/// @nodoc
class __$$_WcSessionRequestRequestCopyWithImpl<$Res>
    extends _$WcSessionRequestRequestCopyWithImpl<$Res,
        _$_WcSessionRequestRequest>
    implements _$$_WcSessionRequestRequestCopyWith<$Res> {
  __$$_WcSessionRequestRequestCopyWithImpl(_$_WcSessionRequestRequest _value,
      $Res Function(_$_WcSessionRequestRequest) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? chainId = null,
    Object? request = null,
  }) {
    return _then(_$_WcSessionRequestRequest(
      chainId: null == chainId
          ? _value.chainId
          : chainId // ignore: cast_nullable_to_non_nullable
              as String,
      request: null == request
          ? _value.request
          : request // ignore: cast_nullable_to_non_nullable
              as SessionRequestParams,
    ));
  }
}

/// @nodoc

@JsonSerializable()
class _$_WcSessionRequestRequest implements _WcSessionRequestRequest {
  const _$_WcSessionRequestRequest(
      {required this.chainId, required this.request});

  factory _$_WcSessionRequestRequest.fromJson(Map<String, dynamic> json) =>
      _$$_WcSessionRequestRequestFromJson(json);

  @override
  final String chainId;
  @override
  final SessionRequestParams request;

  @override
  String toString() {
    return 'WcSessionRequestRequest(chainId: $chainId, request: $request)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_WcSessionRequestRequest &&
            (identical(other.chainId, chainId) || other.chainId == chainId) &&
            (identical(other.request, request) || other.request == request));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, chainId, request);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_WcSessionRequestRequestCopyWith<_$_WcSessionRequestRequest>
      get copyWith =>
          __$$_WcSessionRequestRequestCopyWithImpl<_$_WcSessionRequestRequest>(
              this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_WcSessionRequestRequestToJson(
      this,
    );
  }
}

abstract class _WcSessionRequestRequest implements WcSessionRequestRequest {
  const factory _WcSessionRequestRequest(
          {required final String chainId,
          required final SessionRequestParams request}) =
      _$_WcSessionRequestRequest;

  factory _WcSessionRequestRequest.fromJson(Map<String, dynamic> json) =
      _$_WcSessionRequestRequest.fromJson;

  @override
  String get chainId;
  @override
  SessionRequestParams get request;
  @override
  @JsonKey(ignore: true)
  _$$_WcSessionRequestRequestCopyWith<_$_WcSessionRequestRequest>
      get copyWith => throw _privateConstructorUsedError;
}

SessionRequestParams _$SessionRequestParamsFromJson(Map<String, dynamic> json) {
  return _SessionRequestParams.fromJson(json);
}

/// @nodoc
mixin _$SessionRequestParams {
  String get method => throw _privateConstructorUsedError;
  dynamic get params => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $SessionRequestParamsCopyWith<SessionRequestParams> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SessionRequestParamsCopyWith<$Res> {
  factory $SessionRequestParamsCopyWith(SessionRequestParams value,
          $Res Function(SessionRequestParams) then) =
      _$SessionRequestParamsCopyWithImpl<$Res, SessionRequestParams>;
  @useResult
  $Res call({String method, dynamic params});
}

/// @nodoc
class _$SessionRequestParamsCopyWithImpl<$Res,
        $Val extends SessionRequestParams>
    implements $SessionRequestParamsCopyWith<$Res> {
  _$SessionRequestParamsCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? method = null,
    Object? params = freezed,
  }) {
    return _then(_value.copyWith(
      method: null == method
          ? _value.method
          : method // ignore: cast_nullable_to_non_nullable
              as String,
      params: freezed == params
          ? _value.params
          : params // ignore: cast_nullable_to_non_nullable
              as dynamic,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_SessionRequestParamsCopyWith<$Res>
    implements $SessionRequestParamsCopyWith<$Res> {
  factory _$$_SessionRequestParamsCopyWith(_$_SessionRequestParams value,
          $Res Function(_$_SessionRequestParams) then) =
      __$$_SessionRequestParamsCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String method, dynamic params});
}

/// @nodoc
class __$$_SessionRequestParamsCopyWithImpl<$Res>
    extends _$SessionRequestParamsCopyWithImpl<$Res, _$_SessionRequestParams>
    implements _$$_SessionRequestParamsCopyWith<$Res> {
  __$$_SessionRequestParamsCopyWithImpl(_$_SessionRequestParams _value,
      $Res Function(_$_SessionRequestParams) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? method = null,
    Object? params = freezed,
  }) {
    return _then(_$_SessionRequestParams(
      method: null == method
          ? _value.method
          : method // ignore: cast_nullable_to_non_nullable
              as String,
      params: freezed == params
          ? _value.params
          : params // ignore: cast_nullable_to_non_nullable
              as dynamic,
    ));
  }
}

/// @nodoc

@JsonSerializable()
class _$_SessionRequestParams implements _SessionRequestParams {
  const _$_SessionRequestParams({required this.method, required this.params});

  factory _$_SessionRequestParams.fromJson(Map<String, dynamic> json) =>
      _$$_SessionRequestParamsFromJson(json);

  @override
  final String method;
  @override
  final dynamic params;

  @override
  String toString() {
    return 'SessionRequestParams(method: $method, params: $params)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_SessionRequestParams &&
            (identical(other.method, method) || other.method == method) &&
            const DeepCollectionEquality().equals(other.params, params));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType, method, const DeepCollectionEquality().hash(params));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_SessionRequestParamsCopyWith<_$_SessionRequestParams> get copyWith =>
      __$$_SessionRequestParamsCopyWithImpl<_$_SessionRequestParams>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_SessionRequestParamsToJson(
      this,
    );
  }
}

abstract class _SessionRequestParams implements SessionRequestParams {
  const factory _SessionRequestParams(
      {required final String method,
      required final dynamic params}) = _$_SessionRequestParams;

  factory _SessionRequestParams.fromJson(Map<String, dynamic> json) =
      _$_SessionRequestParams.fromJson;

  @override
  String get method;
  @override
  dynamic get params;
  @override
  @JsonKey(ignore: true)
  _$$_SessionRequestParamsCopyWith<_$_SessionRequestParams> get copyWith =>
      throw _privateConstructorUsedError;
}

WcSessionEventRequest _$WcSessionEventRequestFromJson(
    Map<String, dynamic> json) {
  return _WcSessionEventRequest.fromJson(json);
}

/// @nodoc
mixin _$WcSessionEventRequest {
  String get chainId => throw _privateConstructorUsedError;
  SessionEventParams get event => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $WcSessionEventRequestCopyWith<WcSessionEventRequest> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $WcSessionEventRequestCopyWith<$Res> {
  factory $WcSessionEventRequestCopyWith(WcSessionEventRequest value,
          $Res Function(WcSessionEventRequest) then) =
      _$WcSessionEventRequestCopyWithImpl<$Res, WcSessionEventRequest>;
  @useResult
  $Res call({String chainId, SessionEventParams event});

  $SessionEventParamsCopyWith<$Res> get event;
}

/// @nodoc
class _$WcSessionEventRequestCopyWithImpl<$Res,
        $Val extends WcSessionEventRequest>
    implements $WcSessionEventRequestCopyWith<$Res> {
  _$WcSessionEventRequestCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? chainId = null,
    Object? event = null,
  }) {
    return _then(_value.copyWith(
      chainId: null == chainId
          ? _value.chainId
          : chainId // ignore: cast_nullable_to_non_nullable
              as String,
      event: null == event
          ? _value.event
          : event // ignore: cast_nullable_to_non_nullable
              as SessionEventParams,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $SessionEventParamsCopyWith<$Res> get event {
    return $SessionEventParamsCopyWith<$Res>(_value.event, (value) {
      return _then(_value.copyWith(event: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$_WcSessionEventRequestCopyWith<$Res>
    implements $WcSessionEventRequestCopyWith<$Res> {
  factory _$$_WcSessionEventRequestCopyWith(_$_WcSessionEventRequest value,
          $Res Function(_$_WcSessionEventRequest) then) =
      __$$_WcSessionEventRequestCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String chainId, SessionEventParams event});

  @override
  $SessionEventParamsCopyWith<$Res> get event;
}

/// @nodoc
class __$$_WcSessionEventRequestCopyWithImpl<$Res>
    extends _$WcSessionEventRequestCopyWithImpl<$Res, _$_WcSessionEventRequest>
    implements _$$_WcSessionEventRequestCopyWith<$Res> {
  __$$_WcSessionEventRequestCopyWithImpl(_$_WcSessionEventRequest _value,
      $Res Function(_$_WcSessionEventRequest) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? chainId = null,
    Object? event = null,
  }) {
    return _then(_$_WcSessionEventRequest(
      chainId: null == chainId
          ? _value.chainId
          : chainId // ignore: cast_nullable_to_non_nullable
              as String,
      event: null == event
          ? _value.event
          : event // ignore: cast_nullable_to_non_nullable
              as SessionEventParams,
    ));
  }
}

/// @nodoc

@JsonSerializable()
class _$_WcSessionEventRequest implements _WcSessionEventRequest {
  const _$_WcSessionEventRequest({required this.chainId, required this.event});

  factory _$_WcSessionEventRequest.fromJson(Map<String, dynamic> json) =>
      _$$_WcSessionEventRequestFromJson(json);

  @override
  final String chainId;
  @override
  final SessionEventParams event;

  @override
  String toString() {
    return 'WcSessionEventRequest(chainId: $chainId, event: $event)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_WcSessionEventRequest &&
            (identical(other.chainId, chainId) || other.chainId == chainId) &&
            (identical(other.event, event) || other.event == event));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, chainId, event);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_WcSessionEventRequestCopyWith<_$_WcSessionEventRequest> get copyWith =>
      __$$_WcSessionEventRequestCopyWithImpl<_$_WcSessionEventRequest>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_WcSessionEventRequestToJson(
      this,
    );
  }
}

abstract class _WcSessionEventRequest implements WcSessionEventRequest {
  const factory _WcSessionEventRequest(
      {required final String chainId,
      required final SessionEventParams event}) = _$_WcSessionEventRequest;

  factory _WcSessionEventRequest.fromJson(Map<String, dynamic> json) =
      _$_WcSessionEventRequest.fromJson;

  @override
  String get chainId;
  @override
  SessionEventParams get event;
  @override
  @JsonKey(ignore: true)
  _$$_WcSessionEventRequestCopyWith<_$_WcSessionEventRequest> get copyWith =>
      throw _privateConstructorUsedError;
}

SessionEventParams _$SessionEventParamsFromJson(Map<String, dynamic> json) {
  return _SessionEventParams.fromJson(json);
}

/// @nodoc
mixin _$SessionEventParams {
  String get name => throw _privateConstructorUsedError;
  dynamic get data => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $SessionEventParamsCopyWith<SessionEventParams> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SessionEventParamsCopyWith<$Res> {
  factory $SessionEventParamsCopyWith(
          SessionEventParams value, $Res Function(SessionEventParams) then) =
      _$SessionEventParamsCopyWithImpl<$Res, SessionEventParams>;
  @useResult
  $Res call({String name, dynamic data});
}

/// @nodoc
class _$SessionEventParamsCopyWithImpl<$Res, $Val extends SessionEventParams>
    implements $SessionEventParamsCopyWith<$Res> {
  _$SessionEventParamsCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = null,
    Object? data = freezed,
  }) {
    return _then(_value.copyWith(
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      data: freezed == data
          ? _value.data
          : data // ignore: cast_nullable_to_non_nullable
              as dynamic,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_SessionEventParamsCopyWith<$Res>
    implements $SessionEventParamsCopyWith<$Res> {
  factory _$$_SessionEventParamsCopyWith(_$_SessionEventParams value,
          $Res Function(_$_SessionEventParams) then) =
      __$$_SessionEventParamsCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String name, dynamic data});
}

/// @nodoc
class __$$_SessionEventParamsCopyWithImpl<$Res>
    extends _$SessionEventParamsCopyWithImpl<$Res, _$_SessionEventParams>
    implements _$$_SessionEventParamsCopyWith<$Res> {
  __$$_SessionEventParamsCopyWithImpl(
      _$_SessionEventParams _value, $Res Function(_$_SessionEventParams) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = null,
    Object? data = freezed,
  }) {
    return _then(_$_SessionEventParams(
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      data: freezed == data
          ? _value.data
          : data // ignore: cast_nullable_to_non_nullable
              as dynamic,
    ));
  }
}

/// @nodoc

@JsonSerializable()
class _$_SessionEventParams implements _SessionEventParams {
  const _$_SessionEventParams({required this.name, required this.data});

  factory _$_SessionEventParams.fromJson(Map<String, dynamic> json) =>
      _$$_SessionEventParamsFromJson(json);

  @override
  final String name;
  @override
  final dynamic data;

  @override
  String toString() {
    return 'SessionEventParams(name: $name, data: $data)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_SessionEventParams &&
            (identical(other.name, name) || other.name == name) &&
            const DeepCollectionEquality().equals(other.data, data));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode =>
      Object.hash(runtimeType, name, const DeepCollectionEquality().hash(data));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_SessionEventParamsCopyWith<_$_SessionEventParams> get copyWith =>
      __$$_SessionEventParamsCopyWithImpl<_$_SessionEventParams>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_SessionEventParamsToJson(
      this,
    );
  }
}

abstract class _SessionEventParams implements SessionEventParams {
  const factory _SessionEventParams(
      {required final String name,
      required final dynamic data}) = _$_SessionEventParams;

  factory _SessionEventParams.fromJson(Map<String, dynamic> json) =
      _$_SessionEventParams.fromJson;

  @override
  String get name;
  @override
  dynamic get data;
  @override
  @JsonKey(ignore: true)
  _$$_SessionEventParamsCopyWith<_$_SessionEventParams> get copyWith =>
      throw _privateConstructorUsedError;
}

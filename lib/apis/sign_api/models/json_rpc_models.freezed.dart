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
abstract class _$$WcPairingDeleteRequestImplCopyWith<$Res>
    implements $WcPairingDeleteRequestCopyWith<$Res> {
  factory _$$WcPairingDeleteRequestImplCopyWith(
          _$WcPairingDeleteRequestImpl value,
          $Res Function(_$WcPairingDeleteRequestImpl) then) =
      __$$WcPairingDeleteRequestImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({int code, String message});
}

/// @nodoc
class __$$WcPairingDeleteRequestImplCopyWithImpl<$Res>
    extends _$WcPairingDeleteRequestCopyWithImpl<$Res,
        _$WcPairingDeleteRequestImpl>
    implements _$$WcPairingDeleteRequestImplCopyWith<$Res> {
  __$$WcPairingDeleteRequestImplCopyWithImpl(
      _$WcPairingDeleteRequestImpl _value,
      $Res Function(_$WcPairingDeleteRequestImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? code = null,
    Object? message = null,
  }) {
    return _then(_$WcPairingDeleteRequestImpl(
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
class _$WcPairingDeleteRequestImpl implements _WcPairingDeleteRequest {
  const _$WcPairingDeleteRequestImpl(
      {required this.code, required this.message});

  factory _$WcPairingDeleteRequestImpl.fromJson(Map<String, dynamic> json) =>
      _$$WcPairingDeleteRequestImplFromJson(json);

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
            other is _$WcPairingDeleteRequestImpl &&
            (identical(other.code, code) || other.code == code) &&
            (identical(other.message, message) || other.message == message));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, code, message);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$WcPairingDeleteRequestImplCopyWith<_$WcPairingDeleteRequestImpl>
      get copyWith => __$$WcPairingDeleteRequestImplCopyWithImpl<
          _$WcPairingDeleteRequestImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$WcPairingDeleteRequestImplToJson(
      this,
    );
  }
}

abstract class _WcPairingDeleteRequest implements WcPairingDeleteRequest {
  const factory _WcPairingDeleteRequest(
      {required final int code,
      required final String message}) = _$WcPairingDeleteRequestImpl;

  factory _WcPairingDeleteRequest.fromJson(Map<String, dynamic> json) =
      _$WcPairingDeleteRequestImpl.fromJson;

  @override
  int get code;
  @override
  String get message;
  @override
  @JsonKey(ignore: true)
  _$$WcPairingDeleteRequestImplCopyWith<_$WcPairingDeleteRequestImpl>
      get copyWith => throw _privateConstructorUsedError;
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
abstract class _$$WcPairingPingRequestImplCopyWith<$Res>
    implements $WcPairingPingRequestCopyWith<$Res> {
  factory _$$WcPairingPingRequestImplCopyWith(_$WcPairingPingRequestImpl value,
          $Res Function(_$WcPairingPingRequestImpl) then) =
      __$$WcPairingPingRequestImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({Map<String, dynamic> data});
}

/// @nodoc
class __$$WcPairingPingRequestImplCopyWithImpl<$Res>
    extends _$WcPairingPingRequestCopyWithImpl<$Res, _$WcPairingPingRequestImpl>
    implements _$$WcPairingPingRequestImplCopyWith<$Res> {
  __$$WcPairingPingRequestImplCopyWithImpl(_$WcPairingPingRequestImpl _value,
      $Res Function(_$WcPairingPingRequestImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? data = null,
  }) {
    return _then(_$WcPairingPingRequestImpl(
      data: null == data
          ? _value._data
          : data // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>,
    ));
  }
}

/// @nodoc

@JsonSerializable()
class _$WcPairingPingRequestImpl implements _WcPairingPingRequest {
  const _$WcPairingPingRequestImpl({required final Map<String, dynamic> data})
      : _data = data;

  factory _$WcPairingPingRequestImpl.fromJson(Map<String, dynamic> json) =>
      _$$WcPairingPingRequestImplFromJson(json);

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
            other is _$WcPairingPingRequestImpl &&
            const DeepCollectionEquality().equals(other._data, _data));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode =>
      Object.hash(runtimeType, const DeepCollectionEquality().hash(_data));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$WcPairingPingRequestImplCopyWith<_$WcPairingPingRequestImpl>
      get copyWith =>
          __$$WcPairingPingRequestImplCopyWithImpl<_$WcPairingPingRequestImpl>(
              this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$WcPairingPingRequestImplToJson(
      this,
    );
  }
}

abstract class _WcPairingPingRequest implements WcPairingPingRequest {
  const factory _WcPairingPingRequest(
      {required final Map<String, dynamic> data}) = _$WcPairingPingRequestImpl;

  factory _WcPairingPingRequest.fromJson(Map<String, dynamic> json) =
      _$WcPairingPingRequestImpl.fromJson;

  @override
  Map<String, dynamic> get data;
  @override
  @JsonKey(ignore: true)
  _$$WcPairingPingRequestImplCopyWith<_$WcPairingPingRequestImpl>
      get copyWith => throw _privateConstructorUsedError;
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
abstract class _$$WcSessionProposeRequestImplCopyWith<$Res>
    implements $WcSessionProposeRequestCopyWith<$Res> {
  factory _$$WcSessionProposeRequestImplCopyWith(
          _$WcSessionProposeRequestImpl value,
          $Res Function(_$WcSessionProposeRequestImpl) then) =
      __$$WcSessionProposeRequestImplCopyWithImpl<$Res>;
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
class __$$WcSessionProposeRequestImplCopyWithImpl<$Res>
    extends _$WcSessionProposeRequestCopyWithImpl<$Res,
        _$WcSessionProposeRequestImpl>
    implements _$$WcSessionProposeRequestImplCopyWith<$Res> {
  __$$WcSessionProposeRequestImplCopyWithImpl(
      _$WcSessionProposeRequestImpl _value,
      $Res Function(_$WcSessionProposeRequestImpl) _then)
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
    return _then(_$WcSessionProposeRequestImpl(
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
class _$WcSessionProposeRequestImpl implements _WcSessionProposeRequest {
  const _$WcSessionProposeRequestImpl(
      {required final List<Relay> relays,
      required final Map<String, RequiredNamespace> requiredNamespaces,
      final Map<String, RequiredNamespace>? optionalNamespaces,
      final Map<String, String>? sessionProperties,
      required this.proposer})
      : _relays = relays,
        _requiredNamespaces = requiredNamespaces,
        _optionalNamespaces = optionalNamespaces,
        _sessionProperties = sessionProperties;

  factory _$WcSessionProposeRequestImpl.fromJson(Map<String, dynamic> json) =>
      _$$WcSessionProposeRequestImplFromJson(json);

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
            other is _$WcSessionProposeRequestImpl &&
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
  _$$WcSessionProposeRequestImplCopyWith<_$WcSessionProposeRequestImpl>
      get copyWith => __$$WcSessionProposeRequestImplCopyWithImpl<
          _$WcSessionProposeRequestImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$WcSessionProposeRequestImplToJson(
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
          required final ConnectionMetadata proposer}) =
      _$WcSessionProposeRequestImpl;

  factory _WcSessionProposeRequest.fromJson(Map<String, dynamic> json) =
      _$WcSessionProposeRequestImpl.fromJson;

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
  _$$WcSessionProposeRequestImplCopyWith<_$WcSessionProposeRequestImpl>
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
abstract class _$$WcSessionProposeResponseImplCopyWith<$Res>
    implements $WcSessionProposeResponseCopyWith<$Res> {
  factory _$$WcSessionProposeResponseImplCopyWith(
          _$WcSessionProposeResponseImpl value,
          $Res Function(_$WcSessionProposeResponseImpl) then) =
      __$$WcSessionProposeResponseImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({Relay relay, String responderPublicKey});
}

/// @nodoc
class __$$WcSessionProposeResponseImplCopyWithImpl<$Res>
    extends _$WcSessionProposeResponseCopyWithImpl<$Res,
        _$WcSessionProposeResponseImpl>
    implements _$$WcSessionProposeResponseImplCopyWith<$Res> {
  __$$WcSessionProposeResponseImplCopyWithImpl(
      _$WcSessionProposeResponseImpl _value,
      $Res Function(_$WcSessionProposeResponseImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? relay = null,
    Object? responderPublicKey = null,
  }) {
    return _then(_$WcSessionProposeResponseImpl(
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
class _$WcSessionProposeResponseImpl implements _WcSessionProposeResponse {
  const _$WcSessionProposeResponseImpl(
      {required this.relay, required this.responderPublicKey});

  factory _$WcSessionProposeResponseImpl.fromJson(Map<String, dynamic> json) =>
      _$$WcSessionProposeResponseImplFromJson(json);

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
            other is _$WcSessionProposeResponseImpl &&
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
  _$$WcSessionProposeResponseImplCopyWith<_$WcSessionProposeResponseImpl>
      get copyWith => __$$WcSessionProposeResponseImplCopyWithImpl<
          _$WcSessionProposeResponseImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$WcSessionProposeResponseImplToJson(
      this,
    );
  }
}

abstract class _WcSessionProposeResponse implements WcSessionProposeResponse {
  const factory _WcSessionProposeResponse(
          {required final Relay relay,
          required final String responderPublicKey}) =
      _$WcSessionProposeResponseImpl;

  factory _WcSessionProposeResponse.fromJson(Map<String, dynamic> json) =
      _$WcSessionProposeResponseImpl.fromJson;

  @override
  Relay get relay;
  @override
  String get responderPublicKey;
  @override
  @JsonKey(ignore: true)
  _$$WcSessionProposeResponseImplCopyWith<_$WcSessionProposeResponseImpl>
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
abstract class _$$WcSessionSettleRequestImplCopyWith<$Res>
    implements $WcSessionSettleRequestCopyWith<$Res> {
  factory _$$WcSessionSettleRequestImplCopyWith(
          _$WcSessionSettleRequestImpl value,
          $Res Function(_$WcSessionSettleRequestImpl) then) =
      __$$WcSessionSettleRequestImplCopyWithImpl<$Res>;
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
class __$$WcSessionSettleRequestImplCopyWithImpl<$Res>
    extends _$WcSessionSettleRequestCopyWithImpl<$Res,
        _$WcSessionSettleRequestImpl>
    implements _$$WcSessionSettleRequestImplCopyWith<$Res> {
  __$$WcSessionSettleRequestImplCopyWithImpl(
      _$WcSessionSettleRequestImpl _value,
      $Res Function(_$WcSessionSettleRequestImpl) _then)
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
    return _then(_$WcSessionSettleRequestImpl(
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
class _$WcSessionSettleRequestImpl implements _WcSessionSettleRequest {
  const _$WcSessionSettleRequestImpl(
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

  factory _$WcSessionSettleRequestImpl.fromJson(Map<String, dynamic> json) =>
      _$$WcSessionSettleRequestImplFromJson(json);

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
            other is _$WcSessionSettleRequestImpl &&
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
  _$$WcSessionSettleRequestImplCopyWith<_$WcSessionSettleRequestImpl>
      get copyWith => __$$WcSessionSettleRequestImplCopyWithImpl<
          _$WcSessionSettleRequestImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$WcSessionSettleRequestImplToJson(
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
      _$WcSessionSettleRequestImpl;

  factory _WcSessionSettleRequest.fromJson(Map<String, dynamic> json) =
      _$WcSessionSettleRequestImpl.fromJson;

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
  _$$WcSessionSettleRequestImplCopyWith<_$WcSessionSettleRequestImpl>
      get copyWith => throw _privateConstructorUsedError;
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
abstract class _$$WcSessionUpdateRequestImplCopyWith<$Res>
    implements $WcSessionUpdateRequestCopyWith<$Res> {
  factory _$$WcSessionUpdateRequestImplCopyWith(
          _$WcSessionUpdateRequestImpl value,
          $Res Function(_$WcSessionUpdateRequestImpl) then) =
      __$$WcSessionUpdateRequestImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({Map<String, Namespace> namespaces});
}

/// @nodoc
class __$$WcSessionUpdateRequestImplCopyWithImpl<$Res>
    extends _$WcSessionUpdateRequestCopyWithImpl<$Res,
        _$WcSessionUpdateRequestImpl>
    implements _$$WcSessionUpdateRequestImplCopyWith<$Res> {
  __$$WcSessionUpdateRequestImplCopyWithImpl(
      _$WcSessionUpdateRequestImpl _value,
      $Res Function(_$WcSessionUpdateRequestImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? namespaces = null,
  }) {
    return _then(_$WcSessionUpdateRequestImpl(
      namespaces: null == namespaces
          ? _value._namespaces
          : namespaces // ignore: cast_nullable_to_non_nullable
              as Map<String, Namespace>,
    ));
  }
}

/// @nodoc

@JsonSerializable()
class _$WcSessionUpdateRequestImpl implements _WcSessionUpdateRequest {
  const _$WcSessionUpdateRequestImpl(
      {required final Map<String, Namespace> namespaces})
      : _namespaces = namespaces;

  factory _$WcSessionUpdateRequestImpl.fromJson(Map<String, dynamic> json) =>
      _$$WcSessionUpdateRequestImplFromJson(json);

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
            other is _$WcSessionUpdateRequestImpl &&
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
  _$$WcSessionUpdateRequestImplCopyWith<_$WcSessionUpdateRequestImpl>
      get copyWith => __$$WcSessionUpdateRequestImplCopyWithImpl<
          _$WcSessionUpdateRequestImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$WcSessionUpdateRequestImplToJson(
      this,
    );
  }
}

abstract class _WcSessionUpdateRequest implements WcSessionUpdateRequest {
  const factory _WcSessionUpdateRequest(
          {required final Map<String, Namespace> namespaces}) =
      _$WcSessionUpdateRequestImpl;

  factory _WcSessionUpdateRequest.fromJson(Map<String, dynamic> json) =
      _$WcSessionUpdateRequestImpl.fromJson;

  @override
  Map<String, Namespace> get namespaces;
  @override
  @JsonKey(ignore: true)
  _$$WcSessionUpdateRequestImplCopyWith<_$WcSessionUpdateRequestImpl>
      get copyWith => throw _privateConstructorUsedError;
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
abstract class _$$WcSessionExtendRequestImplCopyWith<$Res>
    implements $WcSessionExtendRequestCopyWith<$Res> {
  factory _$$WcSessionExtendRequestImplCopyWith(
          _$WcSessionExtendRequestImpl value,
          $Res Function(_$WcSessionExtendRequestImpl) then) =
      __$$WcSessionExtendRequestImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({Map<String, dynamic>? data});
}

/// @nodoc
class __$$WcSessionExtendRequestImplCopyWithImpl<$Res>
    extends _$WcSessionExtendRequestCopyWithImpl<$Res,
        _$WcSessionExtendRequestImpl>
    implements _$$WcSessionExtendRequestImplCopyWith<$Res> {
  __$$WcSessionExtendRequestImplCopyWithImpl(
      _$WcSessionExtendRequestImpl _value,
      $Res Function(_$WcSessionExtendRequestImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? data = freezed,
  }) {
    return _then(_$WcSessionExtendRequestImpl(
      data: freezed == data
          ? _value._data
          : data // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>?,
    ));
  }
}

/// @nodoc

@JsonSerializable(includeIfNull: false)
class _$WcSessionExtendRequestImpl implements _WcSessionExtendRequest {
  const _$WcSessionExtendRequestImpl({final Map<String, dynamic>? data})
      : _data = data;

  factory _$WcSessionExtendRequestImpl.fromJson(Map<String, dynamic> json) =>
      _$$WcSessionExtendRequestImplFromJson(json);

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
            other is _$WcSessionExtendRequestImpl &&
            const DeepCollectionEquality().equals(other._data, _data));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode =>
      Object.hash(runtimeType, const DeepCollectionEquality().hash(_data));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$WcSessionExtendRequestImplCopyWith<_$WcSessionExtendRequestImpl>
      get copyWith => __$$WcSessionExtendRequestImplCopyWithImpl<
          _$WcSessionExtendRequestImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$WcSessionExtendRequestImplToJson(
      this,
    );
  }
}

abstract class _WcSessionExtendRequest implements WcSessionExtendRequest {
  const factory _WcSessionExtendRequest({final Map<String, dynamic>? data}) =
      _$WcSessionExtendRequestImpl;

  factory _WcSessionExtendRequest.fromJson(Map<String, dynamic> json) =
      _$WcSessionExtendRequestImpl.fromJson;

  @override
  Map<String, dynamic>? get data;
  @override
  @JsonKey(ignore: true)
  _$$WcSessionExtendRequestImplCopyWith<_$WcSessionExtendRequestImpl>
      get copyWith => throw _privateConstructorUsedError;
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
abstract class _$$WcSessionDeleteRequestImplCopyWith<$Res>
    implements $WcSessionDeleteRequestCopyWith<$Res> {
  factory _$$WcSessionDeleteRequestImplCopyWith(
          _$WcSessionDeleteRequestImpl value,
          $Res Function(_$WcSessionDeleteRequestImpl) then) =
      __$$WcSessionDeleteRequestImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({int code, String message, String? data});
}

/// @nodoc
class __$$WcSessionDeleteRequestImplCopyWithImpl<$Res>
    extends _$WcSessionDeleteRequestCopyWithImpl<$Res,
        _$WcSessionDeleteRequestImpl>
    implements _$$WcSessionDeleteRequestImplCopyWith<$Res> {
  __$$WcSessionDeleteRequestImplCopyWithImpl(
      _$WcSessionDeleteRequestImpl _value,
      $Res Function(_$WcSessionDeleteRequestImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? code = null,
    Object? message = null,
    Object? data = freezed,
  }) {
    return _then(_$WcSessionDeleteRequestImpl(
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
class _$WcSessionDeleteRequestImpl implements _WcSessionDeleteRequest {
  const _$WcSessionDeleteRequestImpl(
      {required this.code, required this.message, this.data});

  factory _$WcSessionDeleteRequestImpl.fromJson(Map<String, dynamic> json) =>
      _$$WcSessionDeleteRequestImplFromJson(json);

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
            other is _$WcSessionDeleteRequestImpl &&
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
  _$$WcSessionDeleteRequestImplCopyWith<_$WcSessionDeleteRequestImpl>
      get copyWith => __$$WcSessionDeleteRequestImplCopyWithImpl<
          _$WcSessionDeleteRequestImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$WcSessionDeleteRequestImplToJson(
      this,
    );
  }
}

abstract class _WcSessionDeleteRequest implements WcSessionDeleteRequest {
  const factory _WcSessionDeleteRequest(
      {required final int code,
      required final String message,
      final String? data}) = _$WcSessionDeleteRequestImpl;

  factory _WcSessionDeleteRequest.fromJson(Map<String, dynamic> json) =
      _$WcSessionDeleteRequestImpl.fromJson;

  @override
  int get code;
  @override
  String get message;
  @override
  String? get data;
  @override
  @JsonKey(ignore: true)
  _$$WcSessionDeleteRequestImplCopyWith<_$WcSessionDeleteRequestImpl>
      get copyWith => throw _privateConstructorUsedError;
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
abstract class _$$WcSessionPingRequestImplCopyWith<$Res>
    implements $WcSessionPingRequestCopyWith<$Res> {
  factory _$$WcSessionPingRequestImplCopyWith(_$WcSessionPingRequestImpl value,
          $Res Function(_$WcSessionPingRequestImpl) then) =
      __$$WcSessionPingRequestImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({Map<String, dynamic>? data});
}

/// @nodoc
class __$$WcSessionPingRequestImplCopyWithImpl<$Res>
    extends _$WcSessionPingRequestCopyWithImpl<$Res, _$WcSessionPingRequestImpl>
    implements _$$WcSessionPingRequestImplCopyWith<$Res> {
  __$$WcSessionPingRequestImplCopyWithImpl(_$WcSessionPingRequestImpl _value,
      $Res Function(_$WcSessionPingRequestImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? data = freezed,
  }) {
    return _then(_$WcSessionPingRequestImpl(
      data: freezed == data
          ? _value._data
          : data // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>?,
    ));
  }
}

/// @nodoc

@JsonSerializable(includeIfNull: false)
class _$WcSessionPingRequestImpl implements _WcSessionPingRequest {
  const _$WcSessionPingRequestImpl({final Map<String, dynamic>? data})
      : _data = data;

  factory _$WcSessionPingRequestImpl.fromJson(Map<String, dynamic> json) =>
      _$$WcSessionPingRequestImplFromJson(json);

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
            other is _$WcSessionPingRequestImpl &&
            const DeepCollectionEquality().equals(other._data, _data));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode =>
      Object.hash(runtimeType, const DeepCollectionEquality().hash(_data));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$WcSessionPingRequestImplCopyWith<_$WcSessionPingRequestImpl>
      get copyWith =>
          __$$WcSessionPingRequestImplCopyWithImpl<_$WcSessionPingRequestImpl>(
              this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$WcSessionPingRequestImplToJson(
      this,
    );
  }
}

abstract class _WcSessionPingRequest implements WcSessionPingRequest {
  const factory _WcSessionPingRequest({final Map<String, dynamic>? data}) =
      _$WcSessionPingRequestImpl;

  factory _WcSessionPingRequest.fromJson(Map<String, dynamic> json) =
      _$WcSessionPingRequestImpl.fromJson;

  @override
  Map<String, dynamic>? get data;
  @override
  @JsonKey(ignore: true)
  _$$WcSessionPingRequestImplCopyWith<_$WcSessionPingRequestImpl>
      get copyWith => throw _privateConstructorUsedError;
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
abstract class _$$WcSessionRequestRequestImplCopyWith<$Res>
    implements $WcSessionRequestRequestCopyWith<$Res> {
  factory _$$WcSessionRequestRequestImplCopyWith(
          _$WcSessionRequestRequestImpl value,
          $Res Function(_$WcSessionRequestRequestImpl) then) =
      __$$WcSessionRequestRequestImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String chainId, SessionRequestParams request});

  @override
  $SessionRequestParamsCopyWith<$Res> get request;
}

/// @nodoc
class __$$WcSessionRequestRequestImplCopyWithImpl<$Res>
    extends _$WcSessionRequestRequestCopyWithImpl<$Res,
        _$WcSessionRequestRequestImpl>
    implements _$$WcSessionRequestRequestImplCopyWith<$Res> {
  __$$WcSessionRequestRequestImplCopyWithImpl(
      _$WcSessionRequestRequestImpl _value,
      $Res Function(_$WcSessionRequestRequestImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? chainId = null,
    Object? request = null,
  }) {
    return _then(_$WcSessionRequestRequestImpl(
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
class _$WcSessionRequestRequestImpl implements _WcSessionRequestRequest {
  const _$WcSessionRequestRequestImpl(
      {required this.chainId, required this.request});

  factory _$WcSessionRequestRequestImpl.fromJson(Map<String, dynamic> json) =>
      _$$WcSessionRequestRequestImplFromJson(json);

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
            other is _$WcSessionRequestRequestImpl &&
            (identical(other.chainId, chainId) || other.chainId == chainId) &&
            (identical(other.request, request) || other.request == request));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, chainId, request);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$WcSessionRequestRequestImplCopyWith<_$WcSessionRequestRequestImpl>
      get copyWith => __$$WcSessionRequestRequestImplCopyWithImpl<
          _$WcSessionRequestRequestImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$WcSessionRequestRequestImplToJson(
      this,
    );
  }
}

abstract class _WcSessionRequestRequest implements WcSessionRequestRequest {
  const factory _WcSessionRequestRequest(
          {required final String chainId,
          required final SessionRequestParams request}) =
      _$WcSessionRequestRequestImpl;

  factory _WcSessionRequestRequest.fromJson(Map<String, dynamic> json) =
      _$WcSessionRequestRequestImpl.fromJson;

  @override
  String get chainId;
  @override
  SessionRequestParams get request;
  @override
  @JsonKey(ignore: true)
  _$$WcSessionRequestRequestImplCopyWith<_$WcSessionRequestRequestImpl>
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
abstract class _$$SessionRequestParamsImplCopyWith<$Res>
    implements $SessionRequestParamsCopyWith<$Res> {
  factory _$$SessionRequestParamsImplCopyWith(_$SessionRequestParamsImpl value,
          $Res Function(_$SessionRequestParamsImpl) then) =
      __$$SessionRequestParamsImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String method, dynamic params});
}

/// @nodoc
class __$$SessionRequestParamsImplCopyWithImpl<$Res>
    extends _$SessionRequestParamsCopyWithImpl<$Res, _$SessionRequestParamsImpl>
    implements _$$SessionRequestParamsImplCopyWith<$Res> {
  __$$SessionRequestParamsImplCopyWithImpl(_$SessionRequestParamsImpl _value,
      $Res Function(_$SessionRequestParamsImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? method = null,
    Object? params = freezed,
  }) {
    return _then(_$SessionRequestParamsImpl(
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
class _$SessionRequestParamsImpl implements _SessionRequestParams {
  const _$SessionRequestParamsImpl(
      {required this.method, required this.params});

  factory _$SessionRequestParamsImpl.fromJson(Map<String, dynamic> json) =>
      _$$SessionRequestParamsImplFromJson(json);

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
            other is _$SessionRequestParamsImpl &&
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
  _$$SessionRequestParamsImplCopyWith<_$SessionRequestParamsImpl>
      get copyWith =>
          __$$SessionRequestParamsImplCopyWithImpl<_$SessionRequestParamsImpl>(
              this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$SessionRequestParamsImplToJson(
      this,
    );
  }
}

abstract class _SessionRequestParams implements SessionRequestParams {
  const factory _SessionRequestParams(
      {required final String method,
      required final dynamic params}) = _$SessionRequestParamsImpl;

  factory _SessionRequestParams.fromJson(Map<String, dynamic> json) =
      _$SessionRequestParamsImpl.fromJson;

  @override
  String get method;
  @override
  dynamic get params;
  @override
  @JsonKey(ignore: true)
  _$$SessionRequestParamsImplCopyWith<_$SessionRequestParamsImpl>
      get copyWith => throw _privateConstructorUsedError;
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
abstract class _$$WcSessionEventRequestImplCopyWith<$Res>
    implements $WcSessionEventRequestCopyWith<$Res> {
  factory _$$WcSessionEventRequestImplCopyWith(
          _$WcSessionEventRequestImpl value,
          $Res Function(_$WcSessionEventRequestImpl) then) =
      __$$WcSessionEventRequestImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String chainId, SessionEventParams event});

  @override
  $SessionEventParamsCopyWith<$Res> get event;
}

/// @nodoc
class __$$WcSessionEventRequestImplCopyWithImpl<$Res>
    extends _$WcSessionEventRequestCopyWithImpl<$Res,
        _$WcSessionEventRequestImpl>
    implements _$$WcSessionEventRequestImplCopyWith<$Res> {
  __$$WcSessionEventRequestImplCopyWithImpl(_$WcSessionEventRequestImpl _value,
      $Res Function(_$WcSessionEventRequestImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? chainId = null,
    Object? event = null,
  }) {
    return _then(_$WcSessionEventRequestImpl(
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
class _$WcSessionEventRequestImpl implements _WcSessionEventRequest {
  const _$WcSessionEventRequestImpl(
      {required this.chainId, required this.event});

  factory _$WcSessionEventRequestImpl.fromJson(Map<String, dynamic> json) =>
      _$$WcSessionEventRequestImplFromJson(json);

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
            other is _$WcSessionEventRequestImpl &&
            (identical(other.chainId, chainId) || other.chainId == chainId) &&
            (identical(other.event, event) || other.event == event));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, chainId, event);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$WcSessionEventRequestImplCopyWith<_$WcSessionEventRequestImpl>
      get copyWith => __$$WcSessionEventRequestImplCopyWithImpl<
          _$WcSessionEventRequestImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$WcSessionEventRequestImplToJson(
      this,
    );
  }
}

abstract class _WcSessionEventRequest implements WcSessionEventRequest {
  const factory _WcSessionEventRequest(
      {required final String chainId,
      required final SessionEventParams event}) = _$WcSessionEventRequestImpl;

  factory _WcSessionEventRequest.fromJson(Map<String, dynamic> json) =
      _$WcSessionEventRequestImpl.fromJson;

  @override
  String get chainId;
  @override
  SessionEventParams get event;
  @override
  @JsonKey(ignore: true)
  _$$WcSessionEventRequestImplCopyWith<_$WcSessionEventRequestImpl>
      get copyWith => throw _privateConstructorUsedError;
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
abstract class _$$SessionEventParamsImplCopyWith<$Res>
    implements $SessionEventParamsCopyWith<$Res> {
  factory _$$SessionEventParamsImplCopyWith(_$SessionEventParamsImpl value,
          $Res Function(_$SessionEventParamsImpl) then) =
      __$$SessionEventParamsImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String name, dynamic data});
}

/// @nodoc
class __$$SessionEventParamsImplCopyWithImpl<$Res>
    extends _$SessionEventParamsCopyWithImpl<$Res, _$SessionEventParamsImpl>
    implements _$$SessionEventParamsImplCopyWith<$Res> {
  __$$SessionEventParamsImplCopyWithImpl(_$SessionEventParamsImpl _value,
      $Res Function(_$SessionEventParamsImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = null,
    Object? data = freezed,
  }) {
    return _then(_$SessionEventParamsImpl(
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
class _$SessionEventParamsImpl implements _SessionEventParams {
  const _$SessionEventParamsImpl({required this.name, required this.data});

  factory _$SessionEventParamsImpl.fromJson(Map<String, dynamic> json) =>
      _$$SessionEventParamsImplFromJson(json);

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
            other is _$SessionEventParamsImpl &&
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
  _$$SessionEventParamsImplCopyWith<_$SessionEventParamsImpl> get copyWith =>
      __$$SessionEventParamsImplCopyWithImpl<_$SessionEventParamsImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$SessionEventParamsImplToJson(
      this,
    );
  }
}

abstract class _SessionEventParams implements SessionEventParams {
  const factory _SessionEventParams(
      {required final String name,
      required final dynamic data}) = _$SessionEventParamsImpl;

  factory _SessionEventParams.fromJson(Map<String, dynamic> json) =
      _$SessionEventParamsImpl.fromJson;

  @override
  String get name;
  @override
  dynamic get data;
  @override
  @JsonKey(ignore: true)
  _$$SessionEventParamsImplCopyWith<_$SessionEventParamsImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

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

WcSessionAuthRequestParams _$WcSessionAuthRequestParamsFromJson(
    Map<String, dynamic> json) {
  return _WcSessionAuthRequestParams.fromJson(json);
}

/// @nodoc
mixin _$WcSessionAuthRequestParams {
  SessionAuthPayload get authPayload => throw _privateConstructorUsedError;
  ConnectionMetadata get requester => throw _privateConstructorUsedError;
  int get expiryTimestamp => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $WcSessionAuthRequestParamsCopyWith<WcSessionAuthRequestParams>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $WcSessionAuthRequestParamsCopyWith<$Res> {
  factory $WcSessionAuthRequestParamsCopyWith(WcSessionAuthRequestParams value,
          $Res Function(WcSessionAuthRequestParams) then) =
      _$WcSessionAuthRequestParamsCopyWithImpl<$Res,
          WcSessionAuthRequestParams>;
  @useResult
  $Res call(
      {SessionAuthPayload authPayload,
      ConnectionMetadata requester,
      int expiryTimestamp});

  $SessionAuthPayloadCopyWith<$Res> get authPayload;
  $ConnectionMetadataCopyWith<$Res> get requester;
}

/// @nodoc
class _$WcSessionAuthRequestParamsCopyWithImpl<$Res,
        $Val extends WcSessionAuthRequestParams>
    implements $WcSessionAuthRequestParamsCopyWith<$Res> {
  _$WcSessionAuthRequestParamsCopyWithImpl(this._value, this._then);

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
              as SessionAuthPayload,
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
  $SessionAuthPayloadCopyWith<$Res> get authPayload {
    return $SessionAuthPayloadCopyWith<$Res>(_value.authPayload, (value) {
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
abstract class _$$WcSessionAuthRequestParamsImplCopyWith<$Res>
    implements $WcSessionAuthRequestParamsCopyWith<$Res> {
  factory _$$WcSessionAuthRequestParamsImplCopyWith(
          _$WcSessionAuthRequestParamsImpl value,
          $Res Function(_$WcSessionAuthRequestParamsImpl) then) =
      __$$WcSessionAuthRequestParamsImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {SessionAuthPayload authPayload,
      ConnectionMetadata requester,
      int expiryTimestamp});

  @override
  $SessionAuthPayloadCopyWith<$Res> get authPayload;
  @override
  $ConnectionMetadataCopyWith<$Res> get requester;
}

/// @nodoc
class __$$WcSessionAuthRequestParamsImplCopyWithImpl<$Res>
    extends _$WcSessionAuthRequestParamsCopyWithImpl<$Res,
        _$WcSessionAuthRequestParamsImpl>
    implements _$$WcSessionAuthRequestParamsImplCopyWith<$Res> {
  __$$WcSessionAuthRequestParamsImplCopyWithImpl(
      _$WcSessionAuthRequestParamsImpl _value,
      $Res Function(_$WcSessionAuthRequestParamsImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? authPayload = null,
    Object? requester = null,
    Object? expiryTimestamp = null,
  }) {
    return _then(_$WcSessionAuthRequestParamsImpl(
      authPayload: null == authPayload
          ? _value.authPayload
          : authPayload // ignore: cast_nullable_to_non_nullable
              as SessionAuthPayload,
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
class _$WcSessionAuthRequestParamsImpl implements _WcSessionAuthRequestParams {
  const _$WcSessionAuthRequestParamsImpl(
      {required this.authPayload,
      required this.requester,
      required this.expiryTimestamp});

  factory _$WcSessionAuthRequestParamsImpl.fromJson(
          Map<String, dynamic> json) =>
      _$$WcSessionAuthRequestParamsImplFromJson(json);

  @override
  final SessionAuthPayload authPayload;
  @override
  final ConnectionMetadata requester;
  @override
  final int expiryTimestamp;

  @override
  String toString() {
    return 'WcSessionAuthRequestParams(authPayload: $authPayload, requester: $requester, expiryTimestamp: $expiryTimestamp)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$WcSessionAuthRequestParamsImpl &&
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
  _$$WcSessionAuthRequestParamsImplCopyWith<_$WcSessionAuthRequestParamsImpl>
      get copyWith => __$$WcSessionAuthRequestParamsImplCopyWithImpl<
          _$WcSessionAuthRequestParamsImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$WcSessionAuthRequestParamsImplToJson(
      this,
    );
  }
}

abstract class _WcSessionAuthRequestParams
    implements WcSessionAuthRequestParams {
  const factory _WcSessionAuthRequestParams(
      {required final SessionAuthPayload authPayload,
      required final ConnectionMetadata requester,
      required final int expiryTimestamp}) = _$WcSessionAuthRequestParamsImpl;

  factory _WcSessionAuthRequestParams.fromJson(Map<String, dynamic> json) =
      _$WcSessionAuthRequestParamsImpl.fromJson;

  @override
  SessionAuthPayload get authPayload;
  @override
  ConnectionMetadata get requester;
  @override
  int get expiryTimestamp;
  @override
  @JsonKey(ignore: true)
  _$$WcSessionAuthRequestParamsImplCopyWith<_$WcSessionAuthRequestParamsImpl>
      get copyWith => throw _privateConstructorUsedError;
}

WcSessionAuthRequestResult _$WcSessionAuthRequestResultFromJson(
    Map<String, dynamic> json) {
  return _WcSessionAuthRequestResult.fromJson(json);
}

/// @nodoc
mixin _$WcSessionAuthRequestResult {
  List<Cacao> get cacaos => throw _privateConstructorUsedError;
  ConnectionMetadata get responder => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $WcSessionAuthRequestResultCopyWith<WcSessionAuthRequestResult>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $WcSessionAuthRequestResultCopyWith<$Res> {
  factory $WcSessionAuthRequestResultCopyWith(WcSessionAuthRequestResult value,
          $Res Function(WcSessionAuthRequestResult) then) =
      _$WcSessionAuthRequestResultCopyWithImpl<$Res,
          WcSessionAuthRequestResult>;
  @useResult
  $Res call({List<Cacao> cacaos, ConnectionMetadata responder});

  $ConnectionMetadataCopyWith<$Res> get responder;
}

/// @nodoc
class _$WcSessionAuthRequestResultCopyWithImpl<$Res,
        $Val extends WcSessionAuthRequestResult>
    implements $WcSessionAuthRequestResultCopyWith<$Res> {
  _$WcSessionAuthRequestResultCopyWithImpl(this._value, this._then);

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
abstract class _$$WcSessionAuthRequestResultImplCopyWith<$Res>
    implements $WcSessionAuthRequestResultCopyWith<$Res> {
  factory _$$WcSessionAuthRequestResultImplCopyWith(
          _$WcSessionAuthRequestResultImpl value,
          $Res Function(_$WcSessionAuthRequestResultImpl) then) =
      __$$WcSessionAuthRequestResultImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({List<Cacao> cacaos, ConnectionMetadata responder});

  @override
  $ConnectionMetadataCopyWith<$Res> get responder;
}

/// @nodoc
class __$$WcSessionAuthRequestResultImplCopyWithImpl<$Res>
    extends _$WcSessionAuthRequestResultCopyWithImpl<$Res,
        _$WcSessionAuthRequestResultImpl>
    implements _$$WcSessionAuthRequestResultImplCopyWith<$Res> {
  __$$WcSessionAuthRequestResultImplCopyWithImpl(
      _$WcSessionAuthRequestResultImpl _value,
      $Res Function(_$WcSessionAuthRequestResultImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? cacaos = null,
    Object? responder = null,
  }) {
    return _then(_$WcSessionAuthRequestResultImpl(
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
class _$WcSessionAuthRequestResultImpl implements _WcSessionAuthRequestResult {
  const _$WcSessionAuthRequestResultImpl(
      {required final List<Cacao> cacaos, required this.responder})
      : _cacaos = cacaos;

  factory _$WcSessionAuthRequestResultImpl.fromJson(
          Map<String, dynamic> json) =>
      _$$WcSessionAuthRequestResultImplFromJson(json);

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
    return 'WcSessionAuthRequestResult(cacaos: $cacaos, responder: $responder)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$WcSessionAuthRequestResultImpl &&
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
  _$$WcSessionAuthRequestResultImplCopyWith<_$WcSessionAuthRequestResultImpl>
      get copyWith => __$$WcSessionAuthRequestResultImplCopyWithImpl<
          _$WcSessionAuthRequestResultImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$WcSessionAuthRequestResultImplToJson(
      this,
    );
  }
}

abstract class _WcSessionAuthRequestResult
    implements WcSessionAuthRequestResult {
  const factory _WcSessionAuthRequestResult(
          {required final List<Cacao> cacaos,
          required final ConnectionMetadata responder}) =
      _$WcSessionAuthRequestResultImpl;

  factory _WcSessionAuthRequestResult.fromJson(Map<String, dynamic> json) =
      _$WcSessionAuthRequestResultImpl.fromJson;

  @override
  List<Cacao> get cacaos;
  @override
  ConnectionMetadata get responder;
  @override
  @JsonKey(ignore: true)
  _$$WcSessionAuthRequestResultImplCopyWith<_$WcSessionAuthRequestResultImpl>
      get copyWith => throw _privateConstructorUsedError;
}

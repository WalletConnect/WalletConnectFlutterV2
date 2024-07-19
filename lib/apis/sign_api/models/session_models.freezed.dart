// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'session_models.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

Namespace _$NamespaceFromJson(Map<String, dynamic> json) {
  return _Namespace.fromJson(json);
}

/// @nodoc
mixin _$Namespace {
  List<String>? get chains => throw _privateConstructorUsedError;
  List<String> get accounts => throw _privateConstructorUsedError;
  List<String> get methods => throw _privateConstructorUsedError;
  List<String> get events => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $NamespaceCopyWith<Namespace> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $NamespaceCopyWith<$Res> {
  factory $NamespaceCopyWith(Namespace value, $Res Function(Namespace) then) =
      _$NamespaceCopyWithImpl<$Res, Namespace>;
  @useResult
  $Res call(
      {List<String>? chains,
      List<String> accounts,
      List<String> methods,
      List<String> events});
}

/// @nodoc
class _$NamespaceCopyWithImpl<$Res, $Val extends Namespace>
    implements $NamespaceCopyWith<$Res> {
  _$NamespaceCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? chains = freezed,
    Object? accounts = null,
    Object? methods = null,
    Object? events = null,
  }) {
    return _then(_value.copyWith(
      chains: freezed == chains
          ? _value.chains
          : chains // ignore: cast_nullable_to_non_nullable
              as List<String>?,
      accounts: null == accounts
          ? _value.accounts
          : accounts // ignore: cast_nullable_to_non_nullable
              as List<String>,
      methods: null == methods
          ? _value.methods
          : methods // ignore: cast_nullable_to_non_nullable
              as List<String>,
      events: null == events
          ? _value.events
          : events // ignore: cast_nullable_to_non_nullable
              as List<String>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$NamespaceImplCopyWith<$Res>
    implements $NamespaceCopyWith<$Res> {
  factory _$$NamespaceImplCopyWith(
          _$NamespaceImpl value, $Res Function(_$NamespaceImpl) then) =
      __$$NamespaceImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {List<String>? chains,
      List<String> accounts,
      List<String> methods,
      List<String> events});
}

/// @nodoc
class __$$NamespaceImplCopyWithImpl<$Res>
    extends _$NamespaceCopyWithImpl<$Res, _$NamespaceImpl>
    implements _$$NamespaceImplCopyWith<$Res> {
  __$$NamespaceImplCopyWithImpl(
      _$NamespaceImpl _value, $Res Function(_$NamespaceImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? chains = freezed,
    Object? accounts = null,
    Object? methods = null,
    Object? events = null,
  }) {
    return _then(_$NamespaceImpl(
      chains: freezed == chains
          ? _value._chains
          : chains // ignore: cast_nullable_to_non_nullable
              as List<String>?,
      accounts: null == accounts
          ? _value._accounts
          : accounts // ignore: cast_nullable_to_non_nullable
              as List<String>,
      methods: null == methods
          ? _value._methods
          : methods // ignore: cast_nullable_to_non_nullable
              as List<String>,
      events: null == events
          ? _value._events
          : events // ignore: cast_nullable_to_non_nullable
              as List<String>,
    ));
  }
}

/// @nodoc

@JsonSerializable(includeIfNull: false)
class _$NamespaceImpl implements _Namespace {
  const _$NamespaceImpl(
      {final List<String>? chains,
      required final List<String> accounts,
      required final List<String> methods,
      required final List<String> events})
      : _chains = chains,
        _accounts = accounts,
        _methods = methods,
        _events = events;

  factory _$NamespaceImpl.fromJson(Map<String, dynamic> json) =>
      _$$NamespaceImplFromJson(json);

  final List<String>? _chains;
  @override
  List<String>? get chains {
    final value = _chains;
    if (value == null) return null;
    if (_chains is EqualUnmodifiableListView) return _chains;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  final List<String> _accounts;
  @override
  List<String> get accounts {
    if (_accounts is EqualUnmodifiableListView) return _accounts;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_accounts);
  }

  final List<String> _methods;
  @override
  List<String> get methods {
    if (_methods is EqualUnmodifiableListView) return _methods;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_methods);
  }

  final List<String> _events;
  @override
  List<String> get events {
    if (_events is EqualUnmodifiableListView) return _events;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_events);
  }

  @override
  String toString() {
    return 'Namespace(chains: $chains, accounts: $accounts, methods: $methods, events: $events)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$NamespaceImpl &&
            const DeepCollectionEquality().equals(other._chains, _chains) &&
            const DeepCollectionEquality().equals(other._accounts, _accounts) &&
            const DeepCollectionEquality().equals(other._methods, _methods) &&
            const DeepCollectionEquality().equals(other._events, _events));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(_chains),
      const DeepCollectionEquality().hash(_accounts),
      const DeepCollectionEquality().hash(_methods),
      const DeepCollectionEquality().hash(_events));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$NamespaceImplCopyWith<_$NamespaceImpl> get copyWith =>
      __$$NamespaceImplCopyWithImpl<_$NamespaceImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$NamespaceImplToJson(
      this,
    );
  }
}

abstract class _Namespace implements Namespace {
  const factory _Namespace(
      {final List<String>? chains,
      required final List<String> accounts,
      required final List<String> methods,
      required final List<String> events}) = _$NamespaceImpl;

  factory _Namespace.fromJson(Map<String, dynamic> json) =
      _$NamespaceImpl.fromJson;

  @override
  List<String>? get chains;
  @override
  List<String> get accounts;
  @override
  List<String> get methods;
  @override
  List<String> get events;
  @override
  @JsonKey(ignore: true)
  _$$NamespaceImplCopyWith<_$NamespaceImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

SessionData _$SessionDataFromJson(Map<String, dynamic> json) {
  return _SessionData.fromJson(json);
}

/// @nodoc
mixin _$SessionData {
  String get topic => throw _privateConstructorUsedError;
  String get pairingTopic => throw _privateConstructorUsedError;
  Relay get relay => throw _privateConstructorUsedError;
  int get expiry => throw _privateConstructorUsedError;
  bool get acknowledged => throw _privateConstructorUsedError;
  String get controller => throw _privateConstructorUsedError;
  Map<String, Namespace> get namespaces => throw _privateConstructorUsedError;
  Map<String, RequiredNamespace>? get requiredNamespaces =>
      throw _privateConstructorUsedError;
  Map<String, RequiredNamespace>? get optionalNamespaces =>
      throw _privateConstructorUsedError;
  Map<String, String>? get sessionProperties =>
      throw _privateConstructorUsedError;
  ConnectionMetadata get self => throw _privateConstructorUsedError;
  ConnectionMetadata get peer => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $SessionDataCopyWith<SessionData> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SessionDataCopyWith<$Res> {
  factory $SessionDataCopyWith(
          SessionData value, $Res Function(SessionData) then) =
      _$SessionDataCopyWithImpl<$Res, SessionData>;
  @useResult
  $Res call(
      {String topic,
      String pairingTopic,
      Relay relay,
      int expiry,
      bool acknowledged,
      String controller,
      Map<String, Namespace> namespaces,
      Map<String, RequiredNamespace>? requiredNamespaces,
      Map<String, RequiredNamespace>? optionalNamespaces,
      Map<String, String>? sessionProperties,
      ConnectionMetadata self,
      ConnectionMetadata peer});

  $ConnectionMetadataCopyWith<$Res> get self;
  $ConnectionMetadataCopyWith<$Res> get peer;
}

/// @nodoc
class _$SessionDataCopyWithImpl<$Res, $Val extends SessionData>
    implements $SessionDataCopyWith<$Res> {
  _$SessionDataCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? topic = null,
    Object? pairingTopic = null,
    Object? relay = null,
    Object? expiry = null,
    Object? acknowledged = null,
    Object? controller = null,
    Object? namespaces = null,
    Object? requiredNamespaces = freezed,
    Object? optionalNamespaces = freezed,
    Object? sessionProperties = freezed,
    Object? self = null,
    Object? peer = null,
  }) {
    return _then(_value.copyWith(
      topic: null == topic
          ? _value.topic
          : topic // ignore: cast_nullable_to_non_nullable
              as String,
      pairingTopic: null == pairingTopic
          ? _value.pairingTopic
          : pairingTopic // ignore: cast_nullable_to_non_nullable
              as String,
      relay: null == relay
          ? _value.relay
          : relay // ignore: cast_nullable_to_non_nullable
              as Relay,
      expiry: null == expiry
          ? _value.expiry
          : expiry // ignore: cast_nullable_to_non_nullable
              as int,
      acknowledged: null == acknowledged
          ? _value.acknowledged
          : acknowledged // ignore: cast_nullable_to_non_nullable
              as bool,
      controller: null == controller
          ? _value.controller
          : controller // ignore: cast_nullable_to_non_nullable
              as String,
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
      self: null == self
          ? _value.self
          : self // ignore: cast_nullable_to_non_nullable
              as ConnectionMetadata,
      peer: null == peer
          ? _value.peer
          : peer // ignore: cast_nullable_to_non_nullable
              as ConnectionMetadata,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $ConnectionMetadataCopyWith<$Res> get self {
    return $ConnectionMetadataCopyWith<$Res>(_value.self, (value) {
      return _then(_value.copyWith(self: value) as $Val);
    });
  }

  @override
  @pragma('vm:prefer-inline')
  $ConnectionMetadataCopyWith<$Res> get peer {
    return $ConnectionMetadataCopyWith<$Res>(_value.peer, (value) {
      return _then(_value.copyWith(peer: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$SessionDataImplCopyWith<$Res>
    implements $SessionDataCopyWith<$Res> {
  factory _$$SessionDataImplCopyWith(
          _$SessionDataImpl value, $Res Function(_$SessionDataImpl) then) =
      __$$SessionDataImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String topic,
      String pairingTopic,
      Relay relay,
      int expiry,
      bool acknowledged,
      String controller,
      Map<String, Namespace> namespaces,
      Map<String, RequiredNamespace>? requiredNamespaces,
      Map<String, RequiredNamespace>? optionalNamespaces,
      Map<String, String>? sessionProperties,
      ConnectionMetadata self,
      ConnectionMetadata peer});

  @override
  $ConnectionMetadataCopyWith<$Res> get self;
  @override
  $ConnectionMetadataCopyWith<$Res> get peer;
}

/// @nodoc
class __$$SessionDataImplCopyWithImpl<$Res>
    extends _$SessionDataCopyWithImpl<$Res, _$SessionDataImpl>
    implements _$$SessionDataImplCopyWith<$Res> {
  __$$SessionDataImplCopyWithImpl(
      _$SessionDataImpl _value, $Res Function(_$SessionDataImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? topic = null,
    Object? pairingTopic = null,
    Object? relay = null,
    Object? expiry = null,
    Object? acknowledged = null,
    Object? controller = null,
    Object? namespaces = null,
    Object? requiredNamespaces = freezed,
    Object? optionalNamespaces = freezed,
    Object? sessionProperties = freezed,
    Object? self = null,
    Object? peer = null,
  }) {
    return _then(_$SessionDataImpl(
      topic: null == topic
          ? _value.topic
          : topic // ignore: cast_nullable_to_non_nullable
              as String,
      pairingTopic: null == pairingTopic
          ? _value.pairingTopic
          : pairingTopic // ignore: cast_nullable_to_non_nullable
              as String,
      relay: null == relay
          ? _value.relay
          : relay // ignore: cast_nullable_to_non_nullable
              as Relay,
      expiry: null == expiry
          ? _value.expiry
          : expiry // ignore: cast_nullable_to_non_nullable
              as int,
      acknowledged: null == acknowledged
          ? _value.acknowledged
          : acknowledged // ignore: cast_nullable_to_non_nullable
              as bool,
      controller: null == controller
          ? _value.controller
          : controller // ignore: cast_nullable_to_non_nullable
              as String,
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
      self: null == self
          ? _value.self
          : self // ignore: cast_nullable_to_non_nullable
              as ConnectionMetadata,
      peer: null == peer
          ? _value.peer
          : peer // ignore: cast_nullable_to_non_nullable
              as ConnectionMetadata,
    ));
  }
}

/// @nodoc

@JsonSerializable(includeIfNull: false)
class _$SessionDataImpl implements _SessionData {
  const _$SessionDataImpl(
      {required this.topic,
      required this.pairingTopic,
      required this.relay,
      required this.expiry,
      required this.acknowledged,
      required this.controller,
      required final Map<String, Namespace> namespaces,
      final Map<String, RequiredNamespace>? requiredNamespaces,
      final Map<String, RequiredNamespace>? optionalNamespaces,
      final Map<String, String>? sessionProperties,
      required this.self,
      required this.peer})
      : _namespaces = namespaces,
        _requiredNamespaces = requiredNamespaces,
        _optionalNamespaces = optionalNamespaces,
        _sessionProperties = sessionProperties;

  factory _$SessionDataImpl.fromJson(Map<String, dynamic> json) =>
      _$$SessionDataImplFromJson(json);

  @override
  final String topic;
  @override
  final String pairingTopic;
  @override
  final Relay relay;
  @override
  final int expiry;
  @override
  final bool acknowledged;
  @override
  final String controller;
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
  final ConnectionMetadata self;
  @override
  final ConnectionMetadata peer;

  @override
  String toString() {
    return 'SessionData(topic: $topic, pairingTopic: $pairingTopic, relay: $relay, expiry: $expiry, acknowledged: $acknowledged, controller: $controller, namespaces: $namespaces, requiredNamespaces: $requiredNamespaces, optionalNamespaces: $optionalNamespaces, sessionProperties: $sessionProperties, self: $self, peer: $peer)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SessionDataImpl &&
            (identical(other.topic, topic) || other.topic == topic) &&
            (identical(other.pairingTopic, pairingTopic) ||
                other.pairingTopic == pairingTopic) &&
            (identical(other.relay, relay) || other.relay == relay) &&
            (identical(other.expiry, expiry) || other.expiry == expiry) &&
            (identical(other.acknowledged, acknowledged) ||
                other.acknowledged == acknowledged) &&
            (identical(other.controller, controller) ||
                other.controller == controller) &&
            const DeepCollectionEquality()
                .equals(other._namespaces, _namespaces) &&
            const DeepCollectionEquality()
                .equals(other._requiredNamespaces, _requiredNamespaces) &&
            const DeepCollectionEquality()
                .equals(other._optionalNamespaces, _optionalNamespaces) &&
            const DeepCollectionEquality()
                .equals(other._sessionProperties, _sessionProperties) &&
            (identical(other.self, self) || other.self == self) &&
            (identical(other.peer, peer) || other.peer == peer));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      topic,
      pairingTopic,
      relay,
      expiry,
      acknowledged,
      controller,
      const DeepCollectionEquality().hash(_namespaces),
      const DeepCollectionEquality().hash(_requiredNamespaces),
      const DeepCollectionEquality().hash(_optionalNamespaces),
      const DeepCollectionEquality().hash(_sessionProperties),
      self,
      peer);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$SessionDataImplCopyWith<_$SessionDataImpl> get copyWith =>
      __$$SessionDataImplCopyWithImpl<_$SessionDataImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$SessionDataImplToJson(
      this,
    );
  }
}

abstract class _SessionData implements SessionData {
  const factory _SessionData(
      {required final String topic,
      required final String pairingTopic,
      required final Relay relay,
      required final int expiry,
      required final bool acknowledged,
      required final String controller,
      required final Map<String, Namespace> namespaces,
      final Map<String, RequiredNamespace>? requiredNamespaces,
      final Map<String, RequiredNamespace>? optionalNamespaces,
      final Map<String, String>? sessionProperties,
      required final ConnectionMetadata self,
      required final ConnectionMetadata peer}) = _$SessionDataImpl;

  factory _SessionData.fromJson(Map<String, dynamic> json) =
      _$SessionDataImpl.fromJson;

  @override
  String get topic;
  @override
  String get pairingTopic;
  @override
  Relay get relay;
  @override
  int get expiry;
  @override
  bool get acknowledged;
  @override
  String get controller;
  @override
  Map<String, Namespace> get namespaces;
  @override
  Map<String, RequiredNamespace>? get requiredNamespaces;
  @override
  Map<String, RequiredNamespace>? get optionalNamespaces;
  @override
  Map<String, String>? get sessionProperties;
  @override
  ConnectionMetadata get self;
  @override
  ConnectionMetadata get peer;
  @override
  @JsonKey(ignore: true)
  _$$SessionDataImplCopyWith<_$SessionDataImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

SessionRequest _$SessionRequestFromJson(Map<String, dynamic> json) {
  return _SessionRequest.fromJson(json);
}

/// @nodoc
mixin _$SessionRequest {
  int get id => throw _privateConstructorUsedError;
  String get topic => throw _privateConstructorUsedError;
  String get method => throw _privateConstructorUsedError;
  String get chainId => throw _privateConstructorUsedError;
  dynamic get params => throw _privateConstructorUsedError;
  VerifyContext get verifyContext => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $SessionRequestCopyWith<SessionRequest> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SessionRequestCopyWith<$Res> {
  factory $SessionRequestCopyWith(
          SessionRequest value, $Res Function(SessionRequest) then) =
      _$SessionRequestCopyWithImpl<$Res, SessionRequest>;
  @useResult
  $Res call(
      {int id,
      String topic,
      String method,
      String chainId,
      dynamic params,
      VerifyContext verifyContext});

  $VerifyContextCopyWith<$Res> get verifyContext;
}

/// @nodoc
class _$SessionRequestCopyWithImpl<$Res, $Val extends SessionRequest>
    implements $SessionRequestCopyWith<$Res> {
  _$SessionRequestCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? topic = null,
    Object? method = null,
    Object? chainId = null,
    Object? params = freezed,
    Object? verifyContext = null,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      topic: null == topic
          ? _value.topic
          : topic // ignore: cast_nullable_to_non_nullable
              as String,
      method: null == method
          ? _value.method
          : method // ignore: cast_nullable_to_non_nullable
              as String,
      chainId: null == chainId
          ? _value.chainId
          : chainId // ignore: cast_nullable_to_non_nullable
              as String,
      params: freezed == params
          ? _value.params
          : params // ignore: cast_nullable_to_non_nullable
              as dynamic,
      verifyContext: null == verifyContext
          ? _value.verifyContext
          : verifyContext // ignore: cast_nullable_to_non_nullable
              as VerifyContext,
    ) as $Val);
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
abstract class _$$SessionRequestImplCopyWith<$Res>
    implements $SessionRequestCopyWith<$Res> {
  factory _$$SessionRequestImplCopyWith(_$SessionRequestImpl value,
          $Res Function(_$SessionRequestImpl) then) =
      __$$SessionRequestImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {int id,
      String topic,
      String method,
      String chainId,
      dynamic params,
      VerifyContext verifyContext});

  @override
  $VerifyContextCopyWith<$Res> get verifyContext;
}

/// @nodoc
class __$$SessionRequestImplCopyWithImpl<$Res>
    extends _$SessionRequestCopyWithImpl<$Res, _$SessionRequestImpl>
    implements _$$SessionRequestImplCopyWith<$Res> {
  __$$SessionRequestImplCopyWithImpl(
      _$SessionRequestImpl _value, $Res Function(_$SessionRequestImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? topic = null,
    Object? method = null,
    Object? chainId = null,
    Object? params = freezed,
    Object? verifyContext = null,
  }) {
    return _then(_$SessionRequestImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      topic: null == topic
          ? _value.topic
          : topic // ignore: cast_nullable_to_non_nullable
              as String,
      method: null == method
          ? _value.method
          : method // ignore: cast_nullable_to_non_nullable
              as String,
      chainId: null == chainId
          ? _value.chainId
          : chainId // ignore: cast_nullable_to_non_nullable
              as String,
      params: freezed == params
          ? _value.params
          : params // ignore: cast_nullable_to_non_nullable
              as dynamic,
      verifyContext: null == verifyContext
          ? _value.verifyContext
          : verifyContext // ignore: cast_nullable_to_non_nullable
              as VerifyContext,
    ));
  }
}

/// @nodoc

@JsonSerializable()
class _$SessionRequestImpl implements _SessionRequest {
  const _$SessionRequestImpl(
      {required this.id,
      required this.topic,
      required this.method,
      required this.chainId,
      required this.params,
      required this.verifyContext});

  factory _$SessionRequestImpl.fromJson(Map<String, dynamic> json) =>
      _$$SessionRequestImplFromJson(json);

  @override
  final int id;
  @override
  final String topic;
  @override
  final String method;
  @override
  final String chainId;
  @override
  final dynamic params;
  @override
  final VerifyContext verifyContext;

  @override
  String toString() {
    return 'SessionRequest(id: $id, topic: $topic, method: $method, chainId: $chainId, params: $params, verifyContext: $verifyContext)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SessionRequestImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.topic, topic) || other.topic == topic) &&
            (identical(other.method, method) || other.method == method) &&
            (identical(other.chainId, chainId) || other.chainId == chainId) &&
            const DeepCollectionEquality().equals(other.params, params) &&
            (identical(other.verifyContext, verifyContext) ||
                other.verifyContext == verifyContext));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, id, topic, method, chainId,
      const DeepCollectionEquality().hash(params), verifyContext);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$SessionRequestImplCopyWith<_$SessionRequestImpl> get copyWith =>
      __$$SessionRequestImplCopyWithImpl<_$SessionRequestImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$SessionRequestImplToJson(
      this,
    );
  }
}

abstract class _SessionRequest implements SessionRequest {
  const factory _SessionRequest(
      {required final int id,
      required final String topic,
      required final String method,
      required final String chainId,
      required final dynamic params,
      required final VerifyContext verifyContext}) = _$SessionRequestImpl;

  factory _SessionRequest.fromJson(Map<String, dynamic> json) =
      _$SessionRequestImpl.fromJson;

  @override
  int get id;
  @override
  String get topic;
  @override
  String get method;
  @override
  String get chainId;
  @override
  dynamic get params;
  @override
  VerifyContext get verifyContext;
  @override
  @JsonKey(ignore: true)
  _$$SessionRequestImplCopyWith<_$SessionRequestImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

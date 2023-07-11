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
  $Res call({List<String> accounts, List<String> methods, List<String> events});
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
    Object? accounts = null,
    Object? methods = null,
    Object? events = null,
  }) {
    return _then(_value.copyWith(
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
abstract class _$$_NamespaceCopyWith<$Res> implements $NamespaceCopyWith<$Res> {
  factory _$$_NamespaceCopyWith(
          _$_Namespace value, $Res Function(_$_Namespace) then) =
      __$$_NamespaceCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({List<String> accounts, List<String> methods, List<String> events});
}

/// @nodoc
class __$$_NamespaceCopyWithImpl<$Res>
    extends _$NamespaceCopyWithImpl<$Res, _$_Namespace>
    implements _$$_NamespaceCopyWith<$Res> {
  __$$_NamespaceCopyWithImpl(
      _$_Namespace _value, $Res Function(_$_Namespace) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? accounts = null,
    Object? methods = null,
    Object? events = null,
  }) {
    return _then(_$_Namespace(
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

@JsonSerializable()
class _$_Namespace implements _Namespace {
  const _$_Namespace(
      {required final List<String> accounts,
      required final List<String> methods,
      required final List<String> events})
      : _accounts = accounts,
        _methods = methods,
        _events = events;

  factory _$_Namespace.fromJson(Map<String, dynamic> json) =>
      _$$_NamespaceFromJson(json);

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
    return 'Namespace(accounts: $accounts, methods: $methods, events: $events)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_Namespace &&
            const DeepCollectionEquality().equals(other._accounts, _accounts) &&
            const DeepCollectionEquality().equals(other._methods, _methods) &&
            const DeepCollectionEquality().equals(other._events, _events));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(_accounts),
      const DeepCollectionEquality().hash(_methods),
      const DeepCollectionEquality().hash(_events));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_NamespaceCopyWith<_$_Namespace> get copyWith =>
      __$$_NamespaceCopyWithImpl<_$_Namespace>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_NamespaceToJson(
      this,
    );
  }
}

abstract class _Namespace implements Namespace {
  const factory _Namespace(
      {required final List<String> accounts,
      required final List<String> methods,
      required final List<String> events}) = _$_Namespace;

  factory _Namespace.fromJson(Map<String, dynamic> json) =
      _$_Namespace.fromJson;

  @override
  List<String> get accounts;
  @override
  List<String> get methods;
  @override
  List<String> get events;
  @override
  @JsonKey(ignore: true)
  _$$_NamespaceCopyWith<_$_Namespace> get copyWith =>
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
abstract class _$$_SessionDataCopyWith<$Res>
    implements $SessionDataCopyWith<$Res> {
  factory _$$_SessionDataCopyWith(
          _$_SessionData value, $Res Function(_$_SessionData) then) =
      __$$_SessionDataCopyWithImpl<$Res>;
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
class __$$_SessionDataCopyWithImpl<$Res>
    extends _$SessionDataCopyWithImpl<$Res, _$_SessionData>
    implements _$$_SessionDataCopyWith<$Res> {
  __$$_SessionDataCopyWithImpl(
      _$_SessionData _value, $Res Function(_$_SessionData) _then)
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
    return _then(_$_SessionData(
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
class _$_SessionData implements _SessionData {
  const _$_SessionData(
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

  factory _$_SessionData.fromJson(Map<String, dynamic> json) =>
      _$$_SessionDataFromJson(json);

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
            other is _$_SessionData &&
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
  _$$_SessionDataCopyWith<_$_SessionData> get copyWith =>
      __$$_SessionDataCopyWithImpl<_$_SessionData>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_SessionDataToJson(
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
      required final ConnectionMetadata peer}) = _$_SessionData;

  factory _SessionData.fromJson(Map<String, dynamic> json) =
      _$_SessionData.fromJson;

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
  _$$_SessionDataCopyWith<_$_SessionData> get copyWith =>
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
      {int id, String topic, String method, String chainId, dynamic params});
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
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_SessionRequestCopyWith<$Res>
    implements $SessionRequestCopyWith<$Res> {
  factory _$$_SessionRequestCopyWith(
          _$_SessionRequest value, $Res Function(_$_SessionRequest) then) =
      __$$_SessionRequestCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {int id, String topic, String method, String chainId, dynamic params});
}

/// @nodoc
class __$$_SessionRequestCopyWithImpl<$Res>
    extends _$SessionRequestCopyWithImpl<$Res, _$_SessionRequest>
    implements _$$_SessionRequestCopyWith<$Res> {
  __$$_SessionRequestCopyWithImpl(
      _$_SessionRequest _value, $Res Function(_$_SessionRequest) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? topic = null,
    Object? method = null,
    Object? chainId = null,
    Object? params = freezed,
  }) {
    return _then(_$_SessionRequest(
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
    ));
  }
}

/// @nodoc

@JsonSerializable()
class _$_SessionRequest implements _SessionRequest {
  const _$_SessionRequest(
      {required this.id,
      required this.topic,
      required this.method,
      required this.chainId,
      required this.params});

  factory _$_SessionRequest.fromJson(Map<String, dynamic> json) =>
      _$$_SessionRequestFromJson(json);

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
  String toString() {
    return 'SessionRequest(id: $id, topic: $topic, method: $method, chainId: $chainId, params: $params)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_SessionRequest &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.topic, topic) || other.topic == topic) &&
            (identical(other.method, method) || other.method == method) &&
            (identical(other.chainId, chainId) || other.chainId == chainId) &&
            const DeepCollectionEquality().equals(other.params, params));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, id, topic, method, chainId,
      const DeepCollectionEquality().hash(params));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_SessionRequestCopyWith<_$_SessionRequest> get copyWith =>
      __$$_SessionRequestCopyWithImpl<_$_SessionRequest>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_SessionRequestToJson(
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
      required final dynamic params}) = _$_SessionRequest;

  factory _SessionRequest.fromJson(Map<String, dynamic> json) =
      _$_SessionRequest.fromJson;

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
  @JsonKey(ignore: true)
  _$$_SessionRequestCopyWith<_$_SessionRequest> get copyWith =>
      throw _privateConstructorUsedError;
}

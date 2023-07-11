// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'proposal_models.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

RequiredNamespace _$RequiredNamespaceFromJson(Map<String, dynamic> json) {
  return _RequiredNamespace.fromJson(json);
}

/// @nodoc
mixin _$RequiredNamespace {
  List<String>? get chains => throw _privateConstructorUsedError;
  List<String> get methods => throw _privateConstructorUsedError;
  List<String> get events => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $RequiredNamespaceCopyWith<RequiredNamespace> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $RequiredNamespaceCopyWith<$Res> {
  factory $RequiredNamespaceCopyWith(
          RequiredNamespace value, $Res Function(RequiredNamespace) then) =
      _$RequiredNamespaceCopyWithImpl<$Res, RequiredNamespace>;
  @useResult
  $Res call({List<String>? chains, List<String> methods, List<String> events});
}

/// @nodoc
class _$RequiredNamespaceCopyWithImpl<$Res, $Val extends RequiredNamespace>
    implements $RequiredNamespaceCopyWith<$Res> {
  _$RequiredNamespaceCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? chains = freezed,
    Object? methods = null,
    Object? events = null,
  }) {
    return _then(_value.copyWith(
      chains: freezed == chains
          ? _value.chains
          : chains // ignore: cast_nullable_to_non_nullable
              as List<String>?,
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
abstract class _$$_RequiredNamespaceCopyWith<$Res>
    implements $RequiredNamespaceCopyWith<$Res> {
  factory _$$_RequiredNamespaceCopyWith(_$_RequiredNamespace value,
          $Res Function(_$_RequiredNamespace) then) =
      __$$_RequiredNamespaceCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({List<String>? chains, List<String> methods, List<String> events});
}

/// @nodoc
class __$$_RequiredNamespaceCopyWithImpl<$Res>
    extends _$RequiredNamespaceCopyWithImpl<$Res, _$_RequiredNamespace>
    implements _$$_RequiredNamespaceCopyWith<$Res> {
  __$$_RequiredNamespaceCopyWithImpl(
      _$_RequiredNamespace _value, $Res Function(_$_RequiredNamespace) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? chains = freezed,
    Object? methods = null,
    Object? events = null,
  }) {
    return _then(_$_RequiredNamespace(
      chains: freezed == chains
          ? _value._chains
          : chains // ignore: cast_nullable_to_non_nullable
              as List<String>?,
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
class _$_RequiredNamespace implements _RequiredNamespace {
  const _$_RequiredNamespace(
      {final List<String>? chains,
      required final List<String> methods,
      required final List<String> events})
      : _chains = chains,
        _methods = methods,
        _events = events;

  factory _$_RequiredNamespace.fromJson(Map<String, dynamic> json) =>
      _$$_RequiredNamespaceFromJson(json);

  final List<String>? _chains;
  @override
  List<String>? get chains {
    final value = _chains;
    if (value == null) return null;
    if (_chains is EqualUnmodifiableListView) return _chains;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
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
    return 'RequiredNamespace(chains: $chains, methods: $methods, events: $events)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_RequiredNamespace &&
            const DeepCollectionEquality().equals(other._chains, _chains) &&
            const DeepCollectionEquality().equals(other._methods, _methods) &&
            const DeepCollectionEquality().equals(other._events, _events));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(_chains),
      const DeepCollectionEquality().hash(_methods),
      const DeepCollectionEquality().hash(_events));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_RequiredNamespaceCopyWith<_$_RequiredNamespace> get copyWith =>
      __$$_RequiredNamespaceCopyWithImpl<_$_RequiredNamespace>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_RequiredNamespaceToJson(
      this,
    );
  }
}

abstract class _RequiredNamespace implements RequiredNamespace {
  const factory _RequiredNamespace(
      {final List<String>? chains,
      required final List<String> methods,
      required final List<String> events}) = _$_RequiredNamespace;

  factory _RequiredNamespace.fromJson(Map<String, dynamic> json) =
      _$_RequiredNamespace.fromJson;

  @override
  List<String>? get chains;
  @override
  List<String> get methods;
  @override
  List<String> get events;
  @override
  @JsonKey(ignore: true)
  _$$_RequiredNamespaceCopyWith<_$_RequiredNamespace> get copyWith =>
      throw _privateConstructorUsedError;
}

SessionProposal _$SessionProposalFromJson(Map<String, dynamic> json) {
  return _SessionProposal.fromJson(json);
}

/// @nodoc
mixin _$SessionProposal {
  int get id => throw _privateConstructorUsedError;
  ProposalData get params => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $SessionProposalCopyWith<SessionProposal> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SessionProposalCopyWith<$Res> {
  factory $SessionProposalCopyWith(
          SessionProposal value, $Res Function(SessionProposal) then) =
      _$SessionProposalCopyWithImpl<$Res, SessionProposal>;
  @useResult
  $Res call({int id, ProposalData params});

  $ProposalDataCopyWith<$Res> get params;
}

/// @nodoc
class _$SessionProposalCopyWithImpl<$Res, $Val extends SessionProposal>
    implements $SessionProposalCopyWith<$Res> {
  _$SessionProposalCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? params = null,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      params: null == params
          ? _value.params
          : params // ignore: cast_nullable_to_non_nullable
              as ProposalData,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $ProposalDataCopyWith<$Res> get params {
    return $ProposalDataCopyWith<$Res>(_value.params, (value) {
      return _then(_value.copyWith(params: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$_SessionProposalCopyWith<$Res>
    implements $SessionProposalCopyWith<$Res> {
  factory _$$_SessionProposalCopyWith(
          _$_SessionProposal value, $Res Function(_$_SessionProposal) then) =
      __$$_SessionProposalCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({int id, ProposalData params});

  @override
  $ProposalDataCopyWith<$Res> get params;
}

/// @nodoc
class __$$_SessionProposalCopyWithImpl<$Res>
    extends _$SessionProposalCopyWithImpl<$Res, _$_SessionProposal>
    implements _$$_SessionProposalCopyWith<$Res> {
  __$$_SessionProposalCopyWithImpl(
      _$_SessionProposal _value, $Res Function(_$_SessionProposal) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? params = null,
  }) {
    return _then(_$_SessionProposal(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      params: null == params
          ? _value.params
          : params // ignore: cast_nullable_to_non_nullable
              as ProposalData,
    ));
  }
}

/// @nodoc

@JsonSerializable()
class _$_SessionProposal implements _SessionProposal {
  const _$_SessionProposal({required this.id, required this.params});

  factory _$_SessionProposal.fromJson(Map<String, dynamic> json) =>
      _$$_SessionProposalFromJson(json);

  @override
  final int id;
  @override
  final ProposalData params;

  @override
  String toString() {
    return 'SessionProposal(id: $id, params: $params)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_SessionProposal &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.params, params) || other.params == params));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, id, params);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_SessionProposalCopyWith<_$_SessionProposal> get copyWith =>
      __$$_SessionProposalCopyWithImpl<_$_SessionProposal>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_SessionProposalToJson(
      this,
    );
  }
}

abstract class _SessionProposal implements SessionProposal {
  const factory _SessionProposal(
      {required final int id,
      required final ProposalData params}) = _$_SessionProposal;

  factory _SessionProposal.fromJson(Map<String, dynamic> json) =
      _$_SessionProposal.fromJson;

  @override
  int get id;
  @override
  ProposalData get params;
  @override
  @JsonKey(ignore: true)
  _$$_SessionProposalCopyWith<_$_SessionProposal> get copyWith =>
      throw _privateConstructorUsedError;
}

ProposalData _$ProposalDataFromJson(Map<String, dynamic> json) {
  return _ProposalData.fromJson(json);
}

/// @nodoc
mixin _$ProposalData {
  int get id => throw _privateConstructorUsedError;
  int get expiry => throw _privateConstructorUsedError;
  List<Relay> get relays => throw _privateConstructorUsedError;
  ConnectionMetadata get proposer => throw _privateConstructorUsedError;
  Map<String, RequiredNamespace> get requiredNamespaces =>
      throw _privateConstructorUsedError;
  Map<String, RequiredNamespace> get optionalNamespaces =>
      throw _privateConstructorUsedError;
  String get pairingTopic => throw _privateConstructorUsedError;
  Map<String, String>? get sessionProperties =>
      throw _privateConstructorUsedError;
  Map<String, Namespace>? get generatedNamespaces =>
      throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $ProposalDataCopyWith<ProposalData> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ProposalDataCopyWith<$Res> {
  factory $ProposalDataCopyWith(
          ProposalData value, $Res Function(ProposalData) then) =
      _$ProposalDataCopyWithImpl<$Res, ProposalData>;
  @useResult
  $Res call(
      {int id,
      int expiry,
      List<Relay> relays,
      ConnectionMetadata proposer,
      Map<String, RequiredNamespace> requiredNamespaces,
      Map<String, RequiredNamespace> optionalNamespaces,
      String pairingTopic,
      Map<String, String>? sessionProperties,
      Map<String, Namespace>? generatedNamespaces});

  $ConnectionMetadataCopyWith<$Res> get proposer;
}

/// @nodoc
class _$ProposalDataCopyWithImpl<$Res, $Val extends ProposalData>
    implements $ProposalDataCopyWith<$Res> {
  _$ProposalDataCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? expiry = null,
    Object? relays = null,
    Object? proposer = null,
    Object? requiredNamespaces = null,
    Object? optionalNamespaces = null,
    Object? pairingTopic = null,
    Object? sessionProperties = freezed,
    Object? generatedNamespaces = freezed,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      expiry: null == expiry
          ? _value.expiry
          : expiry // ignore: cast_nullable_to_non_nullable
              as int,
      relays: null == relays
          ? _value.relays
          : relays // ignore: cast_nullable_to_non_nullable
              as List<Relay>,
      proposer: null == proposer
          ? _value.proposer
          : proposer // ignore: cast_nullable_to_non_nullable
              as ConnectionMetadata,
      requiredNamespaces: null == requiredNamespaces
          ? _value.requiredNamespaces
          : requiredNamespaces // ignore: cast_nullable_to_non_nullable
              as Map<String, RequiredNamespace>,
      optionalNamespaces: null == optionalNamespaces
          ? _value.optionalNamespaces
          : optionalNamespaces // ignore: cast_nullable_to_non_nullable
              as Map<String, RequiredNamespace>,
      pairingTopic: null == pairingTopic
          ? _value.pairingTopic
          : pairingTopic // ignore: cast_nullable_to_non_nullable
              as String,
      sessionProperties: freezed == sessionProperties
          ? _value.sessionProperties
          : sessionProperties // ignore: cast_nullable_to_non_nullable
              as Map<String, String>?,
      generatedNamespaces: freezed == generatedNamespaces
          ? _value.generatedNamespaces
          : generatedNamespaces // ignore: cast_nullable_to_non_nullable
              as Map<String, Namespace>?,
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
abstract class _$$_ProposalDataCopyWith<$Res>
    implements $ProposalDataCopyWith<$Res> {
  factory _$$_ProposalDataCopyWith(
          _$_ProposalData value, $Res Function(_$_ProposalData) then) =
      __$$_ProposalDataCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {int id,
      int expiry,
      List<Relay> relays,
      ConnectionMetadata proposer,
      Map<String, RequiredNamespace> requiredNamespaces,
      Map<String, RequiredNamespace> optionalNamespaces,
      String pairingTopic,
      Map<String, String>? sessionProperties,
      Map<String, Namespace>? generatedNamespaces});

  @override
  $ConnectionMetadataCopyWith<$Res> get proposer;
}

/// @nodoc
class __$$_ProposalDataCopyWithImpl<$Res>
    extends _$ProposalDataCopyWithImpl<$Res, _$_ProposalData>
    implements _$$_ProposalDataCopyWith<$Res> {
  __$$_ProposalDataCopyWithImpl(
      _$_ProposalData _value, $Res Function(_$_ProposalData) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? expiry = null,
    Object? relays = null,
    Object? proposer = null,
    Object? requiredNamespaces = null,
    Object? optionalNamespaces = null,
    Object? pairingTopic = null,
    Object? sessionProperties = freezed,
    Object? generatedNamespaces = freezed,
  }) {
    return _then(_$_ProposalData(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      expiry: null == expiry
          ? _value.expiry
          : expiry // ignore: cast_nullable_to_non_nullable
              as int,
      relays: null == relays
          ? _value._relays
          : relays // ignore: cast_nullable_to_non_nullable
              as List<Relay>,
      proposer: null == proposer
          ? _value.proposer
          : proposer // ignore: cast_nullable_to_non_nullable
              as ConnectionMetadata,
      requiredNamespaces: null == requiredNamespaces
          ? _value._requiredNamespaces
          : requiredNamespaces // ignore: cast_nullable_to_non_nullable
              as Map<String, RequiredNamespace>,
      optionalNamespaces: null == optionalNamespaces
          ? _value._optionalNamespaces
          : optionalNamespaces // ignore: cast_nullable_to_non_nullable
              as Map<String, RequiredNamespace>,
      pairingTopic: null == pairingTopic
          ? _value.pairingTopic
          : pairingTopic // ignore: cast_nullable_to_non_nullable
              as String,
      sessionProperties: freezed == sessionProperties
          ? _value._sessionProperties
          : sessionProperties // ignore: cast_nullable_to_non_nullable
              as Map<String, String>?,
      generatedNamespaces: freezed == generatedNamespaces
          ? _value._generatedNamespaces
          : generatedNamespaces // ignore: cast_nullable_to_non_nullable
              as Map<String, Namespace>?,
    ));
  }
}

/// @nodoc

@JsonSerializable(includeIfNull: false)
class _$_ProposalData implements _ProposalData {
  const _$_ProposalData(
      {required this.id,
      required this.expiry,
      required final List<Relay> relays,
      required this.proposer,
      required final Map<String, RequiredNamespace> requiredNamespaces,
      required final Map<String, RequiredNamespace> optionalNamespaces,
      required this.pairingTopic,
      final Map<String, String>? sessionProperties,
      final Map<String, Namespace>? generatedNamespaces})
      : _relays = relays,
        _requiredNamespaces = requiredNamespaces,
        _optionalNamespaces = optionalNamespaces,
        _sessionProperties = sessionProperties,
        _generatedNamespaces = generatedNamespaces;

  factory _$_ProposalData.fromJson(Map<String, dynamic> json) =>
      _$$_ProposalDataFromJson(json);

  @override
  final int id;
  @override
  final int expiry;
  final List<Relay> _relays;
  @override
  List<Relay> get relays {
    if (_relays is EqualUnmodifiableListView) return _relays;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_relays);
  }

  @override
  final ConnectionMetadata proposer;
  final Map<String, RequiredNamespace> _requiredNamespaces;
  @override
  Map<String, RequiredNamespace> get requiredNamespaces {
    if (_requiredNamespaces is EqualUnmodifiableMapView)
      return _requiredNamespaces;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_requiredNamespaces);
  }

  final Map<String, RequiredNamespace> _optionalNamespaces;
  @override
  Map<String, RequiredNamespace> get optionalNamespaces {
    if (_optionalNamespaces is EqualUnmodifiableMapView)
      return _optionalNamespaces;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_optionalNamespaces);
  }

  @override
  final String pairingTopic;
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

  final Map<String, Namespace>? _generatedNamespaces;
  @override
  Map<String, Namespace>? get generatedNamespaces {
    final value = _generatedNamespaces;
    if (value == null) return null;
    if (_generatedNamespaces is EqualUnmodifiableMapView)
      return _generatedNamespaces;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(value);
  }

  @override
  String toString() {
    return 'ProposalData(id: $id, expiry: $expiry, relays: $relays, proposer: $proposer, requiredNamespaces: $requiredNamespaces, optionalNamespaces: $optionalNamespaces, pairingTopic: $pairingTopic, sessionProperties: $sessionProperties, generatedNamespaces: $generatedNamespaces)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_ProposalData &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.expiry, expiry) || other.expiry == expiry) &&
            const DeepCollectionEquality().equals(other._relays, _relays) &&
            (identical(other.proposer, proposer) ||
                other.proposer == proposer) &&
            const DeepCollectionEquality()
                .equals(other._requiredNamespaces, _requiredNamespaces) &&
            const DeepCollectionEquality()
                .equals(other._optionalNamespaces, _optionalNamespaces) &&
            (identical(other.pairingTopic, pairingTopic) ||
                other.pairingTopic == pairingTopic) &&
            const DeepCollectionEquality()
                .equals(other._sessionProperties, _sessionProperties) &&
            const DeepCollectionEquality()
                .equals(other._generatedNamespaces, _generatedNamespaces));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      expiry,
      const DeepCollectionEquality().hash(_relays),
      proposer,
      const DeepCollectionEquality().hash(_requiredNamespaces),
      const DeepCollectionEquality().hash(_optionalNamespaces),
      pairingTopic,
      const DeepCollectionEquality().hash(_sessionProperties),
      const DeepCollectionEquality().hash(_generatedNamespaces));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_ProposalDataCopyWith<_$_ProposalData> get copyWith =>
      __$$_ProposalDataCopyWithImpl<_$_ProposalData>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_ProposalDataToJson(
      this,
    );
  }
}

abstract class _ProposalData implements ProposalData {
  const factory _ProposalData(
      {required final int id,
      required final int expiry,
      required final List<Relay> relays,
      required final ConnectionMetadata proposer,
      required final Map<String, RequiredNamespace> requiredNamespaces,
      required final Map<String, RequiredNamespace> optionalNamespaces,
      required final String pairingTopic,
      final Map<String, String>? sessionProperties,
      final Map<String, Namespace>? generatedNamespaces}) = _$_ProposalData;

  factory _ProposalData.fromJson(Map<String, dynamic> json) =
      _$_ProposalData.fromJson;

  @override
  int get id;
  @override
  int get expiry;
  @override
  List<Relay> get relays;
  @override
  ConnectionMetadata get proposer;
  @override
  Map<String, RequiredNamespace> get requiredNamespaces;
  @override
  Map<String, RequiredNamespace> get optionalNamespaces;
  @override
  String get pairingTopic;
  @override
  Map<String, String>? get sessionProperties;
  @override
  Map<String, Namespace>? get generatedNamespaces;
  @override
  @JsonKey(ignore: true)
  _$$_ProposalDataCopyWith<_$_ProposalData> get copyWith =>
      throw _privateConstructorUsedError;
}

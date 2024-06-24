// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'pairing_models.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

PairingInfo _$PairingInfoFromJson(Map<String, dynamic> json) {
  return _PairingInfo.fromJson(json);
}

/// @nodoc
mixin _$PairingInfo {
  String get topic => throw _privateConstructorUsedError;
  int get expiry => throw _privateConstructorUsedError;
  Relay get relay => throw _privateConstructorUsedError;
  bool get active => throw _privateConstructorUsedError;
  List<String>? get methods => throw _privateConstructorUsedError;
  PairingMetadata? get peerMetadata => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $PairingInfoCopyWith<PairingInfo> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PairingInfoCopyWith<$Res> {
  factory $PairingInfoCopyWith(
          PairingInfo value, $Res Function(PairingInfo) then) =
      _$PairingInfoCopyWithImpl<$Res, PairingInfo>;
  @useResult
  $Res call(
      {String topic,
      int expiry,
      Relay relay,
      bool active,
      List<String>? methods,
      PairingMetadata? peerMetadata});

  $PairingMetadataCopyWith<$Res>? get peerMetadata;
}

/// @nodoc
class _$PairingInfoCopyWithImpl<$Res, $Val extends PairingInfo>
    implements $PairingInfoCopyWith<$Res> {
  _$PairingInfoCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? topic = null,
    Object? expiry = null,
    Object? relay = null,
    Object? active = null,
    Object? methods = freezed,
    Object? peerMetadata = freezed,
  }) {
    return _then(_value.copyWith(
      topic: null == topic
          ? _value.topic
          : topic // ignore: cast_nullable_to_non_nullable
              as String,
      expiry: null == expiry
          ? _value.expiry
          : expiry // ignore: cast_nullable_to_non_nullable
              as int,
      relay: null == relay
          ? _value.relay
          : relay // ignore: cast_nullable_to_non_nullable
              as Relay,
      active: null == active
          ? _value.active
          : active // ignore: cast_nullable_to_non_nullable
              as bool,
      methods: freezed == methods
          ? _value.methods
          : methods // ignore: cast_nullable_to_non_nullable
              as List<String>?,
      peerMetadata: freezed == peerMetadata
          ? _value.peerMetadata
          : peerMetadata // ignore: cast_nullable_to_non_nullable
              as PairingMetadata?,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $PairingMetadataCopyWith<$Res>? get peerMetadata {
    if (_value.peerMetadata == null) {
      return null;
    }

    return $PairingMetadataCopyWith<$Res>(_value.peerMetadata!, (value) {
      return _then(_value.copyWith(peerMetadata: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$PairingInfoImplCopyWith<$Res>
    implements $PairingInfoCopyWith<$Res> {
  factory _$$PairingInfoImplCopyWith(
          _$PairingInfoImpl value, $Res Function(_$PairingInfoImpl) then) =
      __$$PairingInfoImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String topic,
      int expiry,
      Relay relay,
      bool active,
      List<String>? methods,
      PairingMetadata? peerMetadata});

  @override
  $PairingMetadataCopyWith<$Res>? get peerMetadata;
}

/// @nodoc
class __$$PairingInfoImplCopyWithImpl<$Res>
    extends _$PairingInfoCopyWithImpl<$Res, _$PairingInfoImpl>
    implements _$$PairingInfoImplCopyWith<$Res> {
  __$$PairingInfoImplCopyWithImpl(
      _$PairingInfoImpl _value, $Res Function(_$PairingInfoImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? topic = null,
    Object? expiry = null,
    Object? relay = null,
    Object? active = null,
    Object? methods = freezed,
    Object? peerMetadata = freezed,
  }) {
    return _then(_$PairingInfoImpl(
      topic: null == topic
          ? _value.topic
          : topic // ignore: cast_nullable_to_non_nullable
              as String,
      expiry: null == expiry
          ? _value.expiry
          : expiry // ignore: cast_nullable_to_non_nullable
              as int,
      relay: null == relay
          ? _value.relay
          : relay // ignore: cast_nullable_to_non_nullable
              as Relay,
      active: null == active
          ? _value.active
          : active // ignore: cast_nullable_to_non_nullable
              as bool,
      methods: freezed == methods
          ? _value._methods
          : methods // ignore: cast_nullable_to_non_nullable
              as List<String>?,
      peerMetadata: freezed == peerMetadata
          ? _value.peerMetadata
          : peerMetadata // ignore: cast_nullable_to_non_nullable
              as PairingMetadata?,
    ));
  }
}

/// @nodoc

@JsonSerializable()
class _$PairingInfoImpl implements _PairingInfo {
  const _$PairingInfoImpl(
      {required this.topic,
      required this.expiry,
      required this.relay,
      required this.active,
      final List<String>? methods,
      this.peerMetadata})
      : _methods = methods;

  factory _$PairingInfoImpl.fromJson(Map<String, dynamic> json) =>
      _$$PairingInfoImplFromJson(json);

  @override
  final String topic;
  @override
  final int expiry;
  @override
  final Relay relay;
  @override
  final bool active;
  final List<String>? _methods;
  @override
  List<String>? get methods {
    final value = _methods;
    if (value == null) return null;
    if (_methods is EqualUnmodifiableListView) return _methods;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  @override
  final PairingMetadata? peerMetadata;

  @override
  String toString() {
    return 'PairingInfo(topic: $topic, expiry: $expiry, relay: $relay, active: $active, methods: $methods, peerMetadata: $peerMetadata)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$PairingInfoImpl &&
            (identical(other.topic, topic) || other.topic == topic) &&
            (identical(other.expiry, expiry) || other.expiry == expiry) &&
            (identical(other.relay, relay) || other.relay == relay) &&
            (identical(other.active, active) || other.active == active) &&
            const DeepCollectionEquality().equals(other._methods, _methods) &&
            (identical(other.peerMetadata, peerMetadata) ||
                other.peerMetadata == peerMetadata));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, topic, expiry, relay, active,
      const DeepCollectionEquality().hash(_methods), peerMetadata);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$PairingInfoImplCopyWith<_$PairingInfoImpl> get copyWith =>
      __$$PairingInfoImplCopyWithImpl<_$PairingInfoImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$PairingInfoImplToJson(
      this,
    );
  }
}

abstract class _PairingInfo implements PairingInfo {
  const factory _PairingInfo(
      {required final String topic,
      required final int expiry,
      required final Relay relay,
      required final bool active,
      final List<String>? methods,
      final PairingMetadata? peerMetadata}) = _$PairingInfoImpl;

  factory _PairingInfo.fromJson(Map<String, dynamic> json) =
      _$PairingInfoImpl.fromJson;

  @override
  String get topic;
  @override
  int get expiry;
  @override
  Relay get relay;
  @override
  bool get active;
  @override
  List<String>? get methods;
  @override
  PairingMetadata? get peerMetadata;
  @override
  @JsonKey(ignore: true)
  _$$PairingInfoImplCopyWith<_$PairingInfoImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

PairingMetadata _$PairingMetadataFromJson(Map<String, dynamic> json) {
  return _PairingMetadata.fromJson(json);
}

/// @nodoc
mixin _$PairingMetadata {
  String get name => throw _privateConstructorUsedError;
  String get description => throw _privateConstructorUsedError;
  String get url => throw _privateConstructorUsedError;
  List<String> get icons => throw _privateConstructorUsedError;
  String? get verifyUrl => throw _privateConstructorUsedError;
  Redirect? get redirect => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $PairingMetadataCopyWith<PairingMetadata> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PairingMetadataCopyWith<$Res> {
  factory $PairingMetadataCopyWith(
          PairingMetadata value, $Res Function(PairingMetadata) then) =
      _$PairingMetadataCopyWithImpl<$Res, PairingMetadata>;
  @useResult
  $Res call(
      {String name,
      String description,
      String url,
      List<String> icons,
      String? verifyUrl,
      Redirect? redirect});

  $RedirectCopyWith<$Res>? get redirect;
}

/// @nodoc
class _$PairingMetadataCopyWithImpl<$Res, $Val extends PairingMetadata>
    implements $PairingMetadataCopyWith<$Res> {
  _$PairingMetadataCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = null,
    Object? description = null,
    Object? url = null,
    Object? icons = null,
    Object? verifyUrl = freezed,
    Object? redirect = freezed,
  }) {
    return _then(_value.copyWith(
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      description: null == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String,
      url: null == url
          ? _value.url
          : url // ignore: cast_nullable_to_non_nullable
              as String,
      icons: null == icons
          ? _value.icons
          : icons // ignore: cast_nullable_to_non_nullable
              as List<String>,
      verifyUrl: freezed == verifyUrl
          ? _value.verifyUrl
          : verifyUrl // ignore: cast_nullable_to_non_nullable
              as String?,
      redirect: freezed == redirect
          ? _value.redirect
          : redirect // ignore: cast_nullable_to_non_nullable
              as Redirect?,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $RedirectCopyWith<$Res>? get redirect {
    if (_value.redirect == null) {
      return null;
    }

    return $RedirectCopyWith<$Res>(_value.redirect!, (value) {
      return _then(_value.copyWith(redirect: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$PairingMetadataImplCopyWith<$Res>
    implements $PairingMetadataCopyWith<$Res> {
  factory _$$PairingMetadataImplCopyWith(_$PairingMetadataImpl value,
          $Res Function(_$PairingMetadataImpl) then) =
      __$$PairingMetadataImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String name,
      String description,
      String url,
      List<String> icons,
      String? verifyUrl,
      Redirect? redirect});

  @override
  $RedirectCopyWith<$Res>? get redirect;
}

/// @nodoc
class __$$PairingMetadataImplCopyWithImpl<$Res>
    extends _$PairingMetadataCopyWithImpl<$Res, _$PairingMetadataImpl>
    implements _$$PairingMetadataImplCopyWith<$Res> {
  __$$PairingMetadataImplCopyWithImpl(
      _$PairingMetadataImpl _value, $Res Function(_$PairingMetadataImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = null,
    Object? description = null,
    Object? url = null,
    Object? icons = null,
    Object? verifyUrl = freezed,
    Object? redirect = freezed,
  }) {
    return _then(_$PairingMetadataImpl(
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      description: null == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String,
      url: null == url
          ? _value.url
          : url // ignore: cast_nullable_to_non_nullable
              as String,
      icons: null == icons
          ? _value._icons
          : icons // ignore: cast_nullable_to_non_nullable
              as List<String>,
      verifyUrl: freezed == verifyUrl
          ? _value.verifyUrl
          : verifyUrl // ignore: cast_nullable_to_non_nullable
              as String?,
      redirect: freezed == redirect
          ? _value.redirect
          : redirect // ignore: cast_nullable_to_non_nullable
              as Redirect?,
    ));
  }
}

/// @nodoc

@JsonSerializable(includeIfNull: false)
class _$PairingMetadataImpl implements _PairingMetadata {
  const _$PairingMetadataImpl(
      {required this.name,
      required this.description,
      required this.url,
      required final List<String> icons,
      this.verifyUrl,
      this.redirect})
      : _icons = icons;

  factory _$PairingMetadataImpl.fromJson(Map<String, dynamic> json) =>
      _$$PairingMetadataImplFromJson(json);

  @override
  final String name;
  @override
  final String description;
  @override
  final String url;
  final List<String> _icons;
  @override
  List<String> get icons {
    if (_icons is EqualUnmodifiableListView) return _icons;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_icons);
  }

  @override
  final String? verifyUrl;
  @override
  final Redirect? redirect;

  @override
  String toString() {
    return 'PairingMetadata(name: $name, description: $description, url: $url, icons: $icons, verifyUrl: $verifyUrl, redirect: $redirect)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$PairingMetadataImpl &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.description, description) ||
                other.description == description) &&
            (identical(other.url, url) || other.url == url) &&
            const DeepCollectionEquality().equals(other._icons, _icons) &&
            (identical(other.verifyUrl, verifyUrl) ||
                other.verifyUrl == verifyUrl) &&
            (identical(other.redirect, redirect) ||
                other.redirect == redirect));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, name, description, url,
      const DeepCollectionEquality().hash(_icons), verifyUrl, redirect);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$PairingMetadataImplCopyWith<_$PairingMetadataImpl> get copyWith =>
      __$$PairingMetadataImplCopyWithImpl<_$PairingMetadataImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$PairingMetadataImplToJson(
      this,
    );
  }
}

abstract class _PairingMetadata implements PairingMetadata {
  const factory _PairingMetadata(
      {required final String name,
      required final String description,
      required final String url,
      required final List<String> icons,
      final String? verifyUrl,
      final Redirect? redirect}) = _$PairingMetadataImpl;

  factory _PairingMetadata.fromJson(Map<String, dynamic> json) =
      _$PairingMetadataImpl.fromJson;

  @override
  String get name;
  @override
  String get description;
  @override
  String get url;
  @override
  List<String> get icons;
  @override
  String? get verifyUrl;
  @override
  Redirect? get redirect;
  @override
  @JsonKey(ignore: true)
  _$$PairingMetadataImplCopyWith<_$PairingMetadataImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

Redirect _$RedirectFromJson(Map<String, dynamic> json) {
  return _Redirect.fromJson(json);
}

/// @nodoc
mixin _$Redirect {
  String? get native => throw _privateConstructorUsedError;
  String? get universal => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $RedirectCopyWith<Redirect> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $RedirectCopyWith<$Res> {
  factory $RedirectCopyWith(Redirect value, $Res Function(Redirect) then) =
      _$RedirectCopyWithImpl<$Res, Redirect>;
  @useResult
  $Res call({String? native, String? universal});
}

/// @nodoc
class _$RedirectCopyWithImpl<$Res, $Val extends Redirect>
    implements $RedirectCopyWith<$Res> {
  _$RedirectCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? native = freezed,
    Object? universal = freezed,
  }) {
    return _then(_value.copyWith(
      native: freezed == native
          ? _value.native
          : native // ignore: cast_nullable_to_non_nullable
              as String?,
      universal: freezed == universal
          ? _value.universal
          : universal // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$RedirectImplCopyWith<$Res>
    implements $RedirectCopyWith<$Res> {
  factory _$$RedirectImplCopyWith(
          _$RedirectImpl value, $Res Function(_$RedirectImpl) then) =
      __$$RedirectImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String? native, String? universal});
}

/// @nodoc
class __$$RedirectImplCopyWithImpl<$Res>
    extends _$RedirectCopyWithImpl<$Res, _$RedirectImpl>
    implements _$$RedirectImplCopyWith<$Res> {
  __$$RedirectImplCopyWithImpl(
      _$RedirectImpl _value, $Res Function(_$RedirectImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? native = freezed,
    Object? universal = freezed,
  }) {
    return _then(_$RedirectImpl(
      native: freezed == native
          ? _value.native
          : native // ignore: cast_nullable_to_non_nullable
              as String?,
      universal: freezed == universal
          ? _value.universal
          : universal // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc

@JsonSerializable()
class _$RedirectImpl implements _Redirect {
  const _$RedirectImpl({this.native, this.universal});

  factory _$RedirectImpl.fromJson(Map<String, dynamic> json) =>
      _$$RedirectImplFromJson(json);

  @override
  final String? native;
  @override
  final String? universal;

  @override
  String toString() {
    return 'Redirect(native: $native, universal: $universal)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$RedirectImpl &&
            (identical(other.native, native) || other.native == native) &&
            (identical(other.universal, universal) ||
                other.universal == universal));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, native, universal);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$RedirectImplCopyWith<_$RedirectImpl> get copyWith =>
      __$$RedirectImplCopyWithImpl<_$RedirectImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$RedirectImplToJson(
      this,
    );
  }
}

abstract class _Redirect implements Redirect {
  const factory _Redirect({final String? native, final String? universal}) =
      _$RedirectImpl;

  factory _Redirect.fromJson(Map<String, dynamic> json) =
      _$RedirectImpl.fromJson;

  @override
  String? get native;
  @override
  String? get universal;
  @override
  @JsonKey(ignore: true)
  _$$RedirectImplCopyWith<_$RedirectImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

JsonRpcRecord _$JsonRpcRecordFromJson(Map<String, dynamic> json) {
  return _JsonRpcRecord.fromJson(json);
}

/// @nodoc
mixin _$JsonRpcRecord {
  int get id => throw _privateConstructorUsedError;
  String get topic => throw _privateConstructorUsedError;
  String get method => throw _privateConstructorUsedError;
  dynamic get params => throw _privateConstructorUsedError;
  String? get chainId => throw _privateConstructorUsedError;
  int? get expiry => throw _privateConstructorUsedError;
  dynamic get response => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $JsonRpcRecordCopyWith<JsonRpcRecord> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $JsonRpcRecordCopyWith<$Res> {
  factory $JsonRpcRecordCopyWith(
          JsonRpcRecord value, $Res Function(JsonRpcRecord) then) =
      _$JsonRpcRecordCopyWithImpl<$Res, JsonRpcRecord>;
  @useResult
  $Res call(
      {int id,
      String topic,
      String method,
      dynamic params,
      String? chainId,
      int? expiry,
      dynamic response});
}

/// @nodoc
class _$JsonRpcRecordCopyWithImpl<$Res, $Val extends JsonRpcRecord>
    implements $JsonRpcRecordCopyWith<$Res> {
  _$JsonRpcRecordCopyWithImpl(this._value, this._then);

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
    Object? params = freezed,
    Object? chainId = freezed,
    Object? expiry = freezed,
    Object? response = freezed,
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
      params: freezed == params
          ? _value.params
          : params // ignore: cast_nullable_to_non_nullable
              as dynamic,
      chainId: freezed == chainId
          ? _value.chainId
          : chainId // ignore: cast_nullable_to_non_nullable
              as String?,
      expiry: freezed == expiry
          ? _value.expiry
          : expiry // ignore: cast_nullable_to_non_nullable
              as int?,
      response: freezed == response
          ? _value.response
          : response // ignore: cast_nullable_to_non_nullable
              as dynamic,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$JsonRpcRecordImplCopyWith<$Res>
    implements $JsonRpcRecordCopyWith<$Res> {
  factory _$$JsonRpcRecordImplCopyWith(
          _$JsonRpcRecordImpl value, $Res Function(_$JsonRpcRecordImpl) then) =
      __$$JsonRpcRecordImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {int id,
      String topic,
      String method,
      dynamic params,
      String? chainId,
      int? expiry,
      dynamic response});
}

/// @nodoc
class __$$JsonRpcRecordImplCopyWithImpl<$Res>
    extends _$JsonRpcRecordCopyWithImpl<$Res, _$JsonRpcRecordImpl>
    implements _$$JsonRpcRecordImplCopyWith<$Res> {
  __$$JsonRpcRecordImplCopyWithImpl(
      _$JsonRpcRecordImpl _value, $Res Function(_$JsonRpcRecordImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? topic = null,
    Object? method = null,
    Object? params = freezed,
    Object? chainId = freezed,
    Object? expiry = freezed,
    Object? response = freezed,
  }) {
    return _then(_$JsonRpcRecordImpl(
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
      params: freezed == params
          ? _value.params
          : params // ignore: cast_nullable_to_non_nullable
              as dynamic,
      chainId: freezed == chainId
          ? _value.chainId
          : chainId // ignore: cast_nullable_to_non_nullable
              as String?,
      expiry: freezed == expiry
          ? _value.expiry
          : expiry // ignore: cast_nullable_to_non_nullable
              as int?,
      response: freezed == response
          ? _value.response
          : response // ignore: cast_nullable_to_non_nullable
              as dynamic,
    ));
  }
}

/// @nodoc

@JsonSerializable(includeIfNull: false)
class _$JsonRpcRecordImpl implements _JsonRpcRecord {
  const _$JsonRpcRecordImpl(
      {required this.id,
      required this.topic,
      required this.method,
      required this.params,
      this.chainId,
      this.expiry,
      this.response});

  factory _$JsonRpcRecordImpl.fromJson(Map<String, dynamic> json) =>
      _$$JsonRpcRecordImplFromJson(json);

  @override
  final int id;
  @override
  final String topic;
  @override
  final String method;
  @override
  final dynamic params;
  @override
  final String? chainId;
  @override
  final int? expiry;
  @override
  final dynamic response;

  @override
  String toString() {
    return 'JsonRpcRecord(id: $id, topic: $topic, method: $method, params: $params, chainId: $chainId, expiry: $expiry, response: $response)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$JsonRpcRecordImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.topic, topic) || other.topic == topic) &&
            (identical(other.method, method) || other.method == method) &&
            const DeepCollectionEquality().equals(other.params, params) &&
            (identical(other.chainId, chainId) || other.chainId == chainId) &&
            (identical(other.expiry, expiry) || other.expiry == expiry) &&
            const DeepCollectionEquality().equals(other.response, response));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      topic,
      method,
      const DeepCollectionEquality().hash(params),
      chainId,
      expiry,
      const DeepCollectionEquality().hash(response));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$JsonRpcRecordImplCopyWith<_$JsonRpcRecordImpl> get copyWith =>
      __$$JsonRpcRecordImplCopyWithImpl<_$JsonRpcRecordImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$JsonRpcRecordImplToJson(
      this,
    );
  }
}

abstract class _JsonRpcRecord implements JsonRpcRecord {
  const factory _JsonRpcRecord(
      {required final int id,
      required final String topic,
      required final String method,
      required final dynamic params,
      final String? chainId,
      final int? expiry,
      final dynamic response}) = _$JsonRpcRecordImpl;

  factory _JsonRpcRecord.fromJson(Map<String, dynamic> json) =
      _$JsonRpcRecordImpl.fromJson;

  @override
  int get id;
  @override
  String get topic;
  @override
  String get method;
  @override
  dynamic get params;
  @override
  String? get chainId;
  @override
  int? get expiry;
  @override
  dynamic get response;
  @override
  @JsonKey(ignore: true)
  _$$JsonRpcRecordImplCopyWith<_$JsonRpcRecordImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

ReceiverPublicKey _$ReceiverPublicKeyFromJson(Map<String, dynamic> json) {
  return _ReceiverPublicKey.fromJson(json);
}

/// @nodoc
mixin _$ReceiverPublicKey {
  String get topic => throw _privateConstructorUsedError;
  String get publicKey => throw _privateConstructorUsedError;
  int get expiry => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $ReceiverPublicKeyCopyWith<ReceiverPublicKey> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ReceiverPublicKeyCopyWith<$Res> {
  factory $ReceiverPublicKeyCopyWith(
          ReceiverPublicKey value, $Res Function(ReceiverPublicKey) then) =
      _$ReceiverPublicKeyCopyWithImpl<$Res, ReceiverPublicKey>;
  @useResult
  $Res call({String topic, String publicKey, int expiry});
}

/// @nodoc
class _$ReceiverPublicKeyCopyWithImpl<$Res, $Val extends ReceiverPublicKey>
    implements $ReceiverPublicKeyCopyWith<$Res> {
  _$ReceiverPublicKeyCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? topic = null,
    Object? publicKey = null,
    Object? expiry = null,
  }) {
    return _then(_value.copyWith(
      topic: null == topic
          ? _value.topic
          : topic // ignore: cast_nullable_to_non_nullable
              as String,
      publicKey: null == publicKey
          ? _value.publicKey
          : publicKey // ignore: cast_nullable_to_non_nullable
              as String,
      expiry: null == expiry
          ? _value.expiry
          : expiry // ignore: cast_nullable_to_non_nullable
              as int,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$ReceiverPublicKeyImplCopyWith<$Res>
    implements $ReceiverPublicKeyCopyWith<$Res> {
  factory _$$ReceiverPublicKeyImplCopyWith(_$ReceiverPublicKeyImpl value,
          $Res Function(_$ReceiverPublicKeyImpl) then) =
      __$$ReceiverPublicKeyImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String topic, String publicKey, int expiry});
}

/// @nodoc
class __$$ReceiverPublicKeyImplCopyWithImpl<$Res>
    extends _$ReceiverPublicKeyCopyWithImpl<$Res, _$ReceiverPublicKeyImpl>
    implements _$$ReceiverPublicKeyImplCopyWith<$Res> {
  __$$ReceiverPublicKeyImplCopyWithImpl(_$ReceiverPublicKeyImpl _value,
      $Res Function(_$ReceiverPublicKeyImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? topic = null,
    Object? publicKey = null,
    Object? expiry = null,
  }) {
    return _then(_$ReceiverPublicKeyImpl(
      topic: null == topic
          ? _value.topic
          : topic // ignore: cast_nullable_to_non_nullable
              as String,
      publicKey: null == publicKey
          ? _value.publicKey
          : publicKey // ignore: cast_nullable_to_non_nullable
              as String,
      expiry: null == expiry
          ? _value.expiry
          : expiry // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc

@JsonSerializable(includeIfNull: false)
class _$ReceiverPublicKeyImpl implements _ReceiverPublicKey {
  const _$ReceiverPublicKeyImpl(
      {required this.topic, required this.publicKey, required this.expiry});

  factory _$ReceiverPublicKeyImpl.fromJson(Map<String, dynamic> json) =>
      _$$ReceiverPublicKeyImplFromJson(json);

  @override
  final String topic;
  @override
  final String publicKey;
  @override
  final int expiry;

  @override
  String toString() {
    return 'ReceiverPublicKey(topic: $topic, publicKey: $publicKey, expiry: $expiry)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ReceiverPublicKeyImpl &&
            (identical(other.topic, topic) || other.topic == topic) &&
            (identical(other.publicKey, publicKey) ||
                other.publicKey == publicKey) &&
            (identical(other.expiry, expiry) || other.expiry == expiry));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, topic, publicKey, expiry);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$ReceiverPublicKeyImplCopyWith<_$ReceiverPublicKeyImpl> get copyWith =>
      __$$ReceiverPublicKeyImplCopyWithImpl<_$ReceiverPublicKeyImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ReceiverPublicKeyImplToJson(
      this,
    );
  }
}

abstract class _ReceiverPublicKey implements ReceiverPublicKey {
  const factory _ReceiverPublicKey(
      {required final String topic,
      required final String publicKey,
      required final int expiry}) = _$ReceiverPublicKeyImpl;

  factory _ReceiverPublicKey.fromJson(Map<String, dynamic> json) =
      _$ReceiverPublicKeyImpl.fromJson;

  @override
  String get topic;
  @override
  String get publicKey;
  @override
  int get expiry;
  @override
  @JsonKey(ignore: true)
  _$$ReceiverPublicKeyImplCopyWith<_$ReceiverPublicKeyImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

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
abstract class _$$_PairingInfoCopyWith<$Res>
    implements $PairingInfoCopyWith<$Res> {
  factory _$$_PairingInfoCopyWith(
          _$_PairingInfo value, $Res Function(_$_PairingInfo) then) =
      __$$_PairingInfoCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String topic,
      int expiry,
      Relay relay,
      bool active,
      PairingMetadata? peerMetadata});

  @override
  $PairingMetadataCopyWith<$Res>? get peerMetadata;
}

/// @nodoc
class __$$_PairingInfoCopyWithImpl<$Res>
    extends _$PairingInfoCopyWithImpl<$Res, _$_PairingInfo>
    implements _$$_PairingInfoCopyWith<$Res> {
  __$$_PairingInfoCopyWithImpl(
      _$_PairingInfo _value, $Res Function(_$_PairingInfo) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? topic = null,
    Object? expiry = null,
    Object? relay = null,
    Object? active = null,
    Object? peerMetadata = freezed,
  }) {
    return _then(_$_PairingInfo(
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
      peerMetadata: freezed == peerMetadata
          ? _value.peerMetadata
          : peerMetadata // ignore: cast_nullable_to_non_nullable
              as PairingMetadata?,
    ));
  }
}

/// @nodoc

@JsonSerializable()
class _$_PairingInfo implements _PairingInfo {
  const _$_PairingInfo(
      {required this.topic,
      required this.expiry,
      required this.relay,
      required this.active,
      this.peerMetadata});

  factory _$_PairingInfo.fromJson(Map<String, dynamic> json) =>
      _$$_PairingInfoFromJson(json);

  @override
  final String topic;
  @override
  final int expiry;
  @override
  final Relay relay;
  @override
  final bool active;
  @override
  final PairingMetadata? peerMetadata;

  @override
  String toString() {
    return 'PairingInfo(topic: $topic, expiry: $expiry, relay: $relay, active: $active, peerMetadata: $peerMetadata)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_PairingInfo &&
            (identical(other.topic, topic) || other.topic == topic) &&
            (identical(other.expiry, expiry) || other.expiry == expiry) &&
            (identical(other.relay, relay) || other.relay == relay) &&
            (identical(other.active, active) || other.active == active) &&
            (identical(other.peerMetadata, peerMetadata) ||
                other.peerMetadata == peerMetadata));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode =>
      Object.hash(runtimeType, topic, expiry, relay, active, peerMetadata);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_PairingInfoCopyWith<_$_PairingInfo> get copyWith =>
      __$$_PairingInfoCopyWithImpl<_$_PairingInfo>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_PairingInfoToJson(
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
      final PairingMetadata? peerMetadata}) = _$_PairingInfo;

  factory _PairingInfo.fromJson(Map<String, dynamic> json) =
      _$_PairingInfo.fromJson;

  @override
  String get topic;
  @override
  int get expiry;
  @override
  Relay get relay;
  @override
  bool get active;
  @override
  PairingMetadata? get peerMetadata;
  @override
  @JsonKey(ignore: true)
  _$$_PairingInfoCopyWith<_$_PairingInfo> get copyWith =>
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
abstract class _$$_PairingMetadataCopyWith<$Res>
    implements $PairingMetadataCopyWith<$Res> {
  factory _$$_PairingMetadataCopyWith(
          _$_PairingMetadata value, $Res Function(_$_PairingMetadata) then) =
      __$$_PairingMetadataCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String name,
      String description,
      String url,
      List<String> icons,
      Redirect? redirect});

  @override
  $RedirectCopyWith<$Res>? get redirect;
}

/// @nodoc
class __$$_PairingMetadataCopyWithImpl<$Res>
    extends _$PairingMetadataCopyWithImpl<$Res, _$_PairingMetadata>
    implements _$$_PairingMetadataCopyWith<$Res> {
  __$$_PairingMetadataCopyWithImpl(
      _$_PairingMetadata _value, $Res Function(_$_PairingMetadata) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = null,
    Object? description = null,
    Object? url = null,
    Object? icons = null,
    Object? redirect = freezed,
  }) {
    return _then(_$_PairingMetadata(
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
      redirect: freezed == redirect
          ? _value.redirect
          : redirect // ignore: cast_nullable_to_non_nullable
              as Redirect?,
    ));
  }
}

/// @nodoc

@JsonSerializable(includeIfNull: false)
class _$_PairingMetadata implements _PairingMetadata {
  const _$_PairingMetadata(
      {required this.name,
      required this.description,
      required this.url,
      required final List<String> icons,
      this.redirect})
      : _icons = icons;

  factory _$_PairingMetadata.fromJson(Map<String, dynamic> json) =>
      _$$_PairingMetadataFromJson(json);

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
  final Redirect? redirect;

  @override
  String toString() {
    return 'PairingMetadata(name: $name, description: $description, url: $url, icons: $icons, redirect: $redirect)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_PairingMetadata &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.description, description) ||
                other.description == description) &&
            (identical(other.url, url) || other.url == url) &&
            const DeepCollectionEquality().equals(other._icons, _icons) &&
            (identical(other.redirect, redirect) ||
                other.redirect == redirect));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, name, description, url,
      const DeepCollectionEquality().hash(_icons), redirect);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_PairingMetadataCopyWith<_$_PairingMetadata> get copyWith =>
      __$$_PairingMetadataCopyWithImpl<_$_PairingMetadata>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_PairingMetadataToJson(
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
      final Redirect? redirect}) = _$_PairingMetadata;

  factory _PairingMetadata.fromJson(Map<String, dynamic> json) =
      _$_PairingMetadata.fromJson;

  @override
  String get name;
  @override
  String get description;
  @override
  String get url;
  @override
  List<String> get icons;
  @override
  Redirect? get redirect;
  @override
  @JsonKey(ignore: true)
  _$$_PairingMetadataCopyWith<_$_PairingMetadata> get copyWith =>
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
abstract class _$$_RedirectCopyWith<$Res> implements $RedirectCopyWith<$Res> {
  factory _$$_RedirectCopyWith(
          _$_Redirect value, $Res Function(_$_Redirect) then) =
      __$$_RedirectCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String? native, String? universal});
}

/// @nodoc
class __$$_RedirectCopyWithImpl<$Res>
    extends _$RedirectCopyWithImpl<$Res, _$_Redirect>
    implements _$$_RedirectCopyWith<$Res> {
  __$$_RedirectCopyWithImpl(
      _$_Redirect _value, $Res Function(_$_Redirect) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? native = freezed,
    Object? universal = freezed,
  }) {
    return _then(_$_Redirect(
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
class _$_Redirect implements _Redirect {
  const _$_Redirect({this.native, this.universal});

  factory _$_Redirect.fromJson(Map<String, dynamic> json) =>
      _$$_RedirectFromJson(json);

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
            other is _$_Redirect &&
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
  _$$_RedirectCopyWith<_$_Redirect> get copyWith =>
      __$$_RedirectCopyWithImpl<_$_Redirect>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_RedirectToJson(
      this,
    );
  }
}

abstract class _Redirect implements Redirect {
  const factory _Redirect({final String? native, final String? universal}) =
      _$_Redirect;

  factory _Redirect.fromJson(Map<String, dynamic> json) = _$_Redirect.fromJson;

  @override
  String? get native;
  @override
  String? get universal;
  @override
  @JsonKey(ignore: true)
  _$$_RedirectCopyWith<_$_Redirect> get copyWith =>
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
abstract class _$$_JsonRpcRecordCopyWith<$Res>
    implements $JsonRpcRecordCopyWith<$Res> {
  factory _$$_JsonRpcRecordCopyWith(
          _$_JsonRpcRecord value, $Res Function(_$_JsonRpcRecord) then) =
      __$$_JsonRpcRecordCopyWithImpl<$Res>;
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
class __$$_JsonRpcRecordCopyWithImpl<$Res>
    extends _$JsonRpcRecordCopyWithImpl<$Res, _$_JsonRpcRecord>
    implements _$$_JsonRpcRecordCopyWith<$Res> {
  __$$_JsonRpcRecordCopyWithImpl(
      _$_JsonRpcRecord _value, $Res Function(_$_JsonRpcRecord) _then)
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
    return _then(_$_JsonRpcRecord(
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
class _$_JsonRpcRecord implements _JsonRpcRecord {
  const _$_JsonRpcRecord(
      {required this.id,
      required this.topic,
      required this.method,
      required this.params,
      this.chainId,
      this.expiry,
      this.response});

  factory _$_JsonRpcRecord.fromJson(Map<String, dynamic> json) =>
      _$$_JsonRpcRecordFromJson(json);

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
            other is _$_JsonRpcRecord &&
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
  _$$_JsonRpcRecordCopyWith<_$_JsonRpcRecord> get copyWith =>
      __$$_JsonRpcRecordCopyWithImpl<_$_JsonRpcRecord>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_JsonRpcRecordToJson(
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
      final dynamic response}) = _$_JsonRpcRecord;

  factory _JsonRpcRecord.fromJson(Map<String, dynamic> json) =
      _$_JsonRpcRecord.fromJson;

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
  _$$_JsonRpcRecordCopyWith<_$_JsonRpcRecord> get copyWith =>
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
abstract class _$$_ReceiverPublicKeyCopyWith<$Res>
    implements $ReceiverPublicKeyCopyWith<$Res> {
  factory _$$_ReceiverPublicKeyCopyWith(_$_ReceiverPublicKey value,
          $Res Function(_$_ReceiverPublicKey) then) =
      __$$_ReceiverPublicKeyCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String topic, String publicKey, int expiry});
}

/// @nodoc
class __$$_ReceiverPublicKeyCopyWithImpl<$Res>
    extends _$ReceiverPublicKeyCopyWithImpl<$Res, _$_ReceiverPublicKey>
    implements _$$_ReceiverPublicKeyCopyWith<$Res> {
  __$$_ReceiverPublicKeyCopyWithImpl(
      _$_ReceiverPublicKey _value, $Res Function(_$_ReceiverPublicKey) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? topic = null,
    Object? publicKey = null,
    Object? expiry = null,
  }) {
    return _then(_$_ReceiverPublicKey(
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
class _$_ReceiverPublicKey implements _ReceiverPublicKey {
  const _$_ReceiverPublicKey(
      {required this.topic, required this.publicKey, required this.expiry});

  factory _$_ReceiverPublicKey.fromJson(Map<String, dynamic> json) =>
      _$$_ReceiverPublicKeyFromJson(json);

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
            other is _$_ReceiverPublicKey &&
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
  _$$_ReceiverPublicKeyCopyWith<_$_ReceiverPublicKey> get copyWith =>
      __$$_ReceiverPublicKeyCopyWithImpl<_$_ReceiverPublicKey>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_ReceiverPublicKeyToJson(
      this,
    );
  }
}

abstract class _ReceiverPublicKey implements ReceiverPublicKey {
  const factory _ReceiverPublicKey(
      {required final String topic,
      required final String publicKey,
      required final int expiry}) = _$_ReceiverPublicKey;

  factory _ReceiverPublicKey.fromJson(Map<String, dynamic> json) =
      _$_ReceiverPublicKey.fromJson;

  @override
  String get topic;
  @override
  String get publicKey;
  @override
  int get expiry;
  @override
  @JsonKey(ignore: true)
  _$$_ReceiverPublicKeyCopyWith<_$_ReceiverPublicKey> get copyWith =>
      throw _privateConstructorUsedError;
}

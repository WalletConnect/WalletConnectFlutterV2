// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'verify_context.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

VerifyContext _$VerifyContextFromJson(Map<String, dynamic> json) {
  return _VerifyContext.fromJson(json);
}

/// @nodoc
mixin _$VerifyContext {
  String get origin => throw _privateConstructorUsedError;
  Validation get validation => throw _privateConstructorUsedError;
  String get verifyUrl => throw _privateConstructorUsedError;
  bool? get isScam => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $VerifyContextCopyWith<VerifyContext> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $VerifyContextCopyWith<$Res> {
  factory $VerifyContextCopyWith(
          VerifyContext value, $Res Function(VerifyContext) then) =
      _$VerifyContextCopyWithImpl<$Res, VerifyContext>;
  @useResult
  $Res call(
      {String origin, Validation validation, String verifyUrl, bool? isScam});
}

/// @nodoc
class _$VerifyContextCopyWithImpl<$Res, $Val extends VerifyContext>
    implements $VerifyContextCopyWith<$Res> {
  _$VerifyContextCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? origin = null,
    Object? validation = null,
    Object? verifyUrl = null,
    Object? isScam = freezed,
  }) {
    return _then(_value.copyWith(
      origin: null == origin
          ? _value.origin
          : origin // ignore: cast_nullable_to_non_nullable
              as String,
      validation: null == validation
          ? _value.validation
          : validation // ignore: cast_nullable_to_non_nullable
              as Validation,
      verifyUrl: null == verifyUrl
          ? _value.verifyUrl
          : verifyUrl // ignore: cast_nullable_to_non_nullable
              as String,
      isScam: freezed == isScam
          ? _value.isScam
          : isScam // ignore: cast_nullable_to_non_nullable
              as bool?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_VerifyContextCopyWith<$Res>
    implements $VerifyContextCopyWith<$Res> {
  factory _$$_VerifyContextCopyWith(
          _$_VerifyContext value, $Res Function(_$_VerifyContext) then) =
      __$$_VerifyContextCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String origin, Validation validation, String verifyUrl, bool? isScam});
}

/// @nodoc
class __$$_VerifyContextCopyWithImpl<$Res>
    extends _$VerifyContextCopyWithImpl<$Res, _$_VerifyContext>
    implements _$$_VerifyContextCopyWith<$Res> {
  __$$_VerifyContextCopyWithImpl(
      _$_VerifyContext _value, $Res Function(_$_VerifyContext) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? origin = null,
    Object? validation = null,
    Object? verifyUrl = null,
    Object? isScam = freezed,
  }) {
    return _then(_$_VerifyContext(
      origin: null == origin
          ? _value.origin
          : origin // ignore: cast_nullable_to_non_nullable
              as String,
      validation: null == validation
          ? _value.validation
          : validation // ignore: cast_nullable_to_non_nullable
              as Validation,
      verifyUrl: null == verifyUrl
          ? _value.verifyUrl
          : verifyUrl // ignore: cast_nullable_to_non_nullable
              as String,
      isScam: freezed == isScam
          ? _value.isScam
          : isScam // ignore: cast_nullable_to_non_nullable
              as bool?,
    ));
  }
}

/// @nodoc

@JsonSerializable()
class _$_VerifyContext implements _VerifyContext {
  const _$_VerifyContext(
      {required this.origin,
      required this.validation,
      required this.verifyUrl,
      this.isScam});

  factory _$_VerifyContext.fromJson(Map<String, dynamic> json) =>
      _$$_VerifyContextFromJson(json);

  @override
  final String origin;
  @override
  final Validation validation;
  @override
  final String verifyUrl;
  @override
  final bool? isScam;

  @override
  String toString() {
    return 'VerifyContext(origin: $origin, validation: $validation, verifyUrl: $verifyUrl, isScam: $isScam)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_VerifyContext &&
            (identical(other.origin, origin) || other.origin == origin) &&
            (identical(other.validation, validation) ||
                other.validation == validation) &&
            (identical(other.verifyUrl, verifyUrl) ||
                other.verifyUrl == verifyUrl) &&
            (identical(other.isScam, isScam) || other.isScam == isScam));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode =>
      Object.hash(runtimeType, origin, validation, verifyUrl, isScam);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_VerifyContextCopyWith<_$_VerifyContext> get copyWith =>
      __$$_VerifyContextCopyWithImpl<_$_VerifyContext>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_VerifyContextToJson(
      this,
    );
  }
}

abstract class _VerifyContext implements VerifyContext {
  const factory _VerifyContext(
      {required final String origin,
      required final Validation validation,
      required final String verifyUrl,
      final bool? isScam}) = _$_VerifyContext;

  factory _VerifyContext.fromJson(Map<String, dynamic> json) =
      _$_VerifyContext.fromJson;

  @override
  String get origin;
  @override
  Validation get validation;
  @override
  String get verifyUrl;
  @override
  bool? get isScam;
  @override
  @JsonKey(ignore: true)
  _$$_VerifyContextCopyWith<_$_VerifyContext> get copyWith =>
      throw _privateConstructorUsedError;
}

AttestationResponse _$AttestationResponseFromJson(Map<String, dynamic> json) {
  return _AttestationResponse.fromJson(json);
}

/// @nodoc
mixin _$AttestationResponse {
  String get origin => throw _privateConstructorUsedError;
  String get attestationId => throw _privateConstructorUsedError;
  bool? get isScam => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $AttestationResponseCopyWith<AttestationResponse> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AttestationResponseCopyWith<$Res> {
  factory $AttestationResponseCopyWith(
          AttestationResponse value, $Res Function(AttestationResponse) then) =
      _$AttestationResponseCopyWithImpl<$Res, AttestationResponse>;
  @useResult
  $Res call({String origin, String attestationId, bool? isScam});
}

/// @nodoc
class _$AttestationResponseCopyWithImpl<$Res, $Val extends AttestationResponse>
    implements $AttestationResponseCopyWith<$Res> {
  _$AttestationResponseCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? origin = null,
    Object? attestationId = null,
    Object? isScam = freezed,
  }) {
    return _then(_value.copyWith(
      origin: null == origin
          ? _value.origin
          : origin // ignore: cast_nullable_to_non_nullable
              as String,
      attestationId: null == attestationId
          ? _value.attestationId
          : attestationId // ignore: cast_nullable_to_non_nullable
              as String,
      isScam: freezed == isScam
          ? _value.isScam
          : isScam // ignore: cast_nullable_to_non_nullable
              as bool?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_AttestationResponseCopyWith<$Res>
    implements $AttestationResponseCopyWith<$Res> {
  factory _$$_AttestationResponseCopyWith(_$_AttestationResponse value,
          $Res Function(_$_AttestationResponse) then) =
      __$$_AttestationResponseCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String origin, String attestationId, bool? isScam});
}

/// @nodoc
class __$$_AttestationResponseCopyWithImpl<$Res>
    extends _$AttestationResponseCopyWithImpl<$Res, _$_AttestationResponse>
    implements _$$_AttestationResponseCopyWith<$Res> {
  __$$_AttestationResponseCopyWithImpl(_$_AttestationResponse _value,
      $Res Function(_$_AttestationResponse) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? origin = null,
    Object? attestationId = null,
    Object? isScam = freezed,
  }) {
    return _then(_$_AttestationResponse(
      origin: null == origin
          ? _value.origin
          : origin // ignore: cast_nullable_to_non_nullable
              as String,
      attestationId: null == attestationId
          ? _value.attestationId
          : attestationId // ignore: cast_nullable_to_non_nullable
              as String,
      isScam: freezed == isScam
          ? _value.isScam
          : isScam // ignore: cast_nullable_to_non_nullable
              as bool?,
    ));
  }
}

/// @nodoc

@JsonSerializable()
class _$_AttestationResponse implements _AttestationResponse {
  const _$_AttestationResponse(
      {required this.origin, required this.attestationId, this.isScam});

  factory _$_AttestationResponse.fromJson(Map<String, dynamic> json) =>
      _$$_AttestationResponseFromJson(json);

  @override
  final String origin;
  @override
  final String attestationId;
  @override
  final bool? isScam;

  @override
  String toString() {
    return 'AttestationResponse(origin: $origin, attestationId: $attestationId, isScam: $isScam)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_AttestationResponse &&
            (identical(other.origin, origin) || other.origin == origin) &&
            (identical(other.attestationId, attestationId) ||
                other.attestationId == attestationId) &&
            (identical(other.isScam, isScam) || other.isScam == isScam));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, origin, attestationId, isScam);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_AttestationResponseCopyWith<_$_AttestationResponse> get copyWith =>
      __$$_AttestationResponseCopyWithImpl<_$_AttestationResponse>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_AttestationResponseToJson(
      this,
    );
  }
}

abstract class _AttestationResponse implements AttestationResponse {
  const factory _AttestationResponse(
      {required final String origin,
      required final String attestationId,
      final bool? isScam}) = _$_AttestationResponse;

  factory _AttestationResponse.fromJson(Map<String, dynamic> json) =
      _$_AttestationResponse.fromJson;

  @override
  String get origin;
  @override
  String get attestationId;
  @override
  bool? get isScam;
  @override
  @JsonKey(ignore: true)
  _$$_AttestationResponseCopyWith<_$_AttestationResponse> get copyWith =>
      throw _privateConstructorUsedError;
}

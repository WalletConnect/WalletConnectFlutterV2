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
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

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
abstract class _$$VerifyContextImplCopyWith<$Res>
    implements $VerifyContextCopyWith<$Res> {
  factory _$$VerifyContextImplCopyWith(
          _$VerifyContextImpl value, $Res Function(_$VerifyContextImpl) then) =
      __$$VerifyContextImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String origin, Validation validation, String verifyUrl, bool? isScam});
}

/// @nodoc
class __$$VerifyContextImplCopyWithImpl<$Res>
    extends _$VerifyContextCopyWithImpl<$Res, _$VerifyContextImpl>
    implements _$$VerifyContextImplCopyWith<$Res> {
  __$$VerifyContextImplCopyWithImpl(
      _$VerifyContextImpl _value, $Res Function(_$VerifyContextImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? origin = null,
    Object? validation = null,
    Object? verifyUrl = null,
    Object? isScam = freezed,
  }) {
    return _then(_$VerifyContextImpl(
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
class _$VerifyContextImpl implements _VerifyContext {
  const _$VerifyContextImpl(
      {required this.origin,
      required this.validation,
      required this.verifyUrl,
      this.isScam});

  factory _$VerifyContextImpl.fromJson(Map<String, dynamic> json) =>
      _$$VerifyContextImplFromJson(json);

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
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$VerifyContextImpl &&
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
  _$$VerifyContextImplCopyWith<_$VerifyContextImpl> get copyWith =>
      __$$VerifyContextImplCopyWithImpl<_$VerifyContextImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$VerifyContextImplToJson(
      this,
    );
  }
}

abstract class _VerifyContext implements VerifyContext {
  const factory _VerifyContext(
      {required final String origin,
      required final Validation validation,
      required final String verifyUrl,
      final bool? isScam}) = _$VerifyContextImpl;

  factory _VerifyContext.fromJson(Map<String, dynamic> json) =
      _$VerifyContextImpl.fromJson;

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
  _$$VerifyContextImplCopyWith<_$VerifyContextImpl> get copyWith =>
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
abstract class _$$AttestationResponseImplCopyWith<$Res>
    implements $AttestationResponseCopyWith<$Res> {
  factory _$$AttestationResponseImplCopyWith(_$AttestationResponseImpl value,
          $Res Function(_$AttestationResponseImpl) then) =
      __$$AttestationResponseImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String origin, String attestationId, bool? isScam});
}

/// @nodoc
class __$$AttestationResponseImplCopyWithImpl<$Res>
    extends _$AttestationResponseCopyWithImpl<$Res, _$AttestationResponseImpl>
    implements _$$AttestationResponseImplCopyWith<$Res> {
  __$$AttestationResponseImplCopyWithImpl(_$AttestationResponseImpl _value,
      $Res Function(_$AttestationResponseImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? origin = null,
    Object? attestationId = null,
    Object? isScam = freezed,
  }) {
    return _then(_$AttestationResponseImpl(
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
class _$AttestationResponseImpl implements _AttestationResponse {
  const _$AttestationResponseImpl(
      {required this.origin, required this.attestationId, this.isScam});

  factory _$AttestationResponseImpl.fromJson(Map<String, dynamic> json) =>
      _$$AttestationResponseImplFromJson(json);

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
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AttestationResponseImpl &&
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
  _$$AttestationResponseImplCopyWith<_$AttestationResponseImpl> get copyWith =>
      __$$AttestationResponseImplCopyWithImpl<_$AttestationResponseImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$AttestationResponseImplToJson(
      this,
    );
  }
}

abstract class _AttestationResponse implements AttestationResponse {
  const factory _AttestationResponse(
      {required final String origin,
      required final String attestationId,
      final bool? isScam}) = _$AttestationResponseImpl;

  factory _AttestationResponse.fromJson(Map<String, dynamic> json) =
      _$AttestationResponseImpl.fromJson;

  @override
  String get origin;
  @override
  String get attestationId;
  @override
  bool? get isScam;
  @override
  @JsonKey(ignore: true)
  _$$AttestationResponseImplCopyWith<_$AttestationResponseImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

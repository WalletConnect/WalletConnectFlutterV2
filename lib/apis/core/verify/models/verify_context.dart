import 'package:freezed_annotation/freezed_annotation.dart';

part 'verify_context.g.dart';
part 'verify_context.freezed.dart';

enum Validation {
  UNKNOWN,
  VALID,
  INVALID,
  SCAM;

  bool get invalid => this == INVALID;
  bool get valid => this == VALID;
  bool get unknown => this == UNKNOWN;
  bool get scam => this == SCAM;
}

@freezed
class VerifyContext with _$VerifyContext {
  @JsonSerializable()
  const factory VerifyContext({
    required String origin,
    required Validation validation,
    required String verifyUrl,
    bool? isScam,
  }) = _VerifyContext;

  factory VerifyContext.fromJson(Map<String, dynamic> json) =>
      _$VerifyContextFromJson(json);
}

@freezed
class AttestationResponse with _$AttestationResponse {
  @JsonSerializable()
  const factory AttestationResponse({
    required String origin,
    required String attestationId,
    bool? isScam,
  }) = _AttestationResponse;

  factory AttestationResponse.fromJson(Map<String, dynamic> json) =>
      _$AttestationResponseFromJson(json);
}

class AttestationNotFound implements Exception {
  int code;
  String message;

  AttestationNotFound({required this.code, required this.message}) : super();
}

import 'package:freezed_annotation/freezed_annotation.dart';

import 'package:walletconnect_flutter_v2/apis/sign_api/models/auth/auth_client_models.dart';
import 'package:walletconnect_flutter_v2/apis/sign_api/models/auth/session_auth_models.dart';

part 'common_auth_models.g.dart';
part 'common_auth_models.freezed.dart';

@freezed
class AuthPublicKey with _$AuthPublicKey {
  @JsonSerializable(includeIfNull: false)
  const factory AuthPublicKey({
    required String publicKey,
  }) = _AuthPublicKey;

  factory AuthPublicKey.fromJson(Map<String, dynamic> json) =>
      _$AuthPublicKeyFromJson(json);
}

@freezed
class CacaoRequestPayload with _$CacaoRequestPayload {
  @JsonSerializable(includeIfNull: false)
  const factory CacaoRequestPayload({
    required String domain,
    required String aud,
    required String version,
    required String nonce,
    required String iat,
    String? nbf,
    String? exp,
    String? statement,
    String? requestId,
    List<String>? resources,
  }) = _CacaoRequestPayload;

  factory CacaoRequestPayload.fromPayloadParams(AuthPayloadParams params) {
    return CacaoRequestPayload(
      domain: params.domain,
      aud: params.aud,
      version: params.version,
      nonce: params.nonce,
      iat: params.iat,
      nbf: params.nbf,
      exp: params.exp,
      statement: params.statement,
      requestId: params.requestId,
      resources: params.resources,
    );
  }

  factory CacaoRequestPayload.fromSessionAuthPayload(
    SessionAuthPayload params,
  ) {
    return CacaoRequestPayload(
      domain: params.domain,
      aud: params.aud,
      version: params.version,
      nonce: params.nonce,
      iat: params.iat,
      nbf: params.nbf,
      exp: params.exp,
      statement: params.statement,
      requestId: params.requestId,
      resources: params.resources,
    );
  }

  factory CacaoRequestPayload.fromCacaoPayload(CacaoPayload payload) {
    return CacaoRequestPayload(
      domain: payload.domain,
      aud: payload.aud,
      version: payload.version,
      nonce: payload.nonce,
      iat: payload.iat,
      nbf: payload.nbf,
      exp: payload.exp,
      statement: payload.statement,
      requestId: payload.requestId,
      resources: payload.resources,
    );
  }

  factory CacaoRequestPayload.fromJson(Map<String, dynamic> json) =>
      _$CacaoRequestPayloadFromJson(json);
}

@freezed
class CacaoPayload with _$CacaoPayload {
  @JsonSerializable(includeIfNull: false)
  const factory CacaoPayload({
    required String iss,
    required String domain,
    required String aud,
    required String version,
    required String nonce,
    required String iat,
    String? nbf,
    String? exp,
    String? statement,
    String? requestId,
    List<String>? resources,
  }) = _CacaoPayload;

  factory CacaoPayload.fromRequestPayload({
    required String issuer,
    required CacaoRequestPayload payload,
  }) {
    return CacaoPayload(
      iss: issuer,
      domain: payload.domain,
      aud: payload.aud,
      version: payload.version,
      nonce: payload.nonce,
      iat: payload.iat,
      nbf: payload.nbf,
      exp: payload.exp,
      statement: payload.statement,
      requestId: payload.requestId,
      resources: payload.resources,
    );
  }

  factory CacaoPayload.fromJson(Map<String, dynamic> json) =>
      _$CacaoPayloadFromJson(json);
}

@freezed
class CacaoHeader with _$CacaoHeader {
  static const EIP4361 = 'eip4361';
  static const CAIP122 = 'caip122';

  @JsonSerializable(includeIfNull: false)
  const factory CacaoHeader({
    @Default('eip4361') String t,
  }) = _CacaoHeader;

  factory CacaoHeader.fromJson(Map<String, dynamic> json) =>
      _$CacaoHeaderFromJson(json);
}

@freezed
class CacaoSignature with _$CacaoSignature {
  static const EIP191 = 'eip191';
  static const EIP1271 = 'eip1271';

  @JsonSerializable(includeIfNull: false)
  const factory CacaoSignature({
    required String t,
    required String s,
    String? m,
  }) = _CacaoSignature;

  factory CacaoSignature.fromJson(Map<String, dynamic> json) =>
      _$CacaoSignatureFromJson(json);
}

@freezed
class Cacao with _$Cacao {
  @JsonSerializable(includeIfNull: false)
  const factory Cacao({
    required CacaoHeader h,
    required CacaoPayload p,
    required CacaoSignature s,
  }) = _Cacao;

  factory Cacao.fromJson(Map<String, dynamic> json) => _$CacaoFromJson(json);
}

@freezed
class StoredCacao with _$StoredCacao {
  @JsonSerializable(includeIfNull: false)
  const factory StoredCacao({
    required int id,
    required String pairingTopic,
    required CacaoHeader h,
    required CacaoPayload p,
    required CacaoSignature s,
  }) = _StoredCacao;

  factory StoredCacao.fromCacao({
    required int id,
    required String pairingTopic,
    required Cacao cacao,
  }) {
    return StoredCacao(
      id: id,
      pairingTopic: pairingTopic,
      h: cacao.h,
      p: cacao.p,
      s: cacao.s,
    );
  }

  factory StoredCacao.fromJson(Map<String, dynamic> json) =>
      _$StoredCacaoFromJson(json);
}

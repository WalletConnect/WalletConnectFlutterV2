import 'dart:async';

import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:walletconnect_flutter_v2/apis/auth_api/models/auth_client_events.dart';
import 'package:walletconnect_flutter_v2/apis/auth_api/utils/auth_utils.dart';
import 'package:walletconnect_flutter_v2/apis/models/basic_models.dart';

part 'auth_client_models.g.dart';
part 'auth_client_models.freezed.dart';

class AuthRequestResponse {
  final int id;
  final String pairingTopic;
  final Completer<AuthResponse> completer;
  final Uri? uri;

  AuthRequestResponse({
    required this.id,
    required this.pairingTopic,
    required this.completer,
    this.uri,
  });
}

@freezed
class AuthPublicKey with _$AuthPublicKey {
  @JsonSerializable(includeIfNull: false)
  const factory AuthPublicKey({
    required String publicKey,
  }) = _AuthPublicKey;

  factory AuthPublicKey.fromJson(Map<String, dynamic> json) =>
      _$AuthPublicKeyFromJson(json);
}

class AuthRequestParams {
  /// The Chain ID.
  /// Examples: eip155:1 (Eth Mainnet), eip155:43114 (Avalanche)
  final String chainId;

  /// The complete URL you are logging into.
  /// Example: https://example.com/login
  final String aud;

  /// The domain you are logging in to.
  /// Example: example.com
  /// Domain must exist within the aud, or validation will fail
  final String domain;
  final String nonce;
  final String? type;
  final String? nbf;
  final String? exp;
  final String? statement;
  final String? requestId;
  final List<String>? resources;
  final int? expiry;

  AuthRequestParams({
    required this.chainId,
    required this.domain,
    required this.aud,
    String? nonce,
    this.type = CacaoHeader.EIP4361,
    this.nbf,
    this.exp,
    this.statement,
    this.requestId,
    this.resources,
    this.expiry,
  }) : nonce = nonce ?? AuthUtils.generateNonce();
}

@freezed
class AuthPayloadParams with _$AuthPayloadParams {
  @JsonSerializable(includeIfNull: false)
  const factory AuthPayloadParams({
    required String type,
    required String chainId,
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
  }) = _AuthPayloadParams;

  factory AuthPayloadParams.fromRequestParams(AuthRequestParams params) {
    return AuthPayloadParams(
      type: params.type ?? CacaoHeader.EIP4361,
      chainId: params.chainId,
      domain: params.domain,
      aud: params.aud,
      version: '1',
      nonce: params.nonce,
      iat: DateTime.now().toIso8601String(),
      nbf: params.nbf,
      exp: params.exp,
      statement: params.statement,
      requestId: params.requestId,
      resources: params.resources,
    );
  }

  factory AuthPayloadParams.fromJson(Map<String, dynamic> json) =>
      _$AuthPayloadParamsFromJson(json);
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

@freezed
class PendingAuthRequest with _$PendingAuthRequest {
  @JsonSerializable(includeIfNull: false)
  const factory PendingAuthRequest({
    required int id,
    required String pairingTopic,
    required ConnectionMetadata metadata,
    required CacaoRequestPayload cacaoPayload,
  }) = _PendingAuthRequest;

  factory PendingAuthRequest.fromJson(Map<String, dynamic> json) =>
      _$PendingAuthRequestFromJson(json);
}

class AuthRequestCompleter {
  final int id;
  final String pairingTopic;
  final String responseTopic;
  final PendingAuthRequest request;
  final Completer<Cacao> completer;

  AuthRequestCompleter({
    required this.id,
    required this.pairingTopic,
    required this.responseTopic,
    required this.request,
    required this.completer,
  });
}

class RespondParams {
  final int id;
  final CacaoSignature? signature;
  final WalletConnectError? error;

  RespondParams({
    required this.id,
    this.signature,
    this.error,
  });
}

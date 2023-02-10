import 'package:json_annotation/json_annotation.dart';
import 'package:wallet_connect_flutter_v2/apis/models/basic_models.dart';
import 'package:wallet_connect_flutter_v2/apis/signing_api/models/sign_client_models.dart';

part 'auth_client_models.g.dart';

class AuthRequestResponse {
  final int id;
  final Uri uri;

  AuthRequestResponse({
    required this.id,
    required this.uri,
  });
}

@JsonSerializable(includeIfNull: false)
class AuthPublicKey {
  final String publicKey;

  AuthPublicKey({
    required this.publicKey,
  });

  factory AuthPublicKey.fromJson(Map<String, dynamic> json) => _$AuthPublicKeyFromJson(json);

  Map<String, dynamic> toJson() => _$AuthPublicKeyToJson(this);
}

class AuthRequestParams {
  final String chainId;
  final String domain;
  final String nonce;
  final String aud;
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
    required this.nonce,
    required this.aud,
    this.type,
    this.nbf,
    this.exp,
    this.statement,
    this.requestId,
    this.resources,
    this.expiry,
  });
}

@JsonSerializable(includeIfNull: false)
class AuthPayloadParams {
  final String type;
  final String chainId;
  final String domain;
  final String aud;
  final String version;
  final String nonce;
  final String iat;
  final String? nbf;
  final String? exp;
  final String? statement;
  final String? requestId;
  final List<String>? resources;

  const AuthPayloadParams({
    required this.type,
    required this.chainId,
    required this.domain,
    required this.aud,
    required this.version,
    required this.nonce,
    required this.iat,
    this.nbf,
    this.exp,
    this.statement,
    this.requestId,
    this.resources,
  });

  factory AuthPayloadParams.fromJson(Map<String, dynamic> json) => _$PayloadParamsFromJson(json);

  Map<String, dynamic> toJson() => _$PayloadParamsToJson(this);
}

@JsonSerializable(includeIfNull: false)
class CacaoRequestPayload {
  final String domain;
  final String aud;
  final String version;
  final String nonce;
  final String iat;
  final String? nbf;
  final String? exp;
  final String? statement;
  final String? requestId;
  final List<String>? resources;

  const CacaoRequestPayload({
    required this.domain,
    required this.aud,
    required this.version,
    required this.nonce,
    required this.iat,
    this.nbf,
    this.exp,
    this.statement,
    this.requestId,
    this.resources,
  });

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

  factory CacaoRequestPayload.fromJson(Map<String, dynamic> json) => _$CacaoRequestPayloadFromJson(json);

  Map<String, dynamic> toJson() => _$CacaoRequestPayloadToJson(this);
}

@JsonSerializable(includeIfNull: false)
class CacaoPayload extends CacaoRequestPayload {
  final String iss;

  const CacaoPayload({
    required this.iss,
    required domain,
    required aud,
    required version,
    required nonce,
    required iat,
    nbf,
    exp,
    statement,
    requestId,
    resources,
  }) : super(
          domain: domain,
          aud: aud,
          version: version,
          nonce: nonce,
          iat: iat,
          nbf: nbf,
          exp: exp,
          statement: statement,
          requestId: requestId,
          resources: resources,
        );

  factory CacaoPayload.fromJson(Map<String, dynamic> json) => _$CacaoPayloadFromJson(json);

  Map<String, dynamic> toJson() => _$CacaoPayloadToJson(this);
}

@JsonSerializable(includeIfNull: false)
class CacaoHeader {
  static const EIP4361 = 'eip4361';

  final String t;

  CacaoHeader({
    this.t = 'eip4361',
  });

  factory CacaoHeader.fromJson(Map<String, dynamic> json) => _$CacaoHeaderFromJson(json);

  Map<String, dynamic> toJson() => _$CacaoHeaderToJson(this);
}

@JsonSerializable(includeIfNull: false)
class CacaoSignature {
  static const EIP191 = 'eip191';
  static const EIP1271 = 'eip1271';

  final String t;
  final String s;
  final String? m;

  CacaoSignature({
    required this.t,
    required this.s,
    this.m,
  });

  factory CacaoSignature.fromJson(Map<String, dynamic> json) => _$CacaoSignatureFromJson(json);

  Map<String, dynamic> toJson() => _$CacaoSignatureToJson(this);
}

@JsonSerializable(includeIfNull: false)
class Cacao {
  CacaoHeader h;
  CacaoPayload p;
  CacaoSignature s;

  Cacao({
    required this.h,
    required this.p,
    required this.s,
  });

  factory Cacao.fromJson(Map<String, dynamic> json) => _$CacaoFromJson(json);

  Map<String, dynamic> toJson() => _$CacaoToJson(this);
}

@JsonSerializable(includeIfNull: false)
class StoredCacao extends Cacao {
  final String id;

  StoredCacao({
    required this.id,
    required CacaoHeader h,
    required CacaoPayload p,
    required CacaoSignature s,
  }) : super(h: h, p: p, s: s);

  factory StoredCacao.fromJson(Map<String, dynamic> json) => _$StoredCacaoFromJson(json);

  Map<String, dynamic> toJson() => _$StoredCacaoToJson(this);
}

@JsonSerializable(includeIfNull: false)
class PendingRequest {
  final int id;
  final ConnectionMetadata metadata;
  final CacaoRequestPayload cacaoPayload;

  PendingRequest({
    required this.id,
    required this.metadata,
    required this.cacaoPayload,
  });

  factory PendingRequest.fromJson(Map<String, dynamic> json) => _$PendingRequestFromJson(json);

  Map<String, dynamic> toJson() => _$PendingRequestToJson(this);
}

class RespondParams {
  final int id;
  final CacaoSignature? signature;
  final WCErrorResponse? error;

  RespondParams({
    required this.id,
    this.signature,
    this.error,
  });
}

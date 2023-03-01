import 'dart:async';

import 'package:json_annotation/json_annotation.dart';
import 'package:walletconnect_flutter_v2/apis/auth_api/models/auth_client_events.dart';
import 'package:walletconnect_flutter_v2/apis/auth_api/utils/auth_utils.dart';
import 'package:walletconnect_flutter_v2/apis/models/basic_models.dart';

part 'auth_client_models.g.dart';

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

@JsonSerializable(includeIfNull: false)
class AuthPublicKey {
  final String publicKey;

  AuthPublicKey({
    required this.publicKey,
  });

  factory AuthPublicKey.fromJson(Map<String, dynamic> json) =>
      _$AuthPublicKeyFromJson(json);

  Map<String, dynamic> toJson() => _$AuthPublicKeyToJson(this);
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

  Map<String, dynamic> toJson() => _$AuthPayloadParamsToJson(this);
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

  factory CacaoRequestPayload.fromJson(Map<String, dynamic> json) =>
      _$CacaoRequestPayloadFromJson(json);

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

  Map<String, dynamic> toJson() => _$CacaoPayloadToJson(this);
}

@JsonSerializable(includeIfNull: false)
class CacaoHeader {
  static const EIP4361 = 'eip4361';

  final String t;

  CacaoHeader({
    this.t = 'eip4361',
  });

  factory CacaoHeader.fromJson(Map<String, dynamic> json) =>
      _$CacaoHeaderFromJson(json);

  Map<String, dynamic> toJson() => _$CacaoHeaderToJson(this);
}

@JsonSerializable(includeIfNull: false)
class CacaoSignature {
  static const EIP191 = 'eip191';
  static const EIP1271 = 'eip1271';

  final String t;
  final String s;
  final String? m;

  const CacaoSignature({
    required this.t,
    required this.s,
    this.m,
  });

  factory CacaoSignature.fromJson(Map<String, dynamic> json) =>
      _$CacaoSignatureFromJson(json);

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
  final int id;
  final String pairingTopic;

  StoredCacao({
    required this.id,
    required this.pairingTopic,
    required CacaoHeader h,
    required CacaoPayload p,
    required CacaoSignature s,
  }) : super(h: h, p: p, s: s);

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

  Map<String, dynamic> toJson() => _$StoredCacaoToJson(this);
}

@JsonSerializable(includeIfNull: false)
class PendingAuthRequest {
  final int id;
  final String pairingTopic;
  final ConnectionMetadata metadata;
  final CacaoRequestPayload cacaoPayload;

  PendingAuthRequest({
    required this.id,
    required this.pairingTopic,
    required this.metadata,
    required this.cacaoPayload,
  });

  factory PendingAuthRequest.fromJson(Map<String, dynamic> json) =>
      _$PendingAuthRequestFromJson(json);

  Map<String, dynamic> toJson() => _$PendingAuthRequestToJson(this);
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

import 'dart:async';

import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:walletconnect_flutter_v2/apis/models/basic_models.dart';
import 'package:walletconnect_flutter_v2/apis/sign_api/models/auth/auth_client_events.dart';
import 'package:walletconnect_flutter_v2/apis/sign_api/models/auth/common_auth_models.dart';
import 'package:walletconnect_flutter_v2/apis/sign_api/utils/auth/auth_utils.dart';

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

class AuthRequestParams {
  /// The Chain ID.
  /// Examples: eip155:1 (Eth Mainnet), eip155:43114 (Avalanche)
  final String chainId;

  /// The complete URL you are logging into.
  /// Example: https://example.com/login
  final String aud;

  /// The domain you are logging in to.
  /// Example: example.com
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

  Map<String, dynamic> toJson() => {
        'chainId': chainId,
        'aud': aud,
        'domain': domain,
        'nonce': nonce,
        if (type != null) 'type': type,
        if (nbf != null) 'nbf': nbf,
        if (exp != null) 'exp': exp,
        if (statement != null) 'statement': statement,
        if (requestId != null) 'requestId': requestId,
        if (resources != null) 'resources': resources,
        if (expiry != null) 'expiry': expiry,
      };
}

@freezed
class AuthPayloadParams with _$AuthPayloadParams {
  @JsonSerializable(includeIfNull: false)
  const factory AuthPayloadParams({
    required String chainId,
    required String aud,
    required String domain,
    required String nonce,
    required String type,
    //
    required String version,
    required String iat,
    //
    String? nbf,
    String? exp,
    String? statement,
    String? requestId,
    List<String>? resources,
  }) = _AuthPayloadParams;

  factory AuthPayloadParams.fromRequestParams(AuthRequestParams params) {
    final now = DateTime.now();
    return AuthPayloadParams(
      type: params.type ?? CacaoHeader.EIP4361,
      chainId: params.chainId,
      domain: params.domain,
      aud: params.aud,
      version: '1',
      nonce: params.nonce,
      iat: DateTime.utc(
        now.year,
        now.month,
        now.day,
        now.hour,
        now.minute,
        now.second,
        now.millisecond,
      ).toIso8601String(),
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

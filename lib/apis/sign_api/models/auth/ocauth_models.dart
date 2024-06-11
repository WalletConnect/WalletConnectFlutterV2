import 'dart:async';

import 'package:freezed_annotation/freezed_annotation.dart';

import 'package:walletconnect_flutter_v2/apis/sign_api/models/auth/common_auth_models.dart';
import 'package:walletconnect_flutter_v2/apis/sign_api/models/auth/ocauth_events.dart';

part 'ocauth_models.g.dart';
part 'ocauth_models.freezed.dart';

// TODO this should be under sign_client_models.dart probably
class OCARequestResponse {
  final int id;
  final String pairingTopic;
  final Completer<OCAuthResponse> completer;
  final Uri? uri;

  OCARequestResponse({
    required this.id,
    required this.pairingTopic,
    required this.completer,
    this.uri,
  });
}

class OCARequestParams {
  final List<String> chains;
  final String domain;
  final String nonce;
  final String uri;
  //
  final CacaoHeader? type;
  final String? nbf;
  final String? exp;
  final String? statement;
  final String? requestId;
  final List<String>? resources;
  final int? expiry;
  final List<String>? methods;
  //

  OCARequestParams({
    required this.chains,
    required this.domain,
    required this.nonce,
    required this.uri,
    this.type,
    this.nbf,
    this.exp,
    this.statement,
    this.requestId,
    this.resources,
    this.expiry,
    this.methods = const <String>[],
  });

  Map<String, dynamic> toJson() => {
        'chains': chains,
        'domain': domain,
        'nonce': nonce,
        'uri': uri,
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
class OCAPayloadParams with _$OCAPayloadParams {
  @JsonSerializable(includeIfNull: false)
  const factory OCAPayloadParams({
    required List<String> chains,
    required String domain,
    required String nonce,
    required String aud,
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
  }) = _OCAPayloadParams;

  factory OCAPayloadParams.fromRequestParams(OCARequestParams params) {
    return OCAPayloadParams(
      chains: params.chains,
      domain: params.domain,
      nonce: params.nonce,
      aud: params.uri,
      type: params.type?.t ?? 'eip4361',
      version: '1',
      iat: DateTime.now().toIso8601String(),
      //
      nbf: params.nbf,
      exp: params.exp,
      statement: params.statement,
      requestId: params.requestId,
      resources: params.resources,
    );
  }

  factory OCAPayloadParams.fromJson(Map<String, dynamic> json) =>
      _$OCAPayloadParamsFromJson(json);
}

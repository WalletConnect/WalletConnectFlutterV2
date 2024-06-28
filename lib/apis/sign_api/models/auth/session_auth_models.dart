import 'dart:async';

import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:walletconnect_flutter_v2/apis/core/verify/models/verify_context.dart';
import 'package:walletconnect_flutter_v2/apis/models/basic_models.dart';

import 'package:walletconnect_flutter_v2/apis/sign_api/models/auth/common_auth_models.dart';
import 'package:walletconnect_flutter_v2/apis/sign_api/models/auth/session_auth_events.dart';

part 'session_auth_models.g.dart';
part 'session_auth_models.freezed.dart';

// TODO this should be under sign_client_models.dart probably
class SessionAuthRequestResponse {
  final int id;
  final String pairingTopic;
  final Completer<SessionAuthResponse> completer;
  final Uri? uri;

  SessionAuthRequestResponse({
    required this.id,
    required this.pairingTopic,
    required this.completer,
    this.uri,
  });
}

@freezed
class SessionAuthRequestParams with _$SessionAuthRequestParams {
  @JsonSerializable(includeIfNull: false)
  const factory SessionAuthRequestParams({
    required List<String> chains,
    required String domain,
    required String nonce,
    required String uri,
    //
    CacaoHeader? type,
    String? nbf,
    String? exp,
    String? statement,
    String? requestId,
    List<String>? resources,
    int? expiry,
    @Default(<String>[]) List<String>? methods,
  }) = _SessionAuthRequestParams;
  //
  factory SessionAuthRequestParams.fromJson(Map<String, dynamic> json) =>
      _$SessionAuthRequestParamsFromJson(json);
}

@freezed
class SessionAuthPayload with _$SessionAuthPayload {
  @JsonSerializable(includeIfNull: false)
  const factory SessionAuthPayload({
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
  }) = _SessionAuthPayload;

  factory SessionAuthPayload.fromRequestParams(
    SessionAuthRequestParams params,
  ) {
    final now = DateTime.now();
    return SessionAuthPayload(
      chains: params.chains,
      domain: params.domain,
      nonce: params.nonce,
      aud: params.uri,
      type: params.type?.t ?? 'eip4361',
      version: '1',
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

  factory SessionAuthPayload.fromJson(Map<String, dynamic> json) =>
      _$SessionAuthPayloadFromJson(json);
}

@freezed
class PendingSessionAuthRequest with _$PendingSessionAuthRequest {
  @JsonSerializable(includeIfNull: false)
  const factory PendingSessionAuthRequest({
    required int id,
    required String pairingTopic,
    required ConnectionMetadata requester,
    required int expiryTimestamp,
    required CacaoRequestPayload authPayload,
    required VerifyContext verifyContext,
  }) = _PendingSessionAuthRequest;

  factory PendingSessionAuthRequest.fromJson(Map<String, dynamic> json) =>
      _$PendingSessionAuthRequestFromJson(json);
}

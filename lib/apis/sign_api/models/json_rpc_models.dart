import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:walletconnect_flutter_v2/apis/core/relay_client/relay_client_models.dart';
import 'package:walletconnect_flutter_v2/apis/models/basic_models.dart';
import 'package:walletconnect_flutter_v2/apis/sign_api/models/proposal_models.dart';
import 'package:walletconnect_flutter_v2/apis/sign_api/models/session_models.dart';

part 'json_rpc_models.g.dart';
part 'json_rpc_models.freezed.dart';

@freezed
class WcPairingDeleteRequest with _$WcPairingDeleteRequest {
  @JsonSerializable()
  const factory WcPairingDeleteRequest({
    required int code,
    required String message,
  }) = _WcPairingDeleteRequest;

  factory WcPairingDeleteRequest.fromJson(Map<String, dynamic> json) =>
      _$WcPairingDeleteRequestFromJson(json);
}

@freezed
class WcPairingPingRequest with _$WcPairingPingRequest {
  @JsonSerializable()
  const factory WcPairingPingRequest({
    required Map<String, dynamic> data,
  }) = _WcPairingPingRequest;

  factory WcPairingPingRequest.fromJson(Map<String, dynamic> json) =>
      _$WcPairingPingRequestFromJson(json);
}

@freezed
class WcSessionProposeRequest with _$WcSessionProposeRequest {
  @JsonSerializable(includeIfNull: false)
  const factory WcSessionProposeRequest({
    required List<Relay> relays,
    required Map<String, RequiredNamespace> requiredNamespaces,
    Map<String, RequiredNamespace>? optionalNamespaces,
    Map<String, String>? sessionProperties,
    required ConnectionMetadata proposer,
  }) = _WcSessionProposeRequest;

  factory WcSessionProposeRequest.fromJson(Map<String, dynamic> json) =>
      _$WcSessionProposeRequestFromJson(json);
}

@freezed
class WcSessionProposeResponse with _$WcSessionProposeResponse {
  @JsonSerializable()
  const factory WcSessionProposeResponse({
    required Relay relay,
    required String responderPublicKey,
  }) = _WcSessionProposeResponse;

  factory WcSessionProposeResponse.fromJson(Map<String, dynamic> json) =>
      _$WcSessionProposeResponseFromJson(json);
}

@freezed
class WcSessionSettleRequest with _$WcSessionSettleRequest {
  @JsonSerializable(includeIfNull: false)
  const factory WcSessionSettleRequest({
    required Relay relay,
    required Map<String, Namespace> namespaces,
    Map<String, RequiredNamespace>? requiredNamespaces,
    Map<String, RequiredNamespace>? optionalNamespaces,
    Map<String, String>? sessionProperties,
    required int expiry,
    required ConnectionMetadata controller,
  }) = _WcSessionSettleRequest;

  factory WcSessionSettleRequest.fromJson(Map<String, dynamic> json) =>
      _$WcSessionSettleRequestFromJson(json);
}

@freezed
class WcSessionUpdateRequest with _$WcSessionUpdateRequest {
  @JsonSerializable()
  const factory WcSessionUpdateRequest({
    required Map<String, Namespace> namespaces,
  }) = _WcSessionUpdateRequest;

  factory WcSessionUpdateRequest.fromJson(Map<String, dynamic> json) =>
      _$WcSessionUpdateRequestFromJson(json);
}

@freezed
class WcSessionExtendRequest with _$WcSessionExtendRequest {
  @JsonSerializable(includeIfNull: false)
  const factory WcSessionExtendRequest({
    Map<String, dynamic>? data,
  }) = _WcSessionExtendRequest;

  factory WcSessionExtendRequest.fromJson(Map<String, dynamic> json) =>
      _$WcSessionExtendRequestFromJson(json);
}

@freezed
class WcSessionDeleteRequest with _$WcSessionDeleteRequest {
  @JsonSerializable(includeIfNull: false)
  const factory WcSessionDeleteRequest({
    required int code,
    required String message,
    String? data,
  }) = _WcSessionDeleteRequest;

  factory WcSessionDeleteRequest.fromJson(Map<String, dynamic> json) =>
      _$WcSessionDeleteRequestFromJson(json);
}

@freezed
class WcSessionPingRequest with _$WcSessionPingRequest {
  @JsonSerializable(includeIfNull: false)
  const factory WcSessionPingRequest({
    Map<String, dynamic>? data,
  }) = _WcSessionPingRequest;

  factory WcSessionPingRequest.fromJson(Map<String, dynamic> json) =>
      _$WcSessionPingRequestFromJson(json);
}

@freezed
class WcSessionRequestRequest with _$WcSessionRequestRequest {
  @JsonSerializable()
  const factory WcSessionRequestRequest({
    required String chainId,
    required SessionRequestParams request,
  }) = _WcSessionRequestRequest;

  factory WcSessionRequestRequest.fromJson(Map<String, dynamic> json) =>
      _$WcSessionRequestRequestFromJson(json);
}

@freezed
class SessionRequestParams with _$SessionRequestParams {
  @JsonSerializable()
  const factory SessionRequestParams({
    required String method,
    required dynamic params,
  }) = _SessionRequestParams;

  factory SessionRequestParams.fromJson(Map<String, dynamic> json) =>
      _$SessionRequestParamsFromJson(json);
}

@freezed
class WcSessionEventRequest with _$WcSessionEventRequest {
  @JsonSerializable()
  const factory WcSessionEventRequest({
    required String chainId,
    required SessionEventParams event,
  }) = _WcSessionEventRequest;

  factory WcSessionEventRequest.fromJson(Map<String, dynamic> json) =>
      _$WcSessionEventRequestFromJson(json);
}

@freezed
class SessionEventParams with _$SessionEventParams {
  @JsonSerializable()
  const factory SessionEventParams({
    required String name,
    required dynamic data,
  }) = _SessionEventParams;

  factory SessionEventParams.fromJson(Map<String, dynamic> json) =>
      _$SessionEventParamsFromJson(json);
}

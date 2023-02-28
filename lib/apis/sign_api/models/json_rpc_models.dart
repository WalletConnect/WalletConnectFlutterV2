import 'package:json_annotation/json_annotation.dart';
import 'package:walletconnect_flutter_v2/apis/core/relay_client/relay_client_models.dart';
import 'package:walletconnect_flutter_v2/apis/models/basic_models.dart';
import 'package:walletconnect_flutter_v2/apis/sign_api/models/proposal_models.dart';
import 'package:walletconnect_flutter_v2/apis/sign_api/models/session_models.dart';

part 'json_rpc_models.g.dart';

@JsonSerializable()
class WcPairingDeleteRequest {
  final int code;
  final String message;

  WcPairingDeleteRequest({required this.code, required this.message});

  factory WcPairingDeleteRequest.fromJson(Map<String, dynamic> json) =>
      _$WcPairingDeleteRequestFromJson(json);

  Map<String, dynamic> toJson() => _$WcPairingDeleteRequestToJson(this);
}

@JsonSerializable()
class WcPairingPingRequest {
  final Map<String, dynamic> data;

  WcPairingPingRequest({required this.data});

  factory WcPairingPingRequest.fromJson(Map<String, dynamic> json) =>
      _$WcPairingPingRequestFromJson(json);

  Map<String, dynamic> toJson() => _$WcPairingPingRequestToJson(this);
}

@JsonSerializable(includeIfNull: false)
class WcSessionProposeRequest {
  final List<Relay> relays;
  final Map<String, RequiredNamespace> requiredNamespaces;
  final Map<String, RequiredNamespace>? optionalNamespaces;
  final Map<String, String>? sessionProperties;
  final ConnectionMetadata proposer;

  WcSessionProposeRequest({
    required this.relays,
    required this.requiredNamespaces,
    required this.optionalNamespaces,
    required this.proposer,
    this.sessionProperties,
  });

  factory WcSessionProposeRequest.fromJson(Map<String, dynamic> json) =>
      _$WcSessionProposeRequestFromJson(json);

  Map<String, dynamic> toJson() => _$WcSessionProposeRequestToJson(this);
}

@JsonSerializable()
class WcSessionProposeResponse {
  Relay relay;
  String responderPublicKey;

  WcSessionProposeResponse({
    required this.relay,
    required this.responderPublicKey,
  });

  factory WcSessionProposeResponse.fromJson(Map<String, dynamic> json) =>
      _$WcSessionProposeResponseFromJson(json);

  Map<String, dynamic> toJson() => _$WcSessionProposeResponseToJson(this);
}

@JsonSerializable(includeIfNull: false)
class WcSessionSettleRequest {
  final Relay relay;
  final Map<String, Namespace> namespaces;
  final Map<String, RequiredNamespace>? requiredNamespaces;
  final Map<String, RequiredNamespace>? optionalNamespaces;
  final Map<String, String>? sessionProperties;
  final int expiry;
  final ConnectionMetadata controller;

  WcSessionSettleRequest({
    required this.relay,
    required this.namespaces,
    required this.requiredNamespaces,
    required this.optionalNamespaces,
    this.sessionProperties,
    required this.expiry,
    required this.controller,
  });

  factory WcSessionSettleRequest.fromJson(Map<String, dynamic> json) =>
      _$WcSessionSettleRequestFromJson(json);

  Map<String, dynamic> toJson() => _$WcSessionSettleRequestToJson(this);
}

@JsonSerializable()
class WcSessionUpdateRequest {
  final Map<String, Namespace> namespaces;

  WcSessionUpdateRequest({required this.namespaces});

  factory WcSessionUpdateRequest.fromJson(Map<String, dynamic> json) =>
      _$WcSessionUpdateRequestFromJson(json);

  Map<String, dynamic> toJson() => _$WcSessionUpdateRequestToJson(this);
}

@JsonSerializable(includeIfNull: false)
class WcSessionExtendRequest {
  final Map<String, dynamic>? data;

  WcSessionExtendRequest({this.data});

  factory WcSessionExtendRequest.fromJson(Map<String, dynamic> json) =>
      _$WcSessionExtendRequestFromJson(json);

  Map<String, dynamic> toJson() => _$WcSessionExtendRequestToJson(this);
}

@JsonSerializable(includeIfNull: false)
class WcSessionDeleteRequest {
  final int code;
  final String message;
  final String? data;

  WcSessionDeleteRequest({
    required this.code,
    required this.message,
    this.data,
  });

  factory WcSessionDeleteRequest.fromJson(Map<String, dynamic> json) =>
      _$WcSessionDeleteRequestFromJson(json);

  Map<String, dynamic> toJson() => _$WcSessionDeleteRequestToJson(this);
}

@JsonSerializable(includeIfNull: false)
class WcSessionPingRequest {
  final Map<String, dynamic>? data;

  WcSessionPingRequest({required this.data});

  factory WcSessionPingRequest.fromJson(Map<String, dynamic> json) =>
      _$WcSessionPingRequestFromJson(json);

  Map<String, dynamic> toJson() => _$WcSessionPingRequestToJson(this);
}

@JsonSerializable()
class WcSessionRequestRequest {
  final String chainId;
  final SessionRequestParams request;

  WcSessionRequestRequest({
    required this.chainId,
    required this.request,
  });

  factory WcSessionRequestRequest.fromJson(Map<String, dynamic> json) =>
      _$WcSessionRequestRequestFromJson(json);

  Map<String, dynamic> toJson() => _$WcSessionRequestRequestToJson(this);
}

@JsonSerializable()
class SessionRequestParams {
  final String method;
  final dynamic params;

  SessionRequestParams({
    required this.method,
    required this.params,
  });

  factory SessionRequestParams.fromJson(Map<String, dynamic> json) =>
      _$SessionRequestParamsFromJson(json);

  Map<String, dynamic> toJson() => _$SessionRequestParamsToJson(this);
}

@JsonSerializable()
class WcSessionEventRequest {
  final String chainId;
  final SessionEventParams event;

  WcSessionEventRequest({
    required this.chainId,
    required this.event,
  });

  factory WcSessionEventRequest.fromJson(Map<String, dynamic> json) =>
      _$WcSessionEventRequestFromJson(json);

  Map<String, dynamic> toJson() => _$WcSessionEventRequestToJson(this);
}

@JsonSerializable()
class SessionEventParams {
  final String name;
  final dynamic data;

  SessionEventParams({
    required this.name,
    required this.data,
  });

  factory SessionEventParams.fromJson(Map<String, dynamic> json) =>
      _$SessionEventParamsFromJson(json);

  Map<String, dynamic> toJson() => _$SessionEventParamsToJson(this);
}

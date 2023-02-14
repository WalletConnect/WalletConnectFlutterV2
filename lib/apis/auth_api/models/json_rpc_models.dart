import 'package:json_annotation/json_annotation.dart';
import 'package:walletconnect_dart_v2/apis/auth_api/models/auth_client_models.dart';
import 'package:walletconnect_dart_v2/apis/models/basic_models.dart';

part 'json_rpc_models.g.dart';

@JsonSerializable()
class WcAuthRequestRequest {
  final AuthPayloadParams payloadParams;
  final ConnectionMetadata requester;

  WcAuthRequestRequest({
    required this.payloadParams,
    required this.requester,
  });

  factory WcAuthRequestRequest.fromJson(Map<String, dynamic> json) =>
      _$WcAuthRequestRequestFromJson(json);

  Map<String, dynamic> toJson() => _$WcAuthRequestRequestToJson(this);
}

@JsonSerializable()
class WcAuthRequestResult {
  final Cacao cacao;

  WcAuthRequestResult({
    required this.cacao,
  });

  factory WcAuthRequestResult.fromJson(Map<String, dynamic> json) =>
      _$WcAuthRequestResultFromJson(json);

  Map<String, dynamic> toJson() => _$WcAuthRequestResultToJson(this);
}

import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:walletconnect_flutter_v2/apis/auth_api/models/auth_client_models.dart';
import 'package:walletconnect_flutter_v2/apis/models/basic_models.dart';

part 'json_rpc_models.g.dart';
part 'json_rpc_models.freezed.dart';

@freezed
class WcAuthRequestRequest with _$WcAuthRequestRequest {
  @JsonSerializable()
  const factory WcAuthRequestRequest({
    required AuthPayloadParams payloadParams,
    required ConnectionMetadata requester,
  }) = _WcAuthRequestRequest;

  factory WcAuthRequestRequest.fromJson(Map<String, dynamic> json) =>
      _$WcAuthRequestRequestFromJson(json);
}

@freezed
class WcAuthRequestResult with _$WcAuthRequestResult {
  @JsonSerializable()
  const factory WcAuthRequestResult({
    required Cacao cacao,
  }) = _WcAuthRequestResult;

  factory WcAuthRequestResult.fromJson(Map<String, dynamic> json) =>
      _$WcAuthRequestResultFromJson(json);
}

import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:walletconnect_flutter_v2/apis/models/basic_models.dart';
import 'package:walletconnect_flutter_v2/apis/sign_api/models/auth/auth_client_models.dart';
import 'package:walletconnect_flutter_v2/apis/sign_api/models/auth/auth_common_models.dart';
import 'package:walletconnect_flutter_v2/apis/sign_api/models/auth/one_click_auth_models.dart';

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

@freezed
// TODO should be renamed to WcOCARequestParams
class WcOCARequestRequest with _$WcOCARequestRequest {
  @JsonSerializable()
  const factory WcOCARequestRequest({
    required OCAPayloadParams authPayload,
    required ConnectionMetadata requester,
    required int expiryTimestamp,
  }) = _WcOCARequestRequest;

  factory WcOCARequestRequest.fromJson(Map<String, dynamic> json) =>
      _$WcOCARequestRequestFromJson(json);
}

@freezed
class WcOCARequestResult with _$WcOCARequestResult {
  @JsonSerializable()
  const factory WcOCARequestResult({
    required List<Cacao> cacaos,
    required ConnectionMetadata responder,
  }) = _WcOCARequestResult;

  factory WcOCARequestResult.fromJson(Map<String, dynamic> json) =>
      _$WcOCARequestResultFromJson(json);
}

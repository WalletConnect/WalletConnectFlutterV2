import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:walletconnect_flutter_v2/apis/core/pairing/utils/pairing_models.dart';

part 'basic_models.g.dart';
part 'basic_models.freezed.dart';

/// ERRORS

class WalletConnectErrorSilent {}

@freezed
class WalletConnectError with _$WalletConnectError {
  // @JsonSerializable(includeIfNull: false)
  const factory WalletConnectError({
    required int code,
    required String message,
    String? data,
  }) = _WalletConnectError;

  factory WalletConnectError.fromJson(Map<String, dynamic> json) =>
      _$WalletConnectErrorFromJson(json);
}

@freezed
class RpcOptions with _$RpcOptions {
  // @JsonSerializable()
  const factory RpcOptions({
    required int ttl,
    required bool prompt,
    required int tag,
  }) = _RpcOptions;
}

@freezed
class ConnectionMetadata with _$ConnectionMetadata {
  // @JsonSerializable()
  const factory ConnectionMetadata({
    required String publicKey,
    required PairingMetadata metadata,
  }) = _ConnectionMetadata;

  factory ConnectionMetadata.fromJson(Map<String, dynamic> json) =>
      _$ConnectionMetadataFromJson(json);
}

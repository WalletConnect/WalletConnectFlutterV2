import 'package:json_annotation/json_annotation.dart';
import 'package:walletconnect_flutter_v2/apis/core/pairing/utils/pairing_models.dart';

part 'basic_models.g.dart';

/// ERRORS

class WalletConnectErrorSilent {}

@JsonSerializable(includeIfNull: false)
class WalletConnectError {
  int code;
  String message;
  String? data;

  WalletConnectError({
    required this.code,
    required this.message,
    this.data,
  });

  WalletConnectError copyWith({
    int? code,
    String? message,
    String? data,
  }) {
    return WalletConnectError(
      code: code ?? this.code,
      message: message ?? this.message,
      data: data ?? this.data,
    );
  }

  factory WalletConnectError.fromJson(Map<String, dynamic> json) =>
      _$WalletConnectErrorFromJson(json);

  Map<String, dynamic> toJson() => _$WalletConnectErrorToJson(this);

  @override
  String toString() {
    return 'WalletConnectError(code: $code, message: $message, data: $data)';
  }
}

class RpcOptions {
  final int ttl;
  final bool prompt;
  final int tag;

  const RpcOptions(
    this.ttl,
    this.prompt,
    this.tag,
  );

  RpcOptions copyWith({
    int? ttl,
    bool? prompt,
    int? tag,
  }) {
    return RpcOptions(
      ttl ?? this.ttl,
      prompt ?? this.prompt,
      tag ?? this.tag,
    );
  }

  @override
  String toString() {
    return 'RpcOptions(ttl: $ttl, prompt: $prompt, tag: $tag)';
  }
}

@JsonSerializable()
class ConnectionMetadata {
  final String publicKey;
  final PairingMetadata metadata;

  const ConnectionMetadata({
    required this.publicKey,
    required this.metadata,
  });

  factory ConnectionMetadata.fromJson(Map<String, dynamic> json) =>
      _$ConnectionMetadataFromJson(json);

  Map<String, dynamic> toJson() => _$ConnectionMetadataToJson(this);

  @override
  bool operator ==(Object other) {
    return other is ConnectionMetadata && hashCode == other.hashCode;
  }

  @override
  int get hashCode => publicKey.hashCode + metadata.hashCode;

  @override
  String toString() {
    return 'ConnectionMetadata(publicKey: $publicKey, metadata: $metadata)';
  }
}

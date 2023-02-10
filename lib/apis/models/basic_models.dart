import 'package:json_annotation/json_annotation.dart';
import 'package:wallet_connect_flutter_v2/apis/core/pairing/utils/pairing_models.dart';

part 'basic_models.g.dart';

/// ERRORS

@JsonSerializable()
class WCError {
  int code;
  String message;

  WCError({
    required this.code,
    required this.message,
  });

  factory WCError.fromJson(Map<String, dynamic> json) => _$WCErrorFromJson(json);

  Map<String, dynamic> toJson() => _$WCErrorToJson(this);
}

@JsonSerializable()
class WCErrorResponse extends WCError {
  String? data;

  WCErrorResponse({
    required super.code,
    required super.message,
    this.data,
  });

  factory WCErrorResponse.fromJson(Map<String, dynamic> json) => _$WCErrorResponseFromJson(json);

  Map<String, dynamic> toJson() => _$WCErrorResponseToJson(this);
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
}

@JsonSerializable()
class ConnectionMetadata {
  final String publicKey;
  final PairingMetadata metadata;

  const ConnectionMetadata({
    required this.publicKey,
    required this.metadata,
  });

  factory ConnectionMetadata.fromJson(Map<String, dynamic> json) => _$ConnectionMetadataFromJson(json);

  Map<String, dynamic> toJson() => _$ConnectionMetadataToJson(this);

  @override
  bool operator ==(Object other) {
    return other is ConnectionMetadata && hashCode == other.hashCode;
  }

  @override
  int get hashCode => publicKey.hashCode + metadata.hashCode;
}

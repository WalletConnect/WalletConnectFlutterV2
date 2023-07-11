import 'package:event/event.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:walletconnect_flutter_v2/apis/core/relay_client/relay_client_models.dart';
import 'package:walletconnect_flutter_v2/apis/models/json_rpc_error.dart';
import 'package:walletconnect_flutter_v2/apis/models/json_rpc_request.dart';

part 'pairing_models.g.dart';
part 'pairing_models.freezed.dart';

enum ProtocolType {
  pair,
  sign,
  auth,
}

@freezed
class PairingInfo with _$PairingInfo {
  @JsonSerializable()
  const factory PairingInfo({
    required String topic,
    required int expiry,
    required Relay relay,
    required bool active,
    PairingMetadata? peerMetadata,
  }) = _PairingInfo;

  factory PairingInfo.fromJson(Map<String, dynamic> json) =>
      _$PairingInfoFromJson(json);
}

@freezed
class PairingMetadata with _$PairingMetadata {
  @JsonSerializable(includeIfNull: false)
  const factory PairingMetadata({
    required String name,
    required String description,
    required String url,
    required List<String> icons,
    Redirect? redirect,
  }) = _PairingMetadata;

  factory PairingMetadata.empty() => const PairingMetadata(
        name: '',
        description: '',
        url: '',
        icons: [],
      );

  factory PairingMetadata.fromJson(Map<String, dynamic> json) =>
      _$PairingMetadataFromJson(json);
}

@freezed
class Redirect with _$Redirect {
  @JsonSerializable()
  const factory Redirect({
    String? native,
    String? universal,
  }) = _Redirect;

  factory Redirect.fromJson(Map<String, dynamic> json) =>
      _$RedirectFromJson(json);
}

class CreateResponse {
  String topic;
  Uri uri;
  PairingInfo pairingInfo;

  CreateResponse({
    required this.topic,
    required this.uri,
    required this.pairingInfo,
  });

  @override
  String toString() {
    return 'CreateResponse(topic: $topic, uri: $uri)';
  }
}

class ExpirationEvent extends EventArgs {
  String target;
  int expiry;

  ExpirationEvent({
    required this.target,
    required this.expiry,
  });

  @override
  String toString() {
    return 'ExpirationEvent(target: $target, expiry: $expiry)';
  }
}

class HistoryEvent extends EventArgs {
  JsonRpcRecord record;

  HistoryEvent({required this.record});

  @override
  String toString() {
    return 'HistoryEvent(record: $record)';
  }
}

class PairingInvalidEvent extends EventArgs {
  String message;

  PairingInvalidEvent({
    required this.message,
  });

  @override
  String toString() {
    return 'PairingInvalidEvent(message: $message)';
  }
}

class PairingEvent extends EventArgs {
  int? id;
  String? topic;
  JsonRpcError? error;

  PairingEvent({
    this.id,
    this.topic,
    this.error,
  });

  @override
  String toString() {
    return 'PairingEvent(id: $id, topic: $topic, error: $error)';
  }
}

class PairingActivateEvent extends EventArgs {
  String topic;
  int expiry;

  PairingActivateEvent({
    required this.topic,
    required this.expiry,
  });

  @override
  String toString() {
    return 'PairingActivateEvent(topic: $topic, expiry: $expiry)';
  }
}

@freezed
class JsonRpcRecord with _$JsonRpcRecord {
  @JsonSerializable(includeIfNull: false)
  const factory JsonRpcRecord({
    required int id,
    required String topic,
    required String method,
    required dynamic params,
    String? chainId,
    int? expiry,
    dynamic response,
  }) = _JsonRpcRecord;

  factory JsonRpcRecord.fromJson(Map<String, dynamic> json) =>
      _$JsonRpcRecordFromJson(json);
}

@freezed
class ReceiverPublicKey with _$ReceiverPublicKey {
  @JsonSerializable(includeIfNull: false)
  const factory ReceiverPublicKey({
    required String topic,
    required String publicKey,
    required int expiry,
  }) = _ReceiverPublicKey;

  factory ReceiverPublicKey.fromJson(Map<String, dynamic> json) =>
      _$ReceiverPublicKeyFromJson(json);
}

class RegisteredFunction {
  String method;
  Function(String, JsonRpcRequest) function;
  ProtocolType type;

  RegisteredFunction({
    required this.method,
    required this.function,
    required this.type,
  });

  @override
  String toString() {
    return 'RegisteredFunction(method: $method, function: $function, type: $type)';
  }
}

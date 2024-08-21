import 'dart:convert';

import 'package:event/event.dart';
import 'package:json_annotation/json_annotation.dart';

part 'relay_client_models.g.dart';

enum TransportType {
  relay,
  linkMode;

  bool get isLinkMode => this == linkMode;
}

@JsonSerializable()
class Relay {
  final String protocol;
  final String? data;

  Relay(
    this.protocol, {
    this.data,
  });

  factory Relay.fromJson(Map<String, dynamic> json) => _$RelayFromJson(json);

  Map<String, dynamic> toJson() => _$RelayToJson(this);
}

class MessageEvent extends EventArgs {
  String topic;
  String message;
  int publishedAt;
  TransportType transportType;

  MessageEvent(
    this.topic,
    this.message,
    this.publishedAt,
    this.transportType,
  );

  Map<String, dynamic> toJson() => {
        'topic': topic,
        'message': message,
        'publishedAt': publishedAt,
        'transportType': transportType.name,
      };

  @override
  String toString() => 'MessageEvent(${jsonEncode(toJson())})';
}

class ErrorEvent extends EventArgs {
  dynamic error;

  ErrorEvent(
    this.error,
  );
}

class SubscriptionEvent extends EventArgs {
  String id;

  SubscriptionEvent(
    this.id,
  );
}

class SubscriptionDeletionEvent extends SubscriptionEvent {
  String reason;

  SubscriptionDeletionEvent(
    id,
    this.reason,
  ) : super(id);
}

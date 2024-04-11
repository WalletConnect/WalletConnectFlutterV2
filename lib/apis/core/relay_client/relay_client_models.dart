import 'package:event/event.dart';
import 'package:json_annotation/json_annotation.dart';

part 'relay_client_models.g.dart';

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

  MessageEvent(
    this.topic,
    this.message,
  );

  @override
  String toString() => 'topic: $topic, message: $message';
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

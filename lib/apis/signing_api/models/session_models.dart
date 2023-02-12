import 'dart:async';

import 'package:json_annotation/json_annotation.dart';
import 'package:wallet_connect_flutter_v2/apis/core/relay_client/relay_client_models.dart';
import 'package:wallet_connect_flutter_v2/apis/models/basic_models.dart';
import 'package:wallet_connect_flutter_v2/apis/signing_api/models/proposal_models.dart';
import 'package:wallet_connect_flutter_v2/apis/signing_api/models/sign_client_models.dart';

part 'session_models.g.dart';

class SessionProposalCompleter {
  final int id;
  final String selfPublicKey;
  final String pairingTopic;
  final Map<String, RequiredNamespace> requiredNamespaces;
  final Map<String, RequiredNamespace> optionalNamespaces;
  final Map<String, String>? sessionProperties;
  final Completer completer;

  const SessionProposalCompleter({
    required this.id,
    required this.selfPublicKey,
    required this.pairingTopic,
    required this.requiredNamespaces,
    required this.optionalNamespaces,
    required this.completer,
    this.sessionProperties,
  });
}

@JsonSerializable()
class Namespace {
  final List<String> accounts;
  final List<String> methods;
  final List<String> events;

  const Namespace({
    required this.accounts,
    required this.methods,
    required this.events,
  });

  factory Namespace.fromJson(Map<String, dynamic> json) =>
      _$NamespaceFromJson(json);

  Map<String, dynamic> toJson() => _$NamespaceToJson(this);

  @override
  bool operator ==(Object other) {
    return other is Namespace && hashCode == other.hashCode;
  }

  @override
  int get hashCode =>
      accounts.fold<int>(
        0,
        (prevValue, element) => prevValue + element.hashCode,
      ) +
      methods.fold<int>(
        0,
        (prevValue, element) => prevValue + element.hashCode,
      ) +
      events.fold<int>(
        0,
        (prevValue, element) => prevValue + element.hashCode,
      );
}

@JsonSerializable()
class SessionData {
  final String topic;
  final Relay relay;
  int expiry;
  bool acknowledged;
  final String controller;
  Map<String, Namespace> namespaces;
  final Map<String, RequiredNamespace> requiredNamespaces;
  final Map<String, RequiredNamespace> optionalNamespaces;
  final Map<String, String>? sessionProperties;
  final ConnectionMetadata self;
  final ConnectionMetadata peer;

  SessionData({
    required this.topic,
    required this.relay,
    required this.expiry,
    required this.acknowledged,
    required this.controller,
    required this.namespaces,
    required this.requiredNamespaces,
    required this.optionalNamespaces,
    this.sessionProperties,
    required this.self,
    required this.peer,
  });

  factory SessionData.fromJson(Map<String, dynamic> json) =>
      _$SessionDataFromJson(json);

  Map<String, dynamic> toJson() => _$SessionDataToJson(this);
}

@JsonSerializable()
class SessionRequest {
  /// The JSON-RPC request id
  int id;
  String topic;
  String method;
  String chainId;
  dynamic params;

  SessionRequest({
    required this.id,
    required this.topic,
    required this.method,
    required this.chainId,
    required this.params,
  });

  factory SessionRequest.fromJson(Map<String, dynamic> json) =>
      _$SessionRequestFromJson(json);

  Map<String, dynamic> toJson() => _$SessionRequestToJson(this);
}

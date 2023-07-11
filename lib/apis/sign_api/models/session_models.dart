import 'dart:async';

import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:walletconnect_flutter_v2/apis/core/relay_client/relay_client_models.dart';
import 'package:walletconnect_flutter_v2/apis/models/basic_models.dart';
import 'package:walletconnect_flutter_v2/apis/sign_api/models/proposal_models.dart';

part 'session_models.g.dart';
part 'session_models.freezed.dart';

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

  @override
  String toString() {
    return 'SessionProposalCompleter(id: $id, selfPublicKey: $selfPublicKey, pairingTopic: $pairingTopic, requiredNamespaces: $requiredNamespaces, optionalNamespaces: $optionalNamespaces, sessionProperties: $sessionProperties, completer: $completer)';
  }
}

@freezed
class Namespace with _$Namespace {
  @JsonSerializable()
  const factory Namespace({
    required List<String> accounts,
    required List<String> methods,
    required List<String> events,
  }) = _Namespace;

  factory Namespace.fromJson(Map<String, dynamic> json) =>
      _$NamespaceFromJson(json);
}

@freezed
class SessionData with _$SessionData {
  @JsonSerializable(includeIfNull: false)
  const factory SessionData({
    required String topic,
    required String pairingTopic,
    required Relay relay,
    required int expiry,
    required bool acknowledged,
    required String controller,
    required Map<String, Namespace> namespaces,
    Map<String, RequiredNamespace>? requiredNamespaces,
    Map<String, RequiredNamespace>? optionalNamespaces,
    Map<String, String>? sessionProperties,
    required ConnectionMetadata self,
    required ConnectionMetadata peer,
  }) = _SessionData;

  factory SessionData.fromJson(Map<String, dynamic> json) =>
      _$SessionDataFromJson(json);
}

@freezed
class SessionRequest with _$SessionRequest {
  @JsonSerializable()
  const factory SessionRequest({
    required int id,
    required String topic,
    required String method,
    required String chainId,
    required dynamic params,
  }) = _SessionRequest;

  factory SessionRequest.fromJson(Map<String, dynamic> json) =>
      _$SessionRequestFromJson(json);
}

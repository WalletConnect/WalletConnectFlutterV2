import 'dart:async';

import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:walletconnect_flutter_v2/apis/core/relay_client/relay_client_models.dart';
import 'package:walletconnect_flutter_v2/apis/core/verify/models/verify_context.dart';
import 'package:walletconnect_flutter_v2/apis/models/basic_models.dart';
import 'package:walletconnect_flutter_v2/apis/sign_api/models/auth/common_auth_models.dart';
import 'package:walletconnect_flutter_v2/apis/sign_api/models/auth/session_auth_events.dart';
import 'package:walletconnect_flutter_v2/apis/sign_api/models/json_rpc_models.dart';
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

class SessionAuthenticateCompleter {
  final int id;
  final String pairingTopic;
  final String responseTopic;
  final String selfPublicKey;
  final String? walletUniversalLink;
  final WcSessionAuthRequestParams request;
  final Completer<SessionAuthResponse> completer;

  SessionAuthenticateCompleter({
    required this.id,
    required this.pairingTopic,
    required this.responseTopic,
    required this.selfPublicKey,
    required this.walletUniversalLink,
    required this.request,
    required this.completer,
  });
}

@freezed
class Namespace with _$Namespace {
  @JsonSerializable(includeIfNull: false)
  const factory Namespace({
    List<String>? chains,
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
    required ConnectionMetadata self,
    required ConnectionMetadata peer,
    Map<String, RequiredNamespace>? requiredNamespaces,
    Map<String, RequiredNamespace>? optionalNamespaces,
    Map<String, String>? sessionProperties,
    List<Cacao>? authentication,
    @Default(TransportType.relay) TransportType transportType,
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
    required VerifyContext verifyContext,
    @Default(TransportType.relay) TransportType transportType,
  }) = _SessionRequest;

  factory SessionRequest.fromJson(Map<String, dynamic> json) =>
      _$SessionRequestFromJson(json);
}

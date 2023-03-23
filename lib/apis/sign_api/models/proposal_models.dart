import 'package:json_annotation/json_annotation.dart';
import 'package:walletconnect_flutter_v2/apis/core/relay_client/relay_client_models.dart';
import 'package:walletconnect_flutter_v2/apis/models/basic_models.dart';
import 'package:walletconnect_flutter_v2/apis/sign_api/models/session_models.dart';

part 'proposal_models.g.dart';

@JsonSerializable(includeIfNull: false)
class RequiredNamespace {
  final List<String>? chains;
  final List<String> methods;
  final List<String> events;

  const RequiredNamespace({
    this.chains,
    required this.methods,
    required this.events,
  });

  factory RequiredNamespace.fromJson(Map<String, dynamic> json) =>
      _$RequiredNamespaceFromJson(json);

  Map<String, dynamic> toJson() => _$RequiredNamespaceToJson(this);

  @override
  String toString() {
    return 'RequiredNamespace(chains: $chains, methods: $methods, events: $events)';
  }

  @override
  bool operator ==(Object other) {
    return other is RequiredNamespace && hashCode == other.hashCode;
  }

  @override
  int get hashCode =>
      (chains == null
          ? 0
          : chains!.fold<int>(
              0,
              (previousValue, element) => previousValue + element.hashCode,
            )) +
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
class SessionProposal {
  final int id;
  final ProposalData params;

  SessionProposal({
    required this.id,
    required this.params,
  });

  factory SessionProposal.fromJson(Map<String, dynamic> json) =>
      _$SessionProposalFromJson(json);

  Map<String, dynamic> toJson() => _$SessionProposalToJson(this);
}

@JsonSerializable(includeIfNull: false)
class ProposalData {
  final int id;
  final int expiry;
  final List<Relay> relays;
  final ConnectionMetadata proposer;
  final Map<String, RequiredNamespace> requiredNamespaces;
  final Map<String, RequiredNamespace> optionalNamespaces;
  final Map<String, String>? sessionProperties;
  final String pairingTopic;
  final Map<String, Namespace>? generatedNamespaces;

  const ProposalData({
    required this.id,
    required this.expiry,
    required this.relays,
    required this.proposer,
    required this.requiredNamespaces,
    required this.optionalNamespaces,
    required this.pairingTopic,
    this.sessionProperties,
    this.generatedNamespaces,
  });

  factory ProposalData.fromJson(Map<String, dynamic> json) =>
      _$ProposalDataFromJson(json);

  Map<String, dynamic> toJson() => _$ProposalDataToJson(this);
}

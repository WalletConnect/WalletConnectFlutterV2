import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:walletconnect_flutter_v2/apis/core/relay_client/relay_client_models.dart';
import 'package:walletconnect_flutter_v2/apis/models/basic_models.dart';
import 'package:walletconnect_flutter_v2/apis/sign_api/models/session_models.dart';

part 'proposal_models.g.dart';
part 'proposal_models.freezed.dart';

@freezed
class RequiredNamespace with _$RequiredNamespace {
  @JsonSerializable(includeIfNull: false)
  const factory RequiredNamespace({
    List<String>? chains,
    required List<String> methods,
    required List<String> events,
  }) = _RequiredNamespace;

  factory RequiredNamespace.fromJson(Map<String, dynamic> json) =>
      _$RequiredNamespaceFromJson(json);
}

@freezed
class SessionProposal with _$SessionProposal {
  @JsonSerializable()
  const factory SessionProposal({
    required int id,
    required ProposalData params,
  }) = _SessionProposal;

  factory SessionProposal.fromJson(Map<String, dynamic> json) =>
      _$SessionProposalFromJson(json);
}

@freezed
class ProposalData with _$ProposalData {
  @JsonSerializable(includeIfNull: false)
  const factory ProposalData({
    required int id,
    required int expiry,
    required List<Relay> relays,
    required ConnectionMetadata proposer,
    required Map<String, RequiredNamespace> requiredNamespaces,
    required Map<String, RequiredNamespace> optionalNamespaces,
    required String pairingTopic,
    Map<String, String>? sessionProperties,
    Map<String, Namespace>? generatedNamespaces,
  }) = _ProposalData;

  factory ProposalData.fromJson(Map<String, dynamic> json) =>
      _$ProposalDataFromJson(json);
}

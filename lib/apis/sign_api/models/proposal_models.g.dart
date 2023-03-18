// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'proposal_models.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RequiredNamespace _$RequiredNamespaceFromJson(Map<String, dynamic> json) =>
    RequiredNamespace(
      chains:
          (json['chains'] as List<dynamic>?)?.map((e) => e as String).toList(),
      methods:
          (json['methods'] as List<dynamic>).map((e) => e as String).toList(),
      events:
          (json['events'] as List<dynamic>).map((e) => e as String).toList(),
    );

Map<String, dynamic> _$RequiredNamespaceToJson(RequiredNamespace instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('chains', instance.chains);
  val['methods'] = instance.methods;
  val['events'] = instance.events;
  return val;
}

SessionProposal _$SessionProposalFromJson(Map<String, dynamic> json) =>
    SessionProposal(
      id: json['id'] as int,
      params: ProposalData.fromJson(json['params'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$SessionProposalToJson(SessionProposal instance) =>
    <String, dynamic>{
      'id': instance.id,
      'params': instance.params,
    };

ProposalData _$ProposalDataFromJson(Map<String, dynamic> json) => ProposalData(
      id: json['id'] as int,
      expiry: json['expiry'] as int,
      relays: (json['relays'] as List<dynamic>)
          .map((e) => Relay.fromJson(e as Map<String, dynamic>))
          .toList(),
      proposer:
          ConnectionMetadata.fromJson(json['proposer'] as Map<String, dynamic>),
      requiredNamespaces:
          (json['requiredNamespaces'] as Map<String, dynamic>).map(
        (k, e) =>
            MapEntry(k, RequiredNamespace.fromJson(e as Map<String, dynamic>)),
      ),
      optionalNamespaces:
          (json['optionalNamespaces'] as Map<String, dynamic>).map(
        (k, e) =>
            MapEntry(k, RequiredNamespace.fromJson(e as Map<String, dynamic>)),
      ),
      pairingTopic: json['pairingTopic'] as String,
      sessionProperties:
          (json['sessionProperties'] as Map<String, dynamic>?)?.map(
        (k, e) => MapEntry(k, e as String),
      ),
      generatedNamespaces:
          (json['generatedNamespaces'] as Map<String, dynamic>?)?.map(
        (k, e) => MapEntry(k, Namespace.fromJson(e as Map<String, dynamic>)),
      ),
    );

Map<String, dynamic> _$ProposalDataToJson(ProposalData instance) {
  final val = <String, dynamic>{
    'id': instance.id,
    'expiry': instance.expiry,
    'relays': instance.relays,
    'proposer': instance.proposer,
    'requiredNamespaces': instance.requiredNamespaces,
    'optionalNamespaces': instance.optionalNamespaces,
  };

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('sessionProperties', instance.sessionProperties);
  val['pairingTopic'] = instance.pairingTopic;
  writeNotNull('generatedNamespaces', instance.generatedNamespaces);
  return val;
}

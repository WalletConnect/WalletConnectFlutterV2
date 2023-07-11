// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'proposal_models.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_RequiredNamespace _$$_RequiredNamespaceFromJson(Map<String, dynamic> json) =>
    _$_RequiredNamespace(
      chains:
          (json['chains'] as List<dynamic>?)?.map((e) => e as String).toList(),
      methods:
          (json['methods'] as List<dynamic>).map((e) => e as String).toList(),
      events:
          (json['events'] as List<dynamic>).map((e) => e as String).toList(),
    );

Map<String, dynamic> _$$_RequiredNamespaceToJson(
    _$_RequiredNamespace instance) {
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

_$_SessionProposal _$$_SessionProposalFromJson(Map<String, dynamic> json) =>
    _$_SessionProposal(
      id: json['id'] as int,
      params: ProposalData.fromJson(json['params'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$$_SessionProposalToJson(_$_SessionProposal instance) =>
    <String, dynamic>{
      'id': instance.id,
      'params': instance.params.toJson(),
    };

_$_ProposalData _$$_ProposalDataFromJson(Map<String, dynamic> json) =>
    _$_ProposalData(
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

Map<String, dynamic> _$$_ProposalDataToJson(_$_ProposalData instance) {
  final val = <String, dynamic>{
    'id': instance.id,
    'expiry': instance.expiry,
    'relays': instance.relays.map((e) => e.toJson()).toList(),
    'proposer': instance.proposer.toJson(),
    'requiredNamespaces':
        instance.requiredNamespaces.map((k, e) => MapEntry(k, e.toJson())),
    'optionalNamespaces':
        instance.optionalNamespaces.map((k, e) => MapEntry(k, e.toJson())),
    'pairingTopic': instance.pairingTopic,
  };

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('sessionProperties', instance.sessionProperties);
  writeNotNull('generatedNamespaces',
      instance.generatedNamespaces?.map((k, e) => MapEntry(k, e.toJson())));
  return val;
}

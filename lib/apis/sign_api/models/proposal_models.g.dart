// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'proposal_models.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$RequiredNamespaceImpl _$$RequiredNamespaceImplFromJson(
        Map<String, dynamic> json) =>
    _$RequiredNamespaceImpl(
      chains:
          (json['chains'] as List<dynamic>?)?.map((e) => e as String).toList(),
      methods:
          (json['methods'] as List<dynamic>).map((e) => e as String).toList(),
      events:
          (json['events'] as List<dynamic>).map((e) => e as String).toList(),
    );

Map<String, dynamic> _$$RequiredNamespaceImplToJson(
    _$RequiredNamespaceImpl instance) {
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

_$SessionProposalImpl _$$SessionProposalImplFromJson(
        Map<String, dynamic> json) =>
    _$SessionProposalImpl(
      id: (json['id'] as num).toInt(),
      params: ProposalData.fromJson(json['params'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$$SessionProposalImplToJson(
        _$SessionProposalImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'params': instance.params.toJson(),
    };

_$ProposalDataImpl _$$ProposalDataImplFromJson(Map<String, dynamic> json) =>
    _$ProposalDataImpl(
      id: (json['id'] as num).toInt(),
      expiry: (json['expiry'] as num).toInt(),
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

Map<String, dynamic> _$$ProposalDataImplToJson(_$ProposalDataImpl instance) {
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

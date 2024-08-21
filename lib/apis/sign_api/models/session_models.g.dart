// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'session_models.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$NamespaceImpl _$$NamespaceImplFromJson(Map<String, dynamic> json) =>
    _$NamespaceImpl(
      chains:
          (json['chains'] as List<dynamic>?)?.map((e) => e as String).toList(),
      accounts:
          (json['accounts'] as List<dynamic>).map((e) => e as String).toList(),
      methods:
          (json['methods'] as List<dynamic>).map((e) => e as String).toList(),
      events:
          (json['events'] as List<dynamic>).map((e) => e as String).toList(),
    );

Map<String, dynamic> _$$NamespaceImplToJson(_$NamespaceImpl instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('chains', instance.chains);
  val['accounts'] = instance.accounts;
  val['methods'] = instance.methods;
  val['events'] = instance.events;
  return val;
}

_$SessionDataImpl _$$SessionDataImplFromJson(Map<String, dynamic> json) =>
    _$SessionDataImpl(
      topic: json['topic'] as String,
      pairingTopic: json['pairingTopic'] as String,
      relay: Relay.fromJson(json['relay'] as Map<String, dynamic>),
      expiry: (json['expiry'] as num).toInt(),
      acknowledged: json['acknowledged'] as bool,
      controller: json['controller'] as String,
      namespaces: (json['namespaces'] as Map<String, dynamic>).map(
        (k, e) => MapEntry(k, Namespace.fromJson(e as Map<String, dynamic>)),
      ),
      self: ConnectionMetadata.fromJson(json['self'] as Map<String, dynamic>),
      peer: ConnectionMetadata.fromJson(json['peer'] as Map<String, dynamic>),
      requiredNamespaces:
          (json['requiredNamespaces'] as Map<String, dynamic>?)?.map(
        (k, e) =>
            MapEntry(k, RequiredNamespace.fromJson(e as Map<String, dynamic>)),
      ),
      optionalNamespaces:
          (json['optionalNamespaces'] as Map<String, dynamic>?)?.map(
        (k, e) =>
            MapEntry(k, RequiredNamespace.fromJson(e as Map<String, dynamic>)),
      ),
      sessionProperties:
          (json['sessionProperties'] as Map<String, dynamic>?)?.map(
        (k, e) => MapEntry(k, e as String),
      ),
      authentication: (json['authentication'] as List<dynamic>?)
          ?.map((e) => Cacao.fromJson(e as Map<String, dynamic>))
          .toList(),
      transportType:
          $enumDecodeNullable(_$TransportTypeEnumMap, json['transportType']) ??
              TransportType.relay,
    );

Map<String, dynamic> _$$SessionDataImplToJson(_$SessionDataImpl instance) {
  final val = <String, dynamic>{
    'topic': instance.topic,
    'pairingTopic': instance.pairingTopic,
    'relay': instance.relay.toJson(),
    'expiry': instance.expiry,
    'acknowledged': instance.acknowledged,
    'controller': instance.controller,
    'namespaces': instance.namespaces.map((k, e) => MapEntry(k, e.toJson())),
    'self': instance.self.toJson(),
    'peer': instance.peer.toJson(),
  };

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('requiredNamespaces',
      instance.requiredNamespaces?.map((k, e) => MapEntry(k, e.toJson())));
  writeNotNull('optionalNamespaces',
      instance.optionalNamespaces?.map((k, e) => MapEntry(k, e.toJson())));
  writeNotNull('sessionProperties', instance.sessionProperties);
  writeNotNull('authentication',
      instance.authentication?.map((e) => e.toJson()).toList());
  val['transportType'] = _$TransportTypeEnumMap[instance.transportType]!;
  return val;
}

const _$TransportTypeEnumMap = {
  TransportType.relay: 'relay',
  TransportType.linkMode: 'linkMode',
};

_$SessionRequestImpl _$$SessionRequestImplFromJson(Map<String, dynamic> json) =>
    _$SessionRequestImpl(
      id: (json['id'] as num).toInt(),
      topic: json['topic'] as String,
      method: json['method'] as String,
      chainId: json['chainId'] as String,
      params: json['params'],
      verifyContext:
          VerifyContext.fromJson(json['verifyContext'] as Map<String, dynamic>),
      transportType:
          $enumDecodeNullable(_$TransportTypeEnumMap, json['transportType']) ??
              TransportType.relay,
    );

Map<String, dynamic> _$$SessionRequestImplToJson(
        _$SessionRequestImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'topic': instance.topic,
      'method': instance.method,
      'chainId': instance.chainId,
      'params': instance.params,
      'verifyContext': instance.verifyContext.toJson(),
      'transportType': _$TransportTypeEnumMap[instance.transportType]!,
    };

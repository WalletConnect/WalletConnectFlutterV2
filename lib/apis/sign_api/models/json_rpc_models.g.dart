// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'json_rpc_models.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$WcPairingDeleteRequestImpl _$$WcPairingDeleteRequestImplFromJson(
        Map<String, dynamic> json) =>
    _$WcPairingDeleteRequestImpl(
      code: json['code'] as int,
      message: json['message'] as String,
    );

Map<String, dynamic> _$$WcPairingDeleteRequestImplToJson(
        _$WcPairingDeleteRequestImpl instance) =>
    <String, dynamic>{
      'code': instance.code,
      'message': instance.message,
    };

_$WcPairingPingRequestImpl _$$WcPairingPingRequestImplFromJson(
        Map<String, dynamic> json) =>
    _$WcPairingPingRequestImpl(
      data: json['data'] as Map<String, dynamic>,
    );

Map<String, dynamic> _$$WcPairingPingRequestImplToJson(
        _$WcPairingPingRequestImpl instance) =>
    <String, dynamic>{
      'data': instance.data,
    };

_$WcSessionProposeRequestImpl _$$WcSessionProposeRequestImplFromJson(
        Map<String, dynamic> json) =>
    _$WcSessionProposeRequestImpl(
      relays: (json['relays'] as List<dynamic>)
          .map((e) => Relay.fromJson(e as Map<String, dynamic>))
          .toList(),
      requiredNamespaces:
          (json['requiredNamespaces'] as Map<String, dynamic>).map(
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
      proposer:
          ConnectionMetadata.fromJson(json['proposer'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$$WcSessionProposeRequestImplToJson(
    _$WcSessionProposeRequestImpl instance) {
  final val = <String, dynamic>{
    'relays': instance.relays.map((e) => e.toJson()).toList(),
    'requiredNamespaces':
        instance.requiredNamespaces.map((k, e) => MapEntry(k, e.toJson())),
  };

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('optionalNamespaces',
      instance.optionalNamespaces?.map((k, e) => MapEntry(k, e.toJson())));
  writeNotNull('sessionProperties', instance.sessionProperties);
  val['proposer'] = instance.proposer.toJson();
  return val;
}

_$WcSessionProposeResponseImpl _$$WcSessionProposeResponseImplFromJson(
        Map<String, dynamic> json) =>
    _$WcSessionProposeResponseImpl(
      relay: Relay.fromJson(json['relay'] as Map<String, dynamic>),
      responderPublicKey: json['responderPublicKey'] as String,
    );

Map<String, dynamic> _$$WcSessionProposeResponseImplToJson(
        _$WcSessionProposeResponseImpl instance) =>
    <String, dynamic>{
      'relay': instance.relay.toJson(),
      'responderPublicKey': instance.responderPublicKey,
    };

_$WcSessionSettleRequestImpl _$$WcSessionSettleRequestImplFromJson(
        Map<String, dynamic> json) =>
    _$WcSessionSettleRequestImpl(
      relay: Relay.fromJson(json['relay'] as Map<String, dynamic>),
      namespaces: (json['namespaces'] as Map<String, dynamic>).map(
        (k, e) => MapEntry(k, Namespace.fromJson(e as Map<String, dynamic>)),
      ),
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
      expiry: json['expiry'] as int,
      controller: ConnectionMetadata.fromJson(
          json['controller'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$$WcSessionSettleRequestImplToJson(
    _$WcSessionSettleRequestImpl instance) {
  final val = <String, dynamic>{
    'relay': instance.relay.toJson(),
    'namespaces': instance.namespaces.map((k, e) => MapEntry(k, e.toJson())),
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
  val['expiry'] = instance.expiry;
  val['controller'] = instance.controller.toJson();
  return val;
}

_$WcSessionUpdateRequestImpl _$$WcSessionUpdateRequestImplFromJson(
        Map<String, dynamic> json) =>
    _$WcSessionUpdateRequestImpl(
      namespaces: (json['namespaces'] as Map<String, dynamic>).map(
        (k, e) => MapEntry(k, Namespace.fromJson(e as Map<String, dynamic>)),
      ),
    );

Map<String, dynamic> _$$WcSessionUpdateRequestImplToJson(
        _$WcSessionUpdateRequestImpl instance) =>
    <String, dynamic>{
      'namespaces': instance.namespaces.map((k, e) => MapEntry(k, e.toJson())),
    };

_$WcSessionExtendRequestImpl _$$WcSessionExtendRequestImplFromJson(
        Map<String, dynamic> json) =>
    _$WcSessionExtendRequestImpl(
      data: json['data'] as Map<String, dynamic>?,
    );

Map<String, dynamic> _$$WcSessionExtendRequestImplToJson(
    _$WcSessionExtendRequestImpl instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('data', instance.data);
  return val;
}

_$WcSessionDeleteRequestImpl _$$WcSessionDeleteRequestImplFromJson(
        Map<String, dynamic> json) =>
    _$WcSessionDeleteRequestImpl(
      code: json['code'] as int,
      message: json['message'] as String,
      data: json['data'] as String?,
    );

Map<String, dynamic> _$$WcSessionDeleteRequestImplToJson(
    _$WcSessionDeleteRequestImpl instance) {
  final val = <String, dynamic>{
    'code': instance.code,
    'message': instance.message,
  };

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('data', instance.data);
  return val;
}

_$WcSessionPingRequestImpl _$$WcSessionPingRequestImplFromJson(
        Map<String, dynamic> json) =>
    _$WcSessionPingRequestImpl(
      data: json['data'] as Map<String, dynamic>?,
    );

Map<String, dynamic> _$$WcSessionPingRequestImplToJson(
    _$WcSessionPingRequestImpl instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('data', instance.data);
  return val;
}

_$WcSessionRequestRequestImpl _$$WcSessionRequestRequestImplFromJson(
        Map<String, dynamic> json) =>
    _$WcSessionRequestRequestImpl(
      chainId: json['chainId'] as String,
      request: SessionRequestParams.fromJson(
          json['request'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$$WcSessionRequestRequestImplToJson(
        _$WcSessionRequestRequestImpl instance) =>
    <String, dynamic>{
      'chainId': instance.chainId,
      'request': instance.request.toJson(),
    };

_$SessionRequestParamsImpl _$$SessionRequestParamsImplFromJson(
        Map<String, dynamic> json) =>
    _$SessionRequestParamsImpl(
      method: json['method'] as String,
      params: json['params'],
    );

Map<String, dynamic> _$$SessionRequestParamsImplToJson(
        _$SessionRequestParamsImpl instance) =>
    <String, dynamic>{
      'method': instance.method,
      'params': instance.params,
    };

_$WcSessionEventRequestImpl _$$WcSessionEventRequestImplFromJson(
        Map<String, dynamic> json) =>
    _$WcSessionEventRequestImpl(
      chainId: json['chainId'] as String,
      event: SessionEventParams.fromJson(json['event'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$$WcSessionEventRequestImplToJson(
        _$WcSessionEventRequestImpl instance) =>
    <String, dynamic>{
      'chainId': instance.chainId,
      'event': instance.event.toJson(),
    };

_$SessionEventParamsImpl _$$SessionEventParamsImplFromJson(
        Map<String, dynamic> json) =>
    _$SessionEventParamsImpl(
      name: json['name'] as String,
      data: json['data'],
    );

Map<String, dynamic> _$$SessionEventParamsImplToJson(
        _$SessionEventParamsImpl instance) =>
    <String, dynamic>{
      'name': instance.name,
      'data': instance.data,
    };

_$WcAuthRequestRequestImpl _$$WcAuthRequestRequestImplFromJson(
        Map<String, dynamic> json) =>
    _$WcAuthRequestRequestImpl(
      payloadParams: AuthPayloadParams.fromJson(
          json['payloadParams'] as Map<String, dynamic>),
      requester: ConnectionMetadata.fromJson(
          json['requester'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$$WcAuthRequestRequestImplToJson(
        _$WcAuthRequestRequestImpl instance) =>
    <String, dynamic>{
      'payloadParams': instance.payloadParams.toJson(),
      'requester': instance.requester.toJson(),
    };

_$WcAuthRequestResultImpl _$$WcAuthRequestResultImplFromJson(
        Map<String, dynamic> json) =>
    _$WcAuthRequestResultImpl(
      cacao: Cacao.fromJson(json['cacao'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$$WcAuthRequestResultImplToJson(
        _$WcAuthRequestResultImpl instance) =>
    <String, dynamic>{
      'cacao': instance.cacao.toJson(),
    };

_$WcSessionAuthRequestParamsImpl _$$WcSessionAuthRequestParamsImplFromJson(
        Map<String, dynamic> json) =>
    _$WcSessionAuthRequestParamsImpl(
      authPayload: SessionAuthPayload.fromJson(
          json['authPayload'] as Map<String, dynamic>),
      requester: ConnectionMetadata.fromJson(
          json['requester'] as Map<String, dynamic>),
      expiryTimestamp: json['expiryTimestamp'] as int,
    );

Map<String, dynamic> _$$WcSessionAuthRequestParamsImplToJson(
        _$WcSessionAuthRequestParamsImpl instance) =>
    <String, dynamic>{
      'authPayload': instance.authPayload.toJson(),
      'requester': instance.requester.toJson(),
      'expiryTimestamp': instance.expiryTimestamp,
    };

_$WcSessionAuthRequestResultImpl _$$WcSessionAuthRequestResultImplFromJson(
        Map<String, dynamic> json) =>
    _$WcSessionAuthRequestResultImpl(
      cacaos: (json['cacaos'] as List<dynamic>)
          .map((e) => Cacao.fromJson(e as Map<String, dynamic>))
          .toList(),
      responder: ConnectionMetadata.fromJson(
          json['responder'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$$WcSessionAuthRequestResultImplToJson(
        _$WcSessionAuthRequestResultImpl instance) =>
    <String, dynamic>{
      'cacaos': instance.cacaos.map((e) => e.toJson()).toList(),
      'responder': instance.responder.toJson(),
    };

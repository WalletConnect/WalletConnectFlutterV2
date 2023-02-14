// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'json_rpc_models.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

WcPairingDeleteRequest _$WcPairingDeleteRequestFromJson(
        Map<String, dynamic> json) =>
    WcPairingDeleteRequest(
      code: json['code'] as int,
      message: json['message'] as String,
    );

Map<String, dynamic> _$WcPairingDeleteRequestToJson(
        WcPairingDeleteRequest instance) =>
    <String, dynamic>{
      'code': instance.code,
      'message': instance.message,
    };

WcPairingPingRequest _$WcPairingPingRequestFromJson(
        Map<String, dynamic> json) =>
    WcPairingPingRequest(
      data: json['data'] as Map<String, dynamic>,
    );

Map<String, dynamic> _$WcPairingPingRequestToJson(
        WcPairingPingRequest instance) =>
    <String, dynamic>{
      'data': instance.data,
    };

WcSessionProposeRequest _$WcSessionProposeRequestFromJson(
        Map<String, dynamic> json) =>
    WcSessionProposeRequest(
      relays: (json['relays'] as List<dynamic>)
          .map((e) => Relay.fromJson(e as Map<String, dynamic>))
          .toList(),
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
      proposer:
          ConnectionMetadata.fromJson(json['proposer'] as Map<String, dynamic>),
      sessionProperties:
          (json['sessionProperties'] as Map<String, dynamic>?)?.map(
        (k, e) => MapEntry(k, e as String),
      ),
    );

Map<String, dynamic> _$WcSessionProposeRequestToJson(
    WcSessionProposeRequest instance) {
  final val = <String, dynamic>{
    'relays': instance.relays,
    'requiredNamespaces': instance.requiredNamespaces,
    'optionalNamespaces': instance.optionalNamespaces,
  };

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('sessionProperties', instance.sessionProperties);
  val['proposer'] = instance.proposer;
  return val;
}

WcSessionProposeResponse _$WcSessionProposeResponseFromJson(
        Map<String, dynamic> json) =>
    WcSessionProposeResponse(
      relay: Relay.fromJson(json['relay'] as Map<String, dynamic>),
      responderPublicKey: json['responderPublicKey'] as String,
    );

Map<String, dynamic> _$WcSessionProposeResponseToJson(
        WcSessionProposeResponse instance) =>
    <String, dynamic>{
      'relay': instance.relay,
      'responderPublicKey': instance.responderPublicKey,
    };

WcSessionSettleRequest _$WcSessionSettleRequestFromJson(
        Map<String, dynamic> json) =>
    WcSessionSettleRequest(
      relay: Relay.fromJson(json['relay'] as Map<String, dynamic>),
      namespaces: (json['namespaces'] as Map<String, dynamic>).map(
        (k, e) => MapEntry(k, Namespace.fromJson(e as Map<String, dynamic>)),
      ),
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
      sessionProperties:
          (json['sessionProperties'] as Map<String, dynamic>?)?.map(
        (k, e) => MapEntry(k, e as String),
      ),
      expiry: json['expiry'] as int,
      controller: ConnectionMetadata.fromJson(
          json['controller'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$WcSessionSettleRequestToJson(
    WcSessionSettleRequest instance) {
  final val = <String, dynamic>{
    'relay': instance.relay,
    'namespaces': instance.namespaces,
    'requiredNamespaces': instance.requiredNamespaces,
    'optionalNamespaces': instance.optionalNamespaces,
  };

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('sessionProperties', instance.sessionProperties);
  val['expiry'] = instance.expiry;
  val['controller'] = instance.controller;
  return val;
}

WcSessionUpdateRequest _$WcSessionUpdateRequestFromJson(
        Map<String, dynamic> json) =>
    WcSessionUpdateRequest(
      namespaces: (json['namespaces'] as Map<String, dynamic>).map(
        (k, e) => MapEntry(k, Namespace.fromJson(e as Map<String, dynamic>)),
      ),
    );

Map<String, dynamic> _$WcSessionUpdateRequestToJson(
        WcSessionUpdateRequest instance) =>
    <String, dynamic>{
      'namespaces': instance.namespaces,
    };

WcSessionExtendRequest _$WcSessionExtendRequestFromJson(
        Map<String, dynamic> json) =>
    WcSessionExtendRequest(
      data: json['data'] as Map<String, dynamic>?,
    );

Map<String, dynamic> _$WcSessionExtendRequestToJson(
    WcSessionExtendRequest instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('data', instance.data);
  return val;
}

WcSessionDeleteRequest _$WcSessionDeleteRequestFromJson(
        Map<String, dynamic> json) =>
    WcSessionDeleteRequest(
      code: json['code'] as int,
      message: json['message'] as String,
      data: json['data'] as String?,
    );

Map<String, dynamic> _$WcSessionDeleteRequestToJson(
    WcSessionDeleteRequest instance) {
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

WcSessionPingRequest _$WcSessionPingRequestFromJson(
        Map<String, dynamic> json) =>
    WcSessionPingRequest(
      data: json['data'] as Map<String, dynamic>?,
    );

Map<String, dynamic> _$WcSessionPingRequestToJson(
    WcSessionPingRequest instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('data', instance.data);
  return val;
}

WcSessionRequestRequest _$WcSessionRequestRequestFromJson(
        Map<String, dynamic> json) =>
    WcSessionRequestRequest(
      chainId: json['chainId'] as String,
      request: SessionRequestParams.fromJson(
          json['request'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$WcSessionRequestRequestToJson(
        WcSessionRequestRequest instance) =>
    <String, dynamic>{
      'chainId': instance.chainId,
      'request': instance.request,
    };

SessionRequestParams _$SessionRequestParamsFromJson(
        Map<String, dynamic> json) =>
    SessionRequestParams(
      method: json['method'] as String,
      params: json['params'],
    );

Map<String, dynamic> _$SessionRequestParamsToJson(
        SessionRequestParams instance) =>
    <String, dynamic>{
      'method': instance.method,
      'params': instance.params,
    };

WcSessionEventRequest _$WcSessionEventRequestFromJson(
        Map<String, dynamic> json) =>
    WcSessionEventRequest(
      chainId: json['chainId'] as String,
      event: SessionEventParams.fromJson(json['event'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$WcSessionEventRequestToJson(
        WcSessionEventRequest instance) =>
    <String, dynamic>{
      'chainId': instance.chainId,
      'event': instance.event,
    };

SessionEventParams _$SessionEventParamsFromJson(Map<String, dynamic> json) =>
    SessionEventParams(
      name: json['name'] as String,
      data: json['data'],
    );

Map<String, dynamic> _$SessionEventParamsToJson(SessionEventParams instance) =>
    <String, dynamic>{
      'name': instance.name,
      'data': instance.data,
    };

// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'json_rpc_models.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_WcPairingDeleteRequest _$$_WcPairingDeleteRequestFromJson(
        Map<String, dynamic> json) =>
    _$_WcPairingDeleteRequest(
      code: json['code'] as int,
      message: json['message'] as String,
    );

Map<String, dynamic> _$$_WcPairingDeleteRequestToJson(
        _$_WcPairingDeleteRequest instance) =>
    <String, dynamic>{
      'code': instance.code,
      'message': instance.message,
    };

_$_WcPairingPingRequest _$$_WcPairingPingRequestFromJson(
        Map<String, dynamic> json) =>
    _$_WcPairingPingRequest(
      data: json['data'] as Map<String, dynamic>,
    );

Map<String, dynamic> _$$_WcPairingPingRequestToJson(
        _$_WcPairingPingRequest instance) =>
    <String, dynamic>{
      'data': instance.data,
    };

_$_WcSessionProposeRequest _$$_WcSessionProposeRequestFromJson(
        Map<String, dynamic> json) =>
    _$_WcSessionProposeRequest(
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

Map<String, dynamic> _$$_WcSessionProposeRequestToJson(
    _$_WcSessionProposeRequest instance) {
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

_$_WcSessionProposeResponse _$$_WcSessionProposeResponseFromJson(
        Map<String, dynamic> json) =>
    _$_WcSessionProposeResponse(
      relay: Relay.fromJson(json['relay'] as Map<String, dynamic>),
      responderPublicKey: json['responderPublicKey'] as String,
    );

Map<String, dynamic> _$$_WcSessionProposeResponseToJson(
        _$_WcSessionProposeResponse instance) =>
    <String, dynamic>{
      'relay': instance.relay.toJson(),
      'responderPublicKey': instance.responderPublicKey,
    };

_$_WcSessionSettleRequest _$$_WcSessionSettleRequestFromJson(
        Map<String, dynamic> json) =>
    _$_WcSessionSettleRequest(
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

Map<String, dynamic> _$$_WcSessionSettleRequestToJson(
    _$_WcSessionSettleRequest instance) {
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

_$_WcSessionUpdateRequest _$$_WcSessionUpdateRequestFromJson(
        Map<String, dynamic> json) =>
    _$_WcSessionUpdateRequest(
      namespaces: (json['namespaces'] as Map<String, dynamic>).map(
        (k, e) => MapEntry(k, Namespace.fromJson(e as Map<String, dynamic>)),
      ),
    );

Map<String, dynamic> _$$_WcSessionUpdateRequestToJson(
        _$_WcSessionUpdateRequest instance) =>
    <String, dynamic>{
      'namespaces': instance.namespaces.map((k, e) => MapEntry(k, e.toJson())),
    };

_$_WcSessionExtendRequest _$$_WcSessionExtendRequestFromJson(
        Map<String, dynamic> json) =>
    _$_WcSessionExtendRequest(
      data: json['data'] as Map<String, dynamic>?,
    );

Map<String, dynamic> _$$_WcSessionExtendRequestToJson(
    _$_WcSessionExtendRequest instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('data', instance.data);
  return val;
}

_$_WcSessionDeleteRequest _$$_WcSessionDeleteRequestFromJson(
        Map<String, dynamic> json) =>
    _$_WcSessionDeleteRequest(
      code: json['code'] as int,
      message: json['message'] as String,
      data: json['data'] as String?,
    );

Map<String, dynamic> _$$_WcSessionDeleteRequestToJson(
    _$_WcSessionDeleteRequest instance) {
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

_$_WcSessionPingRequest _$$_WcSessionPingRequestFromJson(
        Map<String, dynamic> json) =>
    _$_WcSessionPingRequest(
      data: json['data'] as Map<String, dynamic>?,
    );

Map<String, dynamic> _$$_WcSessionPingRequestToJson(
    _$_WcSessionPingRequest instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('data', instance.data);
  return val;
}

_$_WcSessionRequestRequest _$$_WcSessionRequestRequestFromJson(
        Map<String, dynamic> json) =>
    _$_WcSessionRequestRequest(
      chainId: json['chainId'] as String,
      request: SessionRequestParams.fromJson(
          json['request'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$$_WcSessionRequestRequestToJson(
        _$_WcSessionRequestRequest instance) =>
    <String, dynamic>{
      'chainId': instance.chainId,
      'request': instance.request.toJson(),
    };

_$_SessionRequestParams _$$_SessionRequestParamsFromJson(
        Map<String, dynamic> json) =>
    _$_SessionRequestParams(
      method: json['method'] as String,
      params: json['params'],
    );

Map<String, dynamic> _$$_SessionRequestParamsToJson(
        _$_SessionRequestParams instance) =>
    <String, dynamic>{
      'method': instance.method,
      'params': instance.params,
    };

_$_WcSessionEventRequest _$$_WcSessionEventRequestFromJson(
        Map<String, dynamic> json) =>
    _$_WcSessionEventRequest(
      chainId: json['chainId'] as String,
      event: SessionEventParams.fromJson(json['event'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$$_WcSessionEventRequestToJson(
        _$_WcSessionEventRequest instance) =>
    <String, dynamic>{
      'chainId': instance.chainId,
      'event': instance.event.toJson(),
    };

_$_SessionEventParams _$$_SessionEventParamsFromJson(
        Map<String, dynamic> json) =>
    _$_SessionEventParams(
      name: json['name'] as String,
      data: json['data'],
    );

Map<String, dynamic> _$$_SessionEventParamsToJson(
        _$_SessionEventParams instance) =>
    <String, dynamic>{
      'name': instance.name,
      'data': instance.data,
    };

// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'pairing_models.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_PairingInfo _$$_PairingInfoFromJson(Map<String, dynamic> json) =>
    _$_PairingInfo(
      topic: json['topic'] as String,
      expiry: json['expiry'] as int,
      relay: Relay.fromJson(json['relay'] as Map<String, dynamic>),
      active: json['active'] as bool,
      peerMetadata: json['peerMetadata'] == null
          ? null
          : PairingMetadata.fromJson(
              json['peerMetadata'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$$_PairingInfoToJson(_$_PairingInfo instance) =>
    <String, dynamic>{
      'topic': instance.topic,
      'expiry': instance.expiry,
      'relay': instance.relay.toJson(),
      'active': instance.active,
      'peerMetadata': instance.peerMetadata?.toJson(),
    };

_$_PairingMetadata _$$_PairingMetadataFromJson(Map<String, dynamic> json) =>
    _$_PairingMetadata(
      name: json['name'] as String,
      description: json['description'] as String,
      url: json['url'] as String,
      icons: (json['icons'] as List<dynamic>).map((e) => e as String).toList(),
      redirect: json['redirect'] == null
          ? null
          : Redirect.fromJson(json['redirect'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$$_PairingMetadataToJson(_$_PairingMetadata instance) {
  final val = <String, dynamic>{
    'name': instance.name,
    'description': instance.description,
    'url': instance.url,
    'icons': instance.icons,
  };

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('redirect', instance.redirect?.toJson());
  return val;
}

_$_Redirect _$$_RedirectFromJson(Map<String, dynamic> json) => _$_Redirect(
      native: json['native'] as String?,
      universal: json['universal'] as String?,
    );

Map<String, dynamic> _$$_RedirectToJson(_$_Redirect instance) =>
    <String, dynamic>{
      'native': instance.native,
      'universal': instance.universal,
    };

_$_JsonRpcRecord _$$_JsonRpcRecordFromJson(Map<String, dynamic> json) =>
    _$_JsonRpcRecord(
      id: json['id'] as int,
      topic: json['topic'] as String,
      method: json['method'] as String,
      params: json['params'],
      chainId: json['chainId'] as String?,
      expiry: json['expiry'] as int?,
      response: json['response'],
    );

Map<String, dynamic> _$$_JsonRpcRecordToJson(_$_JsonRpcRecord instance) {
  final val = <String, dynamic>{
    'id': instance.id,
    'topic': instance.topic,
    'method': instance.method,
  };

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('params', instance.params);
  writeNotNull('chainId', instance.chainId);
  writeNotNull('expiry', instance.expiry);
  writeNotNull('response', instance.response);
  return val;
}

_$_ReceiverPublicKey _$$_ReceiverPublicKeyFromJson(Map<String, dynamic> json) =>
    _$_ReceiverPublicKey(
      topic: json['topic'] as String,
      publicKey: json['publicKey'] as String,
      expiry: json['expiry'] as int,
    );

Map<String, dynamic> _$$_ReceiverPublicKeyToJson(
        _$_ReceiverPublicKey instance) =>
    <String, dynamic>{
      'topic': instance.topic,
      'publicKey': instance.publicKey,
      'expiry': instance.expiry,
    };

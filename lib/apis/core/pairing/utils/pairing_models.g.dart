// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'pairing_models.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PairingInfo _$PairingInfoFromJson(Map<String, dynamic> json) => PairingInfo(
      topic: json['topic'] as String,
      expiry: json['expiry'] as int,
      relay: Relay.fromJson(json['relay'] as Map<String, dynamic>),
      active: json['active'] as bool,
      peerMetadata: json['peerMetadata'] == null
          ? null
          : PairingMetadata.fromJson(
              json['peerMetadata'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$PairingInfoToJson(PairingInfo instance) =>
    <String, dynamic>{
      'topic': instance.topic,
      'expiry': instance.expiry,
      'relay': instance.relay,
      'active': instance.active,
      'peerMetadata': instance.peerMetadata,
    };

PairingMetadata _$PairingMetadataFromJson(Map<String, dynamic> json) =>
    PairingMetadata(
      name: json['name'] as String,
      description: json['description'] as String,
      url: json['url'] as String,
      icons: (json['icons'] as List<dynamic>).map((e) => e as String).toList(),
      redirect: json['redirect'] == null
          ? null
          : Redirect.fromJson(json['redirect'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$PairingMetadataToJson(PairingMetadata instance) =>
    <String, dynamic>{
      'name': instance.name,
      'description': instance.description,
      'url': instance.url,
      'icons': instance.icons,
      'redirect': instance.redirect,
    };

Redirect _$RedirectFromJson(Map<String, dynamic> json) => Redirect(
      native: json['native'] as String?,
      universal: json['universal'] as String?,
    );

Map<String, dynamic> _$RedirectToJson(Redirect instance) => <String, dynamic>{
      'native': instance.native,
      'universal': instance.universal,
    };

JsonRpcRecord _$JsonRpcRecordFromJson(Map<String, dynamic> json) =>
    JsonRpcRecord(
      id: json['id'] as int,
      topic: json['topic'] as String,
      method: json['method'] as String,
      params: json['params'],
      chainId: json['chainId'] as String?,
    )..response = json['response'];

Map<String, dynamic> _$JsonRpcRecordToJson(JsonRpcRecord instance) =>
    <String, dynamic>{
      'id': instance.id,
      'topic': instance.topic,
      'method': instance.method,
      'params': instance.params,
      'response': instance.response,
      'chainId': instance.chainId,
    };

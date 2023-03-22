// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'kadena_test_files.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SignRequest _$SignRequestFromJson(Map<String, dynamic> json) => SignRequest(
      code: json['code'] as String,
      data: json['data'] as Map<String, dynamic>? ?? const {},
      sender: json['sender'] as String,
      networkId: json['networkId'] as String,
      chainId: json['chainId'] as String,
      gasLimit: json['gasLimit'] as int? ?? 2500,
      gasPrice: (json['gasPrice'] as num?)?.toDouble() ?? 1e-8,
      signingPubKey: json['signingPubKey'] as String,
      ttl: json['ttl'] as int? ?? 600,
      caps: (json['caps'] as List<dynamic>?)
              ?.map((e) => DappCapp.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const <DappCapp>[],
    )
      ..pactCode = json['pactCode'] as String
      ..envData = json['envData'] as Map<String, dynamic>;

Map<String, dynamic> _$SignRequestToJson(SignRequest instance) =>
    <String, dynamic>{
      'code': instance.code,
      'pactCode': instance.pactCode,
      'data': instance.data,
      'envData': instance.envData,
      'sender': instance.sender,
      'networkId': instance.networkId,
      'chainId': instance.chainId,
      'gasLimit': instance.gasLimit,
      'gasPrice': instance.gasPrice,
      'signingPubKey': instance.signingPubKey,
      'ttl': instance.ttl,
      'caps': instance.caps,
    };

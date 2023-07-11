// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ethereum_transaction.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

EthereumTransaction _$EthereumTransactionFromJson(Map<String, dynamic> json) =>
    EthereumTransaction(
      from: json['from'] as String,
      to: json['to'] as String,
      value: json['value'] as String,
      nonce: json['nonce'] as String?,
      gasPrice: json['gasPrice'] as String?,
      maxFeePerGas: json['maxFeePerGas'] as String?,
      maxPriorityFeePerGas: json['maxPriorityFeePerGas'] as String?,
      gas: json['gas'] as String?,
      gasLimit: json['gasLimit'] as String?,
      data: json['data'] as String?,
    );

Map<String, dynamic> _$EthereumTransactionToJson(EthereumTransaction instance) {
  final val = <String, dynamic>{
    'from': instance.from,
    'to': instance.to,
    'value': instance.value,
  };

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('nonce', instance.nonce);
  writeNotNull('gasPrice', instance.gasPrice);
  writeNotNull('maxFeePerGas', instance.maxFeePerGas);
  writeNotNull('maxPriorityFeePerGas', instance.maxPriorityFeePerGas);
  writeNotNull('gas', instance.gas);
  writeNotNull('gasLimit', instance.gasLimit);
  writeNotNull('data', instance.data);
  return val;
}

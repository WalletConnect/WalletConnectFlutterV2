import 'dart:typed_data';

import 'package:convert/convert.dart';
import 'package:walletconnect_flutter_v2/walletconnect_flutter_v2.dart';
import 'package:web3dart/crypto.dart' as crypto;

extension TransactionExtension on Transaction {
  Map<String, dynamic> toJson() {
    return {
      if (from != null) 'from': from!.hex,
      if (to != null) 'to': to!.hex,
      if (maxGas != null) 'gas': '0x${maxGas!.toRadixString(16)}',
      if (gasPrice != null)
        'gasPrice': '0x${gasPrice!.getInWei.toRadixString(16)}',
      if (value != null) 'value': '0x${value!.getInWei.toRadixString(16)}',
      if (data != null) 'data': crypto.bytesToHex(data!),
      if (nonce != null) 'nonce': nonce,
      if (maxFeePerGas != null)
        'maxFeePerGas': '0x${maxFeePerGas!.getInWei.toRadixString(16)}',
      if (maxPriorityFeePerGas != null)
        'maxPriorityFeePerGas':
            '0x${maxPriorityFeePerGas!.getInWei.toRadixString(16)}',
    };
  }
}

extension TransactionExtension2 on Map<String, dynamic> {
  Transaction toTransaction() {
    return Transaction(
      from: EthereumAddress.fromHex(this['from']),
      to: EthereumAddress.fromHex(this['to']),
      value: (this['value'] as String?).toEthereAmount(),
      gasPrice: (this['gasPrice'] as String?).toEthereAmount(),
      maxFeePerGas: (this['maxFeePerGas'] as String?).toEthereAmount(),
      maxPriorityFeePerGas:
          (this['maxPriorityFeePerGas'] as String?).toEthereAmount(),
      maxGas: (this['maxGas'] as String?).toIntFromHex(),
      nonce: this['nonce']?.toInt(),
      data: _parseTransactionData(this['data']),
    );
  }
}

Uint8List? _parseTransactionData(dynamic data) {
  if (data != null && data != '0x') {
    if (data.startsWith('0x')) {
      return Uint8List.fromList(hex.decode(data.substring(2)));
    }
    return Uint8List.fromList(hex.decode(data));
  }
  return null;
}

extension EtheraAmountExtension on String? {
  EtherAmount? toEthereAmount() {
    if (this != null) {
      final hexValue = this!.replaceFirst('0x', '');
      return EtherAmount.fromBigInt(
        EtherUnit.wei,
        BigInt.from(int.parse(hexValue, radix: 16)),
      );
    }
    return null;
  }

  int? toIntFromHex() {
    if (this != null) {
      final hexValue = this!.replaceFirst('0x', '');
      return int.parse(hexValue, radix: 16);
    }
    return null;
  }

  int? toInt() {
    if (this != null) {
      return int.tryParse(this!);
    }
    return null;
  }
}

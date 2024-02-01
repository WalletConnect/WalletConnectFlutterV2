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

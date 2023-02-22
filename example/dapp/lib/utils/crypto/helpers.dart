import 'package:flutter/material.dart';
import 'package:walletconnect_flutter_v2_dapp/models/chain_metadata.dart';
import 'package:walletconnect_flutter_v2_dapp/utils/crypto/chain_data.dart';
import 'package:walletconnect_flutter_v2_dapp/utils/crypto/eip155_data.dart';
import 'package:walletconnect_flutter_v2_dapp/utils/crypto/solana_data.dart';

String getChainName(String chainId) {
  try {
    return ChainData.allChains
        .where((element) => element.chainId == chainId)
        .first
        .name;
  } catch (e) {
    debugPrint('Invalid chain');
  }
  return 'Unknown';
}

List<String> getChainMethods(ChainType value) {
  if (value == ChainType.solana) {
    return SolanaData.methods.values.toList();
  } else {
    return EIP155Data.methods.values.toList();
  }
}

List<String> getChainEvents(ChainType value) {
  if (value == ChainType.solana) {
    return SolanaData.events.values.toList();
  } else {
    return EIP155Data.events.values.toList();
  }
}

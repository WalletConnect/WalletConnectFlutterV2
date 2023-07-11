import 'package:flutter/material.dart';
import 'package:walletconnect_flutter_v2_dapp/models/chain_metadata.dart';
import 'package:walletconnect_flutter_v2_dapp/utils/crypto/chain_data.dart';
import 'package:walletconnect_flutter_v2_dapp/utils/crypto/eip155.dart';
import 'package:walletconnect_flutter_v2_dapp/utils/crypto/solana_data.dart';

String getChainName(String chain) {
  try {
    return ChainData.allChains
        .where((element) => element.chainId == chain)
        .first
        .name;
  } catch (e) {
    debugPrint('Invalid chain');
  }
  return 'Unknown';
}

ChainMetadata getChainMetadataFromChain(String chain) {
  try {
    return ChainData.allChains
        .where((element) => element.chainId == chain)
        .first;
  } catch (e) {
    debugPrint('Invalid chain');
  }
  return ChainData.mainChains[0];
}

List<String> getChainMethods(ChainType value) {
  if (value == ChainType.solana) {
    return SolanaData.methods.values.toList();
  } else if (value == ChainType.kadena) {
    return EIP155.methods.values.toList(); //Kadena.methods.values.toList();
  } else {
    return EIP155.methods.values.toList();
  }
}

List<String> getChainEvents(ChainType value) {
  if (value == ChainType.solana) {
    return SolanaData.events.values.toList();
  } else if (value == ChainType.kadena) {
    return EIP155.events.values.toList(); //Kadena.events.values.toList();
  } else {
    return EIP155.events.values.toList();
  }
}

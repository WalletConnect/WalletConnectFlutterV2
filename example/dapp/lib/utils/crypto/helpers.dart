import 'package:walletconnect_flutter_v2_dapp/utils/crypto/eip155_data.dart';
import 'package:walletconnect_flutter_v2_dapp/utils/crypto/solana_data.dart';
import 'package:flutter/material.dart';

String getChainName(String value) {
  try {
    if (value.startsWith('eip155')) {
      return Eip155Data.chains
          .where((element) => element.chainId == value)
          .first
          .name;
    } else if (value.startsWith('solana')) {
      return SolanaData.chains
          .where((element) => element.chainId == value)
          .first
          .name;
    }
  } catch (e) {
    debugPrint('Invalid chain');
  }
  return 'Unknown';
}

List<String> getChainEvents(String value) {
  try {
    if (value.startsWith('eip155')) {
      return Eip155Data.events.values.toList();
    } else if (value.startsWith('solana')) {
      return SolanaData.events.values.toList();
    }
  } catch (e) {
    debugPrint('Invalid chain');
  }
  return [];
}

List<String> getChainMethods(String value) {
  try {
    if (value.startsWith('eip155')) {
      return Eip155Data.methods.values.toList();
    } else if (value.startsWith('solana')) {
      return SolanaData.methods.values.toList();
    }
  } catch (e) {
    debugPrint('Invalid chain');
  }
  return [];
}

import 'dart:convert';

import 'package:convert/convert.dart';
import 'package:get_it/get_it.dart';
import 'package:walletconnect_flutter_v2/walletconnect_flutter_v2.dart';
import 'package:walletconnect_flutter_v2_wallet/dependencies/i_web3wallet_service.dart';

class EthUtils {
  static final addressRegEx = RegExp(
    r'^0x[a-fA-F0-9]{40}$',
    caseSensitive: false,
  );

  static String getUtf8Message(String maybeHex) {
    if (maybeHex.startsWith('0x')) {
      final List<int> decoded = hex.decode(
        maybeHex.substring(2),
      );
      return utf8.decode(decoded);
    }

    return maybeHex;
  }

  static dynamic getAddressFromParamsList(dynamic params) {
    return (params as List).firstWhere((p) {
      try {
        if (addressRegEx.hasMatch(p)) {
          EthereumAddress.fromHex(p);
          return true;
        }
        return false;
      } catch (e) {
        return false;
      }
    }, orElse: () => null);
  }

  static dynamic getDataFromParamsList(dynamic params) {
    final address = getAddressFromParamsList(params);
    final param = (params as List).firstWhere(
      (p) => p != address,
      orElse: () => null,
    );
    return param;
  }

  static Map<String, dynamic>? getTransactionFromParams(dynamic params) {
    final address = getAddressFromParamsList(params);
    final param = params.firstWhere(
      (p) => p != address,
      orElse: () => null,
    );
    return param as Map<String, dynamic>?;
  }

  static Future<dynamic> decodeMessageEvent(MessageEvent event) async {
    final w3Wallet = GetIt.I<IWeb3WalletService>().web3wallet;
    final payloadString = await w3Wallet.core.crypto.decode(
      event.topic,
      event.message,
    );
    if (payloadString == null) return null;

    final data = jsonDecode(payloadString) as Map<String, dynamic>;
    if (data.containsKey('method')) {
      return JsonRpcRequest.fromJson(data);
    } else {
      return JsonRpcResponse.fromJson(data);
    }
  }
}

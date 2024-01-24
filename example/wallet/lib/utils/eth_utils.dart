import 'dart:convert';

import 'package:convert/convert.dart';
import 'package:walletconnect_flutter_v2/walletconnect_flutter_v2.dart';

class EthUtils {
  static String getUtf8Message(String maybeHex) {
    if (maybeHex.startsWith('0x')) {
      final List<int> decoded = hex.decode(
        maybeHex.substring(2),
      );
      return utf8.decode(decoded);
    }

    return maybeHex;
  }

  static String getAddressFromParamsList(dynamic params) {
    return (params as List).firstWhere((p) {
      try {
        EthereumAddress.fromHex(p);
        return true;
      } catch (e) {
        return false;
      }
    });
  }

  static dynamic getDataFromParamsList(dynamic params) {
    return (params as List).firstWhere((p) {
      final address = getAddressFromParamsList(params);
      return p != address;
    });
  }

  static Map<String, dynamic> getTransactionFromParams(dynamic params) {
    final param = (params as List<dynamic>).first;
    return param as Map<String, dynamic>;
  }
}

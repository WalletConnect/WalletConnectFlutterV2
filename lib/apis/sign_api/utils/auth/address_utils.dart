import 'package:walletconnect_flutter_v2/walletconnect_flutter_v2.dart';

class AddressUtils {
  static String getDidAddress(String iss) {
    return iss.split(':').last;
  }

  static String getDidChainId(String iss) {
    return iss.split(':')[3];
  }

  static String getNamespaceDidChainId(String iss) {
    return iss.substring(iss.indexOf(RegExp(r':')) + 1);
  }
}

extension AddressUtilsExtension on String {
  String toEIP55() {
    return EthereumAddress.fromHex(this).hexEip55;
  }
}

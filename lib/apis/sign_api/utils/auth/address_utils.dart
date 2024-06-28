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

import 'dart:math';

import 'package:walletconnect_dart_v2/apis/core/pairing/utils/pairing_models.dart';
import 'package:walletconnect_dart_v2/apis/models/json_rpc_error.dart';
import 'package:walletconnect_dart_v2/apis/utils/errors.dart';

class PairingUtils {
  static int payloadId() {
    int date = DateTime.now().millisecondsSinceEpoch;
    int extra = Random().nextInt(1000) * 1000;
    return date + extra;
  }

  static Map<String, dynamic> formatJsonRpcRequest(
    String method,
    Map<String, dynamic> params, {
    int? id,
  }) {
    return {
      'id': id == null ? payloadId() : id,
      'jsonrpc': '2.0',
      'method': method,
      'params': params,
    };
  }

  static Map<String, dynamic> formatJsonRpcResponse<T>(
    int id,
    T result,
  ) {
    return {
      'id': id,
      'jsonrpc': '2.0',
      'result': result,
    };
  }

  static Map<String, dynamic> formatJsonRpcError(int id, JsonRpcError error) {
    return {
      'id': id,
      'jsonrpc': '2.0',
      'error': error.toJson(),
    };
  }

  static bool validateMethods(
    List<String> methods,
    List<RegisteredFunction> registeredMethods,
  ) {
    List<String> unsupportedMethods = [];

    // Loop through the methods, and validate that each one exists in the registered methods
    for (String method in methods) {
      if (!registeredMethods.any((element) => element.method == method)) {
        // print("Adding method: $method");
        unsupportedMethods.add(method);
      }
    }

    // If there are any unsupported methods, throw an error
    if (unsupportedMethods.isNotEmpty) {
      // print(
      //     'Unsupported Methods: $unsupportedMethods, Length: ${unsupportedMethods.length}');
      throw Errors.getSdkError(
        Errors.WC_METHOD_UNSUPPORTED,
        context:
            'The following methods are not registered: ${unsupportedMethods.join(', ')}.',
      );
    }

    return true;
  }
}

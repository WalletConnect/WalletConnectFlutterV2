import 'dart:convert';
import 'dart:typed_data';

import 'package:walletconnect_flutter_v2/walletconnect_flutter_v2.dart';
import 'package:web3dart/crypto.dart' as crypto;

class CustomCredentials extends CustomTransactionSender {
  CustomCredentials({
    required ISignEngine signEngine,
    required String topic,
    required String chainId,
    required EthereumAddress address,
    String? method,
  })  : _signEngine = signEngine,
        _topic = topic,
        _chainId = chainId,
        _address = address,
        _method = method;

  final ISignEngine _signEngine;
  final String _topic;
  final String _chainId;
  final EthereumAddress _address;
  final String? _method;

  @override
  EthereumAddress get address => _address;

  @override
  Future<String> sendTransaction(Transaction transaction) async {
    final result = await _sendTransaction(transaction);
    if (result is Map) {
      return jsonEncode(result);
    }
    return result.toString();
  }

  Future<dynamic> _sendTransaction(Transaction transaction) async {
    final sessionRequestParams = SessionRequestParams(
      method: _method ?? MethodsConstants.ethSendTransaction,
      params: [
        transaction.toJson(),
      ],
    );

    final result = await _signEngine.request(
      topic: _topic,
      chainId: _chainId,
      request: sessionRequestParams,
    );
    return result;
  }

  @override
  Future<EthereumAddress> extractAddress() => Future.value(_address);

  @override
  Future<crypto.MsgSignature> signToSignature(
    Uint8List payload, {
    int? chainId,
    bool isEIP1559 = false,
  }) {
    final signature = signToEcSignature(
      payload,
      chainId: chainId,
      isEIP1559: isEIP1559,
    );
    return Future.value(signature);
  }

  @override
  crypto.MsgSignature signToEcSignature(
    Uint8List payload, {
    int? chainId,
    bool isEIP1559 = false,
  }) {
    // TODO: implement signToEcSignature
    throw UnimplementedError();
  }
}

import 'dart:typed_data';

import 'package:walletconnect_flutter_v2/walletconnect_flutter_v2.dart';
import 'package:web3dart/crypto.dart' as crypto;
import 'package:http/http.dart' as http;

extension TransactionExtension on Transaction {
  // https://github.com/WalletConnect/WalletConnectFlutterV2/issues/246#issuecomment-1905455072
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

extension ContractsInteractionExtension on Web3App {
  Future<dynamic> readContractCall({
    required DeployedContract deployedContract,
    required String functionName,
    required String rpcUrl,
    List<dynamic> parameters = const [],
  }) async {
    try {
      core.logger.i('readContractCall: with function $functionName');
      final result = await Web3Client(rpcUrl, http.Client()).call(
        contract: deployedContract,
        function: deployedContract.function(functionName),
        params: parameters,
      );

      core.logger.i(
          'readContractCall - function: $functionName - result: ${result.first}');
      return result.first;
    } catch (e) {
      rethrow;
    }
  }

  Future<dynamic> writeContractCall({
    required String topic,
    required String chainId,
    required String rpcUrl,
    required DeployedContract deployedContract,
    required String functionName,
    required Transaction transaction,
    String? method,
    List<dynamic> parameters = const [],
  }) async {
    try {
      final credentials = _CustomCredentialsSender(
        topic: topic,
        chainId: chainId,
        signEngine: signEngine,
        address: transaction.from!,
        method: method,
      );
      final trx = Transaction.callContract(
        contract: deployedContract,
        function: deployedContract.function(functionName),
        from: credentials.address,
        parameters: [
          if (transaction.to != null) transaction.to,
          if (transaction.value != null) transaction.value!.getInWei,
          ...parameters,
        ],
      );

      if (chainId.contains(':')) {
        chainId = chainId.split(':').last;
      }
      return await Web3Client(rpcUrl, http.Client()).sendTransaction(
        credentials,
        trx,
        chainId: int.parse(chainId),
      );
    } catch (e) {
      rethrow;
    }
  }
}

class _CustomCredentialsSender extends CustomTransactionSender {
  _CustomCredentialsSender({
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
    try {
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
    } catch (e) {
      rethrow;
    }
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

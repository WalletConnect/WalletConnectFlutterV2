import 'dart:convert';
import 'package:flutter/material.dart';
// ignore: depend_on_referenced_packages
import 'package:http/http.dart' as http;
import 'package:eth_sig_util/eth_sig_util.dart';
import 'package:get_it/get_it.dart';
import 'package:walletconnect_flutter_v2/walletconnect_flutter_v2.dart';
import 'package:walletconnect_flutter_v2_wallet/dependencies/i_web3wallet_service.dart';
import 'package:walletconnect_flutter_v2_wallet/dependencies/key_service/i_key_service.dart';
import 'package:walletconnect_flutter_v2_wallet/models/chain_metadata.dart';
import 'package:walletconnect_flutter_v2_wallet/utils/eth_utils.dart';
import 'package:walletconnect_flutter_v2_wallet/utils/methods_utils.dart';
import 'package:walletconnect_flutter_v2_wallet/widgets/wc_connection_widget/wc_connection_model.dart';

enum SupportedEVMMethods {
  ethSign,
  ethSignTransaction,
  ethSignTypedData,
  ethSignTypedDataV4,
  switchChain,
  personalSign,
  ethSendTransaction;

  String get name {
    switch (this) {
      case ethSign:
        return 'eth_sign';
      case ethSignTransaction:
        return 'eth_signTransaction';
      case ethSignTypedData:
        return 'eth_signTypedData';
      case ethSignTypedDataV4:
        return 'eth_signTypedData_v4';
      case switchChain:
        return 'wallet_switchEthereumChain';
      case personalSign:
        return 'personal_sign';
      case ethSendTransaction:
        return 'eth_sendTransaction';
    }
  }
}

class EVMService {
  final _web3Wallet = GetIt.I<IWeb3WalletService>().web3wallet;

  final ChainMetadata chainSupported;
  late final Web3Client ethClient;

  Map<String, dynamic Function(String, dynamic)> get sessionRequestHandlers => {
        SupportedEVMMethods.ethSign.name: ethSign,
        SupportedEVMMethods.ethSignTransaction.name: ethSignTransaction,
        SupportedEVMMethods.ethSignTypedData.name: ethSignTypedData,
        SupportedEVMMethods.ethSignTypedDataV4.name: ethSignTypedDataV4,
        SupportedEVMMethods.switchChain.name: switchChain,
        // 'wallet_addEthereumChain': addChain,
      };

  Map<String, dynamic Function(String, dynamic)> get methodRequestHandlers => {
        SupportedEVMMethods.personalSign.name: personalSign,
        SupportedEVMMethods.ethSendTransaction.name: ethSendTransaction,
      };

  EVMService({required this.chainSupported}) {
    ethClient = Web3Client(chainSupported.rpc.first, http.Client());

    for (final event in EventsConstants.allEvents) {
      _web3Wallet.registerEventEmitter(
        chainId: chainSupported.chainId,
        event: event,
      );
    }

    for (var handler in methodRequestHandlers.entries) {
      _web3Wallet.registerRequestHandler(
        chainId: chainSupported.chainId,
        method: handler.key,
        handler: handler.value,
      );
    }
    for (var handler in sessionRequestHandlers.entries) {
      _web3Wallet.registerRequestHandler(
        chainId: chainSupported.chainId,
        method: handler.key,
        handler: handler.value,
      );
    }

    _web3Wallet.onSessionRequest.subscribe(_onSessionRequest);
  }

  // personal_sign is handled using onSessionRequest event for demo purposes
  Future<void> personalSign(String topic, dynamic parameters) async {
    debugPrint('[SampleWallet] personalSign request: $parameters');
    final SessionRequest pRequest = _web3Wallet.pendingRequests.getAll().last;
    final address = EthUtils.getAddressFromSessionRequest(pRequest);
    final data = EthUtils.getDataFromSessionRequest(pRequest);
    final message = EthUtils.getUtf8Message(data.toString());
    var response = JsonRpcResponse(
      id: pRequest.id,
      jsonrpc: '2.0',
    );

    if (await MethodsUtils.requestApproval(
      message,
      method: pRequest.method,
      chainId: pRequest.chainId,
      address: address,
      transportType: pRequest.transportType.name,
    )) {
      try {
        // Load the private key
        final keys = GetIt.I<IKeyService>().getKeysForChain(
          chainSupported.chainId,
        );

        final pk = '0x${keys[0].privateKey}';
        final credentials = EthPrivateKey.fromHex(pk);
        final signature = credentials.signPersonalMessageToUint8List(
          utf8.encode(message),
        );
        final signedTx = bytesToHex(signature, include0x: true);

        isValidSignature(signedTx, message, credentials.address.hex);

        response = response.copyWith(result: signedTx);
      } catch (e) {
        debugPrint('[SampleWallet] personalSign error $e');
        response = response.copyWith(
          error: JsonRpcError(code: 0, message: e.toString()),
        );
      }
    } else {
      response = response.copyWith(
        error: const JsonRpcError(code: 5001, message: 'User rejected method'),
      );
    }

    _handleResponseForTopic(topic, response);
  }

  Future<void> ethSign(String topic, dynamic parameters) async {
    debugPrint('[SampleWallet] ethSign request: $parameters');
    final pRequest = _web3Wallet.pendingRequests.getAll().last;
    final data = EthUtils.getDataFromSessionRequest(pRequest);
    final message = EthUtils.getUtf8Message(data.toString());
    var response = JsonRpcResponse(
      id: pRequest.id,
      jsonrpc: '2.0',
    );

    if (await MethodsUtils.requestApproval(
      message,
      transportType: pRequest.transportType.name,
    )) {
      try {
        // Load the private key
        final keys = GetIt.I<IKeyService>().getKeysForChain(
          chainSupported.chainId,
        );

        final pk = '0x${keys[0].privateKey}';
        final credentials = EthPrivateKey.fromHex(pk);
        final signature = credentials.signPersonalMessageToUint8List(
          utf8.encode(message),
        );
        final signedTx = bytesToHex(signature, include0x: true);

        isValidSignature(signedTx, message, credentials.address.hex);

        response = response.copyWith(result: signedTx);
      } catch (e) {
        debugPrint('[SampleWallet] ethSign error $e');
        response = response.copyWith(
          error: JsonRpcError(code: 0, message: e.toString()),
        );
      }
    } else {
      response = response.copyWith(
        error: const JsonRpcError(code: 5001, message: 'User rejected method'),
      );
    }

    _handleResponseForTopic(topic, response);
  }

  Future<void> ethSignTypedData(String topic, dynamic parameters) async {
    debugPrint('[SampleWallet] ethSignTypedData request: $parameters');
    final pRequest = _web3Wallet.pendingRequests.getAll().last;
    final data = EthUtils.getDataFromSessionRequest(pRequest);
    var response = JsonRpcResponse(
      id: pRequest.id,
      jsonrpc: '2.0',
    );

    if (await MethodsUtils.requestApproval(
      data,
      transportType: pRequest.transportType.name,
    )) {
      try {
        final keys = GetIt.I<IKeyService>().getKeysForChain(
          chainSupported.chainId,
        );

        final signature = EthSigUtil.signTypedData(
          privateKey: keys[0].privateKey,
          jsonData: data,
          version: TypedDataVersion.V4,
        );

        response = response.copyWith(result: signature);
      } catch (e) {
        debugPrint('[SampleWallet] ethSignTypedData error $e');
        response = response.copyWith(
          error: JsonRpcError(code: 0, message: e.toString()),
        );
      }
    } else {
      response = response.copyWith(
        error: const JsonRpcError(code: 5001, message: 'User rejected method'),
      );
    }

    _handleResponseForTopic(topic, response);
  }

  Future<void> ethSignTypedDataV4(String topic, dynamic parameters) async {
    debugPrint('[SampleWallet] ethSignTypedDataV4 request: $parameters');
    final pRequest = _web3Wallet.pendingRequests.getAll().last;
    final data = EthUtils.getDataFromSessionRequest(pRequest);
    var response = JsonRpcResponse(
      id: pRequest.id,
      jsonrpc: '2.0',
    );

    if (await MethodsUtils.requestApproval(
      data,
      transportType: pRequest.transportType.name,
    )) {
      try {
        final keys = GetIt.I<IKeyService>().getKeysForChain(
          chainSupported.chainId,
        );

        final signature = EthSigUtil.signTypedData(
          privateKey: keys[0].privateKey,
          jsonData: data,
          version: TypedDataVersion.V4,
        );

        response = response.copyWith(result: signature);
      } catch (e) {
        debugPrint('[SampleWallet] ethSignTypedDataV4 error $e');
        response = response.copyWith(
          error: JsonRpcError(code: 0, message: e.toString()),
        );
      }
    } else {
      response = response.copyWith(
        error: const JsonRpcError(code: 5001, message: 'User rejected method'),
      );
    }

    _handleResponseForTopic(topic, response);
  }

  Future<void> ethSignTransaction(String topic, dynamic parameters) async {
    debugPrint('[SampleWallet] ethSignTransaction request: $parameters');
    final SessionRequest pRequest = _web3Wallet.pendingRequests.getAll().last;

    final data = EthUtils.getTransactionFromSessionRequest(pRequest);
    if (data == null) return;

    var response = JsonRpcResponse(
      id: pRequest.id,
      jsonrpc: '2.0',
    );

    final transaction = await _approveTransaction(
      data,
      method: pRequest.method,
      chainId: pRequest.chainId,
      transportType: pRequest.transportType.name,
    );
    if (transaction is Transaction) {
      try {
        // Load the private key
        final keys = GetIt.I<IKeyService>().getKeysForChain(
          chainSupported.chainId,
        );

        final pk = '0x${keys[0].privateKey}';
        final credentials = EthPrivateKey.fromHex(pk);
        final chainId = chainSupported.chainId.split(':').last;

        final signature = await ethClient.signTransaction(
          credentials,
          transaction,
          chainId: int.parse(chainId),
        );
        // Sign the transaction
        final signedTx = bytesToHex(signature, include0x: true);

        response = response.copyWith(result: signedTx);
      } on RPCError catch (e) {
        debugPrint('[SampleWallet] ethSignTransaction error $e');
        response = response.copyWith(
          error: JsonRpcError(code: e.errorCode, message: e.message),
        );
      } catch (e) {
        debugPrint('[SampleWallet] ethSignTransaction error $e');
        response = response.copyWith(
          error: JsonRpcError(code: 0, message: e.toString()),
        );
      }
    } else {
      response = response.copyWith(error: transaction as JsonRpcError);
    }

    _handleResponseForTopic(topic, response);
  }

  Future<void> ethSendTransaction(String topic, dynamic parameters) async {
    debugPrint('[SampleWallet] ethSendTransaction request: $parameters');
    final SessionRequest pRequest = _web3Wallet.pendingRequests.getAll().last;

    final data = EthUtils.getTransactionFromSessionRequest(pRequest);
    if (data == null) return;

    var response = JsonRpcResponse(
      id: pRequest.id,
      jsonrpc: '2.0',
    );

    final transaction = await _approveTransaction(
      data,
      method: pRequest.method,
      chainId: pRequest.chainId,
      transportType: pRequest.transportType.name,
    );
    if (transaction is Transaction) {
      try {
        // Load the private key
        final keys = GetIt.I<IKeyService>().getKeysForChain(
          chainSupported.chainId,
        );

        final pk = '0x${keys[0].privateKey}';
        final credentials = EthPrivateKey.fromHex(pk);
        final chainId = chainSupported.chainId.split(':').last;

        final signedTx = await ethClient.sendTransaction(
          credentials,
          transaction,
          chainId: int.parse(chainId),
        );

        response = response.copyWith(result: signedTx);
      } on RPCError catch (e) {
        debugPrint('[SampleWallet] ethSendTransaction error $e');
        response = response.copyWith(
          error: JsonRpcError(code: e.errorCode, message: e.message),
        );
      } catch (e) {
        debugPrint('[SampleWallet] ethSendTransaction error $e');
        response = response.copyWith(
          error: JsonRpcError(code: 0, message: e.toString()),
        );
      }
    } else {
      response = response.copyWith(error: transaction as JsonRpcError);
    }

    _handleResponseForTopic(topic, response);
  }

  Future<void> switchChain(String topic, dynamic parameters) async {
    debugPrint('[SampleWallet] switchChain request: $topic $parameters');
    final pRequest = _web3Wallet.pendingRequests.getAll().last;
    var response = JsonRpcResponse(id: pRequest.id, jsonrpc: '2.0');
    try {
      final params = (parameters as List).first as Map<String, dynamic>;
      final hexChainId = params['chainId'].toString().replaceFirst('0x', '');
      final chainId = int.parse(hexChainId, radix: 16);
      await _web3Wallet.emitSessionEvent(
        topic: topic,
        chainId: 'eip155:$chainId',
        event: SessionEventParams(
          name: 'chainChanged',
          data: chainId,
        ),
      );
      response = response.copyWith(result: true);
    } on WalletConnectError catch (e) {
      debugPrint('[SampleWallet] switchChain error $e');
      response = response.copyWith(
        error: JsonRpcError(code: e.code, message: e.message),
      );
    } catch (e) {
      debugPrint('[SampleWallet] switchChain error $e');
      response = response.copyWith(
        error: JsonRpcError(code: 0, message: e.toString()),
      );
    }

    _handleResponseForTopic(topic, response);
  }

  void _handleResponseForTopic(String topic, JsonRpcResponse response) async {
    final session = _web3Wallet.sessions.get(topic);

    try {
      await _web3Wallet.respondSessionRequest(
        topic: topic,
        response: response,
      );
      MethodsUtils.handleRedirect(
        topic,
        session!.peer.metadata.redirect,
        response.error?.message,
      );
    } on WalletConnectError catch (error) {
      MethodsUtils.handleRedirect(
        topic,
        session!.peer.metadata.redirect,
        error.message,
      );
    }
  }

  // Future<void> addChain(String topic, dynamic parameters) async {
  //   final pRequest = _web3Wallet.pendingRequests.getAll().last;
  //   await _web3Wallet.respondSessionRequest(
  //     topic: topic,
  //     response: JsonRpcResponse(
  //       id: pRequest.id,
  //       jsonrpc: '2.0',
  //       result: true,
  //     ),
  //   );
  //   CommonMethods.goBackToDapp(topic, true);
  // }

  Future<dynamic> _approveTransaction(
    Map<String, dynamic> tJson, {
    String? title,
    String? method,
    String? chainId,
    required String transportType,
  }) async {
    Transaction transaction = tJson.toTransaction();

    final gasPrice = await ethClient.getGasPrice();
    try {
      final gasLimit = await ethClient.estimateGas(
        sender: transaction.from,
        to: transaction.to,
        value: transaction.value,
        data: transaction.data,
        gasPrice: gasPrice,
      );

      transaction = transaction.copyWith(
        gasPrice: gasPrice,
        maxGas: gasLimit.toInt(),
      );
    } on RPCError catch (e) {
      return JsonRpcError(code: e.errorCode, message: e.message);
    }

    final gweiGasPrice = (transaction.gasPrice?.getInWei ?? BigInt.zero) /
        BigInt.from(1000000000);

    const encoder = JsonEncoder.withIndent('  ');
    final trx = encoder.convert(tJson);

    if (await MethodsUtils.requestApproval(
      trx,
      title: title,
      method: method,
      chainId: chainId,
      transportType: transportType,
      extraModels: [
        WCConnectionModel(
          title: 'Gas price',
          elements: ['${gweiGasPrice.toStringAsFixed(2)} GWEI'],
        ),
      ],
    )) {
      return transaction;
    }

    return const JsonRpcError(code: 5001, message: 'User rejected method');
  }

  void _onSessionRequest(SessionRequestEvent? args) async {
    if (args != null && args.chainId == chainSupported.chainId) {
      debugPrint('[SampleWallet] _onSessionRequest ${args.toString()}');
      final handler = sessionRequestHandlers[args.method];
      if (handler != null) {
        await handler(args.topic, args.params);
      }
    }
  }

  bool isValidSignature(
    String hexSignature,
    String message,
    String hexAddress,
  ) {
    try {
      debugPrint(
          '[SampleWallet] isValidSignature: $hexSignature, $message, $hexAddress');
      final recoveredAddress = EthSigUtil.recoverPersonalSignature(
        signature: hexSignature,
        message: utf8.encode(message),
      );
      debugPrint('[SampleWallet] recoveredAddress: $recoveredAddress');

      final recoveredAddress2 = EthSigUtil.recoverSignature(
        signature: hexSignature,
        message: utf8.encode(message),
      );
      debugPrint('[SampleWallet] recoveredAddress2: $recoveredAddress2');

      final isValid = recoveredAddress == hexAddress;
      return isValid;
    } catch (e) {
      return false;
    }
  }
}

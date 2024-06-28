import 'dart:convert';
import 'package:flutter/material.dart';
// ignore: depend_on_referenced_packages
import 'package:http/http.dart' as http;
import 'package:eth_sig_util/eth_sig_util.dart';
import 'package:get_it/get_it.dart';
import 'package:walletconnect_flutter_v2/walletconnect_flutter_v2.dart';
import 'package:walletconnect_flutter_v2_wallet/dependencies/bottom_sheet/i_bottom_sheet_service.dart';
import 'package:walletconnect_flutter_v2_wallet/dependencies/chains/common.dart';
import 'package:walletconnect_flutter_v2_wallet/dependencies/i_web3wallet_service.dart';
import 'package:walletconnect_flutter_v2_wallet/dependencies/key_service/i_key_service.dart';
import 'package:walletconnect_flutter_v2_wallet/models/chain_metadata.dart';
import 'package:walletconnect_flutter_v2_wallet/utils/constants.dart';
import 'package:walletconnect_flutter_v2_wallet/utils/eth_utils.dart';
import 'package:walletconnect_flutter_v2_wallet/widgets/wc_connection_widget/wc_connection_model.dart';
import 'package:walletconnect_flutter_v2_wallet/widgets/wc_connection_widget/wc_connection_widget.dart';
import 'package:walletconnect_flutter_v2_wallet/widgets/wc_request_widget.dart/wc_request_widget.dart';

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
  final _bottomSheetService = GetIt.I<IBottomSheetService>();
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
    debugPrint('[WALLET] personalSign request: $parameters');
    final pRequest = _web3Wallet.pendingRequests.getAll().last;
    final data = EthUtils.getDataFromParamsList(parameters);
    final message = EthUtils.getUtf8Message(data.toString());
    var response = JsonRpcResponse(
      id: pRequest.id,
      jsonrpc: '2.0',
    );

    if (await CommonMethods.requestApproval(message)) {
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
        debugPrint('[WALLET] personalSign error $e');
        response = response.copyWith(
          error: JsonRpcError(code: 0, message: e.toString()),
        );
      }
    } else {
      response = response.copyWith(
        error: const JsonRpcError(code: 5001, message: 'User rejected method'),
      );
    }

    await _web3Wallet.respondSessionRequest(
      topic: topic,
      response: response,
    );

    CommonMethods.goBackToDapp(topic, response.result ?? response.error);
  }

  Future<void> ethSign(String topic, dynamic parameters) async {
    debugPrint('[WALLET] ethSign request: $parameters');
    final pRequest = _web3Wallet.pendingRequests.getAll().last;
    final data = EthUtils.getDataFromParamsList(parameters);
    final message = EthUtils.getUtf8Message(data.toString());
    var response = JsonRpcResponse(
      id: pRequest.id,
      jsonrpc: '2.0',
    );

    if (await CommonMethods.requestApproval(message)) {
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
        debugPrint('[WALLET] ethSign error $e');
        response = response.copyWith(
          error: JsonRpcError(code: 0, message: e.toString()),
        );
      }
    } else {
      response = response.copyWith(
        error: const JsonRpcError(code: 5001, message: 'User rejected method'),
      );
    }

    await _web3Wallet.respondSessionRequest(
      topic: topic,
      response: response,
    );

    CommonMethods.goBackToDapp(topic, response.result ?? response.error);
  }

  Future<void> ethSignTypedData(String topic, dynamic parameters) async {
    debugPrint('[WALLET] ethSignTypedData request: $parameters');
    final pRequest = _web3Wallet.pendingRequests.getAll().last;
    final data = EthUtils.getDataFromParamsList(parameters);
    var response = JsonRpcResponse(
      id: pRequest.id,
      jsonrpc: '2.0',
    );

    if (await CommonMethods.requestApproval(data)) {
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
        debugPrint('[WALLET] ethSignTypedData error $e');
        response = response.copyWith(
          error: JsonRpcError(code: 0, message: e.toString()),
        );
      }
    } else {
      response = response.copyWith(
        error: const JsonRpcError(code: 5001, message: 'User rejected method'),
      );
    }

    await _web3Wallet.respondSessionRequest(
      topic: topic,
      response: response,
    );

    CommonMethods.goBackToDapp(topic, response.result ?? response.error);
  }

  Future<void> ethSignTypedDataV4(String topic, dynamic parameters) async {
    debugPrint('[WALLET] ethSignTypedDataV4 request: $parameters');
    final pRequest = _web3Wallet.pendingRequests.getAll().last;
    final data = EthUtils.getDataFromParamsList(parameters);
    var response = JsonRpcResponse(
      id: pRequest.id,
      jsonrpc: '2.0',
    );

    if (await CommonMethods.requestApproval(data)) {
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
        debugPrint('[WALLET] ethSignTypedDataV4 error $e');
        response = response.copyWith(
          error: JsonRpcError(code: 0, message: e.toString()),
        );
      }
    } else {
      response = response.copyWith(
        error: const JsonRpcError(code: 5001, message: 'User rejected method'),
      );
    }

    await _web3Wallet.respondSessionRequest(
      topic: topic,
      response: response,
    );

    CommonMethods.goBackToDapp(topic, response.result ?? response.error);
  }

  Future<void> ethSignTransaction(String topic, dynamic parameters) async {
    debugPrint('[WALLET] ethSignTransaction request: $parameters');
    final pRequest = _web3Wallet.pendingRequests.getAll().last;
    final data = EthUtils.getTransactionFromParams(parameters);
    if (data == null) return;
    var response = JsonRpcResponse(
      id: pRequest.id,
      jsonrpc: '2.0',
    );

    final transaction = await _approveTransaction(data);
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
        debugPrint('[WALLET] ethSignTransaction error $e');
        response = response.copyWith(
          error: JsonRpcError(code: e.errorCode, message: e.message),
        );
      } catch (e) {
        debugPrint('[WALLET] ethSignTransaction error $e');
        response = response.copyWith(
          error: JsonRpcError(code: 0, message: e.toString()),
        );
      }
    } else {
      response = response.copyWith(error: transaction as JsonRpcError);
    }

    await _web3Wallet.respondSessionRequest(
      topic: topic,
      response: response,
    );

    CommonMethods.goBackToDapp(topic, response.result ?? response.error);
  }

  Future<void> ethSendTransaction(String topic, dynamic parameters) async {
    debugPrint('[WALLET] ethSendTransaction request: $parameters');
    final pRequest = _web3Wallet.pendingRequests.getAll().last;
    final data = EthUtils.getTransactionFromParams(parameters);
    if (data == null) return;
    var response = JsonRpcResponse(
      id: pRequest.id,
      jsonrpc: '2.0',
    );

    final transaction = await _approveTransaction(data);
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
        debugPrint('[WALLET] ethSendTransaction error $e');
        response = response.copyWith(
          error: JsonRpcError(code: e.errorCode, message: e.message),
        );
      } catch (e) {
        debugPrint('[WALLET] ethSendTransaction error $e');
        response = response.copyWith(
          error: JsonRpcError(code: 0, message: e.toString()),
        );
      }
    } else {
      response = response.copyWith(error: transaction as JsonRpcError);
    }

    await _web3Wallet.respondSessionRequest(
      topic: topic,
      response: response,
    );

    CommonMethods.goBackToDapp(topic, response.result ?? response.error);
  }

  Future<void> switchChain(String topic, dynamic parameters) async {
    debugPrint('[WALLET] switchChain request: $topic $parameters');
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
      debugPrint('[WALLET] switchChain error $e');
      response = response.copyWith(
        error: JsonRpcError(code: e.code, message: e.message),
      );
    } catch (e) {
      debugPrint('[WALLET] switchChain error $e');
      response = response.copyWith(
        error: JsonRpcError(code: 0, message: e.toString()),
      );
    }

    await _web3Wallet.respondSessionRequest(
      topic: topic,
      response: response,
    );

    CommonMethods.goBackToDapp(topic, true);
  }

  // Future<void> addChain(String topic, dynamic parameters) async {
  //   debugPrint('[WALLET] addChain request: $topic $parameters');
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

  Future<dynamic> _approveTransaction(Map<String, dynamic> tJson) async {
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
      await _bottomSheetService.queueBottomSheet(
        widget: Container(
          color: Colors.white,
          height: 210.0,
          width: double.infinity,
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              Icon(
                Icons.error_outline_sharp,
                color: Colors.red[100],
                size: 80.0,
              ),
              Text(
                'Error',
                style: StyleConstants.subtitleText.copyWith(
                  color: Colors.black,
                  fontSize: 18.0,
                ),
              ),
              Text(e.message),
            ],
          ),
        ),
      );

      return JsonRpcError(code: e.errorCode, message: e.message);
    }

    final gweiGasPrice = (transaction.gasPrice?.getInWei ?? BigInt.zero) /
        BigInt.from(1000000000);

    final WCBottomSheetResult rs = (await _bottomSheetService.queueBottomSheet(
          widget: WCRequestWidget(
            child: WCConnectionWidget(
              title: 'Approve Transaction',
              info: [
                WCConnectionModel(elements: [jsonEncode(tJson)]),
                WCConnectionModel(
                  title: 'Gas price',
                  elements: ['${gweiGasPrice.toStringAsFixed(2)} GWEI'],
                ),
              ],
            ),
          ),
        )) ??
        WCBottomSheetResult.reject;

    if (rs != WCBottomSheetResult.reject) {
      return transaction;
    }

    return const JsonRpcError(code: 5001, message: 'User rejected method');
  }

  void _onSessionRequest(SessionRequestEvent? args) async {
    if (args != null && args.chainId == chainSupported.chainId) {
      debugPrint('[WALLET] _onSessionRequest ${args.toString()}');
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
      debugPrint('isValidSignature(): $hexSignature, $message, $hexAddress');
      final recoveredAddress = EthSigUtil.recoverPersonalSignature(
        signature: hexSignature,
        message: utf8.encode(message),
      );
      debugPrint('recoveredAddress: $recoveredAddress');

      final recoveredAddress2 = EthSigUtil.recoverSignature(
        signature: hexSignature,
        message: utf8.encode(message),
      );
      debugPrint('recoveredAddress2: $recoveredAddress2');

      final isValid = recoveredAddress == hexAddress;
      debugPrint('isValidSignature: $isValid');
      return isValid;
    } catch (e) {
      debugPrint('isValidSignature() error, $e');
      return false;
    }
  }
}

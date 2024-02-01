import 'dart:convert';
import 'package:flutter/foundation.dart';
// ignore: depend_on_referenced_packages
import 'package:http/http.dart' as http;
import 'package:convert/convert.dart';
import 'package:eth_sig_util/eth_sig_util.dart';
import 'package:get_it/get_it.dart';
import 'package:walletconnect_flutter_v2/walletconnect_flutter_v2.dart';
import 'package:walletconnect_flutter_v2_wallet/dependencies/bottom_sheet/i_bottom_sheet_service.dart';
import 'package:walletconnect_flutter_v2_wallet/dependencies/deep_link_handler.dart';
import 'package:walletconnect_flutter_v2_wallet/dependencies/i_web3wallet_service.dart';
import 'package:walletconnect_flutter_v2_wallet/dependencies/key_service/i_key_service.dart';
import 'package:walletconnect_flutter_v2_wallet/models/chain_data.dart';
import 'package:walletconnect_flutter_v2_wallet/utils/eth_utils.dart';
import 'package:walletconnect_flutter_v2_wallet/widgets/wc_connection_widget/wc_connection_model.dart';
import 'package:walletconnect_flutter_v2_wallet/widgets/wc_connection_widget/wc_connection_widget.dart';
import 'package:walletconnect_flutter_v2_wallet/widgets/wc_request_widget.dart/wc_request_widget.dart';

enum EVMChainsSupported {
  ethereum,
  polygon,
  arbitrum,
  sepolia,
  // bsc,
  mumbai;

  String chain() {
    String id = '';

    switch (this) {
      case EVMChainsSupported.ethereum:
        id = '1';
        break;
      case EVMChainsSupported.polygon:
        id = '137';
        break;
      case EVMChainsSupported.arbitrum:
        id = '42161';
        break;
      case EVMChainsSupported.sepolia:
        id = '11155111';
        break;
      // case EVMChainsSupported.bsc:
      //   id = '56';
      //   break;
      case EVMChainsSupported.mumbai:
        id = '80001';
        break;
    }

    return 'eip155:$id';
  }
}

class EVMService {
  final _bottomSheetService = GetIt.I<IBottomSheetService>();
  final _web3WalletService = GetIt.I<IWeb3WalletService>();
  final _web3Wallet = GetIt.I<IWeb3WalletService>().getWeb3Wallet();

  final EVMChainsSupported chainSupported;
  late final Web3Client ethClient;

  EVMService({required this.chainSupported}) {
    final supportedId = chainSupported.chain();
    final chainMetadata = ChainData.allChains.firstWhere(
      (c) => c.chainId == supportedId,
    );
    debugPrint('supportedId $supportedId - ${chainMetadata.rpc.first}');
    ethClient = Web3Client(chainMetadata.rpc.first, http.Client());

    const supportedEvents = EventsConstants.requiredEvents;
    for (final String event in supportedEvents) {
      debugPrint('Supported event ${chainSupported.chain()} $event');
      _web3Wallet.registerEventEmitter(
        chainId: chainSupported.chain(),
        event: event,
      );
    }
    // Supported methods
    Map<String, dynamic Function(String, dynamic)> methodsHandlers = {
      'personal_sign': personalSign,
      'eth_sign': ethSign,
      'eth_signTransaction': ethSignTransaction,
      'eth_signTypedData': ethSignTypedData,
      'eth_sendTransaction': ethSendTransaction,
      'eth_signTypedData_v4': ethSignTypedData,
      'wallet_switchEthereumChain': switchChain,
      'wallet_addEthereumChain': addChain,
      // add whatever method/handler you want to support
    };

    for (var handler in methodsHandlers.entries) {
      _web3Wallet.registerRequestHandler(
        chainId: chainSupported.chain(),
        method: handler.key,
        handler: handler.value,
      );
    }
  }

  Future<dynamic> personalSign(String topic, dynamic parameters) async {
    debugPrint('[$runtimeType] personalSign request: $parameters');
    dynamic result;
    final data = EthUtils.getDataFromParamsList(parameters);
    final message = EthUtils.getUtf8Message(data.toString());

    if (await requestApproval(message)) {
      try {
        // Load the private key
        final keys = GetIt.I<IKeyService>().getKeysForChain(
          chainSupported.chain(),
        );
        final credentials = EthPrivateKey.fromHex(keys[0].privateKey);

        final String signature = hex.encode(
          credentials.signPersonalMessageToUint8List(
            Uint8List.fromList(utf8.encode(message)),
          ),
        );

        result = '0x$signature';
      } catch (e) {
        debugPrint('[$runtimeType] personalSign error $e');
        result = JsonRpcError(code: 0, message: e.toString());
      }
    } else {
      result = const JsonRpcError(code: 5001, message: 'User rejected method');
    }

    final session = _web3Wallet.sessions.get(topic);
    final scheme = session?.peer.metadata.redirect?.native ?? '';
    DeepLinkHandler.goTo(scheme, delay: 300, modalTitle: 'Success');

    return result;
  }

  Future<dynamic> ethSign(String topic, dynamic parameters) async {
    debugPrint('[$runtimeType] ethSign request: $parameters');
    dynamic result;
    final data = EthUtils.getDataFromParamsList(parameters);
    final message = EthUtils.getUtf8Message(data.toString());

    if (await requestApproval(message)) {
      try {
        // Load the private key
        final keys = GetIt.I<IKeyService>().getKeysForChain(
          chainSupported.chain(),
        );
        final credentials = EthPrivateKey.fromHex(keys[0].privateKey);

        final signature = hex.encode(
          credentials.signPersonalMessageToUint8List(
            Uint8List.fromList(utf8.encode(message)),
          ),
        );

        result = '0x$signature';
      } catch (e) {
        debugPrint('[$runtimeType] ethSign error $e');
        result = JsonRpcError(code: 0, message: e.toString());
      }
    } else {
      result = const JsonRpcError(code: 5001, message: 'User rejected method');
    }

    final session = _web3Wallet.sessions.get(topic);
    final scheme = session?.peer.metadata.redirect?.native ?? '';
    DeepLinkHandler.goTo(scheme, delay: 300, modalTitle: 'Success');

    return result;
  }

  Future<dynamic> ethSignTypedData(String topic, dynamic parameters) async {
    debugPrint('[$runtimeType] ethSignTypedData request: $parameters');
    dynamic result;
    final data = parameters[1] as String;

    if (await requestApproval(data)) {
      try {
        final keys = GetIt.I<IKeyService>().getKeysForChain(
          chainSupported.chain(),
        );

        result = EthSigUtil.signTypedData(
          privateKey: keys[0].privateKey,
          jsonData: data,
          version: TypedDataVersion.V4,
        );
      } catch (e) {
        debugPrint('[$runtimeType] ethSignTypedData error $e');
        result = JsonRpcError(code: 0, message: e.toString());
      }
    } else {
      result = const JsonRpcError(code: 5001, message: 'User rejected method');
    }

    final session = _web3Wallet.sessions.get(topic);
    final scheme = session?.peer.metadata.redirect?.native ?? '';
    DeepLinkHandler.goTo(scheme, delay: 300, modalTitle: 'Success');

    return result;
  }

  Future<void> switchChain(String topic, dynamic parameters) async {
    debugPrint('received switchChain request: $topic $parameters');
    final params = (parameters as List).first as Map<String, dynamic>;
    final hexChainId = params['chainId'].toString().replaceFirst('0x', '');
    final chainId = int.parse(hexChainId, radix: 16);
    final web3wallet = _web3WalletService.getWeb3Wallet();
    await web3wallet.emitSessionEvent(
      topic: topic,
      chainId: 'eip155:$chainId',
      event: SessionEventParams(
        name: 'chainChanged',
        data: chainId,
      ),
    );
  }

  Future<dynamic> ethSignTransaction(String topic, dynamic parameters) async {
    debugPrint('[$runtimeType] ethSignTransaction request: $parameters');
    dynamic result;

    final tJson = parameters[0] as Map<String, dynamic>;
    final transaction = await approveTransaction(tJson);
    if (transaction != null) {
      try {
        // Load the private key
        final keys = GetIt.I<IKeyService>().getKeysForChain(
          chainSupported.chain(),
        );
        final credentials = EthPrivateKey.fromHex('0x${keys[0].privateKey}');
        final chainId = chainSupported.chain().split(':').last;

        final signature = await ethClient.signTransaction(
          credentials,
          transaction,
          chainId: int.parse(chainId),
        );

        // Sign the transaction
        final signedTx = hex.encode(signature);

        // Return the signed transaction as a hexadecimal string
        result = '0x$signedTx';
      } catch (e) {
        debugPrint('[$runtimeType] ethSignTransaction error $e');
        result = JsonRpcError(code: 0, message: e.toString());
      }
    } else {
      result = const JsonRpcError(code: 5001, message: 'User rejected method');
    }

    final session = _web3Wallet.sessions.get(topic);
    final scheme = session?.peer.metadata.redirect?.native ?? '';
    DeepLinkHandler.goTo(scheme, delay: 300, modalTitle: 'Success');

    return result;
  }

  Future<dynamic> ethSendTransaction(String topic, dynamic parameters) async {
    debugPrint('[$runtimeType] ethSendTransaction request: $parameters');
    dynamic result;

    final tJson = parameters[0] as Map<String, dynamic>;
    final transaction = await approveTransaction(tJson);
    if (transaction != null) {
      try {
        // Load the private key
        final keys = GetIt.I<IKeyService>().getKeysForChain(
          chainSupported.chain(),
        );
        final credentials = EthPrivateKey.fromHex('0x${keys[0].privateKey}');

        final chainId = chainSupported.chain().split(':').last;
        debugPrint('[$runtimeType] ethSendTransaction chainId: $chainId');

        final signedTx = await ethClient.sendTransaction(
          credentials,
          transaction,
          chainId: int.parse(chainId),
        );

        result = '0x$signedTx';
      } catch (e) {
        debugPrint('[$runtimeType] ethSendTransaction error $e');
        result = JsonRpcError(code: 0, message: e.toString());
      }
    } else {
      result = const JsonRpcError(code: 5001, message: 'User rejected method');
    }

    final session = _web3Wallet.sessions.get(topic);
    final scheme = session?.peer.metadata.redirect?.native ?? '';
    DeepLinkHandler.goTo(scheme, delay: 300, modalTitle: 'Success');

    return result;
  }

  Future<void> addChain(String topic, dynamic parameters) async {
    debugPrint('received addChain request: $topic $parameters');
  }

  Future<bool> requestApproval(String text) async {
    final approved = await _bottomSheetService.queueBottomSheet(
      widget: WCRequestWidget(
        child: WCConnectionWidget(
          title: 'Approve Request',
          info: [
            WCConnectionModel(text: text),
          ],
        ),
      ),
    );

    return approved ?? false;
  }

  Future<Transaction?> approveTransaction(Map<String, dynamic> tJson) async {
    String? tValue = tJson['value'];
    EtherAmount? value;
    if (tValue != null) {
      tValue = tValue.replaceFirst('0x', '');
      value = EtherAmount.fromBigInt(
        EtherUnit.wei,
        BigInt.from(int.parse(tValue, radix: 16)),
      );
    }
    Transaction transaction = Transaction(
      from: EthereumAddress.fromHex(tJson['from']),
      to: EthereumAddress.fromHex(tJson['to']),
      value: value,
      gasPrice: tJson['gasPrice'],
      maxFeePerGas: tJson['maxFeePerGas'],
      maxPriorityFeePerGas: tJson['maxPriorityFeePerGas'],
      maxGas: tJson['maxGas'],
      nonce: tJson['nonce'],
      data: (tJson['data'] != null && tJson['data'] != '0x')
          ? Uint8List.fromList(hex.decode(tJson['data']!))
          : null,
    );

    final gasPrice = await ethClient.getGasPrice();
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

    final gweiGasPrice = (transaction.gasPrice?.getInWei ?? BigInt.zero) /
        BigInt.from(1000000000);

    final approved = await _bottomSheetService.queueBottomSheet(
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
    );

    if (approved == true) {
      return transaction;
    }

    return null;
  }
}

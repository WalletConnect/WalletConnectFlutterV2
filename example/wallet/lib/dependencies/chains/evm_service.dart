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
import 'package:walletconnect_flutter_v2_wallet/models/eth/ethereum_transaction.dart';
import 'package:walletconnect_flutter_v2_wallet/utils/eth_utils.dart';
import 'package:walletconnect_flutter_v2_wallet/widgets/wc_connection_widget/wc_connection_model.dart';
import 'package:walletconnect_flutter_v2_wallet/widgets/wc_connection_widget/wc_connection_widget.dart';
import 'package:walletconnect_flutter_v2_wallet/widgets/wc_request_widget.dart/wc_request_widget.dart';

enum EVMChainsSupported {
  ethereum,
  polygon,
  arbitrum,
  goerli,
  bsc,
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
      case EVMChainsSupported.goerli:
        id = '5';
        break;
      case EVMChainsSupported.bsc:
        id = '56';
        break;
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
  final Web3Client ethClient;

  EVMService({required this.chainSupported, Web3Client? ethClient})
      : ethClient = ethClient ??
            Web3Client(
                'https://mainnet.infura.io/v3/51716d2096df4e73bec298680a51f0c5',
                http.Client()) {
    // Supported events
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
      'eth_sendTransaction': ethSignTransaction,
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

  Future<String?> personalSign(String topic, dynamic parameters) async {
    debugPrint('[$runtimeType] personalSign request: $parameters');
    String? result;
    final data = EthUtils.getDataFromParamsList(parameters);
    final message = EthUtils.getUtf8Message(data.toString());

    result = await requestApproval(message);
    if (result == null) {
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
        result = e.toString();
      }
    }

    final session = _web3Wallet.sessions.get(topic);
    final scheme = session?.peer.metadata.redirect?.native ?? '';
    DeepLinkHandler.goTo(scheme, delay: 300, modalTitle: 'Success');

    return result;
  }

  Future<String?> ethSign(String topic, dynamic parameters) async {
    debugPrint('[$runtimeType] ethSign request: $parameters');
    String? result;
    final data = EthUtils.getDataFromParamsList(parameters);
    final message = EthUtils.getUtf8Message(data.toString());

    result = await requestApproval(message);
    if (result == null) {
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
        result = e.toString();
      }
    }

    final session = _web3Wallet.sessions.get(topic);
    final scheme = session?.peer.metadata.redirect?.native ?? '';
    DeepLinkHandler.goTo(scheme, delay: 300, modalTitle: 'Success');

    return result;
  }

  Future<String?> ethSignTransaction(String topic, dynamic parameters) async {
    debugPrint('[$runtimeType] ethSignTransaction request: $parameters');
    String? result;

    result = await requestApproval(jsonEncode(parameters[0]));
    if (result == null) {
      // Load the private key
      final keys = GetIt.I<IKeyService>().getKeysForChain(
        chainSupported.chain(),
      );
      final credentials = EthPrivateKey.fromHex('0x${keys[0].privateKey}');

      final ethTransaction = EthereumTransaction.fromJson(parameters[0]);

      // Construct a transaction from the EthereumTransaction object
      final transaction = Transaction(
        from: EthereumAddress.fromHex(ethTransaction.from),
        to: EthereumAddress.fromHex(ethTransaction.to),
        value: EtherAmount.fromBigInt(
          EtherUnit.wei,
          BigInt.tryParse(ethTransaction.value) ?? BigInt.zero,
        ),
        gasPrice: ethTransaction.gasPrice != null
            ? EtherAmount.fromBigInt(
                EtherUnit.wei,
                BigInt.tryParse(ethTransaction.gasPrice!) ?? BigInt.zero,
              )
            : null,
        maxFeePerGas: ethTransaction.maxFeePerGas != null
            ? EtherAmount.fromBigInt(
                EtherUnit.wei,
                BigInt.tryParse(ethTransaction.maxFeePerGas!) ?? BigInt.zero,
              )
            : null,
        maxPriorityFeePerGas: ethTransaction.maxPriorityFeePerGas != null
            ? EtherAmount.fromBigInt(
                EtherUnit.wei,
                BigInt.tryParse(ethTransaction.maxPriorityFeePerGas!) ??
                    BigInt.zero,
              )
            : null,
        maxGas: int.tryParse(ethTransaction.gasLimit ?? ''),
        nonce: int.tryParse(ethTransaction.nonce ?? ''),
        data: (ethTransaction.data != null && ethTransaction.data != '0x')
            ? Uint8List.fromList(hex.decode(ethTransaction.data!))
            : null,
      );

      try {
        final signature = await ethClient.signTransaction(
          credentials,
          transaction,
        );

        // Sign the transaction
        final signedTx = hex.encode(signature);

        // Return the signed transaction as a hexadecimal string
        result = '0x$signedTx';
      } catch (e) {
        debugPrint('[$runtimeType] ethSignTransaction error $e');
        result = e.toString();
      }
    }

    final session = _web3Wallet.sessions.get(topic);
    final scheme = session?.peer.metadata.redirect?.native ?? '';
    DeepLinkHandler.goTo(scheme, delay: 300, modalTitle: 'Success');

    return result;
  }

  Future<String?> ethSignTypedData(String topic, dynamic parameters) async {
    debugPrint('[$runtimeType] ethSignTypedData request: $parameters');
    String? result;
    final data = parameters[1] as String;

    result = await requestApproval(data);
    if (result == null) {
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
        result = e.toString();
      }
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

  Future<void> addChain(String topic, dynamic parameters) async {
    debugPrint('received addChain request: $topic $parameters');
  }

  Future<String?> requestApproval(String text) async {
    final approved = await _bottomSheetService.queueBottomSheet(
      widget: WCRequestWidget(
        child: WCConnectionWidget(
          title: 'Sign Transaction',
          info: [
            WCConnectionModel(text: text),
          ],
        ),
      ),
    );

    if (approved != null && approved == false) {
      return 'User rejected signature';
    }

    return null;
  }
}

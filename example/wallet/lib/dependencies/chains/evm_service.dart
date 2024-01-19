import 'dart:convert';
// ignore: depend_on_referenced_packages
import 'package:http/http.dart' as http;
import 'dart:typed_data';

import 'package:convert/convert.dart';
import 'package:eth_sig_util/eth_sig_util.dart';
import 'package:get_it/get_it.dart';
import 'package:walletconnect_flutter_v2/walletconnect_flutter_v2.dart';
import 'package:walletconnect_flutter_v2_wallet/dependencies/bottom_sheet/i_bottom_sheet_service.dart';
import 'package:walletconnect_flutter_v2_wallet/dependencies/i_web3wallet_service.dart';
import 'package:walletconnect_flutter_v2_wallet/dependencies/key_service/chain_key.dart';
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

  final EVMChainsSupported chainSupported;
  final Web3Client ethClient;

  EVMService({
    required this.chainSupported,
    Web3Client? ethClient,
  }) : ethClient = ethClient ??
            Web3Client(
                'https://mainnet.infura.io/v3/51716d2096df4e73bec298680a51f0c5',
                http.Client()) {
    final wallet = _web3WalletService.getWeb3Wallet();

    // Supported events
    const supportedEvents = EventsConstants.requiredEvents;
    for (final String event in supportedEvents) {
      print('Supported event ${chainSupported.chain()} $event');
      wallet.registerEventEmitter(
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
      wallet.registerRequestHandler(
        chainId: chainSupported.chain(),
        method: handler.key,
        handler: handler.value,
      );
    }
  }

  Future<String?> requestAuthorization(String text) async {
    final bool? approved = await _bottomSheetService.queueBottomSheet(
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

  Future<String?> personalSign(String topic, dynamic parameters) async {
    print('received personal sign request: $parameters');

    final data = EthUtils.getDataFromParamsList(parameters);
    final String message = EthUtils.getUtf8Message(data.toString());

    final String? authAcquired = await requestAuthorization(message);
    if (authAcquired != null) {
      return authAcquired;
    }

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

      return '0x$signature';
    } catch (e) {
      print(e);
      return 'Failed';
    }
  }

  Future<String?> ethSign(String topic, dynamic parameters) async {
    print('received eth sign request: $parameters');

    final String message = EthUtils.getUtf8Message(parameters[1]);

    final String? authAcquired = await requestAuthorization(message);
    if (authAcquired != null) {
      return authAcquired;
    }

    try {
      // Load the private key
      final List<ChainKey> keys = GetIt.I<IKeyService>().getKeysForChain(
        chainSupported.chain(),
      );

      final EthPrivateKey credentials = EthPrivateKey.fromHex(
        keys[0].privateKey,
      );
      final String signature = hex.encode(
        credentials.signPersonalMessageToUint8List(
          Uint8List.fromList(
            utf8.encode(message),
          ),
        ),
      );
      print(signature);

      return '0x$signature';
    } catch (e) {
      print('error:');
      print(e);
      return 'Failed';
    }
  }

  Future<String?> ethSignTransaction(String topic, dynamic parameters) async {
    print('received eth sign transaction request: $parameters');
    final String? authAcquired = await requestAuthorization(
      jsonEncode(
        parameters[0],
      ),
    );
    if (authAcquired != null) {
      return authAcquired;
    }

    // Load the private key
    final List<ChainKey> keys = GetIt.I<IKeyService>().getKeysForChain(
      chainSupported.chain(),
    );
    final Credentials credentials = EthPrivateKey.fromHex(
      '0x${keys[0].privateKey}',
    );

    EthereumTransaction ethTransaction = EthereumTransaction.fromJson(
      parameters[0],
    );

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
      final Uint8List sig = await ethClient.signTransaction(
        credentials,
        transaction,
      );

      // Sign the transaction
      final String signedTx = hex.encode(sig);

      // Return the signed transaction as a hexadecimal string
      return '0x$signedTx';
    } catch (e) {
      print(e);
      return 'Failed';
    }
  }

  Future<String?> ethSignTypedData(String topic, dynamic parameters) async {
    print('received eth sign typed data request: $parameters');
    final String data = parameters[1];
    final String? authAcquired = await requestAuthorization(data);
    if (authAcquired != null) {
      return authAcquired;
    }

    final List<ChainKey> keys = GetIt.I<IKeyService>().getKeysForChain(
      chainSupported.chain(),
    );

    return EthSigUtil.signTypedData(
      privateKey: keys[0].privateKey,
      jsonData: data,
      version: TypedDataVersion.V4,
    );
  }

  Future<void> switchChain(String topic, dynamic parameters) async {
    print('received switchChain request: $topic $parameters');
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
    print('received addChain request: $topic $parameters');
  }
}

import 'dart:convert';
import 'dart:typed_data';

import 'package:convert/convert.dart';
import 'package:eth_sig_util/eth_sig_util.dart';
import 'package:get_it/get_it.dart';
import 'package:walletconnect_flutter_v2/walletconnect_flutter_v2.dart';
import 'package:walletconnect_flutter_v2_wallet/dependencies/chains/i_chain.dart';
import 'package:walletconnect_flutter_v2_wallet/dependencies/bottom_sheet/i_bottom_sheet_service.dart';
import 'package:walletconnect_flutter_v2_wallet/dependencies/i_web3wallet_service.dart';
import 'package:walletconnect_flutter_v2_wallet/dependencies/key_service/chain_key.dart';
import 'package:walletconnect_flutter_v2_wallet/dependencies/key_service/i_key_service.dart';
import 'package:walletconnect_flutter_v2_wallet/models/eth/ethereum_transaction.dart';
import 'package:walletconnect_flutter_v2_wallet/widgets/wc_connection_widget/wc_connection_model.dart';
import 'package:walletconnect_flutter_v2_wallet/widgets/wc_connection_widget/wc_connection_widget.dart';
import 'package:walletconnect_flutter_v2_wallet/widgets/wc_request_widget.dart/wc_request_widget.dart';
import 'package:web3dart/web3dart.dart';

// ignore: implementation_imports
import 'package:web3dart/src/utils/rlp.dart' as rlp;

enum EVMChainId {
  ethereum,
  polygon,
  goerli,
  mumbai,
}

extension KadenaChainIdX on EVMChainId {
  String chain() {
    String name = '';

    switch (this) {
      case EVMChainId.ethereum:
        name = '1';
        break;
      case EVMChainId.polygon:
        name = '137';
        break;
      case EVMChainId.goerli:
        name = '5';
        break;
      case EVMChainId.mumbai:
        name = '80001';
        break;
    }

    return '${EVMService.namespace}:$name';
  }
}

class EVMService extends IChain {
  static const namespace = 'eip155';
  static const pSign = 'personal_sign';
  static const eSign = 'eth_sign';
  static const eSignTransaction = 'eth_signTransaction';
  static const eSignTypedData = 'eth_signTypedData';
  static const eSendTransaction = 'eth_sendTransaction';

  final IBottomSheetService _bottomSheetService =
      GetIt.I<IBottomSheetService>();
  final IWeb3WalletService _web3WalletService = GetIt.I<IWeb3WalletService>();

  final EVMChainId reference;

  EVMService({
    required this.reference,
  }) {
    final Web3Wallet wallet = _web3WalletService.getWeb3Wallet();
    for (final String event in getEvents()) {
      wallet.registerEventEmitter(chainId: getChainId(), event: event);
    }
    wallet.registerRequestHandler(
      chainId: getChainId(),
      method: pSign,
      handler: personalSign,
    );
    wallet.registerRequestHandler(
      chainId: getChainId(),
      method: eSign,
      handler: ethSign,
    );
    wallet.registerRequestHandler(
      chainId: getChainId(),
      method: eSignTransaction,
      handler: ethSignTransaction,
    );
    wallet.registerRequestHandler(
      chainId: getChainId(),
      method: eSendTransaction,
      handler: ethSignTransaction,
    );
    wallet.registerRequestHandler(
      chainId: getChainId(),
      method: eSignTypedData,
      handler: ethSignTypedData,
    );
  }

  @override
  String getNamespace() {
    return namespace;
  }

  @override
  String getChainId() {
    return reference.chain();
  }

  @override
  List<String> getEvents() {
    return ['chainChanged', 'accountsChanged'];
  }

  Future<String?> requestAuthorization(String text) async {
    final bool? approved = await _bottomSheetService.queueBottomSheet(
      widget: WCRequestWidget(
        child: WCConnectionWidget(
          title: 'Sign Transaction',
          info: [
            WCConnectionModel(
              text: text,
            ),
          ],
        ),
      ),
    );

    if (approved != null && approved == false) {
      return 'User rejected signature';
    }

    return null;
  }

  Future personalSign(String topic, dynamic parameters) async {
    print('received personal sign request: $parameters');

    final String? authAcquired = await requestAuthorization(parameters[0]);
    if (authAcquired != null) {
      return authAcquired;
    }

    try {
      // Load the private key
      final List<ChainKey> keys = GetIt.I<IKeyService>().getKeysForChain(
        getChainId(),
      );
      final Credentials credentials = EthPrivateKey.fromHex(keys[0].privateKey);

      final String signature = hex.encode(
        credentials.signPersonalMessageToUint8List(
          Uint8List.fromList(
            (parameters[0] as String).codeUnits,
          ),
        ),
      );

      return '0x$signature';
    } catch (e) {
      print(e);
      return 'Failed';
    }
  }

  Future ethSign(String topic, dynamic parameters) async {
    print('received eth sign request: $parameters');
    final String? authAcquired = await requestAuthorization(parameters[1]);
    if (authAcquired != null) {
      return authAcquired;
    }

    try {
      // Load the private key
      final List<ChainKey> keys = GetIt.I<IKeyService>().getKeysForChain(
        getChainId(),
      );
      final Credentials credentials = EthPrivateKey.fromHex(keys[0].privateKey);

      final String signature = hex.encode(
        credentials.signPersonalMessageToUint8List(
          Uint8List.fromList(
            (parameters[1] as String).codeUnits,
          ),
        ),
      );

      return '0x$signature';
    } catch (e) {
      print(e);
      return 'Failed';
    }
  }

  Future ethSignTransaction(String topic, dynamic parameters) async {
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
      getChainId(),
    );
    final Credentials credentials = EthPrivateKey.fromHex(keys[0].privateKey);

    EthereumTransaction ethTransaction = EthereumTransaction.fromJson(
      parameters[0],
    );

    // Construct a transaction from the EthereumTransaction object
    final transaction = Transaction(
      from: EthereumAddress.fromHex(ethTransaction.from),
      to: EthereumAddress.fromHex(ethTransaction.to),
      value: EtherAmount.fromUnitAndValue(
        EtherUnit.wei,
        BigInt.tryParse(ethTransaction.value) ?? BigInt.zero,
      ),
      gasPrice: ethTransaction.gasPrice != null
          ? EtherAmount.fromUnitAndValue(
              EtherUnit.gwei,
              BigInt.tryParse(ethTransaction.gasPrice!) ?? BigInt.zero,
            )
          : null,
      maxFeePerGas: ethTransaction.maxFeePerGas != null
          ? EtherAmount.fromUnitAndValue(
              EtherUnit.gwei,
              BigInt.tryParse(ethTransaction.maxFeePerGas!) ?? BigInt.zero,
            )
          : null,
      maxPriorityFeePerGas: ethTransaction.maxPriorityFeePerGas != null
          ? EtherAmount.fromUnitAndValue(
              EtherUnit.gwei,
              BigInt.tryParse(ethTransaction.maxPriorityFeePerGas!) ??
                  BigInt.zero,
            )
          : null,
      maxGas: int.tryParse(ethTransaction.gasLimit ?? ''),
      nonce: int.tryParse(ethTransaction.nonce ?? ''),
      data: (ethTransaction.data != null)
          ? Uint8List.fromList(hex.decode(ethTransaction.data!))
          : null,
    );

    // Sign the transaction
    final String signedTx = hex.encode(
      credentials.signToUint8List(
        Uint8List.fromList(
          rlp.encode(
            transaction.toString(),
          ),
        ),
      ),
    );

    // Return the signed transaction as a hexadecimal string
    return '0x$signedTx';
  }

  Future ethSignTypedData(String topic, dynamic parameters) async {
    print('received eth sign typed data request: $parameters');
    final String data = jsonEncode(parameters[1]);
    final String? authAcquired = await requestAuthorization(data);
    if (authAcquired != null) {
      return authAcquired;
    }

    final List<ChainKey> keys = GetIt.I<IKeyService>().getKeysForChain(
      getChainId(),
    );

    return EthSigUtil.signTypedData(
      privateKey: keys[0].privateKey,
      jsonData: data,
      version: TypedDataVersion.V4,
    );
  }
}

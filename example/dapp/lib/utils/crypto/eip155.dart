import 'dart:convert';

import 'package:intl/intl.dart';
import 'package:walletconnect_flutter_v2/walletconnect_flutter_v2.dart';
import 'package:walletconnect_flutter_v2_dapp/models/chain_metadata.dart';
import 'package:walletconnect_flutter_v2_dapp/utils/crypto/chain_data.dart';
import 'package:walletconnect_flutter_v2_dapp/utils/smart_contracts.dart';
import 'package:walletconnect_flutter_v2_dapp/utils/test_data.dart';

enum EIP155Methods {
  personalSign,
  ethSign,
  ethSignTransaction,
  ethSignTypedData,
  ethSendTransaction,
}

enum EIP155Events {
  chainChanged,
  accountsChanged,
}

extension EIP155MethodsStringX on String {
  EIP155Methods? toEip155Method() {
    final entries = EIP155.methods.entries.where(
      (element) => element.value == this,
    );
    return (entries.isNotEmpty) ? entries.first.key : null;
  }
}

extension EIP155EventsStringX on String {
  EIP155Events? toEip155Event() {
    final entries = EIP155.events.entries.where(
      (element) => element.value == this,
    );
    return (entries.isNotEmpty) ? entries.first.key : null;
  }
}

class EIP155 {
  static final Map<EIP155Methods, String> methods = {
    EIP155Methods.personalSign: 'personal_sign',
    EIP155Methods.ethSign: 'eth_sign',
    EIP155Methods.ethSignTransaction: 'eth_signTransaction',
    EIP155Methods.ethSignTypedData: 'eth_signTypedData',
    EIP155Methods.ethSendTransaction: 'eth_sendTransaction',
  };

  static final Map<EIP155Events, String> events = {
    EIP155Events.chainChanged: 'chainChanged',
    EIP155Events.accountsChanged: 'accountsChanged',
  };

  static Future<dynamic> callMethod({
    required Web3App web3App,
    required String topic,
    required EIP155Methods method,
    required ChainMetadata chainData,
    required String address,
  }) {
    switch (method) {
      case EIP155Methods.personalSign:
        return personalSign(
          web3App: web3App,
          topic: topic,
          chainId: chainData.chainId,
          address: address,
          message: testSignData,
        );
      case EIP155Methods.ethSign:
        return ethSign(
          web3App: web3App,
          topic: topic,
          chainId: chainData.chainId,
          address: address,
          message: testSignData,
        );
      case EIP155Methods.ethSignTypedData:
        return ethSignTypedData(
          web3App: web3App,
          topic: topic,
          chainId: chainData.chainId,
          address: address,
          data: typedData,
        );
      case EIP155Methods.ethSignTransaction:
        return ethSignTransaction(
          web3App: web3App,
          topic: topic,
          chainId: chainData.chainId,
          transaction: Transaction(
            from: EthereumAddress.fromHex(address),
            to: EthereumAddress.fromHex(
                '0x59e2f66C0E96803206B6486cDb39029abAE834c0'),
            value: EtherAmount.fromInt(EtherUnit.finney, 12), // == 0.012
          ),
        );
      case EIP155Methods.ethSendTransaction:
        return ethSendTransaction(
          web3App: web3App,
          topic: topic,
          chainId: chainData.chainId,
          transaction: Transaction(
            from: EthereumAddress.fromHex(address),
            to: EthereumAddress.fromHex(
                '0x59e2f66C0E96803206B6486cDb39029abAE834c0'),
            value: EtherAmount.fromInt(EtherUnit.finney, 11), // == 0.011
          ),
        );
    }
  }

  static Future<dynamic> callSmartContract({
    required Web3App web3App,
    required String topic,
    required String address,
    required String action,
  }) {
    // Create DeployedContract object using contract's ABI and address
    final deployedContract = DeployedContract(
      ContractAbi.fromJson(
        jsonEncode(SepoliaTestContract.readContractAbi),
        'Alfreedoms',
      ),
      EthereumAddress.fromHex(SepoliaTestContract.contractAddress),
    );

    switch (action) {
      case 'read':
        return readSmartContract(
          web3App: web3App,
          rpcUrl: ChainData.testChains.first.rpc.first,
          contract: deployedContract,
          address: address,
        );
      case 'write':
        return writeToSmartContract(
          web3App: web3App,
          rpcUrl: ChainData.testChains.first.rpc.first,
          address: address,
          topic: topic,
          chainId: ChainData.testChains.first.chainId,
          contract: deployedContract,
          transaction: Transaction(
            from: EthereumAddress.fromHex(address),
            to: EthereumAddress.fromHex(
                '0x59e2f66C0E96803206B6486cDb39029abAE834c0'),
            value: EtherAmount.fromInt(EtherUnit.finney, 10), // == 0.010
          ),
        );
      default:
        return Future.value();
    }
  }

  static Future<dynamic> personalSign({
    required Web3App web3App,
    required String topic,
    required String chainId,
    required String address,
    required String message,
  }) async {
    return await web3App.request(
      topic: topic,
      chainId: chainId,
      request: SessionRequestParams(
        method: methods[EIP155Methods.personalSign]!,
        params: [message, address],
      ),
    );
  }

  static Future<dynamic> ethSign({
    required Web3App web3App,
    required String topic,
    required String chainId,
    required String address,
    required String message,
  }) async {
    return await web3App.request(
      topic: topic,
      chainId: chainId,
      request: SessionRequestParams(
        method: methods[EIP155Methods.ethSign]!,
        params: [address, message],
      ),
    );
  }

  static Future<dynamic> ethSignTypedData({
    required Web3App web3App,
    required String topic,
    required String chainId,
    required String address,
    required String data,
  }) async {
    return await web3App.request(
      topic: topic,
      chainId: chainId,
      request: SessionRequestParams(
        method: methods[EIP155Methods.ethSignTypedData]!,
        params: [address, data],
      ),
    );
  }

  static Future<dynamic> ethSignTransaction({
    required Web3App web3App,
    required String topic,
    required String chainId,
    required Transaction transaction,
  }) async {
    return await web3App.request(
      topic: topic,
      chainId: chainId,
      request: SessionRequestParams(
        method: methods[EIP155Methods.ethSignTransaction]!,
        params: [transaction.toJson()],
      ),
    );
  }

  static Future<dynamic> ethSendTransaction({
    required Web3App web3App,
    required String topic,
    required String chainId,
    required Transaction transaction,
  }) async {
    return await web3App.request(
      topic: topic,
      chainId: chainId,
      request: SessionRequestParams(
        method: methods[EIP155Methods.ethSendTransaction]!,
        params: [transaction.toJson()],
      ),
    );
  }

  static Future<dynamic> readSmartContract({
    required Web3App web3App,
    required String rpcUrl,
    required String address,
    required DeployedContract contract,
  }) async {
    final results = await Future.wait([
      // results[0]
      web3App.requestReadContract(
        deployedContract: contract,
        functionName: 'name',
        rpcUrl: rpcUrl,
      ),
      // results[1]
      web3App.requestReadContract(
        deployedContract: contract,
        functionName: 'totalSupply',
        rpcUrl: rpcUrl,
      ),
      // results[2]
      web3App.requestReadContract(
        deployedContract: contract,
        functionName: 'balanceOf',
        rpcUrl: rpcUrl,
        parameters: [
          EthereumAddress.fromHex(address),
        ],
      ),
    ]);

    final oCcy = NumberFormat("#,##0.00", "en_US");
    final name = results[0].toString();
    final total = results[1] / BigInt.from(1000000000000000000);
    final balance = results[2] / BigInt.from(1000000000000000000);

    return {
      'name': name,
      'totalSupply': oCcy.format(total),
      'balance': oCcy.format(balance),
    };
  }

  static Future<dynamic> writeToSmartContract({
    required Web3App web3App,
    required String rpcUrl,
    required String topic,
    required String chainId,
    required String address,
    required DeployedContract contract,
    required Transaction transaction,
  }) async {
    return await web3App.requestWriteContract(
      topic: topic,
      chainId: chainId,
      rpcUrl: rpcUrl,
      deployedContract: contract,
      functionName: 'transfer',
      transaction: transaction,
    );
  }
}

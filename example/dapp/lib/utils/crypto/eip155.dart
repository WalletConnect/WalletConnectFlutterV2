import 'dart:convert';
// ignore: depend_on_referenced_packages
import 'package:convert/convert.dart';

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
    required String method,
    required ChainMetadata chainData,
    required String address,
  }) {
    switch (method) {
      case 'personal_sign':
        return personalSign(
          web3App: web3App,
          topic: topic,
          chainId: chainData.chainId,
          address: address,
          message: testSignData,
        );
      case 'eth_sign':
        return ethSign(
          web3App: web3App,
          topic: topic,
          chainId: chainData.chainId,
          address: address,
          message: testSignData,
        );
      case 'eth_signTypedData':
        return ethSignTypedData(
          web3App: web3App,
          topic: topic,
          chainId: chainData.chainId,
          address: address,
          data: typedData,
        );
      case 'eth_signTransaction':
        return ethSignTransaction(
          web3App: web3App,
          topic: topic,
          chainId: chainData.chainId,
          transaction: Transaction(
            from: EthereumAddress.fromHex(address),
            to: EthereumAddress.fromHex(
              '0x59e2f66C0E96803206B6486cDb39029abAE834c0',
            ),
            value: EtherAmount.fromInt(EtherUnit.finney, 12), // == 0.012
          ),
        );
      case 'eth_sendTransaction':
        return ethSendTransaction(
          web3App: web3App,
          topic: topic,
          chainId: chainData.chainId,
          transaction: Transaction(
            from: EthereumAddress.fromHex(address),
            to: EthereumAddress.fromHex(
              '0x59e2f66C0E96803206B6486cDb39029abAE834c0',
            ),
            value: EtherAmount.fromInt(EtherUnit.finney, 11), // == 0.011
          ),
        );
      default:
        throw 'Method unimplemented';
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

    final sepolia =
        ChainData.allChains.firstWhere((e) => e.chainId == 'eip155:11155111');

    switch (action) {
      case 'read':
        return readSmartContract(
          web3App: web3App,
          rpcUrl: sepolia.rpc.first,
          contract: deployedContract,
          address: address,
        );
      case 'write':
        return web3App.requestWriteContract(
          topic: topic,
          chainId: sepolia.chainId,
          rpcUrl: sepolia.rpc.first,
          deployedContract: deployedContract,
          functionName: 'transfer',
          transaction: Transaction(
            from: EthereumAddress.fromHex(address),
          ),
          parameters: [
            // Recipient
            EthereumAddress.fromHex(
              '0x59e2f66C0E96803206B6486cDb39029abAE834c0',
            ),
            // Amount to Transfer
            EtherAmount.fromInt(EtherUnit.finney, 10).getInWei, // == 0.010
          ],
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
    final bytes = utf8.encode(message);
    final encoded = '0x${hex.encode(bytes)}';

    return await web3App.request(
      topic: topic,
      chainId: chainId,
      request: SessionRequestParams(
        method: methods[EIP155Methods.personalSign]!,
        params: [encoded, address],
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
    final name = results[0].first.toString();
    final total = results[1].first / BigInt.from(1000000000000000000);
    final balance = results[2].first / BigInt.from(1000000000000000000);

    return {
      'name': name,
      'totalSupply': oCcy.format(total),
      'balance': oCcy.format(balance),
    };
  }
}

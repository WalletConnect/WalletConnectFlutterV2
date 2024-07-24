import 'dart:convert';
// ignore: depend_on_referenced_packages
import 'package:bs58/bs58.dart';

import 'package:walletconnect_flutter_v2_dapp/models/chain_metadata.dart';
import 'package:walletconnect_flutter_v2_dapp/imports.dart';

enum SolanaMethods {
  solanaSignTransaction,
  solanaSignMessage,
}

enum SolanaEvents {
  none,
}

class Solana {
  static final Map<SolanaMethods, String> methods = {
    SolanaMethods.solanaSignTransaction: 'solana_signTransaction',
    SolanaMethods.solanaSignMessage: 'solana_signMessage'
  };

  static final Map<SolanaEvents, String> events = {};

  static Future<dynamic> callMethod({
    required Web3App web3App,
    required String topic,
    required String method,
    required ChainMetadata chainData,
    required String address,
  }) {
    final bytes = utf8.encode(
      'This is an example message to be signed - ${DateTime.now()}',
    );
    final message = base58.encode(bytes);
    switch (method) {
      case 'solana_signMessage':
        return web3App.request(
          topic: topic,
          chainId: chainData.chainId,
          request: SessionRequestParams(
            method: method,
            params: {
              'pubkey': address,
              'message': message,
            },
          ),
        );
      case 'solana_signTransaction':
        return web3App.request(
          topic: topic,
          chainId: chainData.chainId,
          request: SessionRequestParams(
            method: method,
            params: {
              "feePayer": address,
              "recentBlockhash": "H32Ss1hxpP2ZJM4whREVNyUWRgzFLVA97UXJUjBrEsgx",
              "instructions": [
                {
                  "programId": "11111111111111111111111111111111",
                  "data": [2, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0],
                  "keys": [
                    {
                      "isSigner": true,
                      "isWritable": true,
                      "pubkey": "EbdEmCpKGvEwfwV4ACmVYHFRkwvXdogJhMZeEekDFVVJ"
                    },
                    {
                      "isSigner": false,
                      "isWritable": true,
                      "pubkey": "4SzUq9NNYSYGp41ED5NgSDoCrEh9MoD7zSvmtkwseW8s"
                    }
                  ]
                }
              ]
            },
          ),
        );
      default:
        throw 'Method unimplemented';
    }
  }
}

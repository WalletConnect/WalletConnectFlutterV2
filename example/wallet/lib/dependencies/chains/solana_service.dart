import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

import 'package:walletconnect_flutter_v2/walletconnect_flutter_v2.dart';
import 'package:walletconnect_flutter_v2_wallet/dependencies/chains/common.dart';
import 'package:walletconnect_flutter_v2_wallet/dependencies/i_web3wallet_service.dart';
import 'package:walletconnect_flutter_v2_wallet/dependencies/key_service/i_key_service.dart';
import 'package:walletconnect_flutter_v2_wallet/models/chain_metadata.dart';

import 'package:solana/solana.dart' as solana;
import 'package:solana/encoder.dart' as encoder;
// ignore: depend_on_referenced_packages
import 'package:bs58/bs58.dart';

class SolanaService {
  Map<String, dynamic Function(String, dynamic)> get solanaRequestHandlers => {
        'solana_signMessage': solanaSignMessage,
        'solana_signTransaction': solanaSignTransaction,
      };

  final _web3Wallet = GetIt.I<IWeb3WalletService>().web3wallet;
  final ChainMetadata chainSupported;

  SolanaService({required this.chainSupported}) {
    for (var handler in solanaRequestHandlers.entries) {
      _web3Wallet.registerRequestHandler(
        chainId: chainSupported.chainId,
        method: handler.key,
        handler: handler.value,
      );
    }
  }

  Future<void> solanaSignMessage(String topic, dynamic parameters) async {
    debugPrint('[SampleWallet] solanaSignMessage request: $parameters');
    const method = 'solana_signMessage';
    final pRequest = _web3Wallet.pendingRequests.getAll().last;
    var response = JsonRpcResponse(id: pRequest.id, jsonrpc: '2.0');

    try {
      final params = parameters as Map<String, dynamic>;
      final message = params['message'].toString();

      final keys = GetIt.I<IKeyService>().getKeysForChain(
        chainSupported.chainId,
      );
      final secKeyBytes = keys[0].privateKey.parse32Bytes();

      final keyPair = await solana.Ed25519HDKeyPair.fromPrivateKeyBytes(
        privateKey: secKeyBytes,
      );

      // it's being sent encoded from dapp
      final base58Decoded = base58.decode(message);
      final decodedMessage = utf8.decode(base58Decoded);
      if (await CommonMethods.requestApproval(
        decodedMessage,
        method: method,
        chainId: pRequest.chainId,
        address: keyPair.address,
      )) {
        final signature = await keyPair.sign(base58Decoded.toList());

        response = response.copyWith(
          result: {
            'signature': signature.toBase58(),
          },
        );
      } else {
        response = response.copyWith(
          error: const JsonRpcError(code: 5001, message: 'User rejected'),
        );
      }
      //
    } catch (e) {
      debugPrint('[SampleWallet] polkadotSignMessage error $e');
      response = response.copyWith(
        error: JsonRpcError(code: 0, message: e.toString()),
      );
    }

    await _web3Wallet.respondSessionRequest(
      topic: topic,
      response: response,
    );

    CommonMethods.goBackToDapp(topic, response.result ?? response.error);
  }

  Future<void> solanaSignTransaction(String topic, dynamic parameters) async {
    debugPrint(
        '[SampleWallet] solanaSignTransaction: ${jsonEncode(parameters)}');
    const method = 'solana_signTransaction';
    final pRequest = _web3Wallet.pendingRequests.getAll().last;
    var response = JsonRpcResponse(id: pRequest.id, jsonrpc: '2.0');

    try {
      final params = parameters as Map<String, dynamic>;
      if (params.containsKey('version')) {
        return await solanaSignV0Transaction(topic, parameters);
      }

      final feePayer = params['feePayer'].toString();
      final recentBlockHash = params['recentBlockhash'].toString();
      final instructionsList = params['instructions'] as List<dynamic>;

      final keys = GetIt.I<IKeyService>().getKeysForChain(
        chainSupported.chainId,
      );
      final secKeyBytes = keys[0].privateKey.parse32Bytes();

      final keyPair = await solana.Ed25519HDKeyPair.fromPrivateKeyBytes(
        privateKey: secKeyBytes,
      );

      if (keyPair.address != feePayer) {
        throw Exception('Error');
      }

      const encoder = JsonEncoder.withIndent('  ');
      final transaction = encoder.convert(params);
      if (await CommonMethods.requestApproval(
        transaction,
        method: method,
        chainId: pRequest.chainId,
        address: keyPair.address,
      )) {
        // Sign the transaction.
        final instructions = instructionsList.map((json) {
          return (json as Map<String, dynamic>).toInstruction();
        }).toList();

        final message = solana.Message(instructions: instructions);
        final compiledMessage = message.compile(
          recentBlockhash: recentBlockHash,
          feePayer: solana.Ed25519HDPublicKey.fromBase58(feePayer),
        );

        final signature = await keyPair.sign(compiledMessage.toByteArray());

        response = response.copyWith(
          result: {
            'signature': signature.toBase58(),
          },
        );
      } else {
        response = response.copyWith(
          error: const JsonRpcError(code: 5001, message: 'User rejected'),
        );
      }
    } catch (e) {
      debugPrint('[SampleWallet] solanaSignTransaction error $e');
      response = response.copyWith(
        error: JsonRpcError(code: 0, message: e.toString()),
      );
    }

    await _web3Wallet.respondSessionRequest(
      topic: topic,
      response: response,
    );

    CommonMethods.goBackToDapp(topic, response.result ?? response.error);
  }

  Future<void> solanaSignV0Transaction(String topic, dynamic parameters) async {
    debugPrint(
        '[SampleWallet] solanaSignV0Transaction: ${jsonEncode(parameters)}');
    const method = 'solana_signTransaction';
    final pRequest = _web3Wallet.pendingRequests.getAll().last;
    var response = JsonRpcResponse(id: pRequest.id, jsonrpc: '2.0');

    try {
      final params = parameters as Map<String, dynamic>;
      final version = params['version'] as int;
      if (version != 0) {
        response = response.copyWith(
          error: const JsonRpcError(
            code: 0,
            message: 'Transaction is not v0',
          ),
        );
      } else {
        final message = params['message'] as Map<String, dynamic>;
        // final header = message['header'] as Map<String, dynamic>;
        final recentBlockHash = message['recentBlockhash'] as String;
        final accountKeys = (message['accountKeys'] as List<dynamic>)
            .map((key) => solana.Ed25519HDPublicKey.fromBase58(key))
            .toList();

        final feePayer = accountKeys.first.toString();
        final instructionsList = message['instructions'] as List;

        final keys = GetIt.I<IKeyService>().getKeysForChain(
          chainSupported.chainId,
        );
        final secKeyBytes = keys[0].privateKey.parse32Bytes();

        final keyPair = await solana.Ed25519HDKeyPair.fromPrivateKeyBytes(
          privateKey: secKeyBytes,
        );

        if (keyPair.address != feePayer) {
          throw Exception('Error');
        }

        const encoder = JsonEncoder.withIndent('  ');
        final transaction = encoder.convert(params);
        if (await CommonMethods.requestApproval(
          transaction,
          method: method,
          chainId: pRequest.chainId,
          address: keyPair.address,
        )) {
          // Sign the transaction.
          final instructions = instructionsList.map((json) {
            debugPrint('[SampleWallet] json $json');
            return (json as Map<String, dynamic>).toV0Instruction(accountKeys);
          }).toList();

          final message = solana.Message(instructions: instructions);
          final compiledMessage = message.compile(
            recentBlockhash: recentBlockHash,
            feePayer: solana.Ed25519HDPublicKey.fromBase58(feePayer),
          );

          final signature = await keyPair.sign(compiledMessage.toByteArray());

          response = response.copyWith(
            result: {
              'signature': signature.toBase58(),
            },
          );
        } else {
          response = response.copyWith(
            error: const JsonRpcError(code: 5001, message: 'User rejected'),
          );
        }
      }
    } catch (e, s) {
      debugPrint('[SampleWallet] solanaSignV0Transaction error $e, $s');
      response = response.copyWith(
        error: JsonRpcError(code: 0, message: e.toString()),
      );
    }

    await _web3Wallet.respondSessionRequest(
      topic: topic,
      response: response,
    );

    CommonMethods.goBackToDapp(topic, response.result ?? response.error);
  }
}

extension on String {
  // SigningKey used by solana package requires a 32 bytes key
  Uint8List parse32Bytes() {
    try {
      final List<int> secBytes = split(',').map((e) => int.parse(e)).toList();
      return Uint8List.fromList(secBytes.sublist(0, 32));
    } catch (e) {
      rethrow;
    }
  }
}

extension on Map<String, dynamic> {
  encoder.Instruction toInstruction() {
    final programId = this['programId'] as String;
    final programKey =
        solana.Ed25519HDPublicKey(base58.decode(programId).toList());

    final data = (this['data'] as List).map((e) => e as int).toList();
    final data58 = base58.encode(Uint8List.fromList(data));
    final dataBytes = encoder.ByteArray.fromBase58(data58);

    final keys = this['keys'] as List;
    return encoder.Instruction(
      programId: programKey,
      data: dataBytes,
      accounts: keys.map((k) {
        final kParams = (k as Map<String, dynamic>);
        return encoder.AccountMeta(
          pubKey: solana.Ed25519HDPublicKey.fromBase58(kParams['pubkey']),
          isWriteable: kParams['isWritable'] as bool,
          isSigner: kParams['isSigner'] as bool,
        );
      }).toList(),
    );
  }

  encoder.Instruction toV0Instruction(
    List<solana.Ed25519HDPublicKey> accountKeys,
  ) {
    final programIdIndex = this['programIdIndex'] as int;
    final programKey = accountKeys.elementAt(programIdIndex);

    final accounts = (this['accounts'] as List).map((index) {
      // Assuming first account in each instruction is signer
      final isSigner = index == 0;
      // Assuming second account in each instruction is writable
      final isWriteable = index == 1;
      return encoder.AccountMeta(
        pubKey: accountKeys[index],
        isSigner: isSigner,
        isWriteable: isWriteable,
      );
    }).toList();

    final data = base64Decode(this['data'].toString());
    final data58 = base58.encode(Uint8List.fromList(data));
    final dataBytes = encoder.ByteArray.fromBase58(data58);

    return encoder.Instruction(
      programId: programKey,
      data: dataBytes,
      accounts: accounts,
    );
  }
}

import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

import 'package:walletconnect_flutter_v2/walletconnect_flutter_v2.dart';
import 'package:walletconnect_flutter_v2_wallet/dependencies/chains/common.dart';
import 'package:walletconnect_flutter_v2_wallet/dependencies/i_web3wallet_service.dart';
import 'package:walletconnect_flutter_v2_wallet/dependencies/key_service/i_key_service.dart';
import 'package:walletconnect_flutter_v2_wallet/models/chain_metadata.dart';

import 'package:solana_web3/solana_web3.dart' as solana;
// ignore: implementation_imports
import 'package:solana_web3/src/crypto/nacl.dart' as nacl;
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
    debugPrint('[WALLET] solanaSignMessage request: $parameters');
    final pRequest = _web3Wallet.pendingRequests.getAll().last;
    var response = JsonRpcResponse(id: pRequest.id, jsonrpc: '2.0');

    try {
      final params = parameters as Map<String, dynamic>;
      final message = params['message'].toString();

      final keys = GetIt.I<IKeyService>().getKeysForChain(
        chainSupported.chainId,
      );
      final secKeyBytes = keys[0].privateKey.parseBytes();

      // it's being sent encoded from dapp
      final base58Decoded = base58.decode(message);
      final decodedMessage = utf8.decode(base58Decoded);
      if (await CommonMethods.requestApproval(
        decodedMessage,
        title: 'solana_signMessage',
      )) {
        final encodedMessage = utf8.encode(decodedMessage);
        final signature = await nacl.sign.detached(
          encodedMessage,
          secKeyBytes,
        );

        // verify here

        final bs58Signature = base58.encode(signature);
        response = response.copyWith(
          result: {
            'signature': bs58Signature,
          },
        );
      } else {
        response = response.copyWith(
          error: const JsonRpcError(code: 5001, message: 'User rejected'),
        );
      }
    } catch (e) {
      debugPrint('[WALLET] polkadotSignMessage error $e');
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
        '[WALLET] solanaSignTransaction request: ${jsonEncode(parameters)}');
    final pRequest = _web3Wallet.pendingRequests.getAll().last;
    var response = JsonRpcResponse(id: pRequest.id, jsonrpc: '2.0');

    try {
      final keys = GetIt.I<IKeyService>().getKeysForChain(
        chainSupported.chainId,
      );
      final secKeyBytes = keys[0].privateKey.parseBytes();
      final keyPair = solana.Keypair.fromSeckeySync(secKeyBytes);
      // final keyP = nacl.sign.keypair.fromSeckeySync(secKeyBytes);

      final transaction =
          (parameters as Map<String, dynamic>).toSolanaTransaction();

      if (keys[0].publicKey != '${keyPair.pubkey}') {
        throw Exception('Error');
      }

      const encoder = JsonEncoder.withIndent('  ');
      if (await CommonMethods.requestApproval(
        encoder.convert(parameters),
        title: 'solana_signTransaction',
      )) {
        // Sign the transaction.
        transaction.sign([keyPair]);

        // The first signature is considered "primary" and is used identify and confirm transactions.
        final primarySigPubkeyPair = transaction.signatures.first;
        final bs58Signature = base58.encode(primarySigPubkeyPair);

        response = response.copyWith(
          result: {
            'signature': bs58Signature,
          },
        );
      } else {
        response = response.copyWith(
          error: const JsonRpcError(code: 5001, message: 'User rejected'),
        );
      }
    } catch (e) {
      debugPrint('[WALLET] solanaSignTransaction error $e');
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
  Uint8List parseBytes() {
    try {
      final List<int> secBytes = split(',').map((e) => int.parse(e)).toList();
      return Uint8List.fromList(secBytes);
    } catch (e) {
      rethrow;
    }
  }
}

extension on Map<String, dynamic> {
  solana.Transaction toSolanaTransaction() {
    final instructions = this['instructions'] as List<dynamic>;
    return solana.Transaction.v0(
      payer: solana.Pubkey.fromJson(this['feePayer']),
      recentBlockhash: this['recentBlockhash'],
      instructions: instructions.map((i) {
        return (i as Map<String, dynamic>).toInstruction();
      }).toList(),
    );
  }

  solana.TransactionInstruction toInstruction() {
    final programId = this['programId'] as String;
    final data = (this['data'] as List).map((e) => e as int).toList();
    final keys = this['keys'] as List;
    return solana.TransactionInstruction(
      programId: solana.Pubkey.fromJson(programId),
      data: Uint8List.fromList(data),
      keys: keys.map((k) {
        return (k as Map<String, dynamic>).toAccountMeta();
      }).toList(),
    );
  }

  solana.AccountMeta toAccountMeta() {
    return solana.AccountMeta.fromJson(this);
  }
}

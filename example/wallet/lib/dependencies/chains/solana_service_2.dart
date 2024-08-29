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

// ignore: depend_on_referenced_packages
import 'package:bs58/bs58.dart';
// ignore: implementation_imports
import 'package:solana_web3/src/crypto/nacl.dart' as nacl;

///
/// Uses solana_web3: ^0.1.3
///
class SolanaService2 {
  Map<String, dynamic Function(String, dynamic)> get solanaRequestHandlers => {
        'solana_signMessage': solanaSignMessage,
        'solana_signTransaction': solanaSignTransaction,
      };

  final _web3Wallet = GetIt.I<IWeb3WalletService>().web3wallet;
  final ChainMetadata chainSupported;

  SolanaService2({required this.chainSupported}) {
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
    final pRequest = _web3Wallet.pendingRequests.getAll().last;
    var response = JsonRpcResponse(id: pRequest.id, jsonrpc: '2.0');

    try {
      final params = parameters as Map<String, dynamic>;
      final message = params['message'].toString();

      final keyPair = await _getKeyPair();

      // it's being sent encoded from dapp
      final base58Decoded = base58.decode(message);
      final decodedMessage = utf8.decode(base58Decoded);
      if (await CommonMethods.requestApproval(
        decodedMessage,
        method: pRequest.method,
        chainId: pRequest.chainId,
        address: keyPair.pubkey.toBase58(),
      )) {
        final signature = await nacl.sign.detached(
          base58Decoded,
          keyPair.seckey,
        );

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

  Future<solana.Keypair> _getKeyPair() async {
    final keys = GetIt.I<IKeyService>().getKeysForChain(
      chainSupported.chainId,
    );
    final secKeyBytes = keys[0].privateKey.parse32Bytes();
    return solana.Keypair.fromSeedSync(secKeyBytes);
  }

  Future<void> solanaSignTransaction(String topic, dynamic parameters) async {
    debugPrint(
        '[SampleWallet] solanaSignTransaction: ${jsonEncode(parameters)}');
    final pRequest = _web3Wallet.pendingRequests.getAll().last;
    var response = JsonRpcResponse(id: pRequest.id, jsonrpc: '2.0');

    try {
      final params = parameters as Map<String, dynamic>;
      final beautifiedTrx = const JsonEncoder.withIndent('  ').convert(params);

      final keyPair = await _getKeyPair();

      if (await CommonMethods.requestApproval(
        // Show Approval Modal
        beautifiedTrx,
        method: pRequest.method,
        chainId: pRequest.chainId,
        address: keyPair.pubkey.toBase58(),
      )) {
        // Sign the transaction.
        // if params contains `transaction` key we should parse that one and disregard the rest, see https://docs.walletconnect.com/advanced/multichain/rpc-reference/solana-rpc#solana_signtransaction
        if (params.containsKey('transaction')) {
          final encodedTx = params['transaction'] as String;
          final decodedTx = solana.Transaction.fromBase64(encodedTx);

          // Sign the transaction.
          decodedTx.sign([keyPair]);

          response = response.copyWith(
            result: {
              'signature': decodedTx.signatures.first.toBase58(),
            },
          );
        } else {
          // else we parse the other key/values, see https://docs.walletconnect.com/advanced/multichain/rpc-reference/solana-rpc#solana_signtransaction
          final feePayer = params['feePayer'].toString();
          final recentBlockHash = params['recentBlockhash'].toString();
          final instructionsList = params['instructions'] as List<dynamic>;

          final instructions = instructionsList.map((json) {
            return (json as Map<String, dynamic>).toInstruction();
          }).toList();

          final decodedTx = solana.Transaction.v0(
            payer: solana.Pubkey.fromBase58(feePayer),
            instructions: instructions,
            recentBlockhash: recentBlockHash,
          );

          // Sign the transaction.
          decodedTx.sign([keyPair]);

          response = response.copyWith(
            result: {
              'signature': decodedTx.signatures.first.toBase58(),
            },
          );
        }
      } else {
        response = response.copyWith(
          error: const JsonRpcError(code: 5001, message: 'User rejected'),
        );
      }
    } catch (e, s) {
      debugPrint('[SampleWallet] solanaSignTransaction error $e, $s');
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

extension on Map<String, dynamic> {
  solana.TransactionInstruction toInstruction() {
    final programId = this['programId'] as String;

    final data = (this['data'] as String);
    final dataBytes = base64.decode(data);

    final keys = this['keys'] as List;
    return solana.TransactionInstruction(
      programId: solana.Pubkey.fromBase58(programId),
      data: dataBytes,
      keys: keys.map((k) {
        final kParams = (k as Map<String, dynamic>);
        return solana.AccountMeta(
          solana.Pubkey.fromBase58(kParams['pubkey']),
          isSigner: kParams['isSigner'] as bool,
          isWritable: kParams['isWritable'] as bool,
        );
      }).toList(),
    );
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

extension on Uint8List {
  String toBase58() => base58.encode(this);
}
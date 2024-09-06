import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

import 'package:walletconnect_flutter_v2/walletconnect_flutter_v2.dart';
import 'package:walletconnect_flutter_v2_wallet/dependencies/i_web3wallet_service.dart';
import 'package:walletconnect_flutter_v2_wallet/dependencies/key_service/i_key_service.dart';
import 'package:walletconnect_flutter_v2_wallet/models/chain_metadata.dart';

import 'package:solana/solana.dart' as solana;
import 'package:solana/encoder.dart' as solana_encoder;
// ignore: depend_on_referenced_packages
import 'package:bs58/bs58.dart';
import 'package:walletconnect_flutter_v2_wallet/utils/methods_utils.dart';

///
/// Uses solana: ^0.30.4
///
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
        address: keyPair.address,
      if (await MethodsUtils.requestApproval(
        decodedMessage,
        title: method,
        transportType: pRequest.transportType.name,
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

    _handleResponseForTopic(topic, response);
  }

  Future<solana.Ed25519HDKeyPair> _getKeyPair() async {
    final keys = GetIt.I<IKeyService>().getKeysForChain(
      chainSupported.chainId,
    );
    final secKeyBytes = keys[0].privateKey.parse32Bytes();
    return await solana.Ed25519HDKeyPair.fromPrivateKeyBytes(
      privateKey: secKeyBytes,
    );
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
        address: keyPair.address,
      final keyPair = await Ed25519HDKeyPair.fromPrivateKeyBytes(
        privateKey: secKeyBytes,
      );

      if (keyPair.address != feePayer) {
        throw Exception('Error');
      }

      const encoder = JsonEncoder.withIndent('  ');
      final transaction = encoder.convert(params);
      if (await MethodsUtils.requestApproval(
        transaction,
        title: method,
        transportType: pRequest.transportType.name,
      )) {
        // Sign the transaction.
        // if params contains `transaction` key we should parse that one and disregard the rest
        if (params.containsKey('transaction')) {
          final transaction = params['transaction'] as String;
          final transactionBytes = base64.decode(transaction);
          final signedTx = solana_encoder.SignedTx.fromBytes(
            transactionBytes,
          );

          // Sign the transaction.
          final signature = await keyPair.sign(
            signedTx.compiledMessage.toByteArray(),
          );

          response = response.copyWith(
            result: {
              'signature': signature.toBase58(),
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

          final message = solana.Message(instructions: instructions);
          final compiledMessage = message.compile(
            recentBlockhash: recentBlockHash,
            feePayer: solana.Ed25519HDPublicKey.fromBase58(feePayer),
          );

          // Sign the transaction.
          final signature = await keyPair.sign(
            compiledMessage.toByteArray(),
          );

          response = response.copyWith(
            result: {
              'signature': signature.toBase58(),
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

    _handleResponseForTopic(topic, response);
  }

  void _handleResponseForTopic(String topic, JsonRpcResponse response) async {
    final session = _web3Wallet.sessions.get(topic);

    try {
      await _web3Wallet.respondSessionRequest(
        topic: topic,
        response: response,
      );
      MethodsUtils.handleRedirect(
        topic,
        session!.peer.metadata.redirect,
        response.error?.message,
      );
    } on WalletConnectError catch (error) {
      MethodsUtils.handleRedirect(
        topic,
        session!.peer.metadata.redirect,
        error.message,
      );
    }
  }
}

extension on String {
  // SigningKey used by solana package requires a 32 bytes key
  Uint8List parse32Bytes() {
    try {
      final List<int> secBytes = split(',').map((e) => int.parse(e)).toList();
      return Uint8List.fromList(secBytes.sublist(0, 32));
    } catch (e) {
      final secKeyBytes = base58.decode(this);
      return Uint8List.fromList(secKeyBytes.sublist(0, 32));
    }
  }
}

extension on Map<String, dynamic> {
  solana_encoder.Instruction toInstruction() {
    final programId = this['programId'] as String;
    final programKey =
        solana.Ed25519HDPublicKey(base58.decode(programId).toList());

    final data = (this['data'] as List).map((e) => e as int).toList();
    final data58 = base58.encode(Uint8List.fromList(data));
    final dataBytes = solana_encoder.ByteArray.fromBase58(data58);

    final keys = this['keys'] as List;
    return solana_encoder.Instruction(
      programId: programKey,
      data: dataBytes,
      accounts: keys.map((k) {
        final kParams = (k as Map<String, dynamic>);
        return solana_encoder.AccountMeta(
          pubKey: solana.Ed25519HDPublicKey.fromBase58(kParams['pubkey']),
          isWriteable: kParams['isWritable'] as bool,
          isSigner: kParams['isSigner'] as bool,
        );
      }).toList(),
    );
  }
}

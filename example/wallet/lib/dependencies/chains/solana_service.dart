import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:walletconnect_flutter_v2/walletconnect_flutter_v2.dart';
import 'package:walletconnect_flutter_v2_wallet/dependencies/chains/common.dart';
import 'package:walletconnect_flutter_v2_wallet/dependencies/i_web3wallet_service.dart';
import 'package:walletconnect_flutter_v2_wallet/models/chain_metadata.dart';

class SOLANAService {
  Map<String, dynamic Function(String, dynamic)> get solanaRequestHandlers => {
        'solana_signMessage': solanaSignMessage,
        'solana_signTransaction': solanaSignTransaction,
      };

  final _web3Wallet = GetIt.I<IWeb3WalletService>().web3wallet;
  final ChainMetadata chainSupported;

  SOLANAService({required this.chainSupported}) {
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
    final response = JsonRpcResponse(
      id: pRequest.id,
      jsonrpc: '2.0',
      error: const JsonRpcError(
        code: -32600,
        message: 'Solana support not implemented',
      ),
    );
    await _web3Wallet.respondSessionRequest(
      topic: topic,
      response: response,
    );

    CommonMethods.goBackToDapp(topic, response.result ?? response.error);
  }

  Future<void> solanaSignTransaction(String topic, dynamic parameters) async {
    debugPrint('[WALLET] solanaSignTransaction request: $parameters');
    final pRequest = _web3Wallet.pendingRequests.getAll().last;
    final response = JsonRpcResponse(
      id: pRequest.id,
      jsonrpc: '2.0',
      error: const JsonRpcError(
        code: -32600,
        message: 'Solana support not implemented',
      ),
    );
    await _web3Wallet.respondSessionRequest(
      topic: topic,
      response: response,
    );

    CommonMethods.goBackToDapp(topic, response.result ?? response.error);
  }
}

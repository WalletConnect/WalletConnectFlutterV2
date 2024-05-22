import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:walletconnect_flutter_v2/walletconnect_flutter_v2.dart';
import 'package:walletconnect_flutter_v2_wallet/dependencies/chains/common.dart';
import 'package:walletconnect_flutter_v2_wallet/dependencies/i_web3wallet_service.dart';
import 'package:walletconnect_flutter_v2_wallet/models/chain_metadata.dart';

class CosmosService {
  final _web3Wallet = GetIt.I<IWeb3WalletService>().web3wallet;

  final ChainMetadata chainSupported;

  Map<String, dynamic Function(String, dynamic)> get cosmosRequestHandlers => {
        'cosmos_signDirect': cosmosSignDirect,
        'cosmos_signAmino': cosmosSignAmino,
      };

  CosmosService({required this.chainSupported}) {
    for (var handler in cosmosRequestHandlers.entries) {
      _web3Wallet.registerRequestHandler(
        chainId: chainSupported.chainId,
        method: handler.key,
        handler: handler.value,
      );
    }
  }

  Future<void> cosmosSignDirect(String topic, dynamic parameters) async {
    debugPrint('[WALLET] cosmosSignDirect request: $parameters');
    final pRequest = _web3Wallet.pendingRequests.getAll().last;
    final response = JsonRpcResponse(
      id: pRequest.id,
      jsonrpc: '2.0',
      error: const JsonRpcError(
        code: -32600,
        message: 'Cosmos support not implemented',
      ),
    );
    await _web3Wallet.respondSessionRequest(
      topic: topic,
      response: response,
    );

    CommonMethods.goBackToDapp(topic, response.result ?? response.error);
  }

  Future<void> cosmosSignAmino(String topic, dynamic parameters) async {
    debugPrint('[WALLET] cosmosSignAmino request: $parameters');
    final pRequest = _web3Wallet.pendingRequests.getAll().last;
    final response = JsonRpcResponse(
      id: pRequest.id,
      jsonrpc: '2.0',
      error: const JsonRpcError(
        code: -32600,
        message: 'Cosmos support not implemented',
      ),
    );
    await _web3Wallet.respondSessionRequest(
      topic: topic,
      response: response,
    );

    CommonMethods.goBackToDapp(topic, response.result ?? response.error);
  }
}

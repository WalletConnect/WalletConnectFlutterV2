import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:walletconnect_flutter_v2/walletconnect_flutter_v2.dart';
import 'package:walletconnect_flutter_v2_wallet/dependencies/i_web3wallet_service.dart';
import 'package:walletconnect_flutter_v2_wallet/models/chain_metadata.dart';
import 'package:walletconnect_flutter_v2_wallet/utils/methods_utils.dart';

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
    debugPrint('[SampleWallet] cosmosSignDirect request: $parameters');
    final pRequest = _web3Wallet.pendingRequests.getAll().last;
    final response = JsonRpcResponse(
      id: pRequest.id,
      jsonrpc: '2.0',
      error: const JsonRpcError(
        code: -32600,
        message: 'Cosmos support not implemented',
      ),
    );

    _handleResponseForTopic(topic, response);
  }

  Future<void> cosmosSignAmino(String topic, dynamic parameters) async {
    debugPrint('[SampleWallet] cosmosSignAmino request: $parameters');
    final pRequest = _web3Wallet.pendingRequests.getAll().last;
    final response = JsonRpcResponse(
      id: pRequest.id,
      jsonrpc: '2.0',
      error: const JsonRpcError(
        code: -32600,
        message: 'Cosmos support not implemented',
      ),
    );

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

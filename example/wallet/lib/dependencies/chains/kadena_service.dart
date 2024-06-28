import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:get_it/get_it.dart';

import 'package:walletconnect_flutter_v2/walletconnect_flutter_v2.dart';
import 'package:walletconnect_flutter_v2_wallet/dependencies/bottom_sheet/i_bottom_sheet_service.dart';
import 'package:walletconnect_flutter_v2_wallet/dependencies/chains/common.dart';
import 'package:walletconnect_flutter_v2_wallet/dependencies/i_web3wallet_service.dart';
import 'package:walletconnect_flutter_v2_wallet/dependencies/key_service/i_key_service.dart';
import 'package:walletconnect_flutter_v2_wallet/models/chain_data.dart';
import 'package:walletconnect_flutter_v2_wallet/models/chain_metadata.dart';
import 'package:walletconnect_flutter_v2_wallet/widgets/kadena_request_widget/kadena_request_widget.dart';

import 'package:kadena_dart_sdk/kadena_dart_sdk.dart';

class KadenaService {
  final _bottomSheetService = GetIt.I<IBottomSheetService>();
  final _web3Wallet = GetIt.I<IWeb3WalletService>().web3wallet;

  final ChainMetadata chainSupported;
  late final SigningApi kadenaClient;

  Map<String, dynamic Function(String, dynamic)> get kadenaRequestHandlers => {
        'kadena_getAccounts_v1': kadenaGetAccountsV1,
        'kadena_sign_v1': kadenaSignV1,
        'kadena_quicksign_v1': kadenaQuicksignV1,
      };

  KadenaService({required this.chainSupported}) {
    kadenaClient = SigningApi();

    _web3Wallet.registerEventEmitter(
      chainId: chainSupported.chainId,
      event: 'kadena_transaction_updated',
    );

    for (var handler in kadenaRequestHandlers.entries) {
      _web3Wallet.registerRequestHandler(
        chainId: chainSupported.chainId,
        method: handler.key,
        handler: handler.value,
      );
    }

    _web3Wallet.onSessionRequest.subscribe(_onSessionRequest);
  }

  Future<void> kadenaGetAccountsV1(String topic, dynamic parameters) async {
    debugPrint('[WALLET] kadenaGetAccountsV1 request: $parameters');
    final pRequest = _web3Wallet.pendingRequests.getAll().last;
    var response = JsonRpcResponse(
      id: pRequest.id,
      jsonrpc: '2.0',
    );

    try {
      final accountRequest = AccountRequest.fromJson(parameters);
      final getAccountsRequest = GetAccountsRequest(accounts: [accountRequest]);
      // Get the keys for the kadena chain
      final keys = GetIt.I<IKeyService>().getKeysForChain(
        chainSupported.chainId,
      );

      final kadenaAccounts = <KadenaAccount>[];

      // Loop through the contracts of the request if it exists and add all accounts
      for (var account in getAccountsRequest.accounts) {
        for (var contract in (account.contracts ?? [])) {
          kadenaAccounts.add(
            KadenaAccount(
              name: 'k:${keys[0].publicKey}',
              contract: contract,
              chains: ['1'],
            ),
          );
        }
      }

      response = response.copyWith(
        result: GetAccountsResponse(
          accounts: [
            AccountResponse(
              account: '${chainSupported.chainId}${keys[0].publicKey}',
              publicKey: keys[0].publicKey,
              kadenaAccounts: kadenaAccounts,
            ),
          ],
        ).toJson(),
      );
    } catch (e) {
      debugPrint('[WALLET] kadenaGetAccountsV1 error: $e');
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

  Future<void> kadenaSignV1(String topic, dynamic parameters) async {
    debugPrint('[WALLET] kadenaSignV1 request: ${jsonEncode(parameters)}');
    final pRequest = _web3Wallet.pendingRequests.getAll().last;
    var response = JsonRpcResponse(
      id: pRequest.id,
      jsonrpc: '2.0',
    );

    try {
      final chain = ChainData.kadenaChains.firstWhere(
        (c) => c.chainId == chainSupported.chainId,
      );
      final uri = Uri.parse(chain.rpc.first);
      final params = parameters as Map<String, dynamic>;
      params.putIfAbsent('networkId', () => uri.host);

      final signRequest = kadenaClient.parseSignRequest(request: params);

      // Get the keys for the kadena chain
      final keys = GetIt.I<IKeyService>().getKeysForChain(
        chainSupported.chainId,
      );

      final payload = kadenaClient.constructPactCommandPayload(
        request: signRequest,
        signingPubKey: keys[0].publicKey,
      );

      // Show the sign widget
      final List<bool>? approved = await _bottomSheetService.queueBottomSheet(
        widget: KadenaRequestWidget(payloads: [payload]),
      );

      // If the user approved, sign the request
      if ((approved ?? []).isNotEmpty) {
        final signature = kadenaClient.sign(
          payload: payload,
          keyPair: KadenaSignKeyPair(
            privateKey: keys[0].privateKey,
            publicKey: keys[0].publicKey,
          ),
        );

        response = response.copyWith(
          result: signature.toJson(),
        );
      } else {
        // throw Errors.getSdkError(Errors.USER_REJECTED_SIGN);
        response = response.copyWith(
          error: const JsonRpcError(code: 5001, message: 'User rejected'),
        );
      }
    } catch (e) {
      debugPrint('[WALLET] kadenaSignV1 error: $e');
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

  Future<void> kadenaQuicksignV1(String topic, dynamic parameters) async {
    debugPrint('[WALLET] kadenaQuicksignV1 request: ${jsonEncode(parameters)}');
    final pRequest = _web3Wallet.pendingRequests.getAll().last;
    var response = JsonRpcResponse(
      id: pRequest.id,
      jsonrpc: '2.0',
    );

    try {
      final quicksignRequest = kadenaClient.parseQuicksignRequest(
        request: parameters,
      );

      // Get the keys for the kadena chain
      final keys = GetIt.I<IKeyService>().getKeysForChain(
        chainSupported.chainId,
      );

      // Show the sign widget
      final List<bool>? approved = await _bottomSheetService.queueBottomSheet(
        widget: KadenaRequestWidget(
          payloads: [
            ...(quicksignRequest.commandSigDatas
                .map((e) => PactCommandPayload.fromJson(jsonDecode(e.cmd)))
                .toList()),
          ],
        ),
      );

      if ((approved ?? <bool>[]).isNotEmpty) {
        final List<QuicksignResponse> signatures = [];

        // Loop through the requests and sign each one that is true
        for (int i = 0; i < approved!.length; i++) {
          final bool isApproved = approved[i];
          final CommandSigData request = quicksignRequest.commandSigDatas[i];
          late QuicksignResponse signature;
          if (isApproved) {
            signature = kadenaClient.quicksignSingleCommand(
              commandSigData: request,
              keyPairs: [
                KadenaSignKeyPair(
                  privateKey: keys[0].privateKey,
                  publicKey: keys[0].publicKey,
                )
              ],
            );
          } else {
            signature = QuicksignResponse(
              commandSigData: request,
              outcome: QuicksignOutcome(
                result: QuicksignOutcome.failure,
                msg: 'User rejected sign',
              ),
            );
          }

          signatures.add(signature);
        }

        final result = QuicksignResult(responses: signatures);

        response = response.copyWith(
          result: result.toJson(),
        );
      } else {
        // throw Errors.getSdkError(Errors.USER_REJECTED_SIGN);
        response = response.copyWith(
          error: const JsonRpcError(code: 5001, message: 'User rejected'),
        );
      }
    } catch (e) {
      debugPrint('[WALLET] kadenaSignV1 error: $e');
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

  void _onSessionRequest(SessionRequestEvent? args) async {
    if (args != null && args.chainId == chainSupported.chainId) {
      debugPrint('[WALLET] _onSessionRequest ${args.toString()}');
      final handler = kadenaRequestHandlers[args.method];
      if (handler != null) {
        await handler(args.topic, args.params);
      }
    }
  }
}

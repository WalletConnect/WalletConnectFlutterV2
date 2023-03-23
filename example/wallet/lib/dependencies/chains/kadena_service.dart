import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:kadena_dart_sdk/kadena_dart_sdk.dart';
import 'package:walletconnect_flutter_v2/walletconnect_flutter_v2.dart';
import 'package:walletconnect_flutter_v2_wallet/dependencies/chains/i_chain.dart';
import 'package:walletconnect_flutter_v2_wallet/dependencies/i_bottom_sheet_service.dart';
import 'package:walletconnect_flutter_v2_wallet/dependencies/i_web3wallet_service.dart';
import 'package:walletconnect_flutter_v2_wallet/dependencies/key_service/chain_key.dart';
import 'package:walletconnect_flutter_v2_wallet/dependencies/key_service/i_key_service.dart';
import 'package:walletconnect_flutter_v2_wallet/utils/constants.dart';
import 'package:walletconnect_flutter_v2_wallet/widgets/kadena_widgets/kadena_sign_widget.dart';
import 'package:walletconnect_flutter_v2_wallet/widgets/wc_request_widget.dart/wc_request_widget.dart';

enum KadenaChainId {
  testnet04,
  mainnet01,
  development,
}

extension KadenaChainIdX on KadenaChainId {
  String get chain => '${KadenaService.namespace}:$name';
}

class KadenaService extends IChain {
  static const namespace = 'kadena';
  static const kadenaSign = 'kadena_sign';
  static const kadenaQuicksign = 'kadena_quicksign';
  static const kadenaSignV1 = 'kadena_sign_v1';
  static const kadenaQuicksignV1 = 'kadena_quicksign_v1';
  static const kadenaGetAccountsV1 = 'kadena_getAccounts_v1';

  final ISigningApi _signingApi = SigningApi();
  final IBottomSheetService _bottomSheetService =
      GetIt.I<IBottomSheetService>();
  final IWeb3WalletService _web3WalletService = GetIt.I<IWeb3WalletService>();

  final KadenaChainId reference;

  KadenaService({
    required this.reference,
  }) {
    final Web3Wallet wallet = _web3WalletService.getWeb3Wallet();
    for (final String event in getEvents()) {
      wallet.registerEventEmitter(chainId: getChainId(), event: event);
    }
    wallet.registerRequestHandler(
      chainId: getChainId(),
      method: kadenaSign,
      handler: signV1,
    );
    wallet.registerRequestHandler(
      chainId: getChainId(),
      method: kadenaSignV1,
      handler: signV1,
    );
    wallet.registerRequestHandler(
      chainId: getChainId(),
      method: kadenaQuicksign,
      handler: quicksignV1,
    );
    wallet.registerRequestHandler(
      chainId: getChainId(),
      method: kadenaQuicksignV1,
      handler: quicksignV1,
    );
    wallet.registerRequestHandler(
      chainId: getChainId(),
      method: kadenaGetAccountsV1,
      handler: getAccountsV1,
    );
  }

  @override
  String getNamespace() {
    return namespace;
  }

  @override
  String getChainId() {
    return reference.chain;
  }

  @override
  List<String> getEvents() {
    return ['kadena_transaction_updated'];
  }

  Future signV1(String topic, dynamic parameters) async {
    // print('received kadena sign request: $parameters');
    // Parse the request
    late SignRequest signRequest;
    try {
      signRequest = _signingApi.parseSignRequest(
        request: parameters,
      );
    } catch (e) {
      print(e);
      rethrow;
    }

    // Get the keys for the kadena chain
    final List<ChainKey> keys = GetIt.I<IKeyService>().getKeysForChain(
      getChainId(),
    );

    final PactCommandPayload payload = _signingApi.constructPactCommandPayload(
      request: signRequest,
      signingPubKey: keys[0].publicKey,
    );

    // Show the sign widget
    final List<bool>? approved = await _bottomSheetService.queueBottomSheet(
      widget: KadenaSignWidget(payloads: [payload]),
    );

    // If the user approved, sign the request
    if (approved != null && approved[0]) {
      final SignResult signature = _signingApi.sign(
        payload: payload,
        keyPair: KadenaSignKeyPair(
          privateKey: keys[0].privateKey,
          publicKey: keys[0].publicKey,
        ),
      );

      // Return the signature
      // print(jsonEncode(signature));
      return signature;
    } else {
      throw Errors.getSdkError(Errors.USER_REJECTED_SIGN);
    }
  }

  Future quicksignV1(String topic, dynamic parameters) async {}

  Future getAccountsV1(String topic, dynamic parameters) async {}
}

import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:kadena_dart_sdk/kadena_dart_sdk.dart';
import 'package:walletconnect_flutter_v2/walletconnect_flutter_v2.dart';
import 'package:walletconnect_flutter_v2_wallet/dependencies/bottom_sheet_service.dart';
import 'package:walletconnect_flutter_v2_wallet/dependencies/chains/i_chain.dart';
import 'package:walletconnect_flutter_v2_wallet/dependencies/i_bottom_sheet_service.dart';
import 'package:walletconnect_flutter_v2_wallet/dependencies/i_web3wallet_service.dart';
import 'package:walletconnect_flutter_v2_wallet/dependencies/web3wallet_service.dart';

enum KadenaChainId {
  testnet04,
  mainnet01,
  devnet,
}

class KadenaService extends IChain {
  final ISigningApi _signingApi = SigningApi();
  final IBottomSheetService _bottomSheetService = GetIt.I<BottomSheetService>();
  final IWeb3WalletService _web3WalletService = GetIt.I<Web3WalletService>();

  final String namespace = 'kadena';
  final KadenaChainId chainId;

  static const KADENA_SIGN_V1 = 'kadena_sign_v1';
  static const KADENA_QUICKSIGN_V1 = 'kadena_quicksign_v1';
  static const KADENA_GET_ACCOUNTS_V1 = 'kadena_getAccounts_v1';

  KadenaService({
    required this.chainId,
  }) {
    final Web3Wallet wallet = _web3WalletService.getWeb3Wallet();
    wallet.registerRequestHandler(
      chainId: getChainId(),
      method: KADENA_SIGN_V1,
      handler: signV1,
    );
    wallet.registerRequestHandler(
      chainId: getChainId(),
      method: KADENA_QUICKSIGN_V1,
      handler: quicksignV1,
    );
    wallet.registerRequestHandler(
      chainId: getChainId(),
      method: KADENA_GET_ACCOUNTS_V1,
      handler: getAccountsV1,
    );
  }

  final KadenaSignKeyPair kadenaKeyPair = const KadenaSignKeyPair(
    privateKey:
        '7d54a79feeb95ac4efdc6cfd4b702da5ee5dc1c31781b76ea092301c266e2451',
    publicKey:
        'af242a8d963f184eca742271a5134ee3d3e006f0377d667510e15f6fc18e41d9',
  );

  @override
  String getNamespace() {
    return namespace;
  }

  @override
  String getChainId() {
    switch (chainId) {
      case KadenaChainId.testnet04:
        return '$namespace:testnet04';
      case KadenaChainId.mainnet01:
        return '$namespace:mainnet01';
      case KadenaChainId.devnet:
        return '$namespace:devnet';
    }
  }

  @override
  String getPublicKey() {
    return kadenaKeyPair.publicKey;
  }

  Widget getSignWidget() {
    return Container();
  }

  Future signV1(String topic, dynamic parameters) async {
    // Parse the request

    final SignRequest signRequest = _signingApi.parseSignRequest(
      request: parameters,
    );

    // Show the sign widget
    final bool? approved = await _bottomSheetService.queueBottomSheet(
      widget: getSignWidget(),
    );

    // If the user approved, sign the request
    if (approved != null && approved) {
      final SignResult signature = _signingApi.sign(
        request: signRequest,
        keyPair: kadenaKeyPair,
      );

      // Return the signature
      return signature.toJson();
    } else {
      throw Errors.getSdkError(Errors.USER_REJECTED_SIGN);
    }
  }

  Future quicksignV1(String topic, dynamic parameters) async {}

  Future getAccountsV1(String topic, dynamic parameters) async {}

  @override
  List<String> getEvents() {
    // TODO: implement getEvents
    throw UnimplementedError();
  }
}

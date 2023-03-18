import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:walletconnect_flutter_v2/walletconnect_flutter_v2.dart';
import 'package:walletconnect_flutter_v2_wallet/dependencies/i_bottom_sheet_service.dart';
import 'package:walletconnect_flutter_v2_wallet/dependencies/i_web3wallet_service.dart';
import 'package:walletconnect_flutter_v2_wallet/dependencies/key_service/chain_key.dart';
import 'package:walletconnect_flutter_v2_wallet/dependencies/key_service/i_key_service.dart';
import 'package:walletconnect_flutter_v2_wallet/utils/constants.dart';
import 'package:walletconnect_flutter_v2_wallet/widgets/wc_connection_request/wc_auth_request_model.dart';
import 'package:walletconnect_flutter_v2_wallet/widgets/wc_connection_request/wc_connection_request_widget.dart';
import 'package:walletconnect_flutter_v2_wallet/widgets/wc_connection_request/wc_session_request_model.dart';
import 'package:walletconnect_flutter_v2_wallet/widgets/wc_request_widget.dart/wc_request_widget.dart';

class Web3WalletService extends IWeb3WalletService {
  final IBottomSheetService _bottomSheetHandler =
      GetIt.I<IBottomSheetService>();

  Web3Wallet? _web3Wallet;

  /// The list of requests from the dapp
  /// Potential types include, but aren't limited to:
  /// [SessionProposalEvent], [AuthRequest]
  @override
  ValueNotifier<List<PairingInfo>> pairings =
      ValueNotifier<List<PairingInfo>>([]);
  @override
  ValueNotifier<List<SessionData>> sessions =
      ValueNotifier<List<SessionData>>([]);
  @override
  ValueNotifier<List<AuthRequest>> auth = ValueNotifier<List<AuthRequest>>([]);

  @override
  void create() {
// Create the web3wallet
    _web3Wallet = Web3Wallet(
      core: Core(
        projectId: Constants.projectId,
      ),
      metadata: const PairingMetadata(
        name: 'Example Wallet',
        description: 'Example Wallet',
        url: 'https://walletconnect.com/',
        icons: ['https://walletconnect.com/walletconnect-logo.png'],
      ),
    );

    // Setup our accounts
    List<ChainKey> chainKeys = GetIt.I<IKeyService>().getKeys();
    for (final chainKey in chainKeys) {
      for (final chainId in chainKey.chains) {
        print('registering $chainId:${chainKey.publicKey}');
        _web3Wallet!.registerAccount(
          chainId: chainId,
          accountAddress: chainKey.publicKey,
        );
      }
    }

    // Setup our listeners
    print('web3wallet create');
    _web3Wallet!.core.pairing.onPairingCreate.subscribe(_onPairingProposal);
    _web3Wallet!.onSessionProposal.subscribe(_onSessionProposal);
    _web3Wallet!.onSessionProposalError.subscribe(_onSessionProposalError);
    _web3Wallet!.onSessionConnect.subscribe(_onSessionConnect);
    // _web3Wallet!.onSessionRequest.subscribe(_onSessionRequest);
    _web3Wallet!.onAuthRequest.subscribe(_onAuthRequest);
  }

  @override
  Future<void> init() async {
    // Await the initialization of the web3wallet
    print('web3wallet init');
    await _web3Wallet!.init();
  }

  @override
  FutureOr onDispose() {
    print('web3wallet dispose');
    _web3Wallet!.onSessionProposal.unsubscribe(_onSessionProposal);
    _web3Wallet!.onSessionProposalError.unsubscribe(_onSessionProposalError);
    _web3Wallet!.onSessionConnect.unsubscribe(_onSessionConnect);
    // _web3Wallet!.onSessionRequest.unsubscribe(_onSessionRequest);
    _web3Wallet!.onAuthRequest.unsubscribe(_onAuthRequest);
  }

  @override
  Web3Wallet getWeb3Wallet() {
    return _web3Wallet!;
  }

  void _onPairingProposal(PairingEvent? args) {
    if (args != null) {
      print(args);
      // pairings.value.add(args.);
    }
  }

  void _onSessionProposalError(SessionProposalErrorEvent? args) {
    print(args);
  }

  void _onSessionProposal(SessionProposalEvent? args) async {
    if (args != null) {
      print(args);

      // Validate the
      // args.params.

      final Widget w = WCRequestWidget(
        child: WCConnectionRequestWidget(
          wallet: _web3Wallet!,
          sessionProposal: WCSessionRequestModel(
            request: args.params,
          ),
        ),
      );
      final bool? approved = await _bottomSheetHandler.queueBottomSheet(
        widget: w,
      );
      print('approved: $approved');

      if (approved != null && approved) {
        _web3Wallet!.approveSession(
          id: args.id,
          namespaces: args.params.generatedNamespaces!,
        );
      } else {
        _web3Wallet!.rejectSession(
          id: args.id,
          reason: Errors.getSdkError(
            Errors.USER_REJECTED,
          ),
        );
      }
    }
  }

  void _onSessionConnect(SessionConnect? args) {
    if (args != null) {
      print(args);
      sessions.value.add(args.session);
    }
  }

  void _onAuthRequest(AuthRequest? args) {
    if (args != null) {
      print(args);
      final Widget w = WCRequestWidget(
        child: WCConnectionRequestWidget(
          wallet: _web3Wallet!,
          authRequest: WCAuthRequestModel(
            iss: '',
            request: args,
          ),
        ),
      );
      _bottomSheetHandler.queueBottomSheet(
        widget: w,
      );
    }
  }
}

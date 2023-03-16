import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:walletconnect_flutter_v2/walletconnect_flutter_v2.dart';
import 'package:walletconnect_flutter_v2_wallet/dependencies/i_bottom_sheet_service.dart';
import 'package:walletconnect_flutter_v2_wallet/dependencies/i_web3wallet_service.dart';
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
  final sessions = ValueNotifier<List<SessionData>>([]);
  final auth = ValueNotifier<List<AuthRequest>>([]);

  @override
  Future<void> init() async {
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

    // Setup our listeners
    _web3Wallet!.onSessionProposal.subscribe(_onSessionProposal);
    _web3Wallet!.onSessionConnect.subscribe(_onSessionConnect);
    // _web3Wallet!.onSessionRequest.subscribe(_onSessionRequest);
    _web3Wallet!.onAuthRequest.subscribe(_onAuthRequest);

    // Await the initialization of the web3wallet
    await _web3Wallet!.init();
  }

  @override
  FutureOr onDispose() {
    _web3Wallet!.onSessionProposal.unsubscribe(_onSessionProposal);
    _web3Wallet!.onSessionConnect.unsubscribe(_onSessionConnect);
    // _web3Wallet!.onSessionRequest.unsubscribe(_onSessionRequest);
    _web3Wallet!.onAuthRequest.unsubscribe(_onAuthRequest);
  }

  @override
  Web3Wallet getWeb3Wallet() {
    return _web3Wallet!;
  }

  void _onSessionProposal(SessionProposalEvent? args) async {
    if (args != null) {
      print(args);

      // Validate the
      // args.params.

      final Widget w = WCRequestWidget(
        child: WCConnectionRequestWidget(
          wallet: _web3Wallet!,
          title: 'Sign',
          sessionProposal: WCSessionRequestModel(
            request: args.params,
          ),
        ),
      );
      final bool approved = await _bottomSheetHandler.queueBottomSheet(
        widget: w,
      );

      if (approved) {
        // _web3Wallet!.approveSession(args.id);
      } else {
        // _web3Wallet!.rejectSession(args.id);
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
          title: 'Auth',
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

import 'dart:async';
import 'dart:typed_data';

import 'package:eth_sig_util/eth_sig_util.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:walletconnect_flutter_v2/walletconnect_flutter_v2.dart';
import 'package:walletconnect_flutter_v2_wallet/dependencies/bottom_sheet/i_bottom_sheet_service.dart';
import 'package:walletconnect_flutter_v2_wallet/dependencies/deep_link_handler.dart';
import 'package:walletconnect_flutter_v2_wallet/dependencies/i_web3wallet_service.dart';
import 'package:walletconnect_flutter_v2_wallet/dependencies/key_service/chain_key.dart';
import 'package:walletconnect_flutter_v2_wallet/dependencies/key_service/i_key_service.dart';
import 'package:walletconnect_flutter_v2_wallet/utils/constants.dart';
import 'package:walletconnect_flutter_v2_wallet/utils/dart_defines.dart';
import 'package:walletconnect_flutter_v2_wallet/utils/eth_utils.dart';
import 'package:walletconnect_flutter_v2_wallet/widgets/wc_connection_request/wc_auth_request_model.dart';
import 'package:walletconnect_flutter_v2_wallet/widgets/wc_connection_request/wc_connection_request_widget.dart';
import 'package:walletconnect_flutter_v2_wallet/widgets/wc_connection_request/wc_session_request_model.dart';
import 'package:walletconnect_flutter_v2_wallet/widgets/wc_request_widget.dart/wc_request_widget.dart';

class Web3WalletService extends IWeb3WalletService {
  final _bottomSheetHandler = GetIt.I<IBottomSheetService>();
  Web3Wallet? _web3Wallet;

  @override
  Future<void> create() async {
    // Create the web3wallet
    _web3Wallet = Web3Wallet(
      core: Core(
        projectId: DartDefines.projectId,
        logLevel: LogLevel.error,
      ),
      metadata: const PairingMetadata(
        name: 'Sample Wallet Flutter',
        description: 'WalletConnect\'s sample wallet with Flutter',
        url: 'https://walletconnect.com/',
        icons: [
          'https://docs.walletconnect.com/assets/images/web3walletLogo-54d3b546146931ceaf47a3500868a73a.png'
        ],
        redirect: Redirect(
          native: 'wcflutterwallet://',
          universal: 'https://walletconnect.com',
        ),
      ),
    );

    // Setup our accounts
    List<ChainKey> chainKeys = await GetIt.I<IKeyService>().setKeys();
    if (chainKeys.isEmpty) {
      await GetIt.I<IKeyService>().loadDefaultWallet();
      chainKeys = await GetIt.I<IKeyService>().setKeys();
    }
    for (final chainKey in chainKeys) {
      for (final chainId in chainKey.chains) {
        if (chainId.startsWith('kadena')) {
          final account = '$chainId:k**${chainKey.address}';
          debugPrint('[$runtimeType] registerAccount $account');
          _web3Wallet!.registerAccount(
            chainId: chainId,
            accountAddress: 'k**${chainKey.address}',
          );
        } else {
          final account = '$chainId:${chainKey.address}';
          debugPrint('[$runtimeType] registerAccount $account');
          _web3Wallet!.registerAccount(
            chainId: chainId,
            accountAddress: chainKey.address,
          );
        }
      }
    }

    // Setup our listeners
    debugPrint('[WALLET] [$runtimeType] create');
    _web3Wallet!.core.pairing.onPairingInvalid.subscribe(_onPairingInvalid);
    _web3Wallet!.core.pairing.onPairingCreate.subscribe(_onPairingCreate);
    _web3Wallet!.onSessionProposal.subscribe(_onSessionProposal);
    _web3Wallet!.onSessionConnect.subscribe(_onSessionConnect);
    _web3Wallet!.onSessionProposalError.subscribe(_onSessionProposalError);
    _web3Wallet!.onAuthRequest.subscribe(_onAuthRequest);
    _web3Wallet!.core.relayClient.onRelayClientError.subscribe(
      _onRelayClientError,
    );
    _web3Wallet!.core.relayClient.onRelayClientMessage.subscribe(
      _onRelayClientMessage,
    );
  }

  @override
  Future<void> init() async {
    // Await the initialization of the web3wallet
    debugPrint('[$runtimeType] [WALLET] init');
    await _web3Wallet!.init();
  }

  @override
  FutureOr onDispose() {
    debugPrint('[$runtimeType] [WALLET] dispose');
    _web3Wallet!.core.pairing.onPairingInvalid.unsubscribe(_onPairingInvalid);
    _web3Wallet!.core.pairing.onPairingCreate.unsubscribe(_onPairingCreate);
    _web3Wallet!.onSessionProposal.unsubscribe(_onSessionProposal);
    _web3Wallet!.onSessionConnect.unsubscribe(_onSessionConnect);
    _web3Wallet!.onSessionProposalError.unsubscribe(_onSessionProposalError);
    _web3Wallet!.onAuthRequest.unsubscribe(_onAuthRequest);
    _web3Wallet!.core.relayClient.onRelayClientError.unsubscribe(
      _onRelayClientError,
    );
    _web3Wallet!.core.relayClient.onRelayClientMessage.unsubscribe(
      _onRelayClientMessage,
    );
  }

  @override
  Web3Wallet get web3wallet => _web3Wallet!;

  void _onRelayClientMessage(MessageEvent? event) async {
    if (event != null) {
      final jsonObject = await EthUtils.decodeMessageEvent(event);
      debugPrint('[$runtimeType] [WALLET] _onRelayClientMessage $jsonObject');
      if (jsonObject is JsonRpcRequest) {
        if (jsonObject.method == 'wc_sessionPropose' ||
            jsonObject.method == 'wc_sessionRequest') {
          DeepLinkHandler.waiting.value = true;
        }
      } else {
        final session = _web3Wallet!.sessions.get(event.topic);
        final scheme = session?.peer.metadata.redirect?.native ?? '';
        final isSuccess = jsonObject.result != null;
        final title = isSuccess ? null : 'Error';
        final message = isSuccess ? null : jsonObject.error?.message ?? '';
        DeepLinkHandler.goTo(
          scheme,
          modalTitle: title,
          modalMessage: message,
          success: isSuccess,
        );
      }
    }
  }

  void _onSessionProposal(SessionProposalEvent? args) async {
    debugPrint('[$runtimeType] [WALLET] _onSessionProposal $args');
    if (args != null) {
      final approved = await _bottomSheetHandler.queueBottomSheet(
        widget: WCRequestWidget(
          child: WCConnectionRequestWidget(
            wallet: _web3Wallet!,
            sessionProposal: WCSessionRequestModel(
              request: args.params,
              verifyContext: args.verifyContext,
            ),
          ),
        ),
      );

      if (approved == true) {
        // generatedNamespaces is constructed based on registered methods handlers
        // so if you want to handle requests using onSessionRequest event then you would need to manually add that method in the approved namespaces
        await _web3Wallet!.approveSession(
          id: args.id,
          namespaces: args.params.generatedNamespaces!,
          sessionProperties: args.params.sessionProperties,
        );
      } else {
        final error = Errors.getSdkError(Errors.USER_REJECTED);
        await _web3Wallet!.rejectSession(id: args.id, reason: error);
        await _web3Wallet!.core.pairing.disconnect(
          topic: args.params.pairingTopic,
        );

        // TODO this should be triggered on _onRelayClientMessage
        final scheme = args.params.proposer.metadata.redirect?.native ?? '';
        DeepLinkHandler.goTo(
          scheme,
          modalTitle: 'Error',
          modalMessage: 'User rejected',
          success: false,
        );
      }
    }
  }

  void _onSessionProposalError(SessionProposalErrorEvent? args) async {
    debugPrint('[$runtimeType] [WALLET] _onSessionProposalError $args');
    DeepLinkHandler.waiting.value = false;
    if (args != null) {
      String errorMessage = args.error.message;
      if (args.error.code == 5100) {
        errorMessage =
            errorMessage.replaceFirst('Requested:', '\n\nRequested:');
        errorMessage =
            errorMessage.replaceFirst('Supported:', '\n\nSupported:');
      }
      GetIt.I<IBottomSheetService>().queueBottomSheet(
        widget: Container(
          color: Colors.white,
          width: double.infinity,
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              Icon(
                Icons.error_outline_sharp,
                color: Colors.red[100],
                size: 80.0,
              ),
              Text(
                'Error',
                style: StyleConstants.subtitleText.copyWith(
                  color: Colors.black,
                  fontSize: 18.0,
                ),
              ),
              Text(errorMessage),
            ],
          ),
        ),
      );
    }
  }

  void _onSessionConnect(SessionConnect? args) {
    debugPrint('[$runtimeType] [WALLET] _onSessionConnect $args');
    if (args != null) {
      final scheme = args.session.peer.metadata.redirect?.native ?? '';
      DeepLinkHandler.goTo(scheme);
    }
  }

  void _onRelayClientError(ErrorEvent? args) {
    debugPrint('[$runtimeType] [WALLET] _onRelayClientError ${args?.error}');
  }

  void _onPairingInvalid(PairingInvalidEvent? args) {
    debugPrint('[$runtimeType] [WALLET] _onPairingInvalid $args');
  }

  void _onPairingCreate(PairingEvent? args) {
    debugPrint('[$runtimeType] [WALLET] _onPairingCreate $args');
  }

  Future<void> _onAuthRequest(AuthRequest? args) async {
    debugPrint('[$runtimeType] [WALLET] _onAuthRequest $args');
    if (args != null) {
      final chainKeys = GetIt.I<IKeyService>().getKeysForChain('eip155:1');
      // Create the message to be signed
      final iss = 'did:pkh:eip155:1:${chainKeys.first.address}';

      final bool? auth = await _bottomSheetHandler.queueBottomSheet(
        widget: WCRequestWidget(
          child: WCConnectionRequestWidget(
            wallet: _web3Wallet!,
            authRequest: WCAuthRequestModel(
              iss: iss,
              request: args,
            ),
          ),
        ),
      );

      if (auth != null && auth) {
        final String message = _web3Wallet!.formatAuthMessage(
          iss: iss,
          cacaoPayload: CacaoRequestPayload.fromPayloadParams(
            args.payloadParams,
          ),
        );

        final String sig = EthSigUtil.signPersonalMessage(
          message: Uint8List.fromList(message.codeUnits),
          privateKey: chainKeys.first.privateKey,
        );

        await _web3Wallet!.respondAuthRequest(
          id: args.id,
          iss: iss,
          signature: CacaoSignature(
            t: CacaoSignature.EIP191,
            s: sig,
          ),
        );
        final scheme = args.requester.metadata.redirect?.native ?? '';
        DeepLinkHandler.goTo(scheme);
      } else {
        await _web3Wallet!.respondAuthRequest(
          id: args.id,
          iss: iss,
          error: Errors.getSdkError(Errors.USER_REJECTED_AUTH),
        );
        // TODO this should be triggered on _onRelayClientMessage
        final scheme = args.requester.metadata.redirect?.native ?? '';
        DeepLinkHandler.goTo(
          scheme,
          modalTitle: 'Error',
          modalMessage: 'User rejected',
          success: false,
        );
      }
    }
  }
}

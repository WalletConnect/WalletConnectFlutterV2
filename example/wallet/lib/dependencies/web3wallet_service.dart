import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:walletconnect_flutter_v2/walletconnect_flutter_v2.dart';
import 'package:walletconnect_flutter_v2_wallet/dependencies/bottom_sheet/i_bottom_sheet_service.dart';
import 'package:walletconnect_flutter_v2_wallet/dependencies/chains/evm_service.dart';
import 'package:walletconnect_flutter_v2_wallet/dependencies/deep_link_handler.dart';
import 'package:walletconnect_flutter_v2_wallet/dependencies/i_web3wallet_service.dart';
import 'package:walletconnect_flutter_v2_wallet/dependencies/key_service/chain_key.dart';
import 'package:walletconnect_flutter_v2_wallet/dependencies/key_service/i_key_service.dart';
import 'package:walletconnect_flutter_v2_wallet/models/chain_data.dart';
import 'package:walletconnect_flutter_v2_wallet/utils/constants.dart';
import 'package:walletconnect_flutter_v2_wallet/utils/dart_defines.dart';
import 'package:walletconnect_flutter_v2_wallet/utils/eth_utils.dart';
import 'package:walletconnect_flutter_v2_wallet/widgets/wc_connection_request/wc_connection_request_widget.dart';
import 'package:walletconnect_flutter_v2_wallet/widgets/wc_request_widget.dart/wc_request_widget.dart';
import 'package:walletconnect_flutter_v2_wallet/widgets/wc_request_widget.dart/wc_session_auth_request_widget.dart';

class Web3WalletService extends IWeb3WalletService {
  final _bottomSheetHandler = GetIt.I<IBottomSheetService>();
  Web3Wallet? _web3Wallet;

  @override
  Future<void> create() async {
    // Create the web3wallet
    _web3Wallet = Web3Wallet(
      core: Core(
        projectId: DartDefines.projectId,
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

    _web3Wallet!.core.addLogListener(_logListener);

    // Setup our listeners
    debugPrint('[SampleWallet] create');
    _web3Wallet!.core.pairing.onPairingInvalid.subscribe(_onPairingInvalid);
    _web3Wallet!.core.pairing.onPairingCreate.subscribe(_onPairingCreate);
    _web3Wallet!.core.relayClient.onRelayClientError.subscribe(
      _onRelayClientError,
    );
    _web3Wallet!.core.relayClient.onRelayClientMessage.subscribe(
      _onRelayClientMessage,
    );

    _web3Wallet!.onSessionProposal.subscribe(_onSessionProposal);
    _web3Wallet!.onSessionProposalError.subscribe(_onSessionProposalError);
    _web3Wallet!.onSessionConnect.subscribe(_onSessionConnect);
    _web3Wallet!.onSessionAuthRequest.subscribe(_onSessionAuthRequest);

    _web3Wallet!.onAuthRequest.subscribe(_onAuthRequest);

    await _web3Wallet!.init();

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
          debugPrint('[SampleWallet] registerAccount $account');
          _web3Wallet!.registerAccount(
            chainId: chainId,
            accountAddress: 'k**${chainKey.address}',
          );
        } else {
          final account = '$chainId:${chainKey.address}';
          debugPrint('[SampleWallet] registerAccount $account');
          _web3Wallet!.registerAccount(
            chainId: chainId,
            accountAddress: chainKey.address,
          );
        }
      }
    }
  }

  @override
  Future<void> init() async {
    // Await the initialization of the web3wallet
    await _web3Wallet!.init();
  }

  void _logListener(LogEvent event) {
    debugPrint('[Logger] ${event.level.name}: ${event.message}');
    if (event.level == Level.error) {
      // TODO send to mixpanel
    }
  }

  @override
  FutureOr onDispose() {
    _web3Wallet!.core.removeLogListener(_logListener);
    _web3Wallet!.core.pairing.onPairingInvalid.unsubscribe(_onPairingInvalid);
    _web3Wallet!.core.pairing.onPairingCreate.unsubscribe(_onPairingCreate);
    _web3Wallet!.core.relayClient.onRelayClientError.unsubscribe(
      _onRelayClientError,
    );
    _web3Wallet!.core.relayClient.onRelayClientMessage.unsubscribe(
      _onRelayClientMessage,
    );

    _web3Wallet!.onSessionProposal.unsubscribe(_onSessionProposal);
    _web3Wallet!.onSessionProposalError.unsubscribe(_onSessionProposalError);
    _web3Wallet!.onSessionConnect.unsubscribe(_onSessionConnect);
    _web3Wallet!.onSessionAuthRequest.unsubscribe(_onSessionAuthRequest);

    _web3Wallet!.onAuthRequest.unsubscribe(_onAuthRequest);
  }

  @override
  Web3Wallet get web3wallet => _web3Wallet!;

  void _onRelayClientMessage(MessageEvent? event) async {
    if (event != null) {
      final jsonObject = await EthUtils.decodeMessageEvent(event);
      debugPrint('[SampleWallet] _onRelayClientMessage $jsonObject');
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
    if (args != null) {
      log('[SampleWallet] _onSessionProposal ${jsonEncode(args.params)}');
      final WCBottomSheetResult rs =
          (await _bottomSheetHandler.queueBottomSheet(
                widget: WCRequestWidget(
                  child: WCConnectionRequestWidget(
                    proposalData: args.params,
                    verifyContext: args.verifyContext,
                    metadata: args.params.proposer,
                  ),
                ),
              )) ??
              WCBottomSheetResult.reject;

      if (rs != WCBottomSheetResult.reject) {
        // generatedNamespaces is constructed based on registered methods handlers
        // so if you want to handle requests using onSessionRequest event then you would need to manually add that method in the approved namespaces
        await _web3Wallet!.approveSession(
          id: args.id,
          namespaces: NamespaceUtils.regenerateNamespacesWithChains(
            args.params.generatedNamespaces!,
          ),
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
    log('[SampleWallet] _onSessionProposalError $args');
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
    if (args != null) {
      log('[SampleWallet] _onSessionConnect ${jsonEncode(args.session)}');
      final scheme = args.session.peer.metadata.redirect?.native ?? '';
      DeepLinkHandler.goTo(scheme);
    }
  }

  void _onRelayClientError(ErrorEvent? args) {
    debugPrint('[SampleWallet] _onRelayClientError ${args?.error}');
  }

  void _onPairingInvalid(PairingInvalidEvent? args) {
    debugPrint('[SampleWallet] _onPairingInvalid $args');
  }

  void _onPairingCreate(PairingEvent? args) {
    debugPrint('[SampleWallet] _onPairingCreate $args');
  }

  void _onSessionAuthRequest(SessionAuthRequest? args) async {
    log('[SampleWallet] _onSessionAuthRequest ${jsonEncode(args?.authPayload.toJson())}');
    if (args != null) {
      final SessionAuthPayload authPayload = args.authPayload;
      final supportedChains = ChainData.eip155Chains.map((e) => e.chainId);
      final supportedMethods = SupportedEVMMethods.values.map((e) => e.name);
      final newAuthPayload = AuthSignature.populateAuthPayload(
        authPayload: authPayload,
        chains: supportedChains.toList(),
        methods: supportedMethods.toList(),
      );
      final cacaoRequestPayload = CacaoRequestPayload.fromSessionAuthPayload(
        newAuthPayload,
      );
      final List<Map<String, dynamic>> formattedMessages = [];
      for (var chain in newAuthPayload.chains) {
        final chainKeys = GetIt.I<IKeyService>().getKeysForChain(chain);
        final iss = 'did:pkh:$chain:${chainKeys.first.address}';
        final message = _web3Wallet!.formatAuthMessage(
          iss: iss,
          cacaoPayload: cacaoRequestPayload,
        );
        formattedMessages.add({iss: message});
      }

      final WCBottomSheetResult rs =
          (await _bottomSheetHandler.queueBottomSheet(
                widget: WCSessionAuthRequestWidget(
                  child: WCConnectionRequestWidget(
                    sessionAuthPayload: newAuthPayload,
                    verifyContext: args.verifyContext,
                    metadata: args.requester,
                  ),
                ),
              )) ??
              WCBottomSheetResult.reject;

      if (rs != WCBottomSheetResult.reject) {
        const chain = 'eip155:1';
        final chainKeys = GetIt.I<IKeyService>().getKeysForChain(chain);
        final privateKey = '0x${chainKeys[0].privateKey}';
        final credentials = EthPrivateKey.fromHex(privateKey);
        //
        final messageToSign = formattedMessages.length;
        final count = (rs == WCBottomSheetResult.one) ? 1 : messageToSign;
        //
        final List<Cacao> cacaos = [];
        for (var i = 0; i < count; i++) {
          final iss = formattedMessages[i].keys.first;
          final message = formattedMessages[i].values.first;
          final signature = credentials.signPersonalMessageToUint8List(
            Uint8List.fromList(message.codeUnits),
          );
          final hexSignature = bytesToHex(signature, include0x: true);
          cacaos.add(
            AuthSignature.buildAuthObject(
              requestPayload: cacaoRequestPayload,
              signature: CacaoSignature(
                t: CacaoSignature.EIP191,
                s: hexSignature,
              ),
              iss: iss,
            ),
          );
        }
        //
        final _ = await _web3Wallet!.approveSessionAuthenticate(
          id: args.id,
          auths: cacaos,
        );
        final scheme = args.requester.metadata.redirect?.native ?? '';
        DeepLinkHandler.goTo(scheme);
      } else {
        await _web3Wallet!.rejectSessionAuthenticate(
          id: args.id,
          reason: Errors.getSdkError(Errors.USER_REJECTED_AUTH),
        );
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

  Future<void> _onAuthRequest(AuthRequest? args) async {
    log('[SampleWallet] _onAuthRequest $args');
    if (args != null) {
      //
      final WCBottomSheetResult rs =
          (await _bottomSheetHandler.queueBottomSheet(
                widget: WCRequestWidget(
                  child: WCConnectionRequestWidget(
                    authPayloadParams: args.payloadParams,
                    metadata: args.requester,
                  ),
                ),
              )) ??
              WCBottomSheetResult.reject;

      const chain = 'eip155:1';
      final chainKeys = GetIt.I<IKeyService>().getKeysForChain(chain);
      final privateKey = '0x${chainKeys[0].privateKey}';
      final credentials = EthPrivateKey.fromHex(privateKey);
      final iss = 'did:pkh:$chain:${credentials.address.hex}';

      if (rs != WCBottomSheetResult.reject) {
        //
        final message = _web3Wallet!.formatAuthMessage(
          iss: iss,
          cacaoPayload: CacaoRequestPayload.fromPayloadParams(
            args.payloadParams,
          ),
        );

        final signature = credentials.signPersonalMessageToUint8List(
          Uint8List.fromList(message.codeUnits),
        );
        final hexSignature = bytesToHex(signature, include0x: true);

        await _web3Wallet!.respondAuthRequest(
          id: args.id,
          iss: iss,
          signature: CacaoSignature(
            t: CacaoSignature.EIP191,
            s: hexSignature,
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

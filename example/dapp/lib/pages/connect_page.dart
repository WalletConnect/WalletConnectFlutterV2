import 'dart:async';
import 'dart:convert';

import 'package:fl_toast/fl_toast.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:url_launcher/url_launcher_string.dart';

import 'package:walletconnect_flutter_v2_dapp/models/chain_metadata.dart';
import 'package:walletconnect_flutter_v2_dapp/utils/constants.dart';
import 'package:walletconnect_flutter_v2_dapp/utils/crypto/chain_data.dart';
import 'package:walletconnect_flutter_v2_dapp/utils/crypto/eip155.dart';
import 'package:walletconnect_flutter_v2_dapp/utils/crypto/polkadot.dart';
import 'package:walletconnect_flutter_v2_dapp/utils/crypto/solana.dart';
import 'package:walletconnect_flutter_v2_dapp/utils/string_constants.dart';
import 'package:walletconnect_flutter_v2_dapp/widgets/chain_button.dart';
import 'package:walletconnect_flutter_v2_dapp/imports.dart';
import 'package:walletconnect_modal_flutter/walletconnect_modal_flutter.dart';

class ConnectPage extends StatefulWidget {
  const ConnectPage({
    super.key,
    required this.web3App,
  });

  final Web3App web3App;

  @override
  ConnectPageState createState() => ConnectPageState();
}

class ConnectPageState extends State<ConnectPage> {
  bool _testnetOnly = false;
  final List<ChainMetadata> _selectedChains = [];
  bool _shouldDismissQrCode = true;
  bool _initialized = false;
  late IWalletConnectModalService _walletConnectModalService;

  @override
  void initState() {
    super.initState();
    _initializeWCM();
  }

  Future<void> _initializeWCM() async {
    _walletConnectModalService = WalletConnectModalService(
      web3App: widget.web3App,
    );

    await _walletConnectModalService.init();

    setState(() => _initialized = true);

    widget.web3App.onSessionConnect.subscribe(_onSessionConnect);
  }

  @override
  void dispose() {
    widget.web3App.onSessionConnect.unsubscribe(_onSessionConnect);
    super.dispose();
  }

  void setTestnet(bool value) {
    if (value != _testnetOnly) {
      _selectedChains.clear();
    }
    _testnetOnly = value;
  }

  void _selectChain(ChainMetadata chain) {
    setState(() {
      if (_selectedChains.contains(chain)) {
        _selectedChains.remove(chain);
      } else {
        _selectedChains.add(chain);
      }
      _updateNamespaces();
    });
  }

  Map<String, RequiredNamespace> requiredNamespaces = {};
  Map<String, RequiredNamespace> optionalNamespaces = {};

  void _updateNamespaces() {
    optionalNamespaces = {};

    final evmChains =
        _selectedChains.where((e) => e.type == ChainType.eip155).toList();
    if (evmChains.isNotEmpty) {
      optionalNamespaces['eip155'] = RequiredNamespace(
        chains: evmChains.map((c) => c.chainId).toList(),
        methods: EIP155.methods.values.toList(),
        events: EIP155.events.values.toList(),
      );
    }

    final solanaChains =
        _selectedChains.where((e) => e.type == ChainType.solana).toList();
    if (solanaChains.isNotEmpty) {
      optionalNamespaces['solana'] = RequiredNamespace(
        chains: solanaChains.map((c) => c.chainId).toList(),
        methods: Solana.methods.values.toList(),
        events: Solana.events.values.toList(),
      );
    }

    final polkadotChains =
        _selectedChains.where((e) => e.type == ChainType.polkadot).toList();
    if (polkadotChains.isNotEmpty) {
      optionalNamespaces['polkadot'] = RequiredNamespace(
        chains: polkadotChains.map((c) => c.chainId).toList(),
        methods: Polkadot.methods.values.toList(),
        events: Polkadot.events.values.toList(),
      );
    }

    if (optionalNamespaces.isEmpty) {
      requiredNamespaces = {};
    } else {
      // WalletConnectModal still requires to have requiredNamespaces
      // this has to be changed in that SDK
      requiredNamespaces = {
        'eip155': const RequiredNamespace(
          chains: ['eip155:1'],
          methods: ['personal_sign', 'eth_signTransaction'],
          events: ['chainChanged'],
        ),
      };
    }

    _walletConnectModalService.setRequiredNamespaces(
      requiredNamespaces: requiredNamespaces,
    );
    debugPrint(
        '[SampleDapp] requiredNamespaces ${jsonEncode(requiredNamespaces)}');
    _walletConnectModalService.setOptionalNamespaces(
      optionalNamespaces: optionalNamespaces,
    );
    debugPrint(
        '[SampleDapp] optionalNamespaces ${jsonEncode(optionalNamespaces)}');
  }

  @override
  Widget build(BuildContext context) {
    // Build the list of chain buttons, clear if the textnet changed
    final testChains = ChainData.allChains.where((e) => e.isTestnet).toList();
    final mainChains = ChainData.allChains.where((e) => !e.isTestnet).toList();
    final List<ChainMetadata> chains = _testnetOnly ? testChains : mainChains;

    final List<Widget> evmChainButtons = [];
    final List<Widget> nonEvmChainButtons = [];

    final evmChains = chains.where((e) => e.type == ChainType.eip155);
    final nonEvmChains = chains.where((e) => e.type != ChainType.eip155);

    for (final ChainMetadata chain in evmChains) {
      // Build the button
      evmChainButtons.add(
        ChainButton(
          chain: chain,
          onPressed: () => _selectChain(chain),
          selected: _selectedChains.contains(chain),
        ),
      );
    }

    for (final ChainMetadata chain in nonEvmChains) {
      // Build the button
      nonEvmChainButtons.add(
        ChainButton(
          chain: chain,
          onPressed: () => _selectChain(chain),
          selected: _selectedChains.contains(chain),
        ),
      );
    }

    return ListView(
      padding: const EdgeInsets.symmetric(horizontal: StyleConstants.linear8),
      children: <Widget>[
        Column(
          children: [
            const Text(
              'Flutter Dapp',
              style: StyleConstants.subtitleText,
              textAlign: TextAlign.center,
            ),
            FutureBuilder<PackageInfo>(
              future: PackageInfo.fromPlatform(),
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return const SizedBox.shrink();
                }
                final v = snapshot.data!.version;
                final b = snapshot.data!.buildNumber;
                const f = String.fromEnvironment('FLUTTER_APP_FLAVOR');
                return Text('$v-$f ($b) - SDK v$packageVersion');
              },
            ),
          ],
        ),
        SizedBox(
          height: StyleConstants.linear48,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                StringConstants.testnetsOnly,
                style: StyleConstants.buttonText,
              ),
              Switch(
                value: _testnetOnly,
                onChanged: (value) {
                  setState(() {
                    _selectedChains.clear();
                    _testnetOnly = value;
                  });
                },
              ),
            ],
          ),
        ),
        const Text('EVM Chains:', style: StyleConstants.buttonText),
        const SizedBox(height: StyleConstants.linear8),
        Wrap(
          spacing: 10.0,
          children: evmChainButtons,
        ),
        const Divider(),
        const Text('Non EVM Chains:', style: StyleConstants.buttonText),
        Wrap(
          spacing: 10.0,
          children: nonEvmChainButtons,
        ),
        const Divider(),
        if (_initialized)
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: StyleConstants.linear8),
              const Text(
                'Use WalletConnectModal:',
                style: StyleConstants.buttonText,
              ),
              const SizedBox(height: StyleConstants.linear8),
              WalletConnectModalConnect(
                service: _walletConnectModalService,
                width: double.infinity,
                height: 50.0,
              ),
            ],
          ),
        const SizedBox(height: StyleConstants.linear8),
        const Divider(),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: StyleConstants.linear8),
            const Text(
              'Use custom connection:',
              style: StyleConstants.buttonText,
            ),
            const SizedBox(height: StyleConstants.linear8),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                style: _buttonStyle,
                onPressed: _selectedChains.isEmpty
                    ? null
                    : () => _onConnect(
                          showToast: (m) async {
                            await showPlatformToast(
                                child: Text(m), context: context);
                          },
                          closeModal: () {
                            if (Navigator.canPop(context)) {
                              Navigator.of(context).pop();
                            }
                          },
                        ),
                child: const Text(
                  StringConstants.connect,
                  style: StyleConstants.buttonText,
                ),
              ),
            ),
            const SizedBox(height: StyleConstants.linear8),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                style: _buttonStyle,
                onPressed: _selectedChains.isEmpty
                    ? null
                    : () => _oneClickAuth(
                          closeModal: () {
                            if (Navigator.canPop(context)) {
                              Navigator.of(context).pop();
                            }
                          },
                          showToast: (message) {
                            showPlatformToast(
                                child: Text(message), context: context);
                          },
                        ),
                child: const Text(
                  'One-Click Auth',
                  style: StyleConstants.buttonText,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: StyleConstants.linear16),
      ],
    );
  }

  // Future<void> _onConnectWeb() async {
  //   // `Ethereum.isSupported` is the same as `ethereum != null`
  //   if (ethereum != null) {
  //     try {
  //       // Prompt user to connect to the provider, i.e. confirm the connection modal
  //       final accounts = await ethereum!.requestAccount();
  //       // Get all accounts in node disposal
  //       debugPrint('accounts ${accounts.join(', ')}');
  //     } on EthereumUserRejected {
  //       debugPrint('User rejected the modal');
  //     }
  //   }
  // }

  Future<void> _onConnect({
    Function(String message)? showToast,
    VoidCallback? closeModal,
  }) async {
    debugPrint('[SampleDapp] Creating connection and session');
    // It is currently safer to send chains approvals on optionalNamespaces
    // but depending on Wallet implementation you may need to send some (for innstance eip155:1) as required
    final connectResponse = await widget.web3App.connect(
      requiredNamespaces: requiredNamespaces,
      optionalNamespaces: optionalNamespaces,
    );

    final encodedUri = Uri.encodeComponent(connectResponse.uri.toString());
    const flavor = String.fromEnvironment('FLUTTER_APP_FLAVOR');
    final uri = 'wcflutterwallet-$flavor://wc?uri=$encodedUri';
    if (await canLaunchUrlString(uri)) {
      final openApp = await showDialog(
        // ignore: use_build_context_synchronously
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            content: const Text('Do you want to open with Web3Wallet Flutter'),
            actions: [
              TextButton(
                onPressed: () => Navigator.of(context).pop(false),
                child: const Text('Show QR'),
              ),
              TextButton(
                onPressed: () => Navigator.of(context).pop(true),
                child: const Text('Open'),
              ),
            ],
          );
        },
      );
      if (openApp) {
        launchUrlString(uri, mode: LaunchMode.externalApplication);
      } else {
        _showQrCode(connectResponse.uri.toString());
      }
    } else {
      _showQrCode(connectResponse.uri.toString());
    }

    debugPrint('[SampleDapp] Awaiting session proposal settlement');
    final _ = await connectResponse.session.future;

    showToast?.call(StringConstants.connectionEstablished);
    closeModal?.call();
  }

  Future<void> _showQrCode(String uri) async {
    // Show the QR code
    debugPrint('[SampleDapp] Showing QR Code: $uri');
    _shouldDismissQrCode = true;
    if (kIsWeb) {
      await showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return AlertDialog(
            insetPadding: const EdgeInsets.all(0.0),
            contentPadding: const EdgeInsets.all(0.0),
            backgroundColor: Colors.white,
            content: SizedBox(
              width: 400.0,
              child: AspectRatio(
                aspectRatio: 0.8,
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: _QRCodeView(
                    uri: uri,
                  ),
                ),
              ),
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text('Cancel'),
              )
            ],
          );
        },
      );
      _shouldDismissQrCode = false;
      return;
    }
    Navigator.push(
      context,
      MaterialPageRoute(
        fullscreenDialog: true,
        builder: (context) => QRCodeScreen(uri: uri),
      ),
    );
  }

  void _requestAuth(
    SessionConnect? event, {
    Function(String message)? showToast,
  }) async {
    final shouldAuth = await showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          insetPadding: const EdgeInsets.all(0.0),
          contentPadding: const EdgeInsets.all(0.0),
          backgroundColor: Colors.white,
          title: const Text('Request Auth?'),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context, false),
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                Navigator.pop(context, true);
              },
              child: const Text('Yes!'),
            ),
          ],
        );
      },
    );
    if (shouldAuth != true) return;

    try {
      final pairingTopic = event?.session.pairingTopic;
      // Send off an auth request now that the pairing/session is established
      final authResponse = await widget.web3App.requestAuth(
        pairingTopic: pairingTopic,
        params: AuthRequestParams(
          chainId: 'eip155:1',
          domain: Constants.domain,
          aud: Constants.aud,
          statement: 'Welcome to example flutter app',
        ),
      );

      final scheme = event?.session.peer.metadata.redirect?.native;
      const flavor = String.fromEnvironment('FLUTTER_APP_FLAVOR');
      launchUrlString(
        scheme ?? 'wcflutterwallet-$flavor://',
        mode: LaunchMode.externalApplication,
      );

      debugPrint('[SampleDapp] Awaiting authentication response');
      final response = await authResponse.completer.future;
      if (response.result != null) {
        showToast?.call(StringConstants.authSucceeded);
      } else {
        final error = response.error ?? response.jsonRpcError;
        showToast?.call(error.toString());
      }
    } catch (e) {
      debugPrint('[SampleDapp] auth $e');
      showToast?.call(StringConstants.connectionFailed);
    }
  }

  void _oneClickAuth({
    VoidCallback? closeModal,
    Function(String message)? showToast,
  }) async {
    final methods1 = requiredNamespaces['eip155']?.methods ?? [];
    final methods2 = optionalNamespaces['eip155']?.methods ?? [];
    const flavor = String.fromEnvironment('FLUTTER_APP_FLAVOR');
    final authResponse = await widget.web3App.authenticate(
      params: SessionAuthRequestParams(
        chains: _selectedChains.map((e) => e.chainId).toList(),
        domain: 'wcflutterdapp-$flavor://',
        nonce: AuthUtils.generateNonce(),
        uri: Constants.aud,
        statement: 'Welcome to example flutter app',
        methods: <String>{...methods1, ...methods2}.toList(),
      ),
    );

    final encodedUri = Uri.encodeComponent(authResponse.uri.toString());
    final uri = 'wcflutterwallet-$flavor://wc?uri=$encodedUri';

    if (await canLaunchUrlString(uri)) {
      final openApp = await showDialog(
        // ignore: use_build_context_synchronously
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            content: const Text('Do you want to open with Web3Wallet Flutter'),
            actions: [
              TextButton(
                onPressed: () => Navigator.of(context).pop(false),
                child: const Text('Show QR'),
              ),
              TextButton(
                onPressed: () => Navigator.of(context).pop(true),
                child: const Text('Open'),
              ),
            ],
          );
        },
      );
      if (openApp) {
        launchUrlString(uri, mode: LaunchMode.externalApplication);
      } else {
        _showQrCode(authResponse.uri.toString());
      }
    } else {
      _showQrCode(authResponse.uri.toString());
    }

    try {
      debugPrint('[SampleDapp] Awaiting 1-CA session');
      final response = await authResponse.completer.future;

      if (response.session != null) {
        showToast?.call(
          '${StringConstants.authSucceeded} and ${StringConstants.connectionEstablished}',
        );
      } else {
        final error = response.error ?? response.jsonRpcError;
        showToast?.call(error.toString());
      }
    } catch (e) {
      debugPrint('[SampleDapp] 1-CA $e');
      showToast?.call(StringConstants.connectionFailed);
    }
    closeModal?.call();
  }

  void _onSessionConnect(SessionConnect? event) async {
    if (event == null) return;

    setState(() {
      _selectedChains.clear();
    });

    if (_shouldDismissQrCode && Navigator.canPop(context)) {
      _shouldDismissQrCode = false;
      Navigator.pop(context);
    }

    _requestAuth(
      event,
      showToast: (message) {
        showPlatformToast(child: Text(message), context: context);
      },
    );
  }

  ButtonStyle get _buttonStyle => ButtonStyle(
        backgroundColor: MaterialStateProperty.resolveWith<Color>(
          (states) {
            if (states.contains(MaterialState.disabled)) {
              return StyleConstants.grayColor;
            }
            return StyleConstants.primaryColor;
          },
        ),
        minimumSize: MaterialStateProperty.all<Size>(const Size(
          1000.0,
          StyleConstants.linear48,
        )),
        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(
              StyleConstants.linear8,
            ),
          ),
        ),
      );
}

class QRCodeScreen extends StatefulWidget {
  const QRCodeScreen({super.key, required this.uri});
  final String uri;

  @override
  State<QRCodeScreen> createState() => _QRCodeScreenState();
}

class _QRCodeScreenState extends State<QRCodeScreen> {
  @override
  Widget build(BuildContext context) {
    return Material(
      child: Scaffold(
        appBar: AppBar(title: const Text(StringConstants.scanQrCode)),
        body: _QRCodeView(
          uri: widget.uri,
        ),
      ),
    );
  }
}

class _QRCodeView extends StatelessWidget {
  const _QRCodeView({required this.uri});
  final String uri;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        QrImageView(data: uri),
        const SizedBox(
          height: StyleConstants.linear16,
        ),
        ElevatedButton(
          onPressed: () {
            Clipboard.setData(
              ClipboardData(text: uri.toString()),
            ).then(
              (_) => showPlatformToast(
                child: const Text(StringConstants.copiedToClipboard),
                context: context,
              ),
            );
          },
          child: const Text('Copy URL to Clipboard'),
        ),
      ],
    );
  }
}

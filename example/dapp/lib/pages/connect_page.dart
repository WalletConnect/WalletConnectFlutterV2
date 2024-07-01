import 'dart:async';
import 'dart:convert';

import 'package:fl_toast/fl_toast.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:url_launcher/url_launcher_string.dart';
import 'package:walletconnect_flutter_v2/walletconnect_flutter_v2.dart';
import 'package:walletconnect_flutter_v2_dapp/models/chain_metadata.dart';
import 'package:walletconnect_flutter_v2_dapp/utils/constants.dart';
import 'package:walletconnect_flutter_v2_dapp/utils/crypto/chain_data.dart';
import 'package:walletconnect_flutter_v2_dapp/utils/crypto/eip155.dart';
import 'package:walletconnect_flutter_v2_dapp/utils/crypto/polkadot.dart';
import 'package:walletconnect_flutter_v2_dapp/utils/crypto/solana.dart';
import 'package:walletconnect_flutter_v2_dapp/utils/string_constants.dart';
import 'package:walletconnect_flutter_v2_dapp/widgets/chain_button.dart';

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

  @override
  void initState() {
    super.initState();
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

      debugPrint('[SampleDapp] ${jsonEncode(optionalNamespaces)}');
    });
  }

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
  }

  @override
  Widget build(BuildContext context) {
    // Build the list of chain buttons, clear if the textnet changed
    final testChains = ChainData.allChains.where((e) => e.isTestnet).toList();
    final mainChains = ChainData.allChains.where((e) => !e.isTestnet).toList();
    final List<ChainMetadata> chains = _testnetOnly ? testChains : mainChains;

    List<Widget> children = [];

    for (final ChainMetadata chain in chains) {
      // Build the button
      children.add(
        ChainButton(
          chain: chain,
          onPressed: () => _selectChain(chain),
          selected: _selectedChains.contains(chain),
        ),
      );
    }

    children.add(const SizedBox.square(dimension: 12.0));

    // Add a connect button
    children.add(
      ElevatedButton(
        onPressed: _selectedChains.isEmpty
            ? null
            : () => _onConnect(showToast: (m) async {
                  await showPlatformToast(child: Text(m), context: context);
                }, closeModal: () {
                  if (Navigator.canPop(context)) {
                    Navigator.of(context).pop();
                  }
                }),
        style: ButtonStyle(
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
        ),
        child: const Text(
          StringConstants.connect,
          style: StyleConstants.buttonText,
        ),
      ),
    );

    children.add(const SizedBox(height: 16.0));

    children.add(
      ElevatedButton(
        onPressed: _selectedChains.isEmpty
            ? null
            : () => _oneClickAuth(
                  closeModal: () {
                    if (Navigator.canPop(context)) {
                      Navigator.of(context).pop();
                    }
                  },
                  showToast: (message) {
                    showPlatformToast(child: Text(message), context: context);
                  },
                ),
        style: ButtonStyle(
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
        ),
        child: const Text(
          'One-Click Auth',
          style: StyleConstants.buttonText,
        ),
      ),
    );

    children.add(const SizedBox.square(dimension: 12.0));

    return Center(
      child: Container(
        padding: const EdgeInsets.all(
          StyleConstants.linear8,
        ),
        constraints: const BoxConstraints(
          maxWidth: StyleConstants.maxWidth,
        ),
        child: ListView(
          children: <Widget>[
            const Text(
              StringConstants.appTitle,
              style: StyleConstants.subtitleText,
              textAlign: TextAlign.center,
            ),
            const SizedBox(
              height: StyleConstants.linear16,
            ),
            const Text(
              StringConstants.selectChains,
              style: StyleConstants.paragraph,
              textAlign: TextAlign.center,
            ),
            const SizedBox(
              height: StyleConstants.linear16,
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
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: children,
            ),
          ],
        ),
      ),
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
      optionalNamespaces: optionalNamespaces,
    );

    final encodedUri = Uri.encodeComponent(connectResponse.uri.toString());
    final uri = 'wcflutterwallet://wc?uri=$encodedUri';
    // final uri = 'metamask://wc?uri=$encodedUri';
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
          chainId: _selectedChains[0].chainId,
          domain: Constants.domain,
          aud: Constants.aud,
          statement: 'Welcome to example flutter app',
        ),
      );

      final scheme = event?.session.peer.metadata.redirect?.native;
      launchUrlString(
        scheme ?? 'wcflutterwallet://',
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
    final methods = optionalNamespaces['eip155']?.methods ?? [];
    final authResponse = await widget.web3App.authenticate(
      params: SessionAuthRequestParams(
        chains: _selectedChains.map((e) => e.chainId).toList(),
        domain: 'wcflutterdapp://',
        nonce: AuthUtils.generateNonce(),
        uri: Constants.aud,
        statement: 'Welcome to example flutter app',
        methods: methods,
      ),
    );

    final encodedUri = Uri.encodeComponent(authResponse.uri.toString());
    final uri = 'wcflutterwallet://wc?uri=$encodedUri';

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

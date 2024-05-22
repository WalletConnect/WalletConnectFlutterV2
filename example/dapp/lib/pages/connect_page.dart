// ignore_for_file: use_build_context_synchronously

import 'dart:async';

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

      debugPrint('$optionalNamespaces');
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
    debugPrint('Creating connection and session');
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
        _showQrCode(connectResponse);
      }
    } else {
      _showQrCode(connectResponse);
    }

    debugPrint('Awaiting session proposal settlement');
    final _ = await connectResponse.session.future;

    showToast?.call(StringConstants.connectionEstablished);
  }

  Future<void> _showQrCode(ConnectResponse response) async {
    // Show the QR code
    debugPrint('Showing QR Code: ${response.uri}');
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
                    uri: response.uri.toString(),
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
        builder: (context) => QRCodeScreen(response: response),
      ),
    );
  }

  void _onSessionConnect(SessionConnect? event) async {
    if (event == null) return;

    if (_shouldDismissQrCode && Navigator.canPop(context)) {
      _shouldDismissQrCode = false;
      Navigator.pop(context);
    }

    _requestAuth(event);
  }

  void _requestAuth(SessionConnect? event) async {
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
    if (!shouldAuth) return;

    try {
      final scheme =
          event?.session.peer.metadata.redirect?.native ?? 'wcflutterwallet://';
      launchUrlString(scheme, mode: LaunchMode.externalApplication);

      final pairingTopic = event?.session.pairingTopic;
      // Send off an auth request now that the pairing/session is established
      debugPrint('Requesting authentication');
      final authRes = await widget.web3App.requestAuth(
        pairingTopic: pairingTopic,
        params: AuthRequestParams(
          chainId: _selectedChains[0].chainId,
          domain: Constants.domain,
          aud: Constants.aud,
          // statement: 'Welcome to example flutter app',
        ),
      );

      debugPrint('Awaiting authentication response');
      final authResponse = await authRes.completer.future;

      if (authResponse.error != null) {
        debugPrint('Authentication failed: ${authResponse.error}');
        showPlatformToast(
          child: const Text(StringConstants.authFailed),
          context: context,
        );
      } else {
        showPlatformToast(
          child: const Text(StringConstants.authSucceeded),
          context: context,
        );
      }
    } catch (e) {
      showPlatformToast(
        child: const Text(StringConstants.connectionFailed),
        context: context,
      );
    }
  }
}

class QRCodeScreen extends StatefulWidget {
  const QRCodeScreen({super.key, required this.response});
  final ConnectResponse response;

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
          uri: widget.response.uri!.toString(),
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

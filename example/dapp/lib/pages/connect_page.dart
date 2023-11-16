import 'dart:async';

import 'package:fl_toast/fl_toast.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:qr_flutter_wc/qr_flutter_wc.dart';
import 'package:walletconnect_flutter_v2/walletconnect_flutter_v2.dart';
import 'package:walletconnect_flutter_v2_dapp/models/chain_metadata.dart';
import 'package:walletconnect_flutter_v2_dapp/utils/constants.dart';
import 'package:walletconnect_flutter_v2_dapp/utils/crypto/chain_data.dart';
import 'package:walletconnect_flutter_v2_dapp/utils/crypto/helpers.dart';
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

  void setTestnet(bool value) {
    if (value != _testnetOnly) {
      _selectedChains.clear();
    }
    _testnetOnly = value;
  }

  @override
  Widget build(BuildContext context) {
    // Build the list of chain buttons, clear if the textnet changed
    final List<ChainMetadata> chains =
        _testnetOnly ? ChainData.testChains : ChainData.mainChains;

    List<Widget> chainButtons = [];

    for (final ChainMetadata chain in chains) {
      // Build the button
      chainButtons.add(
        ChainButton(
          chain: chain,
          onPressed: () {
            setState(() {
              if (_selectedChains.contains(chain)) {
                _selectedChains.remove(chain);
              } else {
                _selectedChains.add(chain);
              }
            });
          },
          selected: _selectedChains.contains(chain),
        ),
      );
    }

    // Add a connect button
    chainButtons.add(
      Container(
        width: double.infinity,
        height: StyleConstants.linear48,
        margin: const EdgeInsets.symmetric(
          vertical: StyleConstants.linear8,
        ),
        child: ElevatedButton(
          onPressed: () => _onConnect(_selectedChains, showToast: (m) async {
            await showPlatformToast(child: Text(m), context: context);
          }, closeModal: () {
            Navigator.of(context).pop();
          }),
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all<Color>(
              StyleConstants.primaryColor,
            ),
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
      ),
    );

    return Center(
      child: Container(
        // color: StyleConstants.primaryColor,
        padding: const EdgeInsets.all(
          StyleConstants.linear8,
        ),
        constraints: const BoxConstraints(
          maxWidth: StyleConstants.maxWidth,
        ),
        child: ListView(
          children: <Widget>[
            const SizedBox(
              height: StyleConstants.linear48,
            ),
            const Text(
              StringConstants.appTitle,
              style: StyleConstants.titleText,
              textAlign: TextAlign.center,
            ),
            const SizedBox(
              height: StyleConstants.linear48,
            ),
            const Text(
              StringConstants.selectChains,
              style: StyleConstants.subtitleText,
              textAlign: TextAlign.center,
            ),
            const SizedBox(
              height: StyleConstants.linear24,
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
              children: chainButtons,
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _onConnect(
    List<ChainMetadata> chains, {
    Function(String message)? showToast,
    VoidCallback? closeModal,
  }) async {
    // Use the chain metadata to build the required namespaces:
    // Get the methods, get the events
    final Map<String, RequiredNamespace> requiredNamespaces = {};
    for (final chain in chains) {
      // If the chain is already in the required namespaces, add it to the chains list
      final chainName = chain.chainId.split(':')[0];
      if (requiredNamespaces.containsKey(chainName)) {
        requiredNamespaces[chainName]!.chains!.add(chain.chainId);
        continue;
      }
      final rNamespace = RequiredNamespace(
        chains: [chain.chainId],
        methods: getChainMethods(chain.type),
        events: getChainEvents(chain.type),
      );
      requiredNamespaces[chainName] = rNamespace;
    }
    debugPrint('Required namespaces: $requiredNamespaces');

    // Send off a connect
    debugPrint('Creating connection and session');
    final res = await widget.web3App.connect(
      optionalNamespaces: requiredNamespaces,
    );
    // debugPrint('Connection created, connection response: ${res.uri}');

    // print(res.uri!.toString());
    _showQrCode(res);

    try {
      debugPrint('Awaiting session proposal settlement');
      final _ = await res.session.future;
      // print(sessionData);

      showToast?.call(StringConstants.connectionEstablished);

      // Send off an auth request now that the pairing/session is established
      debugPrint('Requesting authentication');
      final AuthRequestResponse authRes = await widget.web3App.requestAuth(
        pairingTopic: res.pairingTopic,
        params: AuthRequestParams(
          chainId: chains[0].chainId,
          domain: Constants.domain,
          aud: Constants.aud,
          // statement: 'Welcome to example flutter app',
        ),
      );

      debugPrint('Awaiting authentication response');
      final authResponse = await authRes.completer.future;

      if (authResponse.error != null) {
        debugPrint('Authentication failed: ${authResponse.error}');
        showToast?.call(StringConstants.authFailed);
      } else {
        showToast?.call(StringConstants.authSucceeded);
        closeModal?.call();
      }
    } on JsonRpcError catch (e) {
      final rejectedError = Errors.getSdkError(Errors.USER_REJECTED_CHAINS);
      if (e.code == rejectedError.code) {
        showToast?.call(StringConstants.connectionRejected);
      } else {
        showToast?.call(StringConstants.connectionFailed);
        closeModal?.call();
      }
    } catch (e) {
      debugPrint(e.toString());
      showToast?.call(StringConstants.connectionFailed);
      closeModal?.call();
    }
  }

  Future<void> _showQrCode(ConnectResponse response) async {
    // Show the QR code
    debugPrint('Showing QR Code: ${response.uri}');
    if (kIsWeb) {
      return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            content: SizedBox(
              width: 400.0,
              child: AspectRatio(
                aspectRatio: 0.8,
                child: QRCodeScreen(response: response),
              ),
            ),
          );
        },
      );
    }
    Navigator.push(
      context,
      MaterialPageRoute(
        fullscreenDialog: true,
        builder: (context) => QRCodeScreen(response: response),
      ),
    );
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
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            QrImageView(
              data: widget.response.uri!.toString(),
            ),
            const SizedBox(
              height: StyleConstants.linear16,
            ),
            ElevatedButton(
              onPressed: () {
                Clipboard.setData(
                  ClipboardData(text: widget.response.uri!.toString()),
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
        ),
      ),
    );
  }
}

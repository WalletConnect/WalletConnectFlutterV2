import 'dart:async';

import 'package:fl_toast/fl_toast.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:qr_flutter/qr_flutter.dart';
// ignore: unused_import
import 'package:url_launcher/url_launcher_string.dart';
import 'package:walletconnect_flutter_v2/walletconnect_flutter_v2.dart';
import 'package:walletconnect_flutter_v2_dapp/models/chain_metadata.dart';
import 'package:walletconnect_flutter_v2_dapp/utils/constants.dart';
import 'package:walletconnect_flutter_v2_dapp/utils/crypto/chain_data.dart';
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
  Widget build(BuildContext context) {
    // Build the list of chain buttons, clear if the textnet changed
    final List<ChainMetadata> chains =
        _testnetOnly ? ChainData.testChains : ChainData.mainChains;

    List<Widget> children = [];

    for (final ChainMetadata chain in chains) {
      // Build the button
      children.add(
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

    children.add(const SizedBox.square(dimension: 12.0));

    // Add a connect button
    children.add(
      ElevatedButton(
        onPressed: _selectedChains.isEmpty
            ? null
            : () => _onConnect(showToast: (m) async {
                  await showPlatformToast(child: Text(m), context: context);
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

  Future<void> _onConnect({Function(String message)? showToast}) async {
    debugPrint('Creating connection and session');
    // It is currently safer to send chains approvals on optionalNamespaces
    // but depending on Wallet implementation you may need to send some (for innstance eip155:1) as required
    final ConnectResponse res = await widget.web3App.connect(
      optionalNamespaces: {
        'eip155': RequiredNamespace(
          chains: _selectedChains.map((c) => c.chainId).toList(),
          methods: MethodsConstants.allMethods,
          events: EventsConstants.allEvents,
        ),
      },
    );

    final encodedUri = Uri.encodeComponent(res.uri.toString());
    final uri = 'wcflutterwallet://wc?uri=$encodedUri';
    // final uri = 'metamask://wc?uri=$encodedUri';
    if (await canLaunchUrlString(uri)) {
      // ignore: use_build_context_synchronously
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
        _showQrCode(res);
      }
    } else {
      _showQrCode(res);
    }

    try {
      debugPrint('Awaiting session proposal settlement');
      final _ = await res.session.future;

      showToast?.call(StringConstants.connectionEstablished);

      // Send off an auth request now that the pairing/session is established
      debugPrint('Requesting authentication');
      final AuthRequestResponse authRes = await widget.web3App.requestAuth(
        pairingTopic: res.pairingTopic,
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
        showToast?.call(StringConstants.authFailed);
      } else {
        showToast?.call(StringConstants.authSucceeded);
      }

      // ignore: use_build_context_synchronously
      if (_shouldDismissQrCode && Navigator.canPop(context)) {
        // ignore: use_build_context_synchronously
        Navigator.pop(context);
      }
    } catch (e) {
      // ignore: use_build_context_synchronously
      if (_shouldDismissQrCode && Navigator.canPop(context)) {
        // ignore: use_build_context_synchronously
        Navigator.pop(context);
      }
      showToast?.call(StringConstants.connectionFailed);
    }
  }

  Future<void> _showQrCode(ConnectResponse response) async {
    // Show the QR code
    debugPrint('Showing QR Code: ${response.uri}');

    _shouldDismissQrCode = true;
    await showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text(
            StringConstants.scanQrCode,
            style: StyleConstants.titleText,
            textAlign: TextAlign.center,
          ),
          content: SizedBox(
            width: 300,
            height: 350,
            child: Center(
              child: Column(
                children: [
                  QrImageView(
                    data: response.uri!.toString(),
                  ),
                  const SizedBox(
                    height: StyleConstants.linear16,
                  ),
                  ElevatedButton(
                    onPressed: () {
                      Clipboard.setData(
                        ClipboardData(
                          text: response.uri!.toString(),
                        ),
                      ).then(
                        (_) => showPlatformToast(
                          child: const Text(
                            StringConstants.copiedToClipboard,
                          ),
                          context: context,
                        ),
                      );
                    },
                    child: const Text(
                      'Copy URL to Clipboard',
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
    _shouldDismissQrCode = false;
  }
}

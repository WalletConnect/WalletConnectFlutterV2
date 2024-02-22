import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher_string.dart';
import 'package:walletconnect_flutter_v2/walletconnect_flutter_v2.dart';
import 'package:walletconnect_flutter_v2_dapp/models/chain_metadata.dart';
import 'package:walletconnect_flutter_v2_dapp/utils/constants.dart';
import 'package:walletconnect_flutter_v2_dapp/utils/crypto/chain_data.dart';
import 'package:walletconnect_flutter_v2_dapp/utils/crypto/eip155.dart';
import 'package:walletconnect_flutter_v2_dapp/utils/crypto/helpers.dart';
import 'package:walletconnect_flutter_v2_dapp/utils/string_constants.dart';
import 'package:walletconnect_flutter_v2_dapp/widgets/method_dialog.dart';

class SessionWidget extends StatefulWidget {
  const SessionWidget({
    super.key,
    required this.session,
    required this.web3App,
  });

  final SessionData session;
  final Web3App web3App;

  @override
  SessionWidgetState createState() => SessionWidgetState();
}

class SessionWidgetState extends State<SessionWidget> {
  @override
  Widget build(BuildContext context) {
    final List<Widget> children = [
      Text(
        '${StringConstants.sessionTopic}${widget.session.topic}',
      ),
    ];

    // Get all of the accounts
    final List<String> namespaceAccounts = [];

    // Loop through the namespaces, and get the accounts
    for (final Namespace namespace in widget.session.namespaces.values) {
      namespaceAccounts.addAll(namespace.accounts);
    }

    // Loop through the namespace accounts and build the widgets
    for (final String namespaceAccount in namespaceAccounts) {
      children.add(
        _buildAccountWidget(
          namespaceAccount,
        ),
      );
    }

    // Add a delete button
    children.add(
      Container(
        width: double.infinity,
        height: StyleConstants.linear48,
        margin: const EdgeInsets.symmetric(
          vertical: StyleConstants.linear8,
        ),
        child: ElevatedButton(
          onPressed: () async {
            await widget.web3App.disconnectSession(
              topic: widget.session.topic,
              reason: Errors.getSdkError(
                Errors.USER_DISCONNECTED,
              ),
            );
          },
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all<Color>(
              Colors.red,
            ),
          ),
          child: const Text(
            StringConstants.delete,
            style: StyleConstants.buttonText,
          ),
        ),
      ),
    );

    children.add(const SizedBox(height: 20.0));
    return ListView(
      children: children,
    );
  }

  Widget _buildAccountWidget(String namespaceAccount) {
    final chainId = NamespaceUtils.getChainFromAccount(namespaceAccount);
    final account = NamespaceUtils.getAccount(namespaceAccount);
    final chainMetadata = getChainMetadataFromChain(chainId);

    final List<Widget> children = [
      Text(
        chainMetadata.name,
        style: StyleConstants.subtitleText,
      ),
      const SizedBox(
        height: StyleConstants.linear8,
      ),
      Text(
        account,
        textAlign: TextAlign.center,
      ),
      const SizedBox(
        height: StyleConstants.linear8,
      ),
      const Text(
        StringConstants.methods,
        style: StyleConstants.subtitleText,
      ),
    ];

    children.addAll(_buildChainMethodButtons(chainMetadata, account));

    children.add(const Divider());
    if (chainId != ChainData.testChains.first.chainId) {
      children.add(const Text('Connect to Sepolia to Test'));
    }
    children.addAll(_buildSepoliaButtons(account, chainId));

    children.addAll([
      const SizedBox(
        height: StyleConstants.linear8,
      ),
      const Text(
        StringConstants.events,
        style: StyleConstants.subtitleText,
      ),
    ]);
    children.addAll(
      _buildChainEventsTiles(
        chainMetadata,
      ),
    );

    // final ChainMetadata
    return Container(
      width: double.infinity,
      // height: StyleConstants.linear48,
      padding: const EdgeInsets.all(
        StyleConstants.linear8,
      ),
      margin: const EdgeInsets.symmetric(
        vertical: StyleConstants.linear8,
      ),
      decoration: BoxDecoration(
        border: Border.all(
          color: chainMetadata.color,
        ),
        borderRadius: const BorderRadius.all(
          Radius.circular(
            StyleConstants.linear8,
          ),
        ),
      ),
      child: Column(
        children: children,
      ),
    );
  }

  List<Widget> _buildChainMethodButtons(
    ChainMetadata chainMetadata,
    String address,
  ) {
    final List<Widget> buttons = [];
    // Add Methods
    for (final String method in getChainMethods(chainMetadata.type)) {
      final namespaces = widget.session.namespaces[chainMetadata.type.name];
      final supported = namespaces?.methods.contains(method) ?? false;
      buttons.add(
        Container(
          width: double.infinity,
          height: StyleConstants.linear48,
          margin: const EdgeInsets.symmetric(
            vertical: StyleConstants.linear8,
          ),
          child: ElevatedButton(
            onPressed: supported
                ? () async {
                    final future = EIP155.callMethod(
                      web3App: widget.web3App,
                      topic: widget.session.topic,
                      method: method.toEip155Method()!,
                      chainData: chainMetadata,
                      address: address.toLowerCase(),
                    );
                    MethodDialog.show(context, method, future);
                    _launchWallet();
                  }
                : null,
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.resolveWith<Color>(
                (states) => states.contains(MaterialState.disabled)
                    ? Colors.grey
                    : chainMetadata.color,
              ),
              shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(
                    StyleConstants.linear8,
                  ),
                ),
              ),
            ),
            child: Text(
              method,
              style: StyleConstants.buttonText,
              textAlign: TextAlign.center,
            ),
          ),
        ),
      );
    }

    return buttons;
  }

  void _launchWallet() {
    final walletUrl = widget.session.peer.metadata.redirect?.native;
    if ((walletUrl ?? '').isNotEmpty) {
      launchUrlString(
        walletUrl!,
        mode: LaunchMode.externalApplication,
      );
    }
  }

  List<Widget> _buildSepoliaButtons(String address, String chainId) {
    final List<Widget> buttons = [];
    final enabled = chainId == ChainData.testChains.first.chainId;
    buttons.add(
      Container(
        width: double.infinity,
        height: StyleConstants.linear48,
        margin: const EdgeInsets.symmetric(
          vertical: StyleConstants.linear8,
        ),
        child: ElevatedButton(
          onPressed: enabled
              ? () async {
                  final future = EIP155.callSmartContract(
                    web3App: widget.web3App,
                    topic: widget.session.topic,
                    address: address,
                    action: 'read',
                  );
                  MethodDialog.show(context, 'Test Contract (Read)', future);
                }
              : null,
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.resolveWith<Color>((states) {
              if (states.contains(MaterialState.disabled)) {
                return StyleConstants.grayColor;
              }
              return Colors.orange;
            }),
            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
              RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(
                  StyleConstants.linear8,
                ),
              ),
            ),
          ),
          child: const Text(
            'Test Contract (Read)',
            style: StyleConstants.buttonText,
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
    buttons.add(
      Container(
        width: double.infinity,
        height: StyleConstants.linear48,
        margin: const EdgeInsets.symmetric(
          vertical: StyleConstants.linear8,
        ),
        child: ElevatedButton(
          onPressed: enabled
              ? () async {
                  final future = EIP155.callSmartContract(
                    web3App: widget.web3App,
                    topic: widget.session.topic,
                    address: address,
                    action: 'write',
                  );
                  MethodDialog.show(context, 'Test Contract (Write)', future);
                  _launchWallet();
                }
              : null,
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.resolveWith<Color>((states) {
              if (states.contains(MaterialState.disabled)) {
                return StyleConstants.grayColor;
              }
              return Colors.orange;
            }),
            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
              RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(
                  StyleConstants.linear8,
                ),
              ),
            ),
          ),
          child: const Text(
            'Test Contract (Write)',
            style: StyleConstants.buttonText,
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );

    return buttons;
  }

  List<Widget> _buildChainEventsTiles(ChainMetadata chainMetadata) {
    final List<Widget> values = [];

    for (final String event in getChainEvents(chainMetadata.type)) {
      values.add(
        Container(
          width: double.infinity,
          height: StyleConstants.linear48,
          margin: const EdgeInsets.symmetric(
            vertical: StyleConstants.linear8,
          ),
          decoration: BoxDecoration(
            border: Border.all(
              color: chainMetadata.color,
            ),
            borderRadius: const BorderRadius.all(
              Radius.circular(
                StyleConstants.linear8,
              ),
            ),
          ),
          child: Center(
            child: Text(
              event,
              style: StyleConstants.buttonText,
              textAlign: TextAlign.center,
            ),
          ),
        ),
      );
    }

    return values;
  }
}

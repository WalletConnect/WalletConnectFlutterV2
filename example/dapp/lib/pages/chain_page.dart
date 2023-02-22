import 'package:flutter/material.dart';
import 'package:walletconnect_flutter_v2_dapp/models/chain_metadata.dart';
import 'package:walletconnect_flutter_v2_dapp/utils/constants.dart';
import 'package:walletconnect_flutter_v2_dapp/utils/crypto/chain_data.dart';
import 'package:walletconnect_flutter_v2_dapp/utils/string_constants.dart';
import 'package:walletconnect_flutter_v2_dapp/widgets/chain_button.dart';

class ChainPage extends StatefulWidget {
  const ChainPage({
    super.key,
    required this.testnetOnly,
    required this.onConnect,
  });

  final bool testnetOnly;
  final void Function(List<ChainMetadata>) onConnect;

  @override
  ChainPageState createState() => ChainPageState();
}

class ChainPageState extends State<ChainPage> {
  bool _testnetPrev = true;
  final List<ChainMetadata> _selectedChains = [];

  @override
  Widget build(BuildContext context) {
    // Build the list of chain buttons, clear if the textnet changed
    if (_testnetPrev != widget.testnetOnly) {
      _selectedChains.clear();
      _testnetPrev = widget.testnetOnly;
    }
    final List<ChainMetadata> chains =
        widget.testnetOnly ? ChainData.testChains : ChainData.mainChains;

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
          onPressed: () => widget.onConnect(_selectedChains),
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

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: chainButtons,
    );
  }
}

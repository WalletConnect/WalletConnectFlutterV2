import 'package:flutter/material.dart';
import 'package:walletconnect_flutter_v2/walletconnect_flutter_v2.dart';
import 'package:walletconnect_flutter_v2_dapp/utils/constants.dart';
import 'package:walletconnect_flutter_v2_dapp/utils/string_constants.dart';
import 'package:walletconnect_flutter_v2_dapp/widgets/pairing_item.dart';

class PairingsPage extends StatefulWidget {
  const PairingsPage({
    super.key,
    required this.web3App,
  });

  final Web3App web3App;

  @override
  PairingsPageState createState() => PairingsPageState();
}

class PairingsPageState extends State<PairingsPage> {
  List<PairingInfo> _pairings = [];

  @override
  void initState() {
    _pairings = widget.web3App.pairings.getAll();
    // widget.web3App.onSessionDelete.subscribe(_onSessionDelete);
    widget.web3App.core.pairing.onPairingDelete.subscribe(_onPairingDelete);
    widget.web3App.core.pairing.onPairingExpire.subscribe(_onPairingDelete);
    super.initState();
  }

  @override
  void dispose() {
    // widget.web3App.onSessionDelete.unsubscribe(_onSessionDelete);
    widget.web3App.core.pairing.onPairingDelete.unsubscribe(_onPairingDelete);
    widget.web3App.core.pairing.onPairingExpire.unsubscribe(_onPairingDelete);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final List<PairingItem> pairingItems = _pairings
        .map(
          (PairingInfo pairing) => PairingItem(
            key: ValueKey(pairing.topic),
            pairing: pairing,
            onTap: () async {
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    title: const Text(
                      StringConstants.deletePairing,
                      style: StyleConstants.titleText,
                    ),
                    content: Text(
                      pairing.topic,
                    ),
                    actions: [
                      TextButton(
                        child: const Text(
                          StringConstants.cancel,
                        ),
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                      ),
                      TextButton(
                        child: const Text(
                          StringConstants.delete,
                        ),
                        onPressed: () async {
                          try {
                            widget.web3App.core.pairing.disconnect(
                              topic: pairing.topic,
                            );
                            Navigator.of(context).pop();
                          } catch (e) {
                            debugPrint(e.toString());
                          }
                        },
                      ),
                    ],
                  );
                },
              );
            },
          ),
        )
        .toList();

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
          children: pairingItems,
        ),
      ),
    );
  }

  void _onPairingDelete(PairingEvent? event) {
    setState(() {
      _pairings = widget.web3App.pairings.getAll();
    });
  }
}

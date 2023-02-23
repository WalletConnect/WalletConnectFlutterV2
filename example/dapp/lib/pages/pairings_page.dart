import 'dart:convert';

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
  @override
  Widget build(BuildContext context) {
    final List<PairingInfo> pairings = widget.web3App.pairings.getAll();
    final String pairingKey = widget.web3App.pairings.storageKey;
    if (widget.web3App.core.storage.has(pairingKey)) {
      Map<String, dynamic> data = widget.web3App.core.storage.get(pairingKey);
      Map<String, PairingInfo> pairingInfos = {};
      for (var entry in data.entries) {
        pairingInfos[entry.key] = PairingInfo.fromJson(
          entry.value,
        );
      }
      print(pairingInfos);
    }

    final List<PairingItem> pairingItems = pairings
        .map(
          (PairingInfo pairing) => PairingItem(
            key: ValueKey(pairing.topic),
            pairing: pairing,
            onTap: () {
              // widget.web3App.pairings.select(pairing.id);
              // Navigator.of(context).pop();
            },
          ),
        )
        .toList();

    final List<Widget> children = [
      const SizedBox(
        height: StyleConstants.linear48,
      ),
      const Text(
        StringConstants.pairings,
        style: StyleConstants.titleText,
        textAlign: TextAlign.center,
      ),
      const SizedBox(
        height: StyleConstants.linear48,
      ),
    ];
    children.addAll(pairingItems);

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
          children: children,
        ),
      ),
    );
  }
}

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:kadena_dart_sdk/kadena_dart_sdk.dart';
import 'package:walletconnect_flutter_v2_wallet/utils/constants.dart';
import 'package:walletconnect_flutter_v2_wallet/widgets/wc_connection_widget/wc_connection_model.dart';
import 'package:walletconnect_flutter_v2_wallet/widgets/wc_connection_widget/wc_connection_widget.dart';
import 'package:walletconnect_flutter_v2_wallet/widgets/wc_request_widget.dart/wc_request_widget.dart';

/// A widget that takes a list of PactCommandPayloads, and allows the user
/// to sign each one individually. If there is only one item in the list,
/// it doesn't show the number of transactions to be signed. Otherwise, it
/// shows the number of transactions to be signed at the top.
///
/// This widget is used by the KadenaService to sign any kind of request.
///
/// This widget is generally displayed using the [BottomSheetService].
/// It returns a list of booleans. Each boolean represents whether the
/// user approved the transaction at the same index in the list of
/// PactCommandPayloads.
///
/// For each PactCommandPayload to be signed, the widget itself
/// displays the code of the PactCommandPayload and the data.
/// It also shows each [Capability] that is included in the payload.
class KadenaRequestWidget extends StatefulWidget {
  const KadenaRequestWidget({
    super.key,
    required this.payloads,
  });

  final List<PactCommandPayload> payloads;

  @override
  KadenaRequestWidgetState createState() => KadenaRequestWidgetState();
}

class KadenaRequestWidgetState extends State<KadenaRequestWidget> {
  int _currentIndex = 0;
  final List<bool> _responses = [];

  @override
  Widget build(BuildContext context) {
    final List<WCConnectionModel> capsList = [];

    if (widget.payloads[_currentIndex].signers.isNotEmpty &&
        widget.payloads[_currentIndex].signers.first.clist != null) {
      capsList.addAll(
        widget.payloads[_currentIndex].signers.first.clist!
            .map(
              (e) => WCConnectionModel(
                title: e.name,
                elements: e.args
                    .map(
                      (e) => e.toString(),
                    )
                    .toList(),
              ),
            )
            .toList(),
      );
    }

    final List<Widget> signCounter = [];
    if (widget.payloads.length > 1) {
      signCounter.add(
        Text(
          '${_currentIndex + 1} of ${widget.payloads.length}',
          style: StyleConstants.subtitleText,
        ),
      );
      signCounter.add(
        const SizedBox(
          height: StyleConstants.magic20,
        ),
      );
    }

    return WCRequestWidget(
      onAccept: () {
        _responses.add(true);
        _incrementIndex();
      },
      onReject: () {
        _responses.add(false);
        _incrementIndex();
      },
      child: Column(
        children: [
          ...signCounter,
          WCConnectionWidget(
            title: 'Sign Transaction',
            info: [
              WCConnectionModel(
                title: 'Pact Command',
                text: jsonEncode(widget.payloads[_currentIndex]),
              ),
              ...capsList,
            ],
          ),
        ],
      ),
    );
  }

  void _incrementIndex() {
    if (_currentIndex < widget.payloads.length - 1) {
      setState(() {
        _currentIndex++;
      });
    } else {
      Navigator.of(context).pop(_responses);
    }
  }
}

import 'package:flutter/material.dart';
import 'package:kadena_dart_sdk/kadena_dart_sdk.dart';
import 'package:walletconnect_flutter_v2_wallet/utils/constants.dart';
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
class KadenaSignWidget extends StatefulWidget {
  const KadenaSignWidget({
    super.key,
    required this.payloads,
  });

  final List<PactCommandPayload> payloads;

  @override
  KadenaSignWidgetState createState() => KadenaSignWidgetState();
}

class KadenaSignWidgetState extends State<KadenaSignWidget> {
  int _currentIndex = 0;
  final List<bool> _responses = [];

  @override
  Widget build(BuildContext context) {
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
          if (widget.payloads.length > 1)
            Text(
              '$_currentIndex/${widget.payloads.length} Transactions',
              style: StyleConstants.bodyText,
            ),
          const SizedBox(
            height: StyleConstants.linear16,
          ),
          _buildPactCommandPayload(widget.payloads[_currentIndex]),
        ],
      ),
    );
  }

  Widget _buildPactCommandPayload(PactCommandPayload payload) {
    return Column(
      children: [
        Text(
          payload.payload.exec?.code ?? '',
          style: StyleConstants.bodyText,
        ),
        const SizedBox(
          height: StyleConstants.linear16,
        ),
        Text(
          (payload.payload.exec?.data ?? {}).toString(),
          style: StyleConstants.bodyText,
        ),
        const SizedBox(
          height: StyleConstants.linear16,
        ),
        const Text(
          'Capabilities',
          style: StyleConstants.subtitleText,
        ),
        const SizedBox(
          height: StyleConstants.linear16,
        ),
        // Add the caps if they exist
        if (payload.signers[0].clist != null &&
            payload.signers[0].clist!.isNotEmpty)
          ...payload.signers[0].clist!.map(
            (Capability sigCap) => _buildCapability(sigCap),
          ),
      ],
    );
  }

  Widget _buildCapability(Capability cap) {
    return Column(
      children: [
        Text(
          cap.name,
          style: StyleConstants.bodyTextBold,
        ),
        const SizedBox(
          height: StyleConstants.linear16,
        ),
        ...cap.args.map(
          (e) => Text(
            e.toString(),
            style: StyleConstants.bodyText,
          ),
        ),
      ],
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

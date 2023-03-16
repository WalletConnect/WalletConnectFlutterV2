import 'package:flutter/material.dart';
import 'package:walletconnect_flutter_v2/walletconnect_flutter_v2.dart';
import 'package:walletconnect_flutter_v2_wallet/utils/constants.dart';
import 'package:walletconnect_flutter_v2_wallet/utils/string_constants.dart';
import 'package:walletconnect_flutter_v2_wallet/widgets/pairing_item.dart';
import 'package:walletconnect_flutter_v2_wallet/widgets/qr_scan_sheet.dart';
import 'package:walletconnect_flutter_v2_wallet/widgets/uri_input_popup.dart';

class AppsPage extends StatefulWidget {
  const AppsPage({
    Key? key,
    required this.web3Wallet,
  }) : super(key: key);

  final Web3Wallet web3Wallet;

  @override
  AppsPageState createState() => AppsPageState();
}

class AppsPageState extends State<AppsPage> {
  List<PairingInfo> _pairings = [];

  @override
  void initState() {
    _pairings = widget.web3Wallet.pairings.getAll();
    // widget.web3wallet.onSessionDelete.subscribe(_onSessionDelete);
    widget.web3Wallet.core.pairing.onPairingDelete.subscribe(_onPairingDelete);
    widget.web3Wallet.core.pairing.onPairingExpire.subscribe(_onPairingDelete);
    super.initState();
  }

  @override
  void dispose() {
    // widget.web3wallet.onSessionDelete.unsubscribe(_onSessionDelete);
    widget.web3Wallet.core.pairing.onPairingDelete
        .unsubscribe(_onPairingDelete);
    widget.web3Wallet.core.pairing.onPairingExpire
        .unsubscribe(_onPairingDelete);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned(
          bottom: StyleConstants.magic20,
          right: StyleConstants.magic20,
          child: Row(
            children: [
              _buildIconButton(
                Icons.copy,
                _onCopyQrCode,
              ),
              const SizedBox(
                width: StyleConstants.magic20,
              ),
              _buildIconButton(
                Icons.qr_code_rounded,
                _onScanQrCode,
              ),
            ],
          ),
        ),
        _pairings.isEmpty ? _buildNoPairingMessage() : _buildPairingList()
      ],
    );
  }

  Widget _buildNoPairingMessage() {
    return const Center(
      child: Text(
        StringConstants.noApps,
        textAlign: TextAlign.center,
        style: StyleConstants.bodyText,
      ),
    );
  }

  Widget _buildPairingList() {
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
                            widget.web3Wallet.core.pairing.disconnect(
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

    return ListView.builder(
      itemCount: pairingItems.length,
      itemBuilder: (BuildContext context, int index) {
        return pairingItems[index];
      },
    );
  }

  Widget _buildIconButton(IconData icon, void Function()? onPressed) {
    return Container(
      decoration: BoxDecoration(
        color: StyleConstants.primaryColor,
        borderRadius: BorderRadius.circular(
          StyleConstants.linear48,
        ),
      ),
      child: IconButton(
        icon: Icon(
          icon,
          color: StyleConstants.titleTextColor,
        ),
        iconSize: StyleConstants.linear24,
        onPressed: onPressed,
      ),
    );
  }

  Future _onCopyQrCode() async {
    final String? uri = await showDialog<String>(
      context: context,
      builder: (BuildContext context) {
        return UriInputPopup();
      },
    );

    if (uri != null && uri.isNotEmpty) {
      await widget.web3Wallet.pair(
        uri: Uri.parse(uri),
      );
    }
  }

  Future _onScanQrCode() async {
    final String? s = await showModalBottomSheet<String>(
      context: context,
      builder: (BuildContext modalContext) {
        return QRScanSheet(
          title: StringConstants.scanPairing,
        );
      },
    );

    if (s != null) {
      await widget.web3Wallet.pair(
        uri: Uri.parse(s),
      );
    }
  }

  void _onPairingDelete(PairingEvent? event) {
    setState(() {
      _pairings = widget.web3Wallet.pairings.getAll();
    });
  }
}

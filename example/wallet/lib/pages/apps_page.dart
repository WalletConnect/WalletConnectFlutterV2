import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:get_it_mixin/get_it_mixin.dart';
import 'package:walletconnect_flutter_v2/walletconnect_flutter_v2.dart';
import 'package:walletconnect_flutter_v2_wallet/dependencies/i_web3wallet_service.dart';
import 'package:walletconnect_flutter_v2_wallet/utils/constants.dart';
import 'package:walletconnect_flutter_v2_wallet/utils/string_constants.dart';
import 'package:walletconnect_flutter_v2_wallet/widgets/pairing_item.dart';
import 'package:walletconnect_flutter_v2_wallet/widgets/qr_scan_sheet.dart';
import 'package:walletconnect_flutter_v2_wallet/widgets/uri_input_popup.dart';

class AppsPage extends StatefulWidget with GetItStatefulWidgetMixin {
  AppsPage({
    Key? key,
  }) : super(key: key);

  @override
  AppsPageState createState() => AppsPageState();
}

class AppsPageState extends State<AppsPage> with GetItStateMixin {
  List<PairingInfo> _pairings = [];

  final Web3Wallet web3Wallet = GetIt.I<IWeb3WalletService>().getWeb3Wallet();

  @override
  void initState() {
    _pairings = web3Wallet.pairings.getAll();
    // web3wallet.onSessionDelete.subscribe(_onSessionDelete);
    web3Wallet.core.pairing.onPairingDelete.subscribe(_onPairingDelete);
    web3Wallet.core.pairing.onPairingExpire.subscribe(_onPairingDelete);
    super.initState();
  }

  @override
  void dispose() {
    // web3wallet.onSessionDelete.unsubscribe(_onSessionDelete);
    web3Wallet.core.pairing.onPairingDelete.unsubscribe(_onPairingDelete);
    web3Wallet.core.pairing.onPairingExpire.unsubscribe(_onPairingDelete);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    _pairings = watch(
      target: GetIt.I<IWeb3WalletService>().pairings,
    );

    return Stack(
      children: [
        _pairings.isEmpty ? _buildNoPairingMessage() : _buildPairingList(),
        Positioned(
          bottom: StyleConstants.magic20,
          right: StyleConstants.magic20,
          child: Row(
            children: [
              _buildIconButton(
                Icons.discord,
                () {
                  web3Wallet.core.relayClient.disconnect();
                },
              ),
              const SizedBox(
                width: StyleConstants.magic20,
              ),
              _buildIconButton(
                Icons.connect_without_contact,
                () {
                  web3Wallet.core.relayClient.connect();
                },
              ),
              const SizedBox(
                width: StyleConstants.magic20,
              ),
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
                            web3Wallet.core.pairing.disconnect(
                              topic: pairing.topic,
                            );
                            Navigator.of(context).pop();
                          } catch (e) {
                            //debugPrint(e.toString());
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
    // final Widget w = WCRequestWidget(
    //   child: //Center(child: Text('swag')),
    //       WCConnectionRequestWidget(
    //     wallet: web3Wallet,
    //     title: 'Sign',
    //     sessionProposal: WCSessionRequestModel(
    //       request: const ProposalData(
    //         id: 0,
    //         expiry: 0,
    //         relays: [],
    //         proposer: ConnectionMetadata(
    //           publicKey: 'swag',
    //           metadata: PairingMetadata(
    //             name: 'A',
    //             description: 'B',
    //             url: 'abc.com',
    //             icons: [],
    //           ),
    //         ),
    //         requiredNamespaces: {
    //           'kadena': RequiredNamespace(
    //             methods: ['kadena_sign_v1'],
    //             events: [],
    //           ),
    //         },
    //         optionalNamespaces: {},
    //         pairingTopic: 'abc',
    //       ),
    //     ),
    //   ),
    // );

    // final bool? approved =
    //     await GetIt.I<IBottomSheetService>().queueBottomSheet(
    //   widget: w,
    // );

    final String? uri = await showDialog<String>(
      context: context,
      builder: (BuildContext context) {
        return UriInputPopup();
      },
    );

    // print(uri);

    if (uri != null && uri.isNotEmpty) {
      await web3Wallet.pair(
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
      await web3Wallet.pair(
        uri: Uri.parse(s),
      );
    }
  }

  void _onPairingDelete(PairingEvent? event) {
    setState(() {
      _pairings = web3Wallet.pairings.getAll();
    });
  }
}

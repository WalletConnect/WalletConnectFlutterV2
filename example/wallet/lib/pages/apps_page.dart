import 'package:fl_toast/fl_toast.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:get_it_mixin/get_it_mixin.dart';
import 'package:qr_bar_code_scanner_dialog/qr_bar_code_scanner_dialog.dart';
import 'package:walletconnect_flutter_v2/walletconnect_flutter_v2.dart';
import 'package:walletconnect_flutter_v2_wallet/dependencies/bottom_sheet/i_bottom_sheet_service.dart';
import 'package:walletconnect_flutter_v2_wallet/dependencies/deep_link_handler.dart';
import 'package:walletconnect_flutter_v2_wallet/dependencies/i_web3wallet_service.dart';
import 'package:walletconnect_flutter_v2_wallet/pages/app_detail_page.dart';
import 'package:walletconnect_flutter_v2_wallet/utils/constants.dart';
import 'package:walletconnect_flutter_v2_wallet/utils/eth_utils.dart';
import 'package:walletconnect_flutter_v2_wallet/utils/string_constants.dart';
import 'package:walletconnect_flutter_v2_wallet/widgets/pairing_item.dart';
import 'package:walletconnect_flutter_v2_wallet/widgets/uri_input_popup.dart';

class AppsPage extends StatefulWidget with GetItStatefulWidgetMixin {
  AppsPage({Key? key}) : super(key: key);

  @override
  AppsPageState createState() => AppsPageState();
}

class AppsPageState extends State<AppsPage> with GetItStateMixin {
  List<PairingInfo> _pairings = [];
  late IWeb3WalletService _web3walletService;
  late IWeb3Wallet _web3Wallet;

  @override
  void initState() {
    super.initState();
    _web3walletService = GetIt.I<IWeb3WalletService>();
    _web3Wallet = _web3walletService.web3wallet;
    _pairings = _web3Wallet.pairings.getAll();
    _pairings = _pairings.where((p) => p.active).toList();
    //
    _registerListeners();
    // TODO web3Wallet.core.echo.register(firebaseAccessToken);
    DeepLinkHandler.onLink.listen(_onFoundUri);
    DeepLinkHandler.checkInitialLink();
  }

  void _registerListeners() {
    _web3Wallet.core.relayClient.onRelayClientMessage.subscribe(
      _onRelayClientMessage,
    );
    _web3Wallet.pairings.onSync.subscribe(_refreshState);
    _web3Wallet.pairings.onUpdate.subscribe(_refreshState);
    _web3Wallet.onSessionConnect.subscribe(_refreshState);
    _web3Wallet.onSessionDelete.subscribe(_refreshState);
  }

  void _unregisterListeners() {
    _web3Wallet.onSessionDelete.unsubscribe(_refreshState);
    _web3Wallet.onSessionConnect.unsubscribe(_refreshState);
    _web3Wallet.pairings.onSync.unsubscribe(_refreshState);
    _web3Wallet.pairings.onUpdate.unsubscribe(_refreshState);
    _web3Wallet.core.relayClient.onRelayClientMessage.unsubscribe(
      _onRelayClientMessage,
    );
  }

  @override
  void dispose() {
    _unregisterListeners();
    super.dispose();
  }

  void _refreshState(dynamic event) async {
    setState(() {});
  }

  void _onRelayClientMessage(MessageEvent? event) async {
    _refreshState(event);
    if (event != null) {
      final jsonObject = await EthUtils.decodeMessageEvent(event);
      if (!mounted) return;
      if (jsonObject is JsonRpcRequest &&
          jsonObject.method == 'wc_sessionPing') {
        showPlatformToast(
          duration: const Duration(seconds: 1),
          child: Container(
            padding: const EdgeInsets.all(StyleConstants.linear8),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(
                StyleConstants.linear16,
              ),
            ),
            child: Text(jsonObject.method, maxLines: 1),
          ),
          context: context,
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    _pairings = _web3Wallet.pairings.getAll();
    _pairings = _pairings.where((p) => p.active).toList();
    return Stack(
      children: [
        _pairings.isEmpty ? _buildNoPairingMessage() : _buildPairingList(),
        Positioned(
          bottom: StyleConstants.magic20,
          right: StyleConstants.magic20,
          left: StyleConstants.magic20,
          child: Row(
            children: [
              const SizedBox(width: StyleConstants.magic20),
              _buildIconButton(Icons.copy, _onCopyQrCode),
              const SizedBox(width: StyleConstants.magic20),
              _buildIconButton(Icons.qr_code_rounded, _onScanQrCode),
            ],
          ),
        ),
        ValueListenableBuilder(
          valueListenable: DeepLinkHandler.waiting,
          builder: (context, value, _) {
            return Visibility(
              visible: value,
              child: Center(
                child: Container(
                  decoration: const BoxDecoration(
                    color: Colors.black38,
                    borderRadius: BorderRadius.all(Radius.circular(50.0)),
                  ),
                  padding: const EdgeInsets.all(12.0),
                  child: const CircularProgressIndicator(
                    color: Colors.white,
                  ),
                ),
              ),
            );
          },
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
    final pairingItems = _pairings
        .map(
          (PairingInfo pairing) => PairingItem(
            key: ValueKey(pairing.topic),
            pairing: pairing,
            onTap: () => _onListItemTap(pairing),
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

  Future<dynamic> _onCopyQrCode() async {
    final uri = await GetIt.I<IBottomSheetService>().queueBottomSheet(
      widget: UriInputPopup(),
    );
    if (uri is String) {
      _onFoundUri(uri);
    }
  }

  Future _onScanQrCode() async {
    try {
      QrBarCodeScannerDialog().getScannedQrBarCode(
        context: context,
        onCode: (value) {
          if (!mounted) return;
          _onFoundUri(value);
        },
      );
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  Future<void> _onFoundUri(String? uri) async {
    if ((uri ?? '').isEmpty) return;
    try {
      DeepLinkHandler.waiting.value = true;
      final Uri uriData = Uri.parse(uri!);
      await _web3Wallet.pair(uri: uriData);
    } catch (e) {
      DeepLinkHandler.waiting.value = false;
      showPlatformToast(
        child: Container(
          padding: const EdgeInsets.all(StyleConstants.linear8),
          margin: const EdgeInsets.only(
            bottom: StyleConstants.magic40,
          ),
          decoration: BoxDecoration(
            color: StyleConstants.errorColor,
            borderRadius: BorderRadius.circular(
              StyleConstants.linear16,
            ),
          ),
          child: const Text(
            StringConstants.invalidUri,
            style: StyleConstants.bodyTextBold,
          ),
        ),
        // ignore: use_build_context_synchronously
        context: context,
      );
    }
  }

  void _onListItemTap(PairingInfo pairing) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => AppDetailPage(
          pairing: pairing,
        ),
      ),
    );
  }
}

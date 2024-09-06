// import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:get_it/get_it.dart';
import 'package:walletconnect_flutter_v2/walletconnect_flutter_v2.dart';
import 'package:walletconnect_flutter_v2_wallet/dependencies/i_web3wallet_service.dart';

class DeepLinkHandler {
  static const _methodChannel = MethodChannel(
    'com.walletconnect.flutterwallet/methods',
  );
  static const _eventChannel = EventChannel(
    'com.walletconnect.flutterwallet/events',
  );
  static final waiting = ValueNotifier<bool>(false);

  static void initListener() {
    if (kIsWeb) return;
    _eventChannel.receiveBroadcastStream().listen(
          _onLink,
          onError: _onError,
        );
  }

  static void checkInitialLink() async {
    if (kIsWeb) return;
    try {
      _methodChannel.invokeMethod('initialLink');
    } catch (e) {
      debugPrint('[SampleWallet] [DeepLinkHandler] checkInitialLink $e');
    }
  }

  static IWeb3Wallet get _web3wallet =>
      GetIt.I<IWeb3WalletService>().web3wallet;
  static Uri get nativeUri =>
      Uri.parse(_web3wallet.metadata.redirect?.native ?? '');
  static Uri get universalUri =>
      Uri.parse(_web3wallet.metadata.redirect?.universal ?? '');
  static String get host => universalUri.host;

  static void goBackModal({
    String? title,
    String? message,
    bool success = true,
  }) async {
    waiting.value = false;
    await GetIt.I<IBottomSheetService>().queueBottomSheet(
      closeAfter: success ? 3 : 0,
      widget: Container(
        color: Colors.white,
        height: 250.0,
        width: double.infinity,
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            Icon(
              success ? Icons.check_circle_sharp : Icons.error_outline_sharp,
              color: success ? Colors.green[100] : Colors.red[100],
              size: 80.0,
            ),
            Text(
              title ?? 'Connected',
              style: StyleConstants.subtitleText.copyWith(
                color: Colors.black,
                fontSize: 18.0,
              ),
            ),
            Text(message ?? 'You can go back to your dApp now'),
          ],
        ),
      ),
    );
  }

  static void _onLink(Object? event) {
    final decodedUri = Uri.parse(Uri.decodeFull(event.toString()));
    if (decodedUri.isScheme('wc')) {
      waiting.value = true;
      _linksController.sink.add(decodedUri.toString());
  static void _onLink(Object? event) async {
    final ev = WalletConnectUtils.getSearchParamFromURL('$event', 'wc_ev');
    if (ev.isNotEmpty) {
      debugPrint('[SampleWallet] is linkMode $event');
      await _web3wallet.dispatchEnvelope('$event');
    } else {
      final decodedUri = Uri.parse(Uri.decodeFull(event.toString()));
      if (decodedUri.isScheme('wc')) {
        debugPrint('[SampleWallet] is legacy uri $decodedUri');
        waiting.value = true;
        await _web3wallet.pair(uri: decodedUri);
      } else {
        final uriParam = WalletConnectUtils.getSearchParamFromURL(
          '$decodedUri',
          'uri',
        );
        if (decodedUri.isScheme(nativeUri.scheme) && uriParam.isNotEmpty) {
          debugPrint('[SampleWallet] is custom uri $decodedUri');
          waiting.value = true;
          final pairingUri = decodedUri.query.replaceFirst('uri=', '');
          await _web3wallet.pair(uri: Uri.parse(pairingUri));
        }
      }
    }
  }

  static void _onError(Object error) {
    waiting.value = false;
    debugPrint('[SampleWallet] [DeepLinkHandler] _onError $error');
  }
}

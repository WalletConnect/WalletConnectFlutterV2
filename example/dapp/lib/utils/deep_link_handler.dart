import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:walletconnect_flutter_v2_dapp/imports.dart';

class DeepLinkHandler {
  static const _methodChannel = MethodChannel(
    'com.walletconnect.flutterwallet/methods',
  );
  static const _eventChannel = EventChannel(
    'com.walletconnect.flutterwallet/events',
  );
  static final waiting = ValueNotifier<bool>(false);
  static late IWeb3App _web3app;

  static void initListener() {
    if (kIsWeb) return;
    _eventChannel.receiveBroadcastStream().listen(
          _onLink,
          onError: _onError,
        );
  }

  static void init(IWeb3App web3app) {
    if (kIsWeb) return;
    _web3app = web3app;
  }

  static void checkInitialLink() {
    if (kIsWeb) return;
    try {
      _methodChannel.invokeMethod('initialLink').then(
            _onLink,
            onError: _onError,
          );
    } catch (e) {
      debugPrint('[SampleWallet] [DeepLinkHandler] checkInitialLink $e');
    }
  }

  static Uri get nativeUri =>
      Uri.parse(_web3app.metadata.redirect?.native ?? '');
  static Uri get universalUri =>
      Uri.parse(_web3app.metadata.redirect?.universal ?? '');
  static String get host => universalUri.host;

  static void _onLink(dynamic link) async {
    if (link == null) return;
    final envelope = WalletConnectUtils.getSearchParamFromURL(link, 'wc_ev');
    if (envelope.isNotEmpty) {
      debugPrint('[SampleDapp] is linkMode $link');
      await _web3app.dispatchEnvelope(link);
    }
  }

  static void _onError(dynamic error) {
    debugPrint('[SampleDapp] _onError $error');
    waiting.value = false;
  }
}

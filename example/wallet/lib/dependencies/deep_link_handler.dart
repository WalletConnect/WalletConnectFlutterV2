import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:url_launcher/url_launcher_string.dart';

class DeepLinkHandler {
  //
  static final _linksController = StreamController<String>.broadcast();
  static const _methodChannel =
      MethodChannel('com.walletconnect.flutterwallet/methods');
  static const _eventChannel =
      EventChannel('com.walletconnect.flutterwallet/events');

  static void initPlatformState() {
    _eventChannel.receiveBroadcastStream().listen((Object? event) {
      final decodedUri = Uri.parse(Uri.decodeFull(event.toString()));
      if (decodedUri.toString().startsWith('wc:')) {
        return;
      }
      final pairingUri = decodedUri.query.replaceFirst('uri=', '');
      if (!pairingUri.toString().startsWith('wc:')) {
        return;
      }
      _linksController.sink.add(pairingUri);
    }, onError: (Object error) {
      debugPrint('[DeepLinkHandler] _onError $error');
    });

    _methodChannel.invokeMethod('initialLink').then(
          (value) => debugPrint('[DeepLinkHandler] initialLink $value'),
        );
  }

  static Stream<String> get onLink => _linksController.stream;

  static Future<void> goTo(String scheme) async {
    try {
      launchUrlString(scheme, mode: LaunchMode.externalApplication);
    } catch (e) {
      debugPrint('[DeepLinkHandler] error re-opening dapp ($scheme). $e');
    }
  }
}

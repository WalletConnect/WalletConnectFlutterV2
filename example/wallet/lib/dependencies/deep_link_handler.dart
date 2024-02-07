import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get_it/get_it.dart';
import 'package:url_launcher/url_launcher_string.dart';
import 'package:walletconnect_flutter_v2_wallet/dependencies/bottom_sheet/i_bottom_sheet_service.dart';
import 'package:walletconnect_flutter_v2_wallet/utils/constants.dart';

class DeepLinkHandler {
  //
  static final _linksController = StreamController<String>.broadcast();
  static const _methodChannel =
      MethodChannel('com.walletconnect.flutterwallet/methods');
  static const _eventChannel =
      EventChannel('com.walletconnect.flutterwallet/events');

  static void initListener() {
    _eventChannel.receiveBroadcastStream().listen(_onLink, onError: _onError);
  }

  static void checkInitialLink() {
    try {
      _methodChannel.invokeMethod('initialLink').then(
            _onLink,
            onError: _onError,
          );
    } catch (e) {
      debugPrint('[DeepLinkHandler] checkInitialLink $e');
    }
  }

  static Stream<String> get onLink => _linksController.stream;

  static Future<void> goTo(
    String scheme, {
    int delay = 0,
    String? modalTitle,
    String? modalMessage,
    bool success = true,
  }) async {
    if (scheme.isEmpty) return;
    await Future.delayed(Duration(milliseconds: delay));
    try {
      await launchUrlString(scheme, mode: LaunchMode.externalApplication);
    } catch (e) {
      debugPrint('[DeepLinkHandler] error re-opening dapp ($scheme). $e');
      _goBackModal(
        title: modalTitle,
        message: modalMessage,
        success: success,
      );
    }
  }

  static void _onLink(Object? event) {
    final decodedUri = Uri.parse(Uri.decodeFull(event.toString()));
    if (decodedUri.toString().startsWith('wc:')) {
      return;
    }
    final pairingUri = decodedUri.query.replaceFirst('uri=', '');
    if (!pairingUri.toString().startsWith('wc:')) {
      return;
    }
    _linksController.sink.add(pairingUri);
  }

  static void _onError(Object error) {
    debugPrint('[DeepLinkHandler] _onError $error');
  }

  static void _goBackModal({
    String? title,
    String? message,
    bool success = true,
  }) async {
    await GetIt.I<IBottomSheetService>().queueBottomSheet(
      closeAfter: success ? 3 : 0,
      widget: Container(
        color: Colors.white,
        height: 210.0,
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
}

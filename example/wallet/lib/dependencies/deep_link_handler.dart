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
      _methodChannel.invokeMethod('initialLink');
    } catch (e) {
      debugPrint('[DeepLinkHandler] checkInitialLink $e');
    }
  }

  static Stream<String> get onLink => _linksController.stream;

  static Future<void> goTo(
    String scheme, {
    int delay = 0,
    String? modalTitle,
  }) async {
    await Future.delayed(Duration(milliseconds: delay));
    try {
      final canLaunch = await canLaunchUrlString(scheme);
      if (canLaunch) {
        launchUrlString(scheme, mode: LaunchMode.externalApplication);
      } else {
        throw Exception('Can not launch scheme');
      }
    } catch (e) {
      debugPrint('[DeepLinkHandler] error re-opening dapp ($scheme). $e');
      _goBackModal(title: modalTitle);
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

  static void _goBackModal({String? title}) async {
    GetIt.I<IBottomSheetService>().queueBottomSheet(
      widget: Container(
        color: Colors.white,
        height: 180.0,
        width: double.infinity,
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            Icon(
              Icons.check_circle_sharp,
              color: Colors.green[100],
              size: 80.0,
            ),
            Text(
              title ?? 'Connected',
              style: StyleConstants.subtitleText.copyWith(
                color: Colors.black,
                fontSize: 18.0,
              ),
            ),
            const Text('You can go back to your dApp now'),
          ],
        ),
      ),
    );
  }
}

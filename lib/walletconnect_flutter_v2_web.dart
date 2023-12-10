// In order to *not* need this ignore, consider extracting the "web" version
// of your plugin as a separate package, instead of inlining it in the same
// package as the core of your plugin.
// ignore: avoid_web_libraries_in_flutter
import 'dart:html' as html show window;

// ignore: depend_on_referenced_packages
import 'package:flutter_web_plugins/flutter_web_plugins.dart';

import 'walletconnect_flutter_v2_platform_interface.dart';

/// A web implementation of the WalletconnectFlutterV2Platform of the WalletconnectFlutterV2 plugin.
class WalletconnectFlutterV2Web extends WalletconnectFlutterV2Platform {
  /// Constructs a WalletconnectFlutterV2Web
  WalletconnectFlutterV2Web();

  static void registerWith(Registrar registrar) {
    WalletconnectFlutterV2Platform.instance = WalletconnectFlutterV2Web();
  }

  /// Returns a [String] containing the version of the platform.
  @override
  Future<String?> getPlatformVersion() async {
    final version = html.window.navigator.userAgent;
    return version;
  }
}

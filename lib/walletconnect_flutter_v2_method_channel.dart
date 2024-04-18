import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import 'walletconnect_flutter_v2_platform_interface.dart';

/// An implementation of [WalletconnectFlutterV2Platform] that uses method channels.
class MethodChannelWalletconnectFlutterV2
    extends WalletconnectFlutterV2Platform {
  /// The method channel used to interact with the native platform.
  @visibleForTesting
  final methodChannel = const MethodChannel('walletconnect_flutter_v2');

  @override
  Future<String?> getPlatformVersion() async {
    final version =
        await methodChannel.invokeMethod<String>('getPlatformVersion');
    return version;
  }
}

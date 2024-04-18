import 'package:plugin_platform_interface/plugin_platform_interface.dart';

import 'walletconnect_flutter_v2_method_channel.dart';

abstract class WalletconnectFlutterV2Platform extends PlatformInterface {
  /// Constructs a WalletconnectFlutterV2Platform.
  WalletconnectFlutterV2Platform() : super(token: _token);

  static final Object _token = Object();

  static WalletconnectFlutterV2Platform _instance =
      MethodChannelWalletconnectFlutterV2();

  /// The default instance of [WalletconnectFlutterV2Platform] to use.
  ///
  /// Defaults to [MethodChannelWalletconnectFlutterV2].
  static WalletconnectFlutterV2Platform get instance => _instance;

  /// Platform-specific implementations should set this with their own
  /// platform-specific class that extends [WalletconnectFlutterV2Platform] when
  /// they register themselves.
  static set instance(WalletconnectFlutterV2Platform instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }

  Future<String?> getPlatformVersion() {
    throw UnimplementedError('platformVersion() has not been implemented.');
  }
}

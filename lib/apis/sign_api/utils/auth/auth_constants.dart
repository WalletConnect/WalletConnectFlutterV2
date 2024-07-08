import 'package:walletconnect_flutter_v2/apis/utils/constants.dart';

class AuthConstants {
  static const AUTH_REQUEST_EXPIRY_MIN = WalletConnectConstants.FIVE_MINUTES;
  static const AUTH_REQUEST_EXPIRY_MAX = WalletConnectConstants.SEVEN_DAYS;

  static const AUTH_DEFAULT_URL = 'https://rpc.walletconnect.org/v1';

  static const AUTH_PROTOCOL = 'wc';
  static const AUTH_VERSION = 1.5;
  static const AUTH_CONTEXT = 'auth';
  static const AUTH_STORAGE_PREFIX =
      '$AUTH_PROTOCOL@$AUTH_VERSION:$AUTH_CONTEXT:';

  static const AUTH_CLIENT_PUBLIC_KEY_NAME = 'PUB_KEY';

  static const OCAUTH_CLIENT_PUBLIC_KEY_NAME =
      '$AUTH_STORAGE_PREFIX:$AUTH_CLIENT_PUBLIC_KEY_NAME';
}

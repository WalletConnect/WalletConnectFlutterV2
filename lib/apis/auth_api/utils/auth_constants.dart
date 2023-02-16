import 'package:walletconnect_flutter_v2/apis/utils/constants.dart';

class AuthConstants {
  static const AUTH_REQUEST_EXPIRY_MIN = WalletConnectConstants.FIVE_MINUTES;
  static const AUTH_REQUEST_EXPIRY_MAX = WalletConnectConstants.SEVEN_DAYS;

  static const AUTH_DEFAULT_URL = 'https://rpc.walletconnect.com/v1';

  static const AUTH_CLIENT_PUBLIC_KEY_NAME = 'PUB_KEY';

  static const CONTEXT_AUTH_KEYS = 'authKeys';
  static const VERSION_AUTH_KEYS = '2.0';
  static const CONTEXT_PAIRING_TOPICS = 'authPairingTopics';
  static const VERSION_PAIRING_TOPICS = '2.0';
  static const CONTEXT_AUTH_REQUESTS = 'authRequests';
  static const VERSION_AUTH_REQUESTS = '2.0';
  static const CONTEXT_COMPLETE_REQUESTS = 'completeRequests';
  static const VERSION_COMPLETE_REQUESTS = '2.0';
}

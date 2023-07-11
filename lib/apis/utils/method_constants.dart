import 'package:walletconnect_flutter_v2/apis/models/basic_models.dart';
import 'package:walletconnect_flutter_v2/apis/utils/constants.dart';

class MethodConstants {
  static const WC_PAIRING_PING = 'wc_pairingPing';
  static const WC_PAIRING_DELETE = 'wc_pairingDelete';
  static const UNREGISTERED_METHOD = 'unregistered_method';

  static const WC_SESSION_PROPOSE = 'wc_sessionPropose';
  static const WC_SESSION_SETTLE = 'wc_sessionSettle';
  static const WC_SESSION_UPDATE = 'wc_sessionUpdate';
  static const WC_SESSION_EXTEND = 'wc_sessionExtend';
  static const WC_SESSION_REQUEST = 'wc_sessionRequest';
  static const WC_SESSION_EVENT = 'wc_sessionEvent';
  static const WC_SESSION_DELETE = 'wc_sessionDelete';
  static const WC_SESSION_PING = 'wc_sessionPing';

  static const WC_AUTH_REQUEST = 'wc_authRequest';

  static const Map<String, Map<String, RpcOptions>> RPC_OPTS = {
    WC_PAIRING_PING: {
      'req': RpcOptions(
        ttl: WalletConnectConstants.ONE_DAY,
        prompt: false,
        tag: 1000,
      ),
      'res': RpcOptions(
        ttl: WalletConnectConstants.ONE_DAY,
        prompt: false,
        tag: 1001,
      ),
    },
    WC_PAIRING_DELETE: {
      'req': RpcOptions(
        ttl: WalletConnectConstants.THIRTY_SECONDS,
        prompt: false,
        tag: 1002,
      ),
      'res': RpcOptions(
        ttl: WalletConnectConstants.THIRTY_SECONDS,
        prompt: false,
        tag: 1003,
      ),
    },
    UNREGISTERED_METHOD: {
      'req': RpcOptions(
        ttl: WalletConnectConstants.ONE_DAY,
        prompt: false,
        tag: 0,
      ),
      'res': RpcOptions(
        ttl: WalletConnectConstants.ONE_DAY,
        prompt: false,
        tag: 0,
      ),
    },
    WC_SESSION_PROPOSE: {
      'req': RpcOptions(
        ttl: WalletConnectConstants.FIVE_MINUTES,
        prompt: true,
        tag: 1100,
      ),
      'res': RpcOptions(
        ttl: WalletConnectConstants.FIVE_MINUTES,
        prompt: false,
        tag: 1101,
      ),
    },
    WC_SESSION_SETTLE: {
      'req': RpcOptions(
        ttl: WalletConnectConstants.FIVE_MINUTES,
        prompt: false,
        tag: 1102,
      ),
      'res': RpcOptions(
        ttl: WalletConnectConstants.FIVE_MINUTES,
        prompt: false,
        tag: 1103,
      ),
    },
    WC_SESSION_UPDATE: {
      'req': RpcOptions(
        ttl: WalletConnectConstants.ONE_DAY,
        prompt: false,
        tag: 1104,
      ),
      'res': RpcOptions(
        ttl: WalletConnectConstants.ONE_DAY,
        prompt: false,
        tag: 1105,
      ),
    },
    WC_SESSION_EXTEND: {
      'req': RpcOptions(
        ttl: WalletConnectConstants.ONE_DAY,
        prompt: false,
        tag: 1106,
      ),
      'res': RpcOptions(
        ttl: WalletConnectConstants.ONE_DAY,
        prompt: false,
        tag: 1107,
      ),
    },
    WC_SESSION_REQUEST: {
      'req': RpcOptions(
        ttl: WalletConnectConstants.FIVE_MINUTES,
        prompt: true,
        tag: 1108,
      ),
      'res': RpcOptions(
        ttl: WalletConnectConstants.FIVE_MINUTES,
        prompt: false,
        tag: 1109,
      ),
    },
    WC_SESSION_EVENT: {
      'req': RpcOptions(
        ttl: WalletConnectConstants.FIVE_MINUTES,
        prompt: true,
        tag: 1110,
      ),
      'res': RpcOptions(
        ttl: WalletConnectConstants.FIVE_MINUTES,
        prompt: false,
        tag: 1111,
      ),
    },
    WC_SESSION_DELETE: {
      'req': RpcOptions(
        ttl: WalletConnectConstants.ONE_DAY,
        prompt: false,
        tag: 1112,
      ),
      'res': RpcOptions(
        ttl: WalletConnectConstants.ONE_DAY,
        prompt: false,
        tag: 1113,
      ),
    },
    WC_SESSION_PING: {
      'req': RpcOptions(
        ttl: WalletConnectConstants.THIRTY_SECONDS,
        prompt: false,
        tag: 1114,
      ),
      'res': RpcOptions(
        ttl: WalletConnectConstants.THIRTY_SECONDS,
        prompt: false,
        tag: 1115,
      ),
    },
    WC_AUTH_REQUEST: {
      'req': RpcOptions(
        ttl: WalletConnectConstants.ONE_DAY,
        prompt: true,
        tag: 3000,
      ),
      'res': RpcOptions(
        ttl: WalletConnectConstants.ONE_DAY,
        prompt: false,
        tag: 3001,
      ),
    },
  };
}

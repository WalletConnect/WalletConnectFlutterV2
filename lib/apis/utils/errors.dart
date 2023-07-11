import 'package:walletconnect_flutter_v2/apis/models/basic_models.dart';

class Errors {
  static const INVALID_METHOD = 'INVALID_METHOD';
  static const INVALID_EVENT = 'INVALID_EVENT';
  static const INVALID_UPDATE_REQUEST = 'INVALID_UPDATE_REQUEST';
  static const INVALID_EXTEND_REQUEST = 'INVALID_EXTEND_REQUEST';
  static const INVALID_SESSION_SETTLE_REQUEST =
      'INVALID_SESSION_SETTLE_REQUEST';
  static const UNAUTHORIZED_METHOD = 'UNAUTHORIZED_METHOD';
  static const UNAUTHORIZED_EVENT = 'UNAUTHORIZED_EVENT';
  static const UNAUTHORIZED_UPDATE_REQUEST = 'UNAUTHORIZED_UPDATE_REQUEST';
  static const UNAUTHORIZED_EXTEND_REQUEST = 'UNAUTHORIZED_EXTEND_REQUEST';
  static const USER_REJECTED_SIGN = 'USER_REJECTED_SIGN';
  static const USER_REJECTED = 'USER_REJECTED';
  static const USER_REJECTED_CHAINS = 'USER_REJECTED_CHAINS';
  static const USER_REJECTED_METHODS = 'USER_REJECTED_METHODS';
  static const USER_REJECTED_EVENTS = 'USER_REJECTED_EVENTS';
  static const UNSUPPORTED_CHAINS = 'UNSUPPORTED_CHAINS';
  static const UNSUPPORTED_METHODS = 'UNSUPPORTED_METHODS';
  static const UNSUPPORTED_EVENTS = 'UNSUPPORTED_EVENTS';
  static const UNSUPPORTED_ACCOUNTS = 'UNSUPPORTED_ACCOUNTS';
  static const UNSUPPORTED_NAMESPACE_KEY = 'UNSUPPORTED_NAMESPACE_KEY';
  static const USER_DISCONNECTED = 'USER_DISCONNECTED';
  static const SESSION_SETTLEMENT_FAILED = 'SESSION_SETTLEMENT_FAILED';
  static const NO_SESSION_FOR_TOPIC = 'NO_SESSION_FOR_TOPIC';
  static const REQUEST_EXPIRED_SESSION = 'SESSION_REQUEST_EXPIRED';
  static const WC_METHOD_UNSUPPORTED = 'WC_METHOD_UNSUPPORTED';

  // AUTH
  static const MALFORMED_RESPONSE_PARAMS = 'MALFORMED_RESPONSE_PARAMS';
  static const MALFORMED_REQUEST_PARAMS = 'MALFORMED_REQUEST_PARAMS';
  static const MESSAGE_COMPROMISED = 'MESSAGE_COMPROMISED';
  static const SIGNATURE_VERIFICATION_FAILED = 'SIGNATURE_VERIFICATION_FAILED';
  static const REQUEST_EXPIRED_AUTH = 'AUTH_REQUEST_EXPIRED';
  static const MISSING_ISSUER_AUTH = 'AUTH_MISSING_ISSUER';
  static const USER_REJECTED_AUTH = 'AUTH_USER_REJECTED';
  static const USER_DISCONNECTED_AUTH = 'AUTH_USER_DISCONNECTED';

  static const SDK_ERRORS = {
    /* ----- INVALID (1xxx) ----- */
    INVALID_METHOD: {
      'message': 'Invalid method.',
      'code': 1001,
    },
    INVALID_EVENT: {
      'message': 'Invalid event.',
      'code': 1002,
    },
    INVALID_UPDATE_REQUEST: {
      'message': 'Invalid update request.',
      'code': 1003,
    },
    INVALID_EXTEND_REQUEST: {
      'message': 'Invalid extend request.',
      'code': 1004,
    },
    INVALID_SESSION_SETTLE_REQUEST: {
      'message': 'Invalid session settle request.',
      'code': 1005,
    },
    /* ----- UNAUTHORIZED (3xxx) ----- */
    UNAUTHORIZED_METHOD: {
      'message': 'Unauthorized method.',
      'code': 3001,
    },
    UNAUTHORIZED_EVENT: {
      'message': 'Unauthorized event.',
      'code': 3002,
    },
    UNAUTHORIZED_UPDATE_REQUEST: {
      'message': 'Unauthorized update request.',
      'code': 3003,
    },
    UNAUTHORIZED_EXTEND_REQUEST: {
      'message': 'Unauthorized extend request.',
      'code': 3004,
    },
    /* ----- REJECTED (5xxx) ----- */
    USER_REJECTED_SIGN: {
      'message': 'User rejected.',
      'code': 4001,
    },
    /* ----- REJECTED (5xxx) ----- */
    USER_REJECTED: {
      'message': 'User rejected.',
      'code': 5000,
    },
    USER_REJECTED_CHAINS: {
      'message': 'User rejected chains.',
      'code': 5001,
    },
    USER_REJECTED_METHODS: {
      'message': 'User rejected methods.',
      'code': 5002,
    },
    USER_REJECTED_EVENTS: {
      'message': 'User rejected events.',
      'code': 5003,
    },
    UNSUPPORTED_CHAINS: {
      'message': 'Unsupported chains.',
      'code': 5100,
    },
    UNSUPPORTED_METHODS: {
      'message': 'Unsupported methods.',
      'code': 5101,
    },
    UNSUPPORTED_EVENTS: {
      'message': 'Unsupported events.',
      'code': 5102,
    },
    UNSUPPORTED_ACCOUNTS: {
      'message': 'Unsupported accounts.',
      'code': 5103,
    },
    UNSUPPORTED_NAMESPACE_KEY: {
      'message': 'Unsupported namespace key.',
      'code': 5104,
    },
    /* ----- REASON (6xxx) ----- */
    USER_DISCONNECTED: {
      'message': 'User disconnected.',
      'code': 6000,
    },
    /* ----- FAILURE (7xxx) ----- */
    SESSION_SETTLEMENT_FAILED: {
      'message': 'Session settlement failed.',
      'code': 7000,
    },
    NO_SESSION_FOR_TOPIC: {
      'message': 'No session for topic.',
      'code': 7001,
    },
    /* ----- FAILURE (8xxx) ----- */
    REQUEST_EXPIRED_SESSION: {
      'message': 'Session request expired.',
      'code': 8000,
    },
    /* ----- PAIRING (10xxx) ----- */
    WC_METHOD_UNSUPPORTED: {
      'message': 'Unsupported wc_ method.',
      'code': 10001,
    },
    /* ----- AUTH VALIDATION (11xxx) ----- */
    MALFORMED_RESPONSE_PARAMS: {
      'message': 'Malformed response parameters.',
      'code': 11001,
    },
    MALFORMED_REQUEST_PARAMS: {
      'message': 'Malformed request parameters.',
      'code': 11002,
    },
    MESSAGE_COMPROMISED: {
      'message': 'Message compromised.',
      'code': 11003,
    },
    SIGNATURE_VERIFICATION_FAILED: {
      'message': 'Signature verification failed.',
      'code': 11004,
    },
    REQUEST_EXPIRED_AUTH: {
      'message': 'Auth request expired.',
      'code': 11005,
    },
    MISSING_ISSUER_AUTH: {
      'message': 'Missing Issuer.',
      'code': 11006,
    },
    /* ----- AUTH REJECTED (12xxx) ----- */
    USER_REJECTED_AUTH: {
      'message': 'User rejected auth request.',
      'code': 12001,
    },
    USER_DISCONNECTED_AUTH: {
      'message': 'User disconnect auth.',
      'code': 12002,
    },
  };

  static const NOT_INITIALIZED = 'NOT_INITIALIZED';
  static const NO_MATCHING_KEY = 'NO_MATCHING_KEY';
  static const RESTORE_WILL_OVERRIDE = 'RESTORE_WILL_OVERRIDE';
  static const RESUBSCRIBED = 'RESUBSCRIBED';
  static const MISSING_OR_INVALID = 'MISSING_OR_INVALID';
  static const EXPIRED = 'EXPIRED';
  static const UNKNOWN_TYPE = 'UNKNOWN_TYPE';
  static const MISMATCHED_TOPIC = 'MISMATCHED_TOPIC';
  static const NON_CONFORMING_NAMESPACES = 'NON_CONFORMING_NAMESPACES';

  static const INTERNAL_ERRORS = {
    NOT_INITIALIZED: {
      'message': 'Not initialized.',
      'code': 1,
    },
    NO_MATCHING_KEY: {
      'message': 'No matching key.',
      'code': 2,
    },
    RESTORE_WILL_OVERRIDE: {
      'message': 'Restore will override.',
      'code': 3,
    },
    RESUBSCRIBED: {
      'message': 'Resubscribed.',
      'code': 4,
    },
    MISSING_OR_INVALID: {
      'message': 'Missing or invalid.',
      'code': 5,
    },
    EXPIRED: {
      'message': 'Expired.',
      'code': 6,
    },
    UNKNOWN_TYPE: {
      'message': 'Unknown type.',
      'code': 7,
    },
    MISMATCHED_TOPIC: {
      'message': 'Mismatched topic.',
      'code': 8,
    },
    NON_CONFORMING_NAMESPACES: {
      'message': 'Non conforming namespaces.',
      'code': 9,
    },
  };

  static WalletConnectError getInternalError(
    String key, {
    String context = '',
  }) {
    if (INTERNAL_ERRORS.containsKey(key)) {
      return WalletConnectError(
        code: INTERNAL_ERRORS[key]!['code']! as int,
        message: context != ''
            ? "${INTERNAL_ERRORS[key]!['message']! as String} $context"
            : INTERNAL_ERRORS[key]!['message']! as String,
      );
    }
    return const WalletConnectError(
        code: -1, message: 'UNKNOWN INTERNAL ERROR');
  }

  static WalletConnectError getSdkError(
    String key, {
    String context = '',
  }) {
    if (SDK_ERRORS.containsKey(key)) {
      return WalletConnectError(
        code: SDK_ERRORS[key]!['code']! as int,
        message: context != ''
            ? "${SDK_ERRORS[key]!['message']! as String} $context"
            : SDK_ERRORS[key]!['message']! as String,
      );
    }
    return const WalletConnectError(code: -1, message: 'UNKNOWN SDK ERROR');
  }
}

class WebSocketErrors {
  static const int PROJECT_ID_NOT_FOUND = 401;
  static const int INVALID_PROJECT_ID = 403;
  static const int TOO_MANY_REQUESTS = 1013;
  static const String INVALID_PROJECT_ID_OR_JWT =
      'Invalid project ID or JWT Token';
  static const String INVALID_PROJECT_ID_MESSAGE =
      'Invalid project id. Please check your project id.';
  static const String PROJECT_ID_NOT_FOUND_MESSAGE = 'Project id not found.';
  static const String TOO_MANY_REQUESTS_MESSAGE =
      'Too many requests. Please try again later.';

  static const int SERVER_TERMINATING = 1001;
  static const int CLIENT_STALE = 4008;
  static const int LOAD_REBALANCING = 4010;
}

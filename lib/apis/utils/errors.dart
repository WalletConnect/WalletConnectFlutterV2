import 'package:walletconnect_dart_v2/apis/models/basic_models.dart';

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
  static const WC_METHOD_UNSUPPORTED = 'WC_METHOD_UNSUPPORTED';

  static const SDK_ERRORS = {
    /* ----- INVALID (1xxx) ----- */
    INVALID_METHOD: {
      'message': "Invalid method.",
      'code': 1001,
    },
    INVALID_EVENT: {
      'message': "Invalid event.",
      'code': 1002,
    },
    INVALID_UPDATE_REQUEST: {
      'message': "Invalid update request.",
      'code': 1003,
    },
    INVALID_EXTEND_REQUEST: {
      'message': "Invalid extend request.",
      'code': 1004,
    },
    INVALID_SESSION_SETTLE_REQUEST: {
      'message': "Invalid session settle request.",
      'code': 1005,
    },
    /* ----- UNAUTHORIZED (3xxx) ----- */
    UNAUTHORIZED_METHOD: {
      'message': "Unauthorized method.",
      'code': 3001,
    },
    UNAUTHORIZED_EVENT: {
      'message': "Unauthorized event.",
      'code': 3002,
    },
    UNAUTHORIZED_UPDATE_REQUEST: {
      'message': "Unauthorized update request.",
      'code': 3003,
    },
    UNAUTHORIZED_EXTEND_REQUEST: {
      'message': "Unauthorized extend request.",
      'code': 3004,
    },
    /* ----- REJECTED (5xxx) ----- */
    USER_REJECTED: {
      'message': "User rejected.",
      'code': 5000,
    },
    USER_REJECTED_CHAINS: {
      'message': "User rejected chains.",
      'code': 5001,
    },
    USER_REJECTED_METHODS: {
      'message': "User rejected methods.",
      'code': 5002,
    },
    USER_REJECTED_EVENTS: {
      'message': "User rejected events.",
      'code': 5003,
    },
    UNSUPPORTED_CHAINS: {
      'message': "Unsupported chains.",
      'code': 5100,
    },
    UNSUPPORTED_METHODS: {
      'message': "Unsupported methods.",
      'code': 5101,
    },
    UNSUPPORTED_EVENTS: {
      'message': "Unsupported events.",
      'code': 5102,
    },
    UNSUPPORTED_ACCOUNTS: {
      'message': "Unsupported accounts.",
      'code': 5103,
    },
    UNSUPPORTED_NAMESPACE_KEY: {
      'message': "Unsupported namespace key.",
      'code': 5104,
    },
    /* ----- REASON (6xxx) ----- */
    USER_DISCONNECTED: {
      'message': "User disconnected.",
      'code': 6000,
    },
    /* ----- FAILURE (7xxx) ----- */
    SESSION_SETTLEMENT_FAILED: {
      'message': "Session settlement failed.",
      'code': 7000,
    },
    /* ----- PAIRING (10xxx) ----- */
    WC_METHOD_UNSUPPORTED: {
      'message': "Unsupported wc_ method.",
      'code': 10001,
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
      'message': "Not initialized.",
      'code': 1,
    },
    NO_MATCHING_KEY: {
      'message': "No matching key.",
      'code': 2,
    },
    RESTORE_WILL_OVERRIDE: {
      'message': "Restore will override.",
      'code': 3,
    },
    RESUBSCRIBED: {
      'message': "Resubscribed.",
      'code': 4,
    },
    MISSING_OR_INVALID: {
      'message': "Missing or invalid.",
      'code': 5,
    },
    EXPIRED: {
      'message': "Expired.",
      'code': 6,
    },
    UNKNOWN_TYPE: {
      'message': "Unknown type.",
      'code': 7,
    },
    MISMATCHED_TOPIC: {
      'message': "Mismatched topic.",
      'code': 8,
    },
    NON_CONFORMING_NAMESPACES: {
      'message': "Non conforming namespaces.",
      'code': 9,
    },
  };

  static WalletConnectError getInternalError(
    String key, {
    String context = '',
  }) {
    if (INTERNAL_ERRORS.containsKey(key)) {
      return new WalletConnectError(
        code: INTERNAL_ERRORS[key]!['code']! as int,
        message: context != ''
            ? "${INTERNAL_ERRORS[key]!['message']! as String} $context"
            : INTERNAL_ERRORS[key]!['message']! as String,
      );
    }
    return new WalletConnectError(code: -1, message: "UNKNOWN INTERNAL ERROR");
  }

  static WalletConnectError getSdkError(
    String key, {
    String context = '',
  }) {
    if (SDK_ERRORS.containsKey(key)) {
      return new WalletConnectError(
        code: SDK_ERRORS[key]!['code']! as int,
        message: context != ''
            ? "${SDK_ERRORS[key]!['message']! as String} $context"
            : SDK_ERRORS[key]!['message']! as String,
      );
    }
    return new WalletConnectError(code: -1, message: "UNKNOWN SDK ERROR");
  }
}

class WalletConnectConstants {
  static const CORE_PROTOCOL = "wc";
  static const CORE_VERSION = 2;
  static const CORE_CONTEXT = "core";

  static const CORE_STORAGE_PREFIX = '$CORE_PROTOCOL@$CORE_VERSION:$CORE_CONTEXT:';

  static const THIRTY_SECONDS = 30;
  static const ONE_MINUTE = 60;
  static const FIVE_MINUTES = ONE_MINUTE * 5;
  static const ONE_HOUR = ONE_MINUTE * 60;
  static const ONE_DAY = ONE_MINUTE * 24 * 60;
  static const SEVEN_DAYS = ONE_DAY * 7;
  static const THIRTY_DAYS = ONE_DAY * 30;

  static const RELAYER_DEFAULT_PROTOCOL = 'irn';
  static const SDK_VERSION = '2.1.3';
}

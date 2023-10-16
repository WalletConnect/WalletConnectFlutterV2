import 'package:logger/logger.dart';

enum LogLevel {
  verbose,
  debug,
  info,
  warning,
  error,
  wtf,
  nothing;

  Level toLevel() {
    switch (this) {
      case LogLevel.verbose:
        return Level.verbose;
      case LogLevel.debug:
        return Level.debug;
      case LogLevel.info:
        return Level.info;
      case LogLevel.warning:
        return Level.warning;
      case LogLevel.error:
        return Level.error;
      case LogLevel.wtf:
        return Level.wtf;
      default:
        return Level.nothing;
    }
  }
}

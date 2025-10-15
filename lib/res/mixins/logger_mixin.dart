import 'package:flutter/foundation.dart';
import 'package:intl/intl.dart'; // Add this import

enum LogLevel { debug, info, warning, error }

mixin LoggerMixin {
  /// Enable/disable logging globally
  bool get enableLogging => kDebugMode;

  final DateFormat _formatter = DateFormat('yyyy-MM-dd hh:mm:ss a');

  void log(
    String message, {
    LogLevel level = LogLevel.debug,
    String? tag,
    StackTrace? stackTrace,
  }) {
    if (!enableLogging) return;

    final logTag = tag ?? runtimeType.toString();
    final timestamp = _formatter.format(DateTime.now());
    final levelStr = level.toString().split('.').last.toUpperCase();

    final buffer =
        StringBuffer()..writeln('[$timestamp] | [$logTag] $levelStr: $message');

    if (stackTrace != null) {
      buffer.writeln('[$logTag] STACKTRACE:\n$stackTrace');
    }

    // ignore: avoid_print
    print(buffer.toString());
  }

  void logDebug(String message, {String? tag}) =>
      log(message, level: LogLevel.debug, tag: tag);

  void logInfo(String message, {String? tag}) =>
      log(message, level: LogLevel.info, tag: tag);

  void logWarning(String message, {String? tag}) =>
      log(message, level: LogLevel.warning, tag: tag);

  void logError(dynamic error, {StackTrace? stackTrace, String? tag}) => log(
    error.toString(),
    level: LogLevel.error,
    tag: tag,
    stackTrace: stackTrace,
  );
}

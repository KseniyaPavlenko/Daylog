import 'package:flutter/foundation.dart';
import 'package:logging/logging.dart';

// Log mapping https://source.android.com/docs/core/tests/debug/understanding-logging

void setupLog() {
  if (kDebugMode) {
    Logger.root.level = Level.ALL;
  } else {
    Logger.root.level = Level.WARNING;
  }

  Logger.root.onRecord.listen((record) {
    // ignore: avoid_print
    print('${record.level.name}: ${record.time}: ${record.message}');
  });
}

Logger? _instance;

Logger get log {
  if (_instance != null) {
    _instance = createLog(name: 'default');
  }
  return _instance!;
}

Logger createLog({required String name}) {
  final log = Logger(name);
  return log;
}

extension LoggerExt on Logger {
  void wtf(Object? message, [Object? error, StackTrace? stackTrace]) {
    shout(message, error, stackTrace);
  }

  void e(Object? message, [Object? error, StackTrace? stackTrace]) {
    severe(message, error, stackTrace);
  }

  void i(Object? message, [Object? error, StackTrace? stackTrace]) {
    info(message, error, stackTrace);
  }

  void w(Object? message, [Object? error, StackTrace? stackTrace]) {
    warning(message, error, stackTrace);
  }

  void d(Object? message, [Object? error, StackTrace? stackTrace]) {
    fine(message, error, stackTrace);
  }

  void v(Object? message, [Object? error, StackTrace? stackTrace]) {
    finest(message, error, stackTrace);
  }
}

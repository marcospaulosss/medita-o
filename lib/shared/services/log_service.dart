import 'dart:developer' as developer;

class LogService {
  void log(String message, Object? err, StackTrace? trace) {
    developer.log(
      message,
      time: DateTime.now(),
      name: 'LogService',
      error: err,
      stackTrace: trace,
    );

    developer.log(err.toString());
  }
}

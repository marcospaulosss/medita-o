import 'package:cinco_minutos_meditacao/shared/services/log_service.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';

enum ErrorCodes {
  loginGoogleError,
}

class CustomError {
  /// Error message
  String? message;

  /// Error code
  ErrorCodes? code;

  /// Error stack trace
  StackTrace? stackTrace;

  /// Error constructor
  CustomError();

  sendErrorToCrashlytics(
      String? message, ErrorCodes? code, StackTrace? stackTrace) {
    message = message ?? this.message;
    code = code ?? this.code;
    stackTrace = stackTrace ?? this.stackTrace;

    FirebaseCrashlytics.instance.log(message ?? "");
    FirebaseCrashlytics.instance.recordError(message, stackTrace);
    LogService().log(message ?? "", null, stackTrace);
  }
}

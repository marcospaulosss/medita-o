import 'package:cinco_minutos_meditacao/shared/services/log_service.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';

enum ErrorCodes {
  loginGoogleError,
  loginFacebookError,
  loginEmailPasswordError,
  unauthorized,
  timeoutException,
}

class CustomError extends Error {
  /// Error message
  String? message;

  /// Error code
  ErrorCodes? code;

  /// Error stack trace
  StackTrace? stackTrace;

  /// Error constructor
  CustomError();

  CustomError sendErrorToCrashlytics(
      String? message, ErrorCodes? code, StackTrace? stackTrace) {
    this.message = message ?? "";
    this.code = code;
    this.stackTrace = stackTrace;

    FirebaseCrashlytics.instance.log(message ?? "");
    FirebaseCrashlytics.instance.recordError(message, stackTrace);
    LogService().log(message ?? "", null, stackTrace);

    return this;
  }
}

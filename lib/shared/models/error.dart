import 'package:cinco_minutos_meditacao/shared/services/log_service.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';

enum ErrorCodes {
  loginGoogleError,
}

class CustomError {
  /// Error message
  final String message;

  /// Error code
  final ErrorCodes code;

  /// Stack trace
  final StackTrace stackTrace;

  /// Error constructor
  /// - [message] is the error message
  /// - [code] is the error code
  /// - [stackTrace] is the stack trace
  CustomError(
      {required this.message, required this.code, required this.stackTrace});

  sendErrorToCrashlytics() {
    FirebaseCrashlytics.instance.log(message);
    FirebaseCrashlytics.instance.recordError(message, stackTrace);
    LogService().log(message, null, stackTrace);
  }

  /// Error.fromJson factory
  factory CustomError.fromJson(Map<String, dynamic> json) {
    return CustomError(
      message: json['message'],
      code: json['code'],
      stackTrace: json['stackTrace'],
    );
  }
}

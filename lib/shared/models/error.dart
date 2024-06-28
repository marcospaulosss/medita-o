import 'package:cinco_minutos_meditacao/shared/services/log_service.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';

enum ErrorCodes {
  loginGoogleError,
  loginFacebookError,
  loginEmailPasswordError,
  alreadyRegistered,
  unauthorized,
  timeoutException,
  badRequest,
  registerError,
}

class CustomError extends Error {
  /// Error message
  String? message;

  /// Error code
  ErrorCodes? code;

  /// Error stack trace
  @override
  StackTrace? stackTrace;

  /// Error constructor
  CustomError();

  static final Map<ErrorCodes, String> _defaultMessages = {
    ErrorCodes.loginGoogleError: "Erro ao fazer login com o Google.",
    ErrorCodes.loginFacebookError: "Erro ao fazer login com o Facebook.",
    ErrorCodes.loginEmailPasswordError: "Erro ao fazer login com email e senha.",
    ErrorCodes.unauthorized: "Usuário não autorizado.",
    ErrorCodes.timeoutException: "Tempo de resposta excedido.",
    ErrorCodes.badRequest: "Parametros inválidos.",
    ErrorCodes.alreadyRegistered: "Usuário já cadastrado.",
    ErrorCodes.registerError: "Erro ao realizar cadastro.",
  };

  CustomError sendErrorToCrashlytics({
      String? message, ErrorCodes? code, StackTrace? stackTrace}) {
    this.code = code;
    this.message = message ?? _defaultMessages[code] ?? "Erro desconhecido.";
    this.stackTrace = stackTrace;

    FirebaseCrashlytics.instance.log(this.message ?? "");
    FirebaseCrashlytics.instance.recordError(this.message, stackTrace);
    LogService().log(this.message ?? "", null, stackTrace);

    return this;
  }

  String get getErrorMessage {
    return message ?? _defaultMessages[code] ?? "Erro desconhecido.";
  }
}

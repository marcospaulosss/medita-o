import 'package:cinco_minutos_meditacao/shared/services/log_service.dart';
import 'package:dio/dio.dart';
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
  getMeError,
  getMeditionsError,
  createNewMeditationError,
  createNewEventCalendar,
  cameraError,
  getCalendarError,
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
    ErrorCodes.loginEmailPasswordError:
        "Erro ao fazer login com email e senha.",
    ErrorCodes.unauthorized: "Usuário não autorizado.",
    ErrorCodes.timeoutException: "Tempo de resposta excedido.",
    ErrorCodes.badRequest: "Parametros inválidos.",
    ErrorCodes.alreadyRegistered: "Usuário já cadastrado.",
    ErrorCodes.registerError: "Erro ao realizar cadastro.",
    ErrorCodes.getMeError: "Erro ao obter informações do usuário.",
    ErrorCodes.getMeditionsError: "Erro ao obter meditações.",
    ErrorCodes.createNewMeditationError: "Erro ao criar nova meditação.",
    ErrorCodes.createNewEventCalendar:
        "Erro ao criar um novo evento no calendário.",
    ErrorCodes.cameraError: "Erro ao acessar a câmera.",
    ErrorCodes.getCalendarError: "Erro ao acessar o calendário.",
  };

  CustomError sendErrorToCrashlytics(
      {String? message,
      ErrorCodes? code,
      StackTrace? stackTrace,
      DioException? dioException}) {
    this.code = code;
    this.message = message ?? _defaultMessages[code] ?? "Erro desconhecido.";
    this.stackTrace = stackTrace;

    if (dioException != null) {
      FirebaseCrashlytics.instance.log(dioException.message ?? "");
      FirebaseCrashlytics.instance.recordError(dioException, stackTrace);
      LogService().log(dioException.message!, null, stackTrace);
    }

    FirebaseCrashlytics.instance.log(this.message ?? "");
    FirebaseCrashlytics.instance.recordError(this.message, stackTrace);
    LogService().log(this.message ?? "", null, stackTrace);

    return this;
  }

  String get getErrorMessage {
    return message ?? _defaultMessages[code] ?? "Erro desconhecido.";
  }
}

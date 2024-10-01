import 'dart:async';

import 'package:cinco_minutos_meditacao/core/analytics/manager.dart';
import 'package:cinco_minutos_meditacao/core/wrappers/secure_storage.dart';
import 'package:cinco_minutos_meditacao/modules/authentication/analytics/events.dart';
import 'package:cinco_minutos_meditacao/modules/authentication/screens/register/register_contracts.dart';
import 'package:cinco_minutos_meditacao/shared/clients/client_api.dart';
import 'package:cinco_minutos_meditacao/shared/clients/models/requests/auth_request.dart';
import 'package:cinco_minutos_meditacao/shared/clients/models/responses/register_response.dart';
import 'package:cinco_minutos_meditacao/shared/models/error.dart';
import 'package:dio/dio.dart';

class RegisterRepository extends Repository {
  /// Gerenciador de analytics
  final AnalyticsManager _analyticsManager;

  /// Cliente de autenticação social
  final ClientApi _clientApi;

  /// Erro customizado
  final CustomError _error;

  /// Armazenamento seguro
  final SecureStorage _secureStorage;

  /// - [_analyticsManager] : Gerenciador de analytics
  /// - [_socialClientApi] : Cliente de autenticação social
  /// - [_error] : Erro customizado
  /// - [_secureStorage] : Armazenamento seguro
  RegisterRepository(
    this._analyticsManager,
    this._clientApi,
    this._error,
    this._secureStorage,
  );

  /// Envia o evento de analytics associado a tela de cadastro do usuário
  @override
  void sendOpenScreenEvent() {
    _analyticsManager.sendEvent(AuthenticationEvents.registerScreenOpened);
  }

  @override
  Future<CustomError?> requestRegister(AuthRequest authRequest) async {
    try {
      RegisterResponse response = await _clientApi.register(authRequest);

      await _secureStorage.setTokenAPI(response.token!);
      await _secureStorage.setIsLogged(true);

      return null;
    } on TimeoutException {
      return _error.sendErrorToCrashlytics(
          code: ErrorCodes.timeoutException, stackTrace: StackTrace.current);
    } on DioException catch (e) {
      switch (e.response?.statusCode) {
        case 422:
          _error.code = ErrorCodes.alreadyRegistered;
          return _error;
        case 400:
          _error.code = ErrorCodes.badRequest;
          _error.message = e.response?.data['message'];
          return _error;
        default:
          return _error.sendErrorToCrashlytics(
              code: ErrorCodes.registerError,
              stackTrace: StackTrace.current,
              dioException: e);
      }
    } catch (e) {
      return _error.sendErrorToCrashlytics(
          code: ErrorCodes.registerError, stackTrace: StackTrace.current);
    }
  }
}

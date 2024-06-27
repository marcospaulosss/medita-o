import 'dart:async';

import 'package:cinco_minutos_meditacao/core/analytics/manager.dart';
import 'package:cinco_minutos_meditacao/core/wrappers/secure_storage.dart';
import 'package:cinco_minutos_meditacao/modules/authentication/analytics/events.dart';
import 'package:cinco_minutos_meditacao/shared/clients/client_api.dart';
import 'package:cinco_minutos_meditacao/shared/clients/models/auth_request.dart';
import 'package:cinco_minutos_meditacao/modules/authentication/screens/login/login_contracts.dart';
import 'package:cinco_minutos_meditacao/shared/clients/models/authenticate_google_request.dart';
import 'package:cinco_minutos_meditacao/shared/clients/models/authenticate_google_response.dart';
import 'package:cinco_minutos_meditacao/shared/models/error.dart';
import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';

class LoginRepository extends Repository {
  /// Gerenciador de analytics
  final AnalyticsManager _analyticsManager;

  /// Cliente de autenticação social
  final ClientApi _clientApi;

  /// Armazenamento seguro
  final SecureStorage _secureStorage;

  /// - [_analyticsManager] : Gerenciador de analytics
  /// - [_socialClientApi] : Cliente de autenticação social
  /// - [_secureStorage] : Armazenamento seguro
  LoginRepository(
    this._analyticsManager,
    this._clientApi,
    this._secureStorage,
  );

  /// Envia o evento de analytics associado a tela de login
  @override
  void sendOpenScreenEvent() {
    _analyticsManager.sendEvent(AuthenticationEvents.loginScreenOpened);
  }

  /// Autentica o usuário utilizando o Google
  @override
  Future<Object?> authenticateUserByGoogle(AuthCredential credential) async {
    AuthenticateGoogleRequest request =
        AuthenticateGoogleRequest(idToken: credential.accessToken);

    try {
      AuthenticateGoogleResponse response =
          await _clientApi.authGoogle(request);

      await _secureStorage.setTokenAPI(response.token!);
      await _secureStorage.setIsLogged(true);

      return null;
    } on TimeoutException {
      return FlutterError("Tempo de conexão excedido");
    } on DioException catch (e) {
      if (e.response != null && e.response!.statusCode == 401) {
        await _secureStorage.setIsLogged(false);

        return null;
      }

      return e.error;
    } catch (e) {
      return e;
    }
  }

  @override
  Future<CustomError?> authenticateUserByEmailPassword(AuthRequest authRequest) async {
    try {
      await _clientApi.login(authRequest);

      return null;
    } on TimeoutException {
      return Future.error(FlutterError("Tempo de conexão excedido"));
    } on DioException catch (e) {
      if (e.response != null && e.response!.statusCode == 401) {
        await _secureStorage.setIsLogged(false);

        var error = CustomError();
        error.code = ErrorCodes.unauthorized;
        return error;
      }

      return CustomError().sendErrorToCrashlytics(
          "Erro ao realizar login com e-mail e senha",
          ErrorCodes.loginEmailPasswordError,
          e.stackTrace);
    } catch (e) {
      return CustomError().sendErrorToCrashlytics(
          "Erro ao realizar login com e-mail e senha",
          ErrorCodes.loginEmailPasswordError,
          StackTrace.current);
    }
  }
}

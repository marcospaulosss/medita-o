import 'dart:async';

import 'package:cinco_minutos_meditacao/core/analytics/manager.dart';
import 'package:cinco_minutos_meditacao/core/wrappers/secure_storage.dart';
import 'package:cinco_minutos_meditacao/modules/authentication/analytics/events.dart';
import 'package:cinco_minutos_meditacao/modules/authentication/screens/login/login_contracts.dart';
import 'package:cinco_minutos_meditacao/shared/clients/models/authenticate_google_request.dart';
import 'package:cinco_minutos_meditacao/shared/clients/models/authenticate_google_response.dart';
import 'package:cinco_minutos_meditacao/shared/clients/social_client_api.dart';
import 'package:cinco_minutos_meditacao/shared/models/error.dart';
import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';

class LoginRepository extends Repository {
  /// Gerenciador de analytics
  final AnalyticsManager _analyticsManager;

  /// Cliente de autenticação social
  final SocialClientApi _socialClientApi;

  /// Armazenamento seguro
  final SecureStorage _secureStorage;

  /// - [_analyticsManager] : Gerenciador de analytics
  /// - [_socialClientApi] : Cliente de autenticação social
  /// - [_secureStorage] : Armazenamento seguro
  LoginRepository(
    this._analyticsManager,
    this._socialClientApi,
    this._secureStorage,
  );

  /// Envia o evento de analytics associado a tela de login
  @override
  void sendOpenScreenEvent() {
    _analyticsManager.sendEvent(AuthenticationEvents.loginScreenOpened);
  }

  /// Autentica o usuário utilizando o Google
  @override
  Future<CustomError?> authenticateUserByGoogle(
      AuthCredential credential) async {
    AuthenticateGoogleRequest request =
        AuthenticateGoogleRequest(idToken: credential.accessToken);

    try {
      AuthenticateGoogleResponse response =
          await _socialClientApi.authGoogle(request);

      await _secureStorage.setTokenAPI(response.token!);
      await _secureStorage.setIsLogged(true);

      return null;
    } on TimeoutException {
      return CustomError(
        message: 'Timeout ao tentar autenticar com o Google',
        code: ErrorCodes.loginGoogleError,
        stackTrace: StackTrace.current,
      );
    } on DioException catch (e, stacktrace) {
      if (e.response != null && e.response!.statusCode == 401) {
        await _secureStorage.setIsLogged(false);

        return null;
      }

      return CustomError(
        message: e.message.toString(),
        code: ErrorCodes.loginGoogleError,
        stackTrace: stacktrace,
      );
    } catch (e, stacktrace) {
      return CustomError(
        message: 'Erro desconhecido ao autenticar com o Google',
        code: ErrorCodes.loginGoogleError,
        stackTrace: stacktrace,
      );
    }
  }
}

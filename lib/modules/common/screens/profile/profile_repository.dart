import 'dart:async';
import 'dart:io';

import 'package:cinco_minutos_meditacao/core/analytics/manager.dart';
import 'package:cinco_minutos_meditacao/core/wrappers/secure_storage.dart';
import 'package:cinco_minutos_meditacao/modules/common/analytics/events.dart';
import 'package:cinco_minutos_meditacao/modules/common/screens/profile/profile_contract.dart';
import 'package:cinco_minutos_meditacao/shared/clients/client_api.dart';
import 'package:cinco_minutos_meditacao/shared/clients/models/responses/user_response.dart';
import 'package:cinco_minutos_meditacao/shared/models/error.dart';
import 'package:dio/dio.dart';

class ProfileRepository implements Repository {
  /// Analytics
  final AnalyticsManager _analytics;

  /// Cliente de autenticação social
  final ClientApi _clientApi;

  /// Erro customizado
  final CustomError _error;

  /// Secure Storage
  final SecureStorage _secureStorage;

  /// - [analytics] : Analytics
  /// - [clientApi] : Cliente de autenticação social
  /// - [error] : Erro customizado
  /// - [secureStorage] : Secure Storage
  /// construtor
  ProfileRepository(
    this._analytics,
    this._clientApi,
    this._error,
    this._secureStorage,
  );

  /// envia o evento de tela aberta
  @override
  void sendOpenScreenEvent() {
    _analytics.sendEvent(CommonEvents.profileScreenOpened);
  }

  /// efetua o logout do usuário
  @override
  void logOut() {
    _secureStorage.setIsLogged(false);
  }

  /// Busca informações do usuário
  @override
  Future<(UserResponse?, CustomError?)> requestUser() async {
    try {
      UserResponse response = await _clientApi.user();

      await _saveUserToSecureStorage(response);

      return (response, null);
    } on TimeoutException {
      return (null, _handleTimeoutError());
    } on DioException catch (e) {
      return (null, _handleDioError(e));
    } catch (e, stackTrace) {
      return (null, _handleGenericError(stackTrace));
    }
  }

  /// Atualiza a imagem de perfil do usuário
  @override
  Future<CustomError?> uploadImageProfile(File file) async {
    try {
      await _clientApi.uploadPhoto(file);

      return null;
    } on TimeoutException {
      return _handleTimeoutError();
    } on DioException catch (e) {
      return _handleDioError(e);
    } catch (e, stackTrace) {
      return _handleGenericError(stackTrace);
    }
  }

  Future<void> _saveUserToSecureStorage(UserResponse response) async {
    await _secureStorage.setUserId(response.id.toString());
    await _secureStorage.setUserName(response.name);
    await _secureStorage.setUserEmail(response.email);
    await _secureStorage.setGoogleId(response.googleId ?? "");
  }

  CustomError _handleTimeoutError() {
    return _error.sendErrorToCrashlytics(
      code: ErrorCodes.timeoutException,
      stackTrace: StackTrace.current,
    );
  }

  CustomError _handleDioError(DioException e) {
    return _error.sendErrorToCrashlytics(
      code: ErrorCodes.getMeError,
      stackTrace: StackTrace.current,
      dioException: e,
    );
  }

  CustomError _handleGenericError(StackTrace stackTrace) {
    return _error.sendErrorToCrashlytics(
      code: ErrorCodes.getMeError,
      stackTrace: stackTrace,
    );
  }
}

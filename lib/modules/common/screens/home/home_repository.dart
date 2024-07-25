import 'dart:async';
import 'dart:io';

import 'package:cinco_minutos_meditacao/core/analytics/manager.dart';
import 'package:cinco_minutos_meditacao/core/wrappers/secure_storage.dart';
import 'package:cinco_minutos_meditacao/modules/common/analytics/events.dart';
import 'package:cinco_minutos_meditacao/modules/common/screens/home/home_contract.dart';
import 'package:cinco_minutos_meditacao/shared/clients/client_api.dart';
import 'package:cinco_minutos_meditacao/shared/clients/models/responses/meditations_response.dart';
import 'package:cinco_minutos_meditacao/shared/clients/models/responses/user_response.dart';
import 'package:cinco_minutos_meditacao/shared/models/error.dart';
import 'package:dio/dio.dart';

class HomeRepository implements Repository {
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
  HomeRepository(
      this._analytics, this._clientApi, this._error, this._secureStorage);

  /// envia o evento de tela aberta
  @override
  void sendOpenScreenEvent() {
    _analytics.sendEvent(CommonEvents.homeScreenOpened);
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

      await _secureStorage.setUserId(response.id);
      await _secureStorage.setUserName(response.name);
      await _secureStorage.setUserEmail(response.email);
      await _secureStorage.setGoogleId(response.googleId);

      return (response, null);
    } on TimeoutException {
      return (
        null,
        _error.sendErrorToCrashlytics(
            code: ErrorCodes.timeoutException, stackTrace: StackTrace.current)
      );
    } on DioException catch (e) {
      return (
        null,
        _error.sendErrorToCrashlytics(
          code: ErrorCodes.getMeError,
          stackTrace: StackTrace.current,
        )
      );
    } catch (e) {
      return (
        null,
        _error.sendErrorToCrashlytics(
            code: ErrorCodes.getMeError, stackTrace: StackTrace.current)
      );
    }
  }

  /// Atualiza a imagem de perfil do usuário
  @override
  Future<CustomError?> uploadImageProfile(File file) async {
    try {
      await _clientApi.uploadPhoto(file);

      return null;
    } on TimeoutException {
      return _error.sendErrorToCrashlytics(
          code: ErrorCodes.timeoutException, stackTrace: StackTrace.current);
    } on DioException catch (e) {
      return _error.sendErrorToCrashlytics(
        code: ErrorCodes.getMeError,
        stackTrace: StackTrace.current,
      );
    } catch (e) {
      return _error.sendErrorToCrashlytics(
          code: ErrorCodes.getMeError, stackTrace: StackTrace.current);
    }
  }

  @override
  Future<(MeditationsResponse?, CustomError?)> requestMeditations() async {
    try {
      MeditationsResponse response = await _clientApi.meditations();

      return (response, null);
    } on TimeoutException {
      return (
        null,
        _error.sendErrorToCrashlytics(
            code: ErrorCodes.timeoutException, stackTrace: StackTrace.current)
      );
    } on DioException catch (e) {
      return (
        null,
        _error.sendErrorToCrashlytics(
          code: ErrorCodes.getMeditionsError,
          stackTrace: StackTrace.current,
        )
      );
    } catch (e) {
      return (
        null,
        _error.sendErrorToCrashlytics(
            code: ErrorCodes.getMeError, stackTrace: StackTrace.current)
      );
    }
  }
}

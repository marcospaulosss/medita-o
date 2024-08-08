import 'dart:async';
import 'dart:io';

import 'package:cinco_minutos_meditacao/core/analytics/manager.dart';
import 'package:cinco_minutos_meditacao/core/wrappers/secure_storage.dart';
import 'package:cinco_minutos_meditacao/modules/meditate/analytics/events.dart';
import 'package:cinco_minutos_meditacao/shared/clients/client_api.dart';
import 'package:cinco_minutos_meditacao/shared/clients/models/responses/meditations_response.dart';
import 'package:cinco_minutos_meditacao/shared/clients/models/responses/user_response.dart';
import 'package:cinco_minutos_meditacao/shared/models/error.dart';
import 'package:dio/dio.dart';

import 'meditate_info_contract.dart';

class MeditateInfoRepository implements Repository {
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
  MeditateInfoRepository(
    this._analytics,
    this._clientApi,
    this._error,
    this._secureStorage,
  );

  /// envia o evento de tela aberta
  @override
  void sendOpenScreenEvent() {
    _analytics.sendEvent(MeditateEvents.informationMethodScreenOpened);
  }

  /// Busca informações do usuário
  @override
  Future<(UserResponse?, CustomError?)> requestUser() async {
    try {
      UserResponse response = await _clientApi.user();

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
  Future<(MeditationsResponse?, CustomError?)>
      requestMeditationsByUser() async {
    try {
      String id = await _secureStorage.userId;

      MeditationsResponse response =
          await _clientApi.meditationsByUser(id.toString());

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
            code: ErrorCodes.getMeditionsError, stackTrace: StackTrace.current)
      );
    }
  }
}

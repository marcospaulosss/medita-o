import 'dart:async';
import 'dart:io';

import 'package:cinco_minutos_meditacao/core/analytics/manager.dart';
import 'package:cinco_minutos_meditacao/core/wrappers/secure_storage.dart';
import 'package:cinco_minutos_meditacao/modules/meditometer/analytics/events.dart';
import 'package:cinco_minutos_meditacao/shared/clients/client_api.dart';
import 'package:cinco_minutos_meditacao/shared/clients/models/responses/meditations_response.dart';
import 'package:cinco_minutos_meditacao/shared/clients/models/responses/month_calendar_response.dart';
import 'package:cinco_minutos_meditacao/shared/clients/models/responses/user_response.dart';
import 'package:cinco_minutos_meditacao/shared/clients/models/responses/week_calendar_response.dart';
import 'package:cinco_minutos_meditacao/shared/clients/models/responses/year_calendar_response.dart';
import 'package:cinco_minutos_meditacao/shared/models/error.dart';
import 'package:dio/dio.dart';

import 'calendar_contract.dart';

class CalendarRepository implements Repository {
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
  CalendarRepository(
      this._analytics, this._clientApi, this._error, this._secureStorage);

  /// envia o evento de tela aberta
  @override
  void sendOpenScreenEvent() {
    _analytics.sendEvent(MeditometerEvents.meditometerScreenOpened);
  }

  /// Busca informações do usuário
  @override
  Future<(UserResponse?, CustomError?)> requestUser() async {
    try {
      UserResponse response = await _clientApi.user();

      await _secureStorage.setUserId(response.id.toString());
      await _secureStorage.setUserName(response.name);
      await _secureStorage.setUserEmail(response.email);
      await _secureStorage.setGoogleId(response.googleId ?? "");

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
          dioException: e,
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

  /// Busca a quantidade de meditações realizadas no mundo
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
          dioException: e,
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
        dioException: e,
      );
    } catch (e) {
      return _error.sendErrorToCrashlytics(
          code: ErrorCodes.getMeError, stackTrace: StackTrace.current);
    }
  }

  @override
  Future<(WeekCalendarResponse?, CustomError?)> requestCalendarWeek(
      String date) async {
    try {
      WeekCalendarResponse weekCalendar = await _clientApi.calendarWeek(date);

      return (weekCalendar, null);
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
          code: ErrorCodes.getCalendarError,
          stackTrace: StackTrace.current,
          dioException: e,
        )
      );
    } catch (e) {
      return (
        null,
        _error.sendErrorToCrashlytics(
          code: ErrorCodes.getCalendarError,
          stackTrace: StackTrace.current,
        )
      );
    }
  }

  @override
  Future<(MonthCalendarResponse?, CustomError?)> requestCalendarMonth(
      String date) async {
    try {
      int month = int.parse(date.split('-')[1]);
      int year = int.parse(date.split('-')[0]);
      MonthCalendarResponse monthCalendar =
          await _clientApi.calendarMonth(month, year);

      return (monthCalendar, null);
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
          code: ErrorCodes.getCalendarError,
          stackTrace: StackTrace.current,
          dioException: e,
        )
      );
    } catch (e) {
      return (
        null,
        _error.sendErrorToCrashlytics(
          code: ErrorCodes.getCalendarError,
          stackTrace: StackTrace.current,
        )
      );
    }
  }

  @override
  Future<(YearCalendarResponse?, CustomError?)> requestCalendarYear(
      String date) async {
    try {
      int year = int.parse(date.split('-')[0]);
      YearCalendarResponse yearCalendar = await _clientApi.calendarYear(year);

      return (yearCalendar, null);
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
          code: ErrorCodes.getCalendarError,
          stackTrace: StackTrace.current,
          dioException: e,
        )
      );
    } catch (e) {
      return (
        null,
        _error.sendErrorToCrashlytics(
          code: ErrorCodes.getCalendarError,
          stackTrace: StackTrace.current,
        )
      );
    }
  }

  /// Busca a imagem para compartilhamento nas redes sociais
  @override
  Future<(String?, CustomError?)> getTokenApi() async {
    try {
      String token = await _secureStorage.tokenAPI;
      return (token, null);
    } catch (e) {
      return (
        null,
        _error.sendErrorToCrashlytics(
            code: ErrorCodes.getTokenApiError, stackTrace: StackTrace.current)
      );
    }
  }
}

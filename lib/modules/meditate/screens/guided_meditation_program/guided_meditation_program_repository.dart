import 'dart:async';

import 'package:cinco_minutos_meditacao/core/analytics/manager.dart';
import 'package:cinco_minutos_meditacao/core/wrappers/secure_storage.dart';
import 'package:cinco_minutos_meditacao/modules/meditate/analytics/events.dart';
import 'package:cinco_minutos_meditacao/shared/clients/client_api.dart';
import 'package:cinco_minutos_meditacao/shared/clients/models/requests/create_new_meditations_request.dart';
import 'package:cinco_minutos_meditacao/shared/models/error.dart';
import 'package:dio/dio.dart';

import 'guided_meditation_program_contract.dart';

class GuidedMeditationProgramRepository implements Repository {
  /// Analytics
  final AnalyticsManager _analytics;

  /// client api
  final ClientApi _clientApi;

  /// Erro customizado
  final CustomError error;

  /// secure storage
  final SecureStorage _secureStorage;

  /// - [analytics] : Analytics
  /// - [clientApi] : ClientApi
  /// - [error] : CustomError
  /// - [secureStorage] : SecureStorage
  /// construtor
  GuidedMeditationProgramRepository(
    this._analytics,
    this._clientApi,
    this.error,
    this._secureStorage,
  );

  /// envia o evento de tela aberta
  @override
  void sendOpenScreenEvent() {
    _analytics.sendEvent(MeditateEvents.guidedMeditationProgramScreenOpened);
  }

  @override
  Future<void> requestRegisterMeditateCompleted(int time) async {
    try {
      String userId = await _secureStorage.userId;
      CreateNewMeditationsRequest request = CreateNewMeditationsRequest(
        numPeople: int.parse(userId),
        minutes: time,
        type: "padrao",
        date: DateTime.now().toIso8601String(),
      );

      await _clientApi.createNewMeditation(request);
    } on TimeoutException {
      error.sendErrorToCrashlytics(
          code: ErrorCodes.timeoutException, stackTrace: StackTrace.current);
    } on DioException catch (e) {
      error.sendErrorToCrashlytics(
        code: ErrorCodes.createNewMeditationError,
        stackTrace: StackTrace.current,
      );
    } catch (e) {
      error.sendErrorToCrashlytics(
          code: ErrorCodes.createNewMeditationError,
          stackTrace: StackTrace.current);
    }
  }
}

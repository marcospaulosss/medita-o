import 'dart:async';

import 'package:cinco_minutos_meditacao/core/analytics/manager.dart';
import 'package:cinco_minutos_meditacao/core/wrappers/secure_storage.dart';
import 'package:cinco_minutos_meditacao/modules/meditate/screens/guided_meditation_program/guided_meditation_program_repository.dart';
import 'package:cinco_minutos_meditacao/shared/clients/client_api.dart';
import 'package:cinco_minutos_meditacao/shared/models/error.dart';
import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'guided_meditation_program_repository_test.mocks.dart';

@GenerateMocks([AnalyticsManager, ClientApi, CustomError, SecureStorage])
void main() {
  group('GuidedMeditationProgramRepository', () {
    late GuidedMeditationProgramRepository repository;
    late MockAnalyticsManager analytics;
    late MockClientApi clientApi;
    late MockCustomError error;
    late MockSecureStorage secureStorage;

    setUp(() {
      analytics = MockAnalyticsManager();
      clientApi = MockClientApi();
      error = MockCustomError();
      secureStorage = MockSecureStorage();
      repository = GuidedMeditationProgramRepository(
          analytics, clientApi, error, secureStorage);
    });

    test('should send open screen event', () {
      when(analytics.sendEvent(any)).thenReturn(null);

      repository.sendOpenScreenEvent();

      verify(analytics.sendEvent(any)).called(1);
    });

    test('should request register meditate completed', () async {
      when(secureStorage.userId).thenAnswer((_) async => '1');
      when(clientApi.createNewMeditation(any)).thenAnswer((_) async {});

      await repository.requestRegisterMeditateCompleted(5);

      verify(secureStorage.userId).called(1);
      verify(clientApi.createNewMeditation(any)).called(1);
    });

    test(
        'should request register meditate completed and throw timeout exception',
        () async {
      when(secureStorage.userId).thenAnswer((_) async => '1');
      when(clientApi.createNewMeditation(any))
          .thenThrow(TimeoutException('timeout'));
      when(error.sendErrorToCrashlytics(
        code: ErrorCodes.timeoutException,
        stackTrace: anyNamed('stackTrace'),
      )).thenReturn(error);

      await repository.requestRegisterMeditateCompleted(5);

      verify(secureStorage.userId).called(1);
      verify(clientApi.createNewMeditation(any)).called(1);
      verify(error.sendErrorToCrashlytics(
        code: ErrorCodes.timeoutException,
        stackTrace: anyNamed('stackTrace'),
      )).called(1);
    });

    test('should request register meditate completed and throw dio exception',
        () async {
      when(secureStorage.userId).thenAnswer((_) async => '1');
      when(clientApi.createNewMeditation(any)).thenThrow(DioException(
          response: Response(requestOptions: RequestOptions(path: '')),
          requestOptions: RequestOptions(path: '')));
      when(error.sendErrorToCrashlytics(
        code: ErrorCodes.createNewMeditationError,
        stackTrace: anyNamed('stackTrace'),
        dioException: anyNamed('dioException'),
      )).thenReturn(error);

      await repository.requestRegisterMeditateCompleted(5);

      verify(secureStorage.userId).called(1);
      verify(clientApi.createNewMeditation(any)).called(1);
      verify(error.sendErrorToCrashlytics(
        code: ErrorCodes.createNewMeditationError,
        stackTrace: anyNamed('stackTrace'),
        dioException: anyNamed('dioException'),
      )).called(1);
    });

    test(
        'should request register meditate completed and throw generic exception',
        () async {
      when(secureStorage.userId).thenAnswer((_) async => '1');
      when(clientApi.createNewMeditation(any)).thenThrow(Exception());
      when(error.sendErrorToCrashlytics(
        code: ErrorCodes.createNewMeditationError,
        stackTrace: anyNamed('stackTrace'),
      )).thenReturn(error);

      await repository.requestRegisterMeditateCompleted(5);

      verify(secureStorage.userId).called(1);
      verify(clientApi.createNewMeditation(any)).called(1);
      verify(error.sendErrorToCrashlytics(
        code: ErrorCodes.createNewMeditationError,
        stackTrace: anyNamed('stackTrace'),
      )).called(1);
    });
  });
}

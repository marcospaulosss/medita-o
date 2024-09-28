import 'dart:async';
import 'dart:io';

import 'package:cinco_minutos_meditacao/core/analytics/manager.dart';
import 'package:cinco_minutos_meditacao/core/wrappers/secure_storage.dart';
import 'package:cinco_minutos_meditacao/modules/meditometer/screens/meditometer/meditometer_repository.dart';
import 'package:cinco_minutos_meditacao/shared/clients/client_api.dart';
import 'package:cinco_minutos_meditacao/shared/clients/models/responses/meditations_response.dart';
import 'package:cinco_minutos_meditacao/shared/clients/models/responses/user_response.dart';
import 'package:cinco_minutos_meditacao/shared/models/error.dart';
import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'meditometer_repository_test.mocks.dart';

@GenerateMocks([AnalyticsManager, ClientApi, CustomError, SecureStorage])
void main() {
  group('MeditometerRepository', () {
    late MeditometerRepository repository;
    late MockAnalyticsManager analytics;
    late MockClientApi clientApi;
    late MockCustomError error;
    late MockSecureStorage secureStorage;

    setUp(() {
      analytics = MockAnalyticsManager();
      clientApi = MockClientApi();
      error = MockCustomError();
      secureStorage = MockSecureStorage();
      repository =
          MeditometerRepository(analytics, clientApi, error, secureStorage);
    });

    test('should send open screen event', () {
      when(analytics.sendEvent(any)).thenReturn(null);

      repository.sendOpenScreenEvent();

      verify(analytics.sendEvent(any)).called(1);
    });

    test('should request user successfully', () async {
      final userResponse = UserResponse(
          1,
          'Test',
          'test@example.com',
          '12345',
          '12345',
          '12345',
          './assets/images/avatar.png',
          '2024-09-28',
          '2024-09-28');
      when(clientApi.user()).thenAnswer((_) async => userResponse);

      final result = await repository.requestUser();

      expect(result, (userResponse, null));
      verify(secureStorage.setUserId(userResponse.id.toString())).called(1);
      verify(secureStorage.setUserName(userResponse.name)).called(1);
      verify(secureStorage.setUserEmail(userResponse.email)).called(1);
      verify(secureStorage.setGoogleId(userResponse.googleId)).called(1);
    });

    test('should handle timeout exception on request user', () async {
      when(clientApi.user()).thenThrow(TimeoutException('timeout'));
      when(error.sendErrorToCrashlytics(
        code: ErrorCodes.timeoutException,
        stackTrace: anyNamed('stackTrace'),
      )).thenReturn(error);

      final result = await repository.requestUser();

      expect(result, (null, error));
      verify(error.sendErrorToCrashlytics(
        code: ErrorCodes.timeoutException,
        stackTrace: anyNamed('stackTrace'),
      )).called(1);
    });

    test('should handle DioException on request user', () async {
      when(clientApi.user())
          .thenThrow(DioException(requestOptions: RequestOptions(path: '')));
      when(error.sendErrorToCrashlytics(
        code: ErrorCodes.getMeError,
        stackTrace: anyNamed('stackTrace'),
      )).thenReturn(error);

      final result = await repository.requestUser();

      expect(result, (null, error));
      verify(error.sendErrorToCrashlytics(
        code: ErrorCodes.getMeError,
        stackTrace: anyNamed('stackTrace'),
      )).called(1);
    });

    test('should handle exception on request user', () async {
      when(clientApi.user())
          .thenThrow(Exception('An error occurred while requesting user'));
      when(error.sendErrorToCrashlytics(
        code: ErrorCodes.getMeError,
        stackTrace: anyNamed('stackTrace'),
      )).thenReturn(error);

      final result = await repository.requestUser();

      expect(result, (null, error));
      verify(error.sendErrorToCrashlytics(
        code: ErrorCodes.getMeError,
        stackTrace: anyNamed('stackTrace'),
      )).called(1);
    });

    test('should request meditations successfully', () async {
      final meditationsResponse = MeditationsResponse(100, 1);
      when(clientApi.meditations())
          .thenAnswer((_) async => meditationsResponse);

      final result = await repository.requestMeditations();

      expect(result, (meditationsResponse, null));
    });

    test('should handle timeout exception on request meditations', () async {
      when(clientApi.meditations()).thenThrow(TimeoutException('timeout'));
      when(error.sendErrorToCrashlytics(
        code: ErrorCodes.timeoutException,
        stackTrace: anyNamed('stackTrace'),
      )).thenReturn(error);

      final result = await repository.requestMeditations();

      expect(result, (null, error));
      verify(error.sendErrorToCrashlytics(
        code: ErrorCodes.timeoutException,
        stackTrace: anyNamed('stackTrace'),
      )).called(1);
    });

    test('should handle DioException on request meditations', () async {
      when(clientApi.meditations())
          .thenThrow(DioException(requestOptions: RequestOptions(path: '')));
      when(error.sendErrorToCrashlytics(
        code: ErrorCodes.getMeditionsError,
        stackTrace: anyNamed('stackTrace'),
      )).thenReturn(error);

      final result = await repository.requestMeditations();

      expect(result, (null, error));
      verify(error.sendErrorToCrashlytics(
        code: ErrorCodes.getMeditionsError,
        stackTrace: anyNamed('stackTrace'),
      )).called(1);
    });

    test('should handle DioException on request meditations', () async {
      when(clientApi.meditations()).thenThrow(
          Exception('An error occurred while requesting meditations'));
      when(error.sendErrorToCrashlytics(
        code: ErrorCodes.getMeditionsError,
        stackTrace: anyNamed('stackTrace'),
      )).thenReturn(error);

      final result = await repository.requestMeditations();

      expect(result, (null, error));
      verify(error.sendErrorToCrashlytics(
        code: ErrorCodes.getMeditionsError,
        stackTrace: anyNamed('stackTrace'),
      )).called(1);
    });

    test('should upload image profile successfully', () async {
      final file = File('path/to/file');
      when(clientApi.uploadPhoto(file)).thenAnswer((_) async => null);

      final result = await repository.uploadImageProfile(file);

      expect(result, null);
      verify(clientApi.uploadPhoto(file)).called(1);
    });

    test('should handle timeout exception on upload image profile', () async {
      final file = File('path/to/file');
      when(clientApi.uploadPhoto(file)).thenThrow(TimeoutException('timeout'));
      when(error.sendErrorToCrashlytics(
        code: ErrorCodes.timeoutException,
        stackTrace: anyNamed('stackTrace'),
      )).thenReturn(error);

      final result = await repository.uploadImageProfile(file);

      expect(result, error);
      verify(error.sendErrorToCrashlytics(
        code: ErrorCodes.timeoutException,
        stackTrace: anyNamed('stackTrace'),
      )).called(1);
    });

    test('should handle DioException on upload image profile', () async {
      final file = File('path/to/file');
      when(clientApi.uploadPhoto(file))
          .thenThrow(DioException(requestOptions: RequestOptions(path: '')));
      when(error.sendErrorToCrashlytics(
        code: ErrorCodes.getMeError,
        stackTrace: anyNamed('stackTrace'),
      )).thenReturn(error);

      final result = await repository.uploadImageProfile(file);

      expect(result, error);
      verify(error.sendErrorToCrashlytics(
        code: ErrorCodes.getMeError,
        stackTrace: anyNamed('stackTrace'),
      )).called(1);
    });

    test('should handle Exception on upload image profile', () async {
      final file = File('path/to/file');
      when(clientApi.uploadPhoto(file))
          .thenThrow(Exception('An error occurred while uploading image'));
      when(error.sendErrorToCrashlytics(
        code: ErrorCodes.getMeError,
        stackTrace: anyNamed('stackTrace'),
      )).thenReturn(error);

      final result = await repository.uploadImageProfile(file);

      expect(result, error);
      verify(error.sendErrorToCrashlytics(
        code: ErrorCodes.getMeError,
        stackTrace: anyNamed('stackTrace'),
      )).called(1);
    });
  });
}

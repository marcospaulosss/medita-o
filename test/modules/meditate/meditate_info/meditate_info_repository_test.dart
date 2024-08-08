import 'dart:async';
import 'dart:io';

import 'package:cinco_minutos_meditacao/core/analytics/manager.dart';
import 'package:cinco_minutos_meditacao/core/wrappers/secure_storage.dart';
import 'package:cinco_minutos_meditacao/modules/meditate/screens/meditate_info/meditate_info_repository.dart';
import 'package:cinco_minutos_meditacao/shared/clients/client_api.dart';
import 'package:cinco_minutos_meditacao/shared/clients/models/responses/meditations_response.dart';
import 'package:cinco_minutos_meditacao/shared/clients/models/responses/user_response.dart';
import 'package:cinco_minutos_meditacao/shared/models/error.dart';
import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'meditate_info_repository_test.mocks.dart';

@GenerateMocks([AnalyticsManager, ClientApi, CustomError, SecureStorage])
void main() {
  group('Meditate Info', () {
    late MockAnalyticsManager analytics;
    late MockClientApi clientApi;
    late MockCustomError error;
    late MockSecureStorage secureStorage;
    late MeditateInfoRepository repository;

    setUp(() {
      analytics = MockAnalyticsManager();
      clientApi = MockClientApi();
      error = MockCustomError();
      secureStorage = MockSecureStorage();
      repository =
          MeditateInfoRepository(analytics, clientApi, error, secureStorage);
    });

    test('sendOpenScreenEvent', () {
      // arrange
      when(analytics.sendEvent(any)).thenReturn(null);

      // act
      repository.sendOpenScreenEvent();

      // assert
      verify(analytics.sendEvent(any));
    });

    test(
        'requestUser should return UserResponse and null error when successful',
        () async {
      // arrange
      final userResponse = UserResponse(1, 'name', 'email', 'photo', 'token', 1,
          'created_at', '', 'updated_at');
      when(clientApi.user()).thenAnswer((_) async => userResponse);

      // act
      final result = await repository.requestUser();

      // assert
      expect(result, (userResponse, null));

      verify(clientApi.user()).called(1);
    });

    test(
        'requestUser should return null and CustomError when DioException is thrown',
        () async {
      // arrange
      when(clientApi.user()).thenThrow(DioException(
          response: Response(requestOptions: RequestOptions(path: 'path')),
          requestOptions: RequestOptions(path: 'path')));
      when(error.sendErrorToCrashlytics(
        code: ErrorCodes.getMeError,
        stackTrace: anyNamed('stackTrace'),
      )).thenReturn(error);

      // act
      final result = await repository.requestUser();

      // assert
      expect(result, (null, error));

      verify(clientApi.user()).called(1);
    });

    test(
        'requestUser should return null and CustomError when TimeoutException is thrown',
        () async {
      // arrange
      when(clientApi.user()).thenThrow(TimeoutException('timeout'));
      when(error.sendErrorToCrashlytics(
        code: ErrorCodes.timeoutException,
        stackTrace: anyNamed('stackTrace'),
      )).thenReturn(error);

      // act
      final result = await repository.requestUser();

      // assert
      expect(result, (null, error));

      verify(clientApi.user()).called(1);
    });

    test(
        'requestUser should return null and CustomError when generic is thrown',
        () async {
      // arrange
      when(clientApi.user()).thenThrow(Exception('generic'));
      when(error.sendErrorToCrashlytics(
        code: ErrorCodes.getMeError,
        stackTrace: anyNamed('stackTrace'),
      )).thenReturn(error);

      // act
      final result = await repository.requestUser();

      // assert
      expect(result, (null, error));

      verify(clientApi.user()).called(1);
    });

    test('uploadImageProfile should return null when successful', () async {
      // arrange
      final file = File('path');
      when(clientApi.uploadPhoto(file)).thenAnswer((_) async => null);

      // act
      final result = await repository.uploadImageProfile(file);

      // assert
      expect(result, null);

      verify(clientApi.uploadPhoto(file)).called(1);
    });

    test(
        'uploadImageProfile should return CustomError when DioException is thrown',
        () async {
      // arrange
      final file = File('path');
      when(clientApi.uploadPhoto(file)).thenThrow(DioException(
          response: Response(requestOptions: RequestOptions(path: 'path')),
          requestOptions: RequestOptions(path: 'path')));
      when(error.sendErrorToCrashlytics(
        code: ErrorCodes.getMeError,
        stackTrace: anyNamed('stackTrace'),
      )).thenReturn(error);

      // act
      final result = await repository.uploadImageProfile(file);

      // assert
      expect(result, error);

      verify(clientApi.uploadPhoto(file)).called(1);
    });

    test(
        'uploadImageProfile should return CustomError when TimeoutException is thrown',
        () async {
      // arrange
      final file = File('path');
      when(clientApi.uploadPhoto(file)).thenThrow(TimeoutException('timeout'));
      when(error.sendErrorToCrashlytics(
        code: ErrorCodes.timeoutException,
        stackTrace: anyNamed('stackTrace'),
      )).thenReturn(error);

      // act
      final result = await repository.uploadImageProfile(file);

      // assert
      expect(result, error);

      verify(clientApi.uploadPhoto(file)).called(1);
    });

    test('uploadImageProfile should return CustomError when generic is thrown',
        () async {
      // arrange
      final file = File('path');
      when(clientApi.uploadPhoto(file)).thenThrow(Exception('generic'));
      when(error.sendErrorToCrashlytics(
        code: ErrorCodes.getMeError,
        stackTrace: anyNamed('stackTrace'),
      )).thenReturn(error);

      // act
      final result = await repository.uploadImageProfile(file);

      // assert
      expect(result, error);

      verify(clientApi.uploadPhoto(file)).called(1);
    });

    test(
        'requestMeditationsByUser should return MeditationsResponse and null error when successful',
        () async {
      // arrange
      final meditationsResponse = MeditationsResponse(1, 30);
      when(secureStorage.userId).thenAnswer((_) async => '1');
      when(clientApi.meditationsByUser('1'))
          .thenAnswer((_) async => meditationsResponse);

      // act
      final result = await repository.requestMeditationsByUser();

      // assert
      expect(result, (meditationsResponse, null));

      verify(secureStorage.userId).called(1);
      verify(clientApi.meditationsByUser('1')).called(1);
    });

    test(
        'requestMeditationsByUser should return null and CustomError when DioException is thrown',
        () async {
      // arrange
      when(secureStorage.userId).thenAnswer((_) async => '1');
      when(clientApi.meditationsByUser('1')).thenThrow(DioException(
          response: Response(requestOptions: RequestOptions(path: 'path')),
          requestOptions: RequestOptions(path: 'path')));
      when(error.sendErrorToCrashlytics(
        code: ErrorCodes.getMeditionsError,
        stackTrace: anyNamed('stackTrace'),
      )).thenReturn(error);

      // act
      final result = await repository.requestMeditationsByUser();

      // assert
      expect(result, (null, error));

      verify(secureStorage.userId).called(1);
      verify(clientApi.meditationsByUser('1')).called(1);
    });

    test(
        'requestMeditationsByUser should return null and CustomError when TimeoutException is thrown',
        () async {
      // arrange
      when(secureStorage.userId).thenAnswer((_) async => '1');
      when(clientApi.meditationsByUser('1'))
          .thenThrow(TimeoutException('timeout'));
      when(error.sendErrorToCrashlytics(
        code: ErrorCodes.timeoutException,
        stackTrace: anyNamed('stackTrace'),
      )).thenReturn(error);

      // act
      final result = await repository.requestMeditationsByUser();

      // assert
      expect(result, (null, error));

      verify(secureStorage.userId).called(1);
      verify(clientApi.meditationsByUser('1')).called(1);
    });

    test(
        'requestMeditationsByUser should return null and CustomError when generic is thrown',
        () async {
      // arrange
      when(secureStorage.userId).thenAnswer((_) async => '1');
      when(clientApi.meditationsByUser('1')).thenThrow(Exception('generic'));
      when(error.sendErrorToCrashlytics(
        code: ErrorCodes.getMeditionsError,
        stackTrace: anyNamed('stackTrace'),
      )).thenReturn(error);

      // act
      final result = await repository.requestMeditationsByUser();

      // assert
      expect(result, (null, error));

      verify(secureStorage.userId).called(1);
      verify(clientApi.meditationsByUser('1')).called(1);
    });
  });
}

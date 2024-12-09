import 'dart:async';
import 'dart:io';

import 'package:cinco_minutos_meditacao/core/analytics/manager.dart';
import 'package:cinco_minutos_meditacao/core/wrappers/secure_storage.dart';
import 'package:cinco_minutos_meditacao/modules/common/screens/home/home_repository.dart';
import 'package:cinco_minutos_meditacao/shared/clients/client_api.dart';
import 'package:cinco_minutos_meditacao/shared/clients/models/responses/user_response.dart';
import 'package:cinco_minutos_meditacao/shared/models/error.dart';
import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'home_repository_test.mocks.dart';

@GenerateMocks([AnalyticsManager, SecureStorage, ClientApi, CustomError])
void main() {
  group("HomeRepository", () {
    late MockAnalyticsManager analytics;
    late MockSecureStorage secureStorage;
    late MockClientApi clientApi;
    late MockCustomError customError;
    late HomeRepository repository;

    setUp(() {
      analytics = MockAnalyticsManager();
      secureStorage = MockSecureStorage();
      clientApi = MockClientApi();
      customError = MockCustomError();
      repository = HomeRepository(
        analytics,
        clientApi,
        customError,
        secureStorage,
      );
    });

    test("sendOpenScreenEvent", () {
      // arrange
      when(analytics.sendEvent(any)).thenReturn(null);

      // act
      repository.sendOpenScreenEvent();

      // assert
      verify(analytics.sendEvent(any));
    });

    test("logOut should set isLogged to false in secureStorage", () {
      // act
      repository.logOut();

      // assert
      verify(secureStorage.setIsLogged(false)).called(1);
    });

    test(
        "requestUser should return UserResponse and null error when successful",
        () async {
      // arrange
      UserResponse userResponse = UserResponse(
        1,
        'Test',
        'test@test.com',
        'teste',
        'googleId',
        'facebookId',
        'appleId',
        '23/04/2024',
        '23/04/2024',
        'masculino',
        '1983-07-02',
        State(1, 'São Paulo', Country(1, 'Brasil')),
      );
      when(clientApi.user()).thenAnswer((_) async => userResponse);

      // act
      var (result, error) = await repository.requestUser();

      // assert
      expect(result, userResponse);
      expect(error, null);
    });

    test(
        "requestUser should return null and CustomError when there is a TimeoutException",
        () async {
      // arrange
      when(clientApi.user()).thenThrow(TimeoutException(''));
      when(customError.sendErrorToCrashlytics(
        code: ErrorCodes.timeoutException,
        stackTrace: anyNamed('stackTrace'),
      )).thenReturn(customError);

      // act
      var (result, error) = await repository.requestUser();

      // assert
      expect(result, null);
      expect(error, isA<CustomError>());
    });

    test(
        "requestUser should return null and CustomError when there is a DioException",
        () async {
      // arrange
      when(clientApi.user()).thenThrow(DioException(
          response: Response(requestOptions: RequestOptions(path: '')),
          requestOptions: RequestOptions()));
      when(customError.sendErrorToCrashlytics(
        code: ErrorCodes.getMeError,
        stackTrace: anyNamed('stackTrace'),
        dioException: anyNamed('dioException'),
      )).thenReturn(customError);

      // act
      var (result, error) = await repository.requestUser();

      // assert
      expect(result, null);
      expect(error, isA<CustomError>());
    });

    test(
        "requestUser should return null and CustomError when there is an exception",
        () async {
      // arrange
      when(clientApi.user()).thenThrow(Exception());
      when(customError.sendErrorToCrashlytics(
        code: ErrorCodes.getMeError,
        stackTrace: anyNamed('stackTrace'),
      )).thenReturn(customError);

      // act
      var (result, error) = await repository.requestUser();

      // assert
      expect(result, null);
      expect(error, isA<CustomError>());
    });

    test("uploadImageProfile should return null when successful", () async {
      // arrange
      File file = File('path/to/file');
      when(clientApi.uploadPhoto(file)).thenAnswer((_) async => null);

      // act
      var result = await repository.uploadImageProfile(file);

      // assert
      expect(result, null);
    });

    test(
        "uploadImageProfile should return CustomError when there is a TimeoutException",
        () async {
      // arrange
      File file = File('path/to/file');
      when(clientApi.uploadPhoto(file)).thenThrow(TimeoutException(''));
      when(customError.sendErrorToCrashlytics(
        code: ErrorCodes.timeoutException,
        stackTrace: anyNamed('stackTrace'),
      )).thenReturn(customError);

      // act
      var result = await repository.uploadImageProfile(file);

      // assert
      expect(result, isA<CustomError>());
    });

    test(
        "uploadImageProfile should return CustomError when there is a DioException",
        () async {
      // arrange
      File file = File('path/to/file');
      when(clientApi.uploadPhoto(file)).thenThrow(DioException(
          response: Response(requestOptions: RequestOptions(path: '')),
          requestOptions: RequestOptions()));
      when(customError.sendErrorToCrashlytics(
        code: ErrorCodes.getMeError,
        stackTrace: anyNamed('stackTrace'),
        dioException: anyNamed('dioException'),
      )).thenReturn(customError);

      // act
      var result = await repository.uploadImageProfile(file);

      // assert
      expect(result, isA<CustomError>());
    });

    test(
        "uploadImageProfile should return CustomError when there is an exception",
        () async {
      // arrange
      File file = File('path/to/file');
      when(clientApi.uploadPhoto(file)).thenThrow(Exception());
      when(customError.sendErrorToCrashlytics(
        code: ErrorCodes.getMeError,
        stackTrace: anyNamed('stackTrace'),
      )).thenReturn(customError);

      // act
      var result = await repository.uploadImageProfile(file);

      // assert
      expect(result, isA<CustomError>());
    });

    test(
        "requestMeditations should return null and CustomError when there is a TimeoutException",
        () async {
      // arrange
      when(clientApi.meditations()).thenThrow(TimeoutException(''));
      when(customError.sendErrorToCrashlytics(
        code: ErrorCodes.timeoutException,
        stackTrace: anyNamed('stackTrace'),
      )).thenReturn(customError);

      // act
      var (result, error) = await repository.requestMeditations();

      // assert
      expect(result, null);
      expect(error, isA<CustomError>());
    });

    test(
        "requestMeditations should return null and CustomError when there is a DioException",
        () async {
      // arrange
      when(clientApi.meditations()).thenThrow(DioException(
          response: Response(requestOptions: RequestOptions(path: '')),
          requestOptions: RequestOptions()));
      when(customError.sendErrorToCrashlytics(
        code: ErrorCodes.getMeditionsError,
        stackTrace: anyNamed('stackTrace'),
        dioException: anyNamed('dioException'),
      )).thenReturn(customError);

      // act
      var (result, error) = await repository.requestMeditations();

      // assert
      expect(result, null);
      expect(error, isA<CustomError>());
    });

    test(
        "requestMeditations should return null and CustomError when there is an exception",
        () async {
      // arrange
      when(clientApi.meditations()).thenThrow(Exception());
      when(customError.sendErrorToCrashlytics(
        code: ErrorCodes.getMeditionsError,
        stackTrace: anyNamed('stackTrace'),
      )).thenReturn(customError);

      // act
      var (result, error) = await repository.requestMeditations();

      // assert
      expect(result, null);
      expect(error, isA<CustomError>());
    });
  });
}

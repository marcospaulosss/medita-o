import 'dart:async';
import 'dart:io';

import 'package:cinco_minutos_meditacao/core/analytics/manager.dart';
import 'package:cinco_minutos_meditacao/core/wrappers/secure_storage.dart';
import 'package:cinco_minutos_meditacao/modules/common/screens/profile/profile_repository.dart';
import 'package:cinco_minutos_meditacao/shared/clients/client_api.dart';
import 'package:cinco_minutos_meditacao/shared/clients/models/responses/countries_response.dart';
import 'package:cinco_minutos_meditacao/shared/clients/models/responses/states_response.dart';
import 'package:cinco_minutos_meditacao/shared/clients/models/responses/user_response.dart';
import 'package:cinco_minutos_meditacao/shared/models/error.dart';
import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'profile_repository_test.mocks.dart';

@GenerateMocks([AnalyticsManager, ClientApi, CustomError, SecureStorage])
void main() {
  late ProfileRepository repository;
  late MockAnalyticsManager mockAnalyticsManager;
  late MockClientApi mockClientApi;
  late MockCustomError mockCustomError;
  late MockSecureStorage mockSecureStorage;

  setUp(() {
    mockAnalyticsManager = MockAnalyticsManager();
    mockClientApi = MockClientApi();
    mockCustomError = MockCustomError();
    mockSecureStorage = MockSecureStorage();
    repository = ProfileRepository(
      mockAnalyticsManager,
      mockClientApi,
      mockCustomError,
      mockSecureStorage,
    );
  });

  group('ProfileRepository', () {
    test('sendOpenScreenEvent sends profile screen opened event', () {
      when(mockAnalyticsManager.sendEvent(any)).thenReturn(null);
      repository.sendOpenScreenEvent();
      verify(mockAnalyticsManager.sendEvent(any)).called(1);
    });

    test('logOut sets isLogged to false in secure storage', () {
      repository.logOut();
      verify(mockSecureStorage.setIsLogged(false)).called(1);
    });

    test('requestUser returns user response on success', () async {
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
          State(1, 'São Paulo', Country(1, 'Brasil')));
      when(mockClientApi.user()).thenAnswer((_) async => userResponse);

      final result = await repository.requestUser();

      expect(result, (userResponse, null));
      verify(mockSecureStorage.setUserId(userResponse.id.toString())).called(1);
      verify(mockSecureStorage.setUserName(userResponse.name)).called(1);
      verify(mockSecureStorage.setUserEmail(userResponse.email)).called(1);
    });

    test('requestUser handles timeout exception', () async {
      when(mockClientApi.user())
          .thenThrow(TimeoutException('Request timed out'));
      when(mockCustomError.sendErrorToCrashlytics(
        code: anyNamed('code'),
        stackTrace: anyNamed('stackTrace'),
      )).thenReturn(CustomError());

      final (result, err) = await repository.requestUser();

      expect(result, null);
      expect(err, isA<CustomError>());
      verify(mockCustomError.sendErrorToCrashlytics(
        code: anyNamed('code'),
        stackTrace: anyNamed('stackTrace'),
      )).called(1);
    });

    test('requestUser handles Dio exception', () async {
      final dioException =
          DioException(requestOptions: RequestOptions(path: ''));
      when(mockClientApi.user()).thenThrow(dioException);
      when(mockCustomError.sendErrorToCrashlytics(
        message: anyNamed('message'),
        code: anyNamed('code'),
        stackTrace: anyNamed('stackTrace'),
        dioException: anyNamed('dioException'),
      )).thenReturn(CustomError());

      final (result, err) = await repository.requestUser();

      expect(result, null);
      expect(err, isA<CustomError>());
      verify(mockCustomError.sendErrorToCrashlytics(
        message: anyNamed('message'),
        code: anyNamed('code'),
        stackTrace: anyNamed('stackTrace'),
        dioException: anyNamed('dioException'),
      )).called(1);
    });

    test('requestUser handles Generic exception', () async {
      when(mockClientApi.user()).thenThrow(Exception('Generic error'));
      when(mockCustomError.sendErrorToCrashlytics(
        code: anyNamed('code'),
        stackTrace: anyNamed('stackTrace'),
      )).thenReturn(CustomError());

      final (result, err) = await repository.requestUser();

      expect(result, null);
      expect(err, isA<CustomError>());
      verify(mockCustomError.sendErrorToCrashlytics(
        code: anyNamed('code'),
        stackTrace: anyNamed('stackTrace'),
      )).called(1);
    });

    test('uploadImageProfile calls uploadPhoto and returns null on success',
        () async {
      final file = File('path/to/file');
      when(mockClientApi.uploadPhoto(file)).thenAnswer((_) async => null);

      final result = await repository.uploadImageProfile(file);

      expect(result, isNull);
      verify(mockClientApi.uploadPhoto(file)).called(1);
    });

    test('uploadImageProfile handles timeout exception', () async {
      final file = File('path/to/file');
      when(mockClientApi.uploadPhoto(file))
          .thenThrow(TimeoutException('Request timed out'));
      when(mockCustomError.sendErrorToCrashlytics(
        code: ErrorCodes.timeoutException,
        stackTrace: anyNamed('stackTrace'),
      )).thenReturn(CustomError());

      final result = await repository.uploadImageProfile(file);

      expect(result, isA<CustomError>());
      verify(mockCustomError.sendErrorToCrashlytics(
        code: ErrorCodes.timeoutException,
        stackTrace: anyNamed('stackTrace'),
      )).called(1);
    });

    test('uploadImageProfile handles Dio exception', () async {
      final file = File('path/to/file');
      final dioException =
          DioException(requestOptions: RequestOptions(path: ''));
      when(mockClientApi.uploadPhoto(file)).thenThrow(dioException);
      when(mockCustomError.sendErrorToCrashlytics(
        message: anyNamed('message'),
        code: anyNamed('code'),
        stackTrace: anyNamed('stackTrace'),
        dioException: anyNamed('dioException'),
      )).thenReturn(CustomError());

      final result = await repository.uploadImageProfile(file);

      expect(result, isA<CustomError>());
      verify(mockCustomError.sendErrorToCrashlytics(
        message: anyNamed('message'),
        code: anyNamed('code'),
        stackTrace: anyNamed('stackTrace'),
        dioException: anyNamed('dioException'),
      )).called(1);
    });

    test('uploadImageProfile handles Generic exception', () async {
      final file = File('path/to/file');
      when(mockClientApi.uploadPhoto(file))
          .thenThrow(Exception('Generic error'));
      when(mockCustomError.sendErrorToCrashlytics(
        code: anyNamed('code'),
        stackTrace: anyNamed('stackTrace'),
      )).thenReturn(CustomError());

      final result = await repository.uploadImageProfile(file);

      expect(result, isA<CustomError>());
      verify(mockCustomError.sendErrorToCrashlytics(
        code: anyNamed('code'),
        stackTrace: anyNamed('stackTrace'),
      )).called(1);
    });

    test('requestGetCountries returns coutries response on success', () async {
      CountriesResponse countriesResponse =
          CountriesResponse([Countries(1, 'Brazil')]);
      when(mockClientApi.countries())
          .thenAnswer((_) async => countriesResponse);

      final result = await repository.requestGetCountries();

      expect(result, (countriesResponse, null));
    });

    test('requestGetCountries handles timeout exception', () async {
      when(mockClientApi.countries())
          .thenThrow(TimeoutException('Request timed out'));
      when(mockCustomError.sendErrorToCrashlytics(
        code: ErrorCodes.timeoutException,
        stackTrace: anyNamed('stackTrace'),
      )).thenReturn(CustomError());

      var (result, err) = await repository.requestGetCountries();

      expect(err, isA<CustomError>());
      expect(result, isNull);
      verify(mockCustomError.sendErrorToCrashlytics(
        code: ErrorCodes.timeoutException,
        stackTrace: anyNamed('stackTrace'),
      )).called(1);
    });

    test('requestGetCountries handles Dio exception', () async {
      final dioException =
          DioException(requestOptions: RequestOptions(path: ''));
      when(mockClientApi.countries()).thenThrow(dioException);
      when(mockCustomError.sendErrorToCrashlytics(
        message: anyNamed('message'),
        code: anyNamed('code'),
        stackTrace: anyNamed('stackTrace'),
        dioException: anyNamed('dioException'),
      )).thenReturn(CustomError());

      var (result, err) = await repository.requestGetCountries();

      expect(err, isA<CustomError>());
      expect(result, isNull);
      verify(mockCustomError.sendErrorToCrashlytics(
        message: anyNamed('message'),
        code: anyNamed('code'),
        stackTrace: anyNamed('stackTrace'),
        dioException: anyNamed('dioException'),
      )).called(1);
    });

    test('requestGetCountries handles Generic exception', () async {
      when(mockClientApi.countries()).thenThrow(Exception('Generic error'));
      when(mockCustomError.sendErrorToCrashlytics(
        code: anyNamed('code'),
        stackTrace: anyNamed('stackTrace'),
      )).thenReturn(CustomError());

      var (result, err) = await repository.requestGetCountries();

      expect(err, isA<CustomError>());
      expect(result, isNull);
      verify(mockCustomError.sendErrorToCrashlytics(
        code: anyNamed('code'),
        stackTrace: anyNamed('stackTrace'),
      )).called(1);
    });

    test('requestGetStatesByCountryId returns states response on success',
        () async {
      StatesResponse statesResponse = StatesResponse([States(1, 1, 'Brazil')]);
      when(mockClientApi.states(any)).thenAnswer((_) async => statesResponse);

      final result = await repository.requestGetStatesByCountryId(1);

      expect(result, (statesResponse, null));
    });

    test('requestGetStatesByCountryId handles timeout exception', () async {
      when(mockClientApi.states(any))
          .thenThrow(TimeoutException('Request timed out'));
      when(mockCustomError.sendErrorToCrashlytics(
        code: ErrorCodes.timeoutException,
        stackTrace: anyNamed('stackTrace'),
      )).thenReturn(CustomError());

      var (result, err) = await repository.requestGetStatesByCountryId(1);

      expect(err, isA<CustomError>());
      expect(result, isNull);
      verify(mockCustomError.sendErrorToCrashlytics(
        code: ErrorCodes.timeoutException,
        stackTrace: anyNamed('stackTrace'),
      )).called(1);
    });

    test('requestGetStatesByCountryId handles Dio exception', () async {
      final dioException =
          DioException(requestOptions: RequestOptions(path: ''));
      when(mockClientApi.states(any)).thenThrow(dioException);
      when(mockCustomError.sendErrorToCrashlytics(
        message: anyNamed('message'),
        code: anyNamed('code'),
        stackTrace: anyNamed('stackTrace'),
        dioException: anyNamed('dioException'),
      )).thenReturn(CustomError());

      var (result, err) = await repository.requestGetStatesByCountryId(1);

      expect(err, isA<CustomError>());
      expect(result, isNull);
      verify(mockCustomError.sendErrorToCrashlytics(
        message: anyNamed('message'),
        code: anyNamed('code'),
        stackTrace: anyNamed('stackTrace'),
        dioException: anyNamed('dioException'),
      )).called(1);
    });

    test('requestGetStatesByCountryId handles Generic exception', () async {
      when(mockClientApi.states(any)).thenThrow(Exception('Generic error'));
      when(mockCustomError.sendErrorToCrashlytics(
        code: anyNamed('code'),
        stackTrace: anyNamed('stackTrace'),
      )).thenReturn(CustomError());

      var (result, err) = await repository.requestGetStatesByCountryId(1);

      expect(err, isA<CustomError>());
      expect(result, isNull);
      verify(mockCustomError.sendErrorToCrashlytics(
        code: anyNamed('code'),
        stackTrace: anyNamed('stackTrace'),
      )).called(1);
    });
  });
}

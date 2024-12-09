import 'dart:async';
import 'dart:io';

import 'package:cinco_minutos_meditacao/core/analytics/manager.dart';
import 'package:cinco_minutos_meditacao/core/wrappers/secure_storage.dart';
import 'package:cinco_minutos_meditacao/modules/calendar/screens/calendar/calendar_repository.dart';
import 'package:cinco_minutos_meditacao/shared/clients/client_api.dart';
import 'package:cinco_minutos_meditacao/shared/clients/models/responses/meditations_response.dart';
import 'package:cinco_minutos_meditacao/shared/clients/models/responses/month_calendar_response.dart';
import 'package:cinco_minutos_meditacao/shared/clients/models/responses/user_response.dart';
import 'package:cinco_minutos_meditacao/shared/clients/models/responses/week_calendar_response.dart';
import 'package:cinco_minutos_meditacao/shared/clients/models/responses/year_calendar_response.dart';
import 'package:cinco_minutos_meditacao/shared/models/error.dart';
import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'calendar_repository_test.mocks.dart';

@GenerateMocks([AnalyticsManager, ClientApi, CustomError, SecureStorage])
void main() {
  late CalendarRepository repository;
  late MockAnalyticsManager mockAnalytics;
  late MockClientApi mockClientApi;
  late MockCustomError mockError;
  late MockSecureStorage mockSecureStorage;

  setUp(() {
    mockAnalytics = MockAnalyticsManager();
    mockClientApi = MockClientApi();
    mockError = MockCustomError();
    mockSecureStorage = MockSecureStorage();

    repository = CalendarRepository(
      mockAnalytics,
      mockClientApi,
      mockError,
      mockSecureStorage,
    );
  });

  group('sendOpenScreenEvent', () {
    test('should send event to analytics', () {
      when(mockAnalytics.sendEvent(any)).thenAnswer((_) async => null);
      // Act
      repository.sendOpenScreenEvent();

      // Assert
      verify(mockAnalytics.sendEvent(any)).called(1);
    });
  });

  group('requestUser', () {
    final userResponse = UserResponse(
        1,
        'John Doe',
        'john@example.com',
        '2024-10-10',
        '12345',
        '12323',
        'path',
        '2024-10-10',
        '2024-10-10',
        'masculino',
        '1983-07-02',
        State(1, 'São Paulo', Country(1, 'Brasil')));

    test('should return UserResponse on success', () async {
      // Arrange
      when(mockClientApi.user()).thenAnswer((_) async => userResponse);

      // Act
      final result = await repository.requestUser();

      // Assert
      expect(result, (userResponse, null));
      verify(mockSecureStorage.setUserId(userResponse.id.toString())).called(1);
      verify(mockSecureStorage.setUserName(userResponse.name)).called(1);
      verify(mockSecureStorage.setUserEmail(userResponse.email)).called(1);
      verify(mockSecureStorage.setGoogleId(userResponse.googleId)).called(1);
    });

    test('should return CustomError on TimeoutException', () async {
      // Arrange
      when(mockClientApi.user()).thenThrow(TimeoutException('Timeout'));
      when(mockError.sendErrorToCrashlytics(
        code: ErrorCodes.timeoutException,
        stackTrace: anyNamed('stackTrace'),
      )).thenAnswer((_) => CustomError());

      // Act
      final (result, err) = await repository.requestUser();

      // Assert
      expect(err, isA<CustomError>());
      expect(result, isNull);
      verify(mockError.sendErrorToCrashlytics(
        code: ErrorCodes.timeoutException,
        stackTrace: anyNamed('stackTrace'),
      )).called(1);
    });

    test('should return CustomError on DioException', () async {
      // Arrange
      final dioException =
          DioException(requestOptions: RequestOptions(path: ''));
      when(mockClientApi.user()).thenThrow(dioException);
      when(mockError.sendErrorToCrashlytics(
        code: ErrorCodes.getMeError,
        stackTrace: anyNamed('stackTrace'),
        dioException: dioException,
      )).thenAnswer((_) => CustomError());

      // Act
      final (result, err) = await repository.requestUser();

      // Assert
      expect(err, isA<CustomError>());
      expect(result, isNull);
      verify(mockError.sendErrorToCrashlytics(
        code: ErrorCodes.getMeError,
        stackTrace: anyNamed('stackTrace'),
        dioException: dioException,
      )).called(1);
    });

    test('should return CustomError on generic exception', () async {
      // Arrange
      when(mockClientApi.user()).thenThrow(Exception('Generic error'));
      when(mockError.sendErrorToCrashlytics(
        code: ErrorCodes.getMeError,
        stackTrace: anyNamed('stackTrace'),
      )).thenAnswer((_) => CustomError());

      // Act
      final (result, err) = await repository.requestUser();

      // Assert
      expect(err, isA<CustomError>());
      expect(result, isNull);
      verify(mockError.sendErrorToCrashlytics(
        code: ErrorCodes.getMeError,
        stackTrace: anyNamed('stackTrace'),
      )).called(1);
    });
  });

  group('requestMeditations', () {
    final meditationsResponse = MeditationsResponse(1000, 5000);

    test('should return MeditationsResponse on success', () async {
      // Arrange
      when(mockClientApi.meditations())
          .thenAnswer((_) async => meditationsResponse);

      // Act
      final result = await repository.requestMeditations();

      // Assert
      expect(result, (meditationsResponse, null));
    });

    test('should return CustomError on TimeoutException', () async {
      // Arrange
      when(mockClientApi.meditations()).thenThrow(TimeoutException('Timeout'));
      when(mockError.sendErrorToCrashlytics(
        code: ErrorCodes.timeoutException,
        stackTrace: anyNamed('stackTrace'),
      )).thenAnswer((_) => CustomError());

      // Act
      final (result, err) = await repository.requestMeditations();

      // Assert
      expect(err, isA<CustomError>());
      expect(result, isNull);
      verify(mockError.sendErrorToCrashlytics(
        code: ErrorCodes.timeoutException,
        stackTrace: anyNamed('stackTrace'),
      )).called(1);
    });

    test('should return CustomError on DioException', () async {
      // Arrange
      final dioException =
          DioException(requestOptions: RequestOptions(path: ''));
      when(mockClientApi.meditations()).thenThrow(dioException);
      when(mockError.sendErrorToCrashlytics(
        code: ErrorCodes.getMeditionsError,
        stackTrace: anyNamed('stackTrace'),
        dioException: dioException,
      )).thenAnswer((_) => CustomError());

      // Act
      final (result, err) = await repository.requestMeditations();

      // Assert
      expect(err, isA<CustomError>());
      expect(result, isNull);
      verify(mockError.sendErrorToCrashlytics(
        code: ErrorCodes.getMeditionsError,
        stackTrace: anyNamed('stackTrace'),
        dioException: dioException,
      )).called(1);
    });

    test('should return CustomError on generic exception', () async {
      // Arrange
      when(mockClientApi.meditations()).thenThrow(Exception('Generic error'));
      when(mockError.sendErrorToCrashlytics(
        code: ErrorCodes.getMeditionsError,
        stackTrace: anyNamed('stackTrace'),
      )).thenAnswer((_) => CustomError());

      // Act
      final (result, err) = await repository.requestMeditations();

      // Assert
      expect(err, isA<CustomError>());
      expect(result, isNull);
      verify(mockError.sendErrorToCrashlytics(
        code: ErrorCodes.getMeditionsError,
        stackTrace: anyNamed('stackTrace'),
      )).called(1);
    });
  });

  group('uploadImageProfile', () {
    final file = File('path/to/file');

    test('should return null on success', () async {
      // Arrange
      when(mockClientApi.uploadPhoto(file)).thenAnswer((_) async => null);

      // Act
      final result = await repository.uploadImageProfile(file);

      // Assert
      expect(result, null);
    });

    test('should return CustomError on TimeoutException', () async {
      // Arrange
      when(mockClientApi.uploadPhoto(file))
          .thenThrow(TimeoutException('Timeout'));
      when(mockError.sendErrorToCrashlytics(
        code: ErrorCodes.timeoutException,
        stackTrace: anyNamed('stackTrace'),
      )).thenAnswer((_) => CustomError());

      // Act
      final result = await repository.uploadImageProfile(file);

      // Assert
      expect(result, isA<CustomError>());
      verify(mockError.sendErrorToCrashlytics(
        code: ErrorCodes.timeoutException,
        stackTrace: anyNamed('stackTrace'),
      )).called(1);
    });

    test('should return CustomError on DioException', () async {
      // Arrange
      final dioException =
          DioException(requestOptions: RequestOptions(path: ''));
      when(mockClientApi.uploadPhoto(file)).thenThrow(dioException);
      when(mockError.sendErrorToCrashlytics(
        code: ErrorCodes.getMeError,
        stackTrace: anyNamed('stackTrace'),
        dioException: dioException,
      )).thenAnswer((_) => CustomError());

      // Act
      final result = await repository.uploadImageProfile(file);

      // Assert
      expect(result, isA<CustomError>());
      verify(mockError.sendErrorToCrashlytics(
        code: ErrorCodes.getMeError,
        stackTrace: anyNamed('stackTrace'),
        dioException: dioException,
      )).called(1);
    });

    test('should return CustomError on generic exception', () async {
      // Arrange
      when(mockClientApi.uploadPhoto(file))
          .thenThrow(Exception('Generic error'));
      when(mockError.sendErrorToCrashlytics(
        code: ErrorCodes.getMeError,
        stackTrace: anyNamed('stackTrace'),
      )).thenAnswer((_) => CustomError());

      // Act
      final result = await repository.uploadImageProfile(file);

      // Assert
      expect(result, isA<CustomError>());
      verify(mockError.sendErrorToCrashlytics(
        code: ErrorCodes.getMeError,
        stackTrace: anyNamed('stackTrace'),
      )).called(1);
    });
  });

  group('requestCalendarWeek', () {
    final weekResponse = WeekCalendarResponse();

    test('should return WeekCalendarResponse on success', () async {
      // Arrange
      when(mockClientApi.calendarWeek('2024-10-22'))
          .thenAnswer((_) async => weekResponse);

      // Act
      final result = await repository.requestCalendarWeek('2024-10-22');

      // Assert
      expect(result, (weekResponse, null));
    });

    test('should return CustomError on TimeoutException', () async {
      // Arrange
      when(mockClientApi.calendarWeek('2024-10-22'))
          .thenThrow(TimeoutException('Timeout'));
      when(mockError.sendErrorToCrashlytics(
        code: ErrorCodes.timeoutException,
        stackTrace: anyNamed('stackTrace'),
      )).thenAnswer((_) => CustomError());

      // Act
      final (result, err) = await repository.requestCalendarWeek('2024-10-22');

      // Assert
      expect(err, isA<CustomError>());
      expect(result, isNull);
      verify(mockError.sendErrorToCrashlytics(
        code: ErrorCodes.timeoutException,
        stackTrace: anyNamed('stackTrace'),
      )).called(1);
    });

    test('should return CustomError on DioException', () async {
      // Arrange
      final dioException =
          DioException(requestOptions: RequestOptions(path: ''));
      when(mockClientApi.calendarWeek('2024-10-22')).thenThrow(dioException);
      when(mockError.sendErrorToCrashlytics(
        code: ErrorCodes.getCalendarError,
        stackTrace: anyNamed('stackTrace'),
        dioException: dioException,
      )).thenAnswer((_) => CustomError());

      // Act
      final (result, err) = await repository.requestCalendarWeek('2024-10-22');

      // Assert
      expect(err, isA<CustomError>());
      expect(result, isNull);
      verify(mockError.sendErrorToCrashlytics(
        code: ErrorCodes.getCalendarError,
        stackTrace: anyNamed('stackTrace'),
        dioException: dioException,
      )).called(1);
    });

    test('should return CustomError on generic exception', () async {
      // Arrange
      when(mockClientApi.calendarWeek('2024-10-22'))
          .thenThrow(Exception('Generic error'));
      when(mockError.sendErrorToCrashlytics(
        code: ErrorCodes.getCalendarError,
        stackTrace: anyNamed('stackTrace'),
      )).thenAnswer((_) => CustomError());

      // Act
      final (result, err) = await repository.requestCalendarWeek('2024-10-22');

      // Assert
      expect(err, isA<CustomError>());
      expect(result, isNull);
      verify(mockError.sendErrorToCrashlytics(
        code: ErrorCodes.getCalendarError,
        stackTrace: anyNamed('stackTrace'),
      )).called(1);
    });
  });

  group('requestCalendarMonth', () {
    final monthResponse = MonthCalendarResponse();

    test('should return MonthCalendarResponse on success', () async {
      // Arrange
      when(mockClientApi.calendarMonth(10, 2024))
          .thenAnswer((_) async => monthResponse);

      // Act
      final result = await repository.requestCalendarMonth('2024-10');

      // Assert
      expect(result, (monthResponse, null));
    });

    test('should return CustomError on TimeoutException', () async {
      // Arrange
      when(mockClientApi.calendarMonth(10, 2024))
          .thenThrow(TimeoutException('Timeout'));
      when(mockError.sendErrorToCrashlytics(
        code: ErrorCodes.timeoutException,
        stackTrace: anyNamed('stackTrace'),
      )).thenAnswer((_) => CustomError());

      // Act
      final (result, err) = await repository.requestCalendarMonth('2024-10');

      // Assert
      expect(err, isA<CustomError>());
      expect(result, isNull);
      verify(mockError.sendErrorToCrashlytics(
        code: ErrorCodes.timeoutException,
        stackTrace: anyNamed('stackTrace'),
      )).called(1);
    });

    test('should return CustomError on DioException', () async {
      // Arrange
      final dioException =
          DioException(requestOptions: RequestOptions(path: ''));
      when(mockClientApi.calendarMonth(10, 2024)).thenThrow(dioException);
      when(mockError.sendErrorToCrashlytics(
        code: ErrorCodes.getCalendarError,
        stackTrace: anyNamed('stackTrace'),
        dioException: dioException,
      )).thenAnswer((_) => CustomError());

      // Act
      final (result, err) = await repository.requestCalendarMonth('2024-10');

      // Assert
      expect(err, isA<CustomError>());
      expect(result, isNull);
      verify(mockError.sendErrorToCrashlytics(
        code: ErrorCodes.getCalendarError,
        stackTrace: anyNamed('stackTrace'),
        dioException: dioException,
      )).called(1);
    });

    test('should return CustomError on generic exception', () async {
      // Arrange
      when(mockClientApi.calendarMonth(10, 2024))
          .thenThrow(Exception('Generic error'));
      when(mockError.sendErrorToCrashlytics(
        code: ErrorCodes.getCalendarError,
        stackTrace: anyNamed('stackTrace'),
      )).thenAnswer((_) => CustomError());

      // Act
      final (result, err) = await repository.requestCalendarMonth('2024-10');

      // Assert
      expect(err, isA<CustomError>());
      expect(result, isNull);
      verify(mockError.sendErrorToCrashlytics(
        code: ErrorCodes.getCalendarError,
        stackTrace: anyNamed('stackTrace'),
      )).called(1);
    });
  });

  group('requestCalendarYear', () {
    final yearResponse = YearCalendarResponse();

    test('should return YearCalendarResponse on success', () async {
      // Arrange
      when(mockClientApi.calendarYear(2024))
          .thenAnswer((_) async => yearResponse);

      // Act
      final result = await repository.requestCalendarYear('2024');

      // Assert
      expect(result, (yearResponse, null));
    });

    test('should return CustomError on TimeoutException', () async {
      // Arrange
      when(mockClientApi.calendarYear(2024))
          .thenThrow(TimeoutException('Timeout'));
      when(mockError.sendErrorToCrashlytics(
        code: ErrorCodes.timeoutException,
        stackTrace: anyNamed('stackTrace'),
      )).thenAnswer((_) => CustomError());

      // Act
      final (result, err) = await repository.requestCalendarYear('2024');

      // Assert
      expect(err, isA<CustomError>());
      expect(result, isNull);
      verify(mockError.sendErrorToCrashlytics(
        code: ErrorCodes.timeoutException,
        stackTrace: anyNamed('stackTrace'),
      )).called(1);
    });

    test('should return CustomError on DioException', () async {
      // Arrange
      final dioException =
          DioException(requestOptions: RequestOptions(path: ''));
      when(mockClientApi.calendarYear(2024)).thenThrow(dioException);
      when(mockError.sendErrorToCrashlytics(
        code: ErrorCodes.getCalendarError,
        stackTrace: anyNamed('stackTrace'),
        dioException: dioException,
      )).thenAnswer((_) => CustomError());

      // Act
      final (result, err) = await repository.requestCalendarYear('2024');

      // Assert
      expect(err, isA<CustomError>());
      expect(result, isNull);
      verify(mockError.sendErrorToCrashlytics(
        code: ErrorCodes.getCalendarError,
        stackTrace: anyNamed('stackTrace'),
        dioException: dioException,
      )).called(1);
    });

    test('should return CustomError on generic exception', () async {
      // Arrange
      when(mockClientApi.calendarYear(2024))
          .thenThrow(Exception('Generic error'));
      when(mockError.sendErrorToCrashlytics(
        code: ErrorCodes.getCalendarError,
        stackTrace: anyNamed('stackTrace'),
      )).thenAnswer((_) => CustomError());

      // Act
      final (result, err) = await repository.requestCalendarYear('2024');

      // Assert
      expect(err, isA<CustomError>());
      expect(result, isNull);
      verify(mockError.sendErrorToCrashlytics(
        code: ErrorCodes.getCalendarError,
        stackTrace: anyNamed('stackTrace'),
      )).called(1);
    });
  });
}

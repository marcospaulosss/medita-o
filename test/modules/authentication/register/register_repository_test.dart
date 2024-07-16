import 'dart:async';

import 'package:cinco_minutos_meditacao/core/analytics/manager.dart';
import 'package:cinco_minutos_meditacao/core/wrappers/secure_storage.dart';
import 'package:cinco_minutos_meditacao/modules/authentication/screens/register/register_repository.dart';
import 'package:cinco_minutos_meditacao/shared/clients/client_api.dart';
import 'package:cinco_minutos_meditacao/shared/clients/models/auth_request.dart';
import 'package:cinco_minutos_meditacao/shared/clients/models/register_response.dart';
import 'package:cinco_minutos_meditacao/shared/models/error.dart';
import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'register_repository_test.mocks.dart';

@GenerateMocks([AnalyticsManager, ClientApi, CustomError, SecureStorage])
void main() {
  late MockAnalyticsManager mockAnalyticsManager;
  late MockClientApi mockClientApi;
  late MockCustomError mockCustomError;
  late MockSecureStorage mockSecureStorage;
  late RegisterRepository repository;

  setUp(() {
    mockAnalyticsManager = MockAnalyticsManager();
    mockClientApi = MockClientApi();
    mockCustomError = MockCustomError();
    mockSecureStorage = MockSecureStorage();
    repository = RegisterRepository(mockAnalyticsManager, mockClientApi,
        mockCustomError, mockSecureStorage);
  });

  group('RegisterRepository', () {
    test('sendOpenScreenEvent should send registerScreenOpened event', () {
      when(mockAnalyticsManager.sendEvent(any)).thenReturn(null);

      repository.sendOpenScreenEvent();

      verify(mockAnalyticsManager.sendEvent(any)).called(1);
    });

    test('requestRegister should register user', () async {
      final authRequest =
          AuthRequest(email: 'test@test.com', password: 'password');
      when(mockClientApi.register(authRequest))
          .thenAnswer((_) async => RegisterResponse('token', 'type'));

      final result = await repository.requestRegister(authRequest);

      expect(result, isNull);
      verify(mockClientApi.register(authRequest)).called(1);
      verify(mockSecureStorage.setTokenAPI('token')).called(1);
      verify(mockSecureStorage.setIsLogged(true)).called(1);
    });

    test('requestRegister should handle TimeoutException', () async {
      final authRequest =
          AuthRequest(email: 'test@test.com', password: 'password');
      when(mockClientApi.register(any)).thenThrow(TimeoutException('Timeout'));
      when(mockCustomError.sendErrorToCrashlytics(
              message: anyNamed('message'),
              code: anyNamed('code'),
              stackTrace: anyNamed('stackTrace')))
          .thenReturn(mockCustomError);

      final result = await repository.requestRegister(authRequest);

      expect(result, isA<CustomError>());
      verify(mockClientApi.register(any)).called(1);
      verify(mockCustomError.sendErrorToCrashlytics(
              message: anyNamed('message'),
              code: anyNamed('code'),
              stackTrace: anyNamed('stackTrace')))
          .called(1);
    });

    test('requestRegister should handle DioException with 422 status code',
        () async {
      final authRequest =
          AuthRequest(email: 'test@test.com', password: 'password');
      final dioError = DioException(
        requestOptions: RequestOptions(path: ''),
        response:
            Response(statusCode: 422, requestOptions: RequestOptions(path: '')),
      );
      when(mockClientApi.register(authRequest)).thenThrow(dioError);
      when(mockCustomError.code).thenReturn(ErrorCodes.alreadyRegistered);

      final result = await repository.requestRegister(authRequest);

      expect(result, isA<CustomError>());
      expect(result?.code, equals(ErrorCodes.alreadyRegistered));
      verify(mockClientApi.register(authRequest)).called(1);
    });

    test('requestRegister should handle DioException with 400 status code',
        () async {
      final authRequest =
          AuthRequest(email: 'test@test.com', password: 'password');
      final dioError = DioException(
        requestOptions: RequestOptions(path: ''),
        response: Response(
            data: {'message': 'Bad request'},
            statusCode: 400,
            requestOptions: RequestOptions(path: '')),
      );
      when(mockClientApi.register(authRequest)).thenThrow(dioError);
      when(mockCustomError.code).thenReturn(ErrorCodes.badRequest);
      when(mockCustomError.message).thenReturn('Bad request');

      final result = await repository.requestRegister(authRequest);

      expect(result, isA<CustomError>());
      expect(result?.code, equals(ErrorCodes.badRequest));
      verify(mockClientApi.register(authRequest)).called(1);
    });

    test('requestRegister should handle generic exception', () async {
      final authRequest =
          AuthRequest(email: 'test@test.com', password: 'password');
      final genericError = Exception('Generic error');
      when(mockClientApi.register(authRequest)).thenThrow(genericError);
      when(mockCustomError.code).thenReturn(ErrorCodes.registerError);
      when(mockCustomError.sendErrorToCrashlytics(
              message: anyNamed('message'),
              code: anyNamed('code'),
              stackTrace: anyNamed('stackTrace')))
          .thenReturn(mockCustomError);

      final result = await repository.requestRegister(authRequest);

      expect(result, isA<CustomError>());
      expect(result?.code, equals(ErrorCodes.registerError));
      verify(mockClientApi.register(authRequest)).called(1);
    });

    test('requestRegister should handle default error in dio', () async {
      final authRequest =
          AuthRequest(email: 'test@test.com', password: 'password');
      final dioError = DioException(
        requestOptions: RequestOptions(path: ''),
        response:
            Response(statusCode: 405, requestOptions: RequestOptions(path: '')),
      );
      when(mockClientApi.register(authRequest)).thenThrow(dioError);
      when(mockCustomError.sendErrorToCrashlytics(
              message: anyNamed('message'),
              code: anyNamed('code'),
              stackTrace: anyNamed('stackTrace')))
          .thenReturn(mockCustomError);

      final result = await repository.requestRegister(authRequest);

      expect(result, isA<CustomError>());
      verify(mockClientApi.register(authRequest)).called(1);
      verify(mockCustomError.sendErrorToCrashlytics(
              message: anyNamed('message'),
              code: anyNamed('code'),
              stackTrace: anyNamed('stackTrace')))
          .called(1);
    });
  });
}

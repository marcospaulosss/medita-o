import 'dart:async';

import 'package:cinco_minutos_meditacao/core/analytics/manager.dart';
import 'package:cinco_minutos_meditacao/core/wrappers/secure_storage.dart';
import 'package:cinco_minutos_meditacao/modules/authentication/screens/login/login_repository.dart';
import 'package:cinco_minutos_meditacao/shared/clients/client_api.dart';
import 'package:cinco_minutos_meditacao/shared/clients/models/requests/auth_request.dart';
import 'package:cinco_minutos_meditacao/shared/clients/models/responses/authenticate_google_response.dart';
import 'package:cinco_minutos_meditacao/shared/clients/models/responses/register_response.dart';
import 'package:cinco_minutos_meditacao/shared/models/error.dart';
import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'login_repository_test.mocks.dart';

@GenerateMocks([AnalyticsManager, ClientApi, SecureStorage, CustomError])
void main() {
  late MockCustomError mockCustomError;
  late MockAnalyticsManager mockAnalyticsManager;
  late MockClientApi mockSocialClientApi;
  late MockSecureStorage mockSecureStorage;
  late LoginRepository repository;

  setUp(() {
    mockCustomError = MockCustomError();
    mockAnalyticsManager = MockAnalyticsManager();
    mockSocialClientApi = MockClientApi();
    mockSecureStorage = MockSecureStorage();
    repository = LoginRepository(mockAnalyticsManager, mockSocialClientApi,
        mockCustomError, mockSecureStorage);
  });

  group('LoginRepository', () {
    group('Authenticate Google', () {
      test('sendOpenScreenEvent should send analytics event', () {
        when(mockAnalyticsManager.sendEvent(any)).thenAnswer((_) async => {});
        repository.sendOpenScreenEvent();

        verify(mockAnalyticsManager.sendEvent(any)).called(1);
      });

      test('authenticateUserByGoogle should authenticate user and store token',
          () async {
        const credential = AuthCredential(
            accessToken: 'token', providerId: 'id', signInMethod: 'method');
        final response = AuthenticateGoogleResponse('api_token', null);
        when(mockSocialClientApi.authGoogle(any))
            .thenAnswer((_) async => response);

        final result = await repository.authenticateUserByGoogle(credential);

        expect(result, isNull);
        verify(mockSocialClientApi.authGoogle(any)).called(1);
        verify(mockSecureStorage.setTokenAPI('api_token')).called(1);
        verify(mockSecureStorage.setIsLogged(true)).called(1);
      });

      test('authenticateUserByGoogle should handle TimeoutException', () async {
        const credential = AuthCredential(
            accessToken: 'token', providerId: 'id', signInMethod: 'method');
        when(mockSocialClientApi.authGoogle(any))
            .thenThrow(TimeoutException('Timeout'));

        final result = await repository.authenticateUserByGoogle(credential);

        expect(result, isA<FlutterError>());
        verify(mockSocialClientApi.authGoogle(any)).called(1);
        verifyNever(mockSecureStorage.setTokenAPI(any));
        verifyNever(mockSecureStorage.setIsLogged(any));
      });

      test(
          'authenticateUserByGoogle should handle DioException with 401 status code',
          () async {
        const credential = AuthCredential(
            accessToken: 'token', providerId: 'id', signInMethod: 'method');
        final dioError = DioException(
          requestOptions: RequestOptions(path: ''),
          response: Response(
              statusCode: 401, requestOptions: RequestOptions(path: '')),
        );
        when(mockSocialClientApi.authGoogle(any)).thenThrow(dioError);

        final result = await repository.authenticateUserByGoogle(credential);

        expect(result, isNull);
        verify(mockSocialClientApi.authGoogle(any)).called(1);
        verify(mockSecureStorage.setIsLogged(false)).called(1);
        verifyNever(mockSecureStorage.setTokenAPI(any));
      });

      test(
          'authenticateUserByGoogle should handle DioException with other status code',
          () async {
        const credential = AuthCredential(
            accessToken: 'token', providerId: 'id', signInMethod: 'method');
        final dioError = DioException(
          requestOptions: RequestOptions(path: ''),
          response: Response(
              statusCode: 500, requestOptions: RequestOptions(path: '')),
        );
        when(mockSocialClientApi.authGoogle(any)).thenThrow(dioError);

        final result = await repository.authenticateUserByGoogle(credential);

        expect(result, dioError.error);
        verify(mockSocialClientApi.authGoogle(any)).called(1);
        verifyNever(mockSecureStorage.setTokenAPI(any));
        verifyNever(mockSecureStorage.setIsLogged(any));
      });

      test('authenticateUserByGoogle should handle generic exception',
          () async {
        const credential = AuthCredential(
            accessToken: 'token', providerId: 'id', signInMethod: 'method');
        final genericError = Exception('Generic error');
        when(mockSocialClientApi.authGoogle(any)).thenThrow(genericError);

        final result = await repository.authenticateUserByGoogle(credential);

        expect(result, genericError);
        verify(mockSocialClientApi.authGoogle(any)).called(1);
        verifyNever(mockSecureStorage.setTokenAPI(any));
        verifyNever(mockSecureStorage.setIsLogged(any));
      });
    });

    group('Authenticate api', () {
      test(
          'authenticateUserByEmailPassword should authenticate user with return null in response',
          () async {
        final authRequest =
            AuthRequest(email: 'test@test.com', password: 'password');
        when(mockSocialClientApi.login(any))
            .thenAnswer((_) async => RegisterResponse(null, null));
        when(mockCustomError.sendErrorToCrashlytics(
                message: anyNamed("message"),
                code: anyNamed("code"),
                stackTrace: anyNamed("stackTrace")))
            .thenReturn(mockCustomError);

        final result =
            await repository.authenticateUserByEmailPassword(authRequest);

        expect(result, isNotNull);
        verify(mockSocialClientApi.login(authRequest)).called(1);
        verify(mockCustomError.sendErrorToCrashlytics(
                message: anyNamed("message"),
                code: anyNamed("code"),
                stackTrace: anyNamed("stackTrace")))
            .called(1);
      });

      test('authenticateUserByEmailPassword should handle TimeoutException',
          () async {
        final authRequest =
            AuthRequest(email: 'test@test.com', password: 'password');
        when(mockSocialClientApi.login(any))
            .thenThrow(TimeoutException('Timeout'));
        when(mockCustomError.sendErrorToCrashlytics(
                message: anyNamed("message"),
                code: anyNamed("code"),
                stackTrace: anyNamed("stackTrace")))
            .thenReturn(mockCustomError);

        final result =
            await repository.authenticateUserByEmailPassword(authRequest);

        expect(result, isA<CustomError>());
        verify(mockSocialClientApi.login(any)).called(1);
        verify(mockCustomError.sendErrorToCrashlytics(
                message: anyNamed("message"),
                code: anyNamed("code"),
                stackTrace: anyNamed("stackTrace")))
            .called(1);
      });

      test(
          'authenticateUserByEmailPassword should handle DioException with 401 status code',
          () async {
        final authRequest =
            AuthRequest(email: 'test@test.com', password: 'password');
        final dioError = DioException(
          requestOptions: RequestOptions(path: ''),
          response: Response(
              statusCode: 401, requestOptions: RequestOptions(path: '')),
        );
        when(mockSocialClientApi.login(any)).thenThrow(dioError);
        when(mockCustomError.code).thenReturn(ErrorCodes.unauthorized);

        final result =
            await repository.authenticateUserByEmailPassword(authRequest);

        expect(result, isA<CustomError>());
        expect(result?.code, equals(ErrorCodes.unauthorized));
        verify(mockSocialClientApi.login(any)).called(1);
        verify(mockSecureStorage.setIsLogged(false)).called(1);
      });

      test(
          'authenticateUserByEmailPassword should handle DioException with other status code',
          () async {
        final authRequest =
            AuthRequest(email: 'test@test.com', password: 'password');
        final dioError = DioException(
          requestOptions: RequestOptions(path: ''),
          response: Response(
              statusCode: 500, requestOptions: RequestOptions(path: '')),
        );
        when(mockSocialClientApi.login(any)).thenThrow(dioError);
        when(mockCustomError.sendErrorToCrashlytics(
          message: anyNamed("message"),
          code: anyNamed("code"),
          stackTrace: anyNamed("stackTrace"),
          dioException: anyNamed('dioException'),
        )).thenReturn(mockCustomError);
        when(mockCustomError.code)
            .thenReturn(ErrorCodes.loginEmailPasswordError);

        final result =
            await repository.authenticateUserByEmailPassword(authRequest);

        expect(result, isA<CustomError>());
        expect(result?.code, equals(ErrorCodes.loginEmailPasswordError));
        verify(mockSocialClientApi.login(any)).called(1);
      });

      test('authenticateUserByEmailPassword should handle generic exception',
          () async {
        final authRequest =
            AuthRequest(email: 'test@test.com', password: 'password');
        final genericError = Exception('Generic error');
        when(mockSocialClientApi.login(any)).thenThrow(genericError);
        when(mockCustomError.sendErrorToCrashlytics(
                message: anyNamed("message"),
                code: anyNamed("code"),
                stackTrace: anyNamed("stackTrace")))
            .thenReturn(mockCustomError);
        when(mockCustomError.code)
            .thenReturn(ErrorCodes.loginEmailPasswordError);

        final result =
            await repository.authenticateUserByEmailPassword(authRequest);

        expect(result, isA<CustomError>());
        expect(result?.code, equals(ErrorCodes.loginEmailPasswordError));
        verify(mockSocialClientApi.login(any)).called(1);
      });

      test(
          'authenticateUserByEmailPassword should authenticate user with return correct in response',
          () async {
        final authRequest =
            AuthRequest(email: 'test@test.com', password: 'password');
        when(mockSocialClientApi.login(any)).thenAnswer((_) async =>
            RegisterResponse("teafadsfasdfasdfas", "teafadsfasdfasdfas"));
        when(mockSecureStorage.setTokenAPI(any)).thenAnswer((_) async => {});
        when(mockSecureStorage.setIsLogged(any)).thenAnswer((_) async => {});

        final result =
            await repository.authenticateUserByEmailPassword(authRequest);

        expect(result, isNull);
        verify(mockSocialClientApi.login(authRequest)).called(1);
        verify(mockSecureStorage.setTokenAPI(any)).called(1);
        verify(mockSecureStorage.setIsLogged(any)).called(1);
      });
    });
  });
}

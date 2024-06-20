import 'dart:async';

import 'package:cinco_minutos_meditacao/core/analytics/manager.dart';
import 'package:cinco_minutos_meditacao/core/wrappers/secure_storage.dart';
import 'package:cinco_minutos_meditacao/modules/authentication/screens/login/login_repository.dart';
import 'package:cinco_minutos_meditacao/shared/clients/models/authenticate_google_response.dart';
import 'package:cinco_minutos_meditacao/shared/clients/social_client_api.dart';
import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'login_repository_test.mocks.dart';

@GenerateMocks([AnalyticsManager, SocialClientApi, SecureStorage])
void main() {
  late MockAnalyticsManager mockAnalyticsManager;
  late MockSocialClientApi mockSocialClientApi;
  late MockSecureStorage mockSecureStorage;
  late LoginRepository repository;

  setUp(() {
    mockAnalyticsManager = MockAnalyticsManager();
    mockSocialClientApi = MockSocialClientApi();
    mockSecureStorage = MockSecureStorage();
    repository = LoginRepository(
        mockAnalyticsManager, mockSocialClientApi, mockSecureStorage);
  });

  group('LoginRepository', () {
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
        response:
            Response(statusCode: 401, requestOptions: RequestOptions(path: '')),
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
        response:
            Response(statusCode: 500, requestOptions: RequestOptions(path: '')),
      );
      when(mockSocialClientApi.authGoogle(any)).thenThrow(dioError);

      final result = await repository.authenticateUserByGoogle(credential);

      expect(result, dioError.error);
      verify(mockSocialClientApi.authGoogle(any)).called(1);
      verifyNever(mockSecureStorage.setTokenAPI(any));
      verifyNever(mockSecureStorage.setIsLogged(any));
    });

    test('authenticateUserByGoogle should handle generic exception', () async {
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
}

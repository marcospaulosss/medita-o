import 'package:cinco_minutos_meditacao/core/routers/app_router.dart';
import 'package:cinco_minutos_meditacao/modules/authentication/screens/login/login_contracts.dart';
import 'package:cinco_minutos_meditacao/modules/authentication/screens/login/login_presenter.dart';
import 'package:cinco_minutos_meditacao/shared/models/error.dart';
import 'package:cinco_minutos_meditacao/shared/services/auth_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'login_presenter_test.mocks.dart';

@GenerateMocks(
    [AuthService, CustomError, AppRouter, LoginViewContract, Repository])
void main() {
  late MockAuthService mockAuthService;
  late MockCustomError mockCustomError;
  late MockAppRouter mockAppRouter;
  late MockLoginViewContract mockView;
  late MockRepository mockRepository;
  late LoginPresenter presenter;

  setUp(() {
    mockAuthService = MockAuthService();
    mockCustomError = MockCustomError();
    mockAppRouter = MockAppRouter();
    mockView = MockLoginViewContract();
    mockRepository = MockRepository();
    presenter = LoginPresenter(
        mockAuthService, mockCustomError, mockAppRouter, mockRepository);
    presenter.view = mockView;
  });

  group('LoginPresenter', () {
    test('loginGoogle should show loading and handle error', () async {
      when(mockAuthService.loginGoogle())
          .thenAnswer((_) async => (null, mockCustomError));
      when(mockCustomError.sendErrorToCrashlytics(any, any, any))
          .thenAnswer((_) async => {});

      await presenter.loginGoogle();

      verify(mockView.showLoading()).called(1);
      verify(mockView.showError('Erro ao realizar login com o Google'))
          .called(1);
      verifyNever(mockAppRouter.goToReplace(any));
    });

    test('loginGoogle should authenticate user and navigate to home', () async {
      const credential = AuthCredential(
          accessToken: 'token', providerId: 'id', signInMethod: 'method');
      when(mockAuthService.loginGoogle())
          .thenAnswer((_) async => (credential, null));
      when(mockRepository.authenticateUserByGoogle(credential))
          .thenAnswer((_) async => null);

      await presenter.loginGoogle();

      verify(mockView.showLoading()).called(1);
      verify(mockRepository.authenticateUserByGoogle(credential)).called(1);
      verify(mockAppRouter.goToReplace(any)).called(1);
    });

    test('loginGoogle should handle authentication error', () async {
      const credential = AuthCredential(
          accessToken: 'token', providerId: 'id', signInMethod: 'method');
      when(mockAuthService.loginGoogle())
          .thenAnswer((_) async => (credential, null));
      when(mockRepository.authenticateUserByGoogle(credential))
          .thenAnswer((_) async => mockCustomError);
      when(mockAppRouter.goToReplace(any)).thenAnswer((_) async => {});

      await presenter.loginGoogle();

      verify(mockView.showLoading()).called(1);
      verify(mockRepository.authenticateUserByGoogle(credential)).called(1);
      verify(mockView.showError(
              'Erro ao authenticar usuário com o Google no servidor'))
          .called(1);

      verifyNever(mockAppRouter.goToReplace(any));
    });

    test('loginGoogle should handle null credential', () async {
      when(mockAuthService.loginGoogle()).thenAnswer((_) async => (null, null));
      when(mockCustomError.sendErrorToCrashlytics(any, any, any))
          .thenAnswer((_) async => {});

      await presenter.loginGoogle();

      verify(mockView.showLoading()).called(1);
      verify(mockCustomError.sendErrorToCrashlytics(
        "Erro ao realizar login com o Google",
        ErrorCodes.loginGoogleError,
        any,
      )).called(1);
      verify(mockView.showError("Erro ao realizar login com o Google"))
          .called(1);
      verifyNever(mockAppRouter.goToReplace(any));
    });

    test('loginGoogle should handle null accessToken', () async {
      const credential = AuthCredential(
          accessToken: null, providerId: 'id', signInMethod: 'method');
      when(mockAuthService.loginGoogle())
          .thenAnswer((_) async => (credential, null));
      when(mockCustomError.sendErrorToCrashlytics(any, any, any))
          .thenAnswer((_) async => {});

      await presenter.loginGoogle();

      verify(mockView.showLoading()).called(1);
      verify(mockCustomError.sendErrorToCrashlytics(
        "Erro ao realizar login com o Google",
        ErrorCodes.loginGoogleError,
        any,
      )).called(1);
      verify(mockView.showError("Erro ao realizar login com o Google"))
          .called(1);
      verifyNever(mockAppRouter.goToReplace(any));
    });

    test('loginGoogle should handle empty accessToken', () async {
      const credential = AuthCredential(
          accessToken: '', providerId: 'id', signInMethod: 'method');
      when(mockAuthService.loginGoogle())
          .thenAnswer((_) async => (credential, null));
      when(mockCustomError.sendErrorToCrashlytics(any, any, any))
          .thenAnswer((_) async => {});

      await presenter.loginGoogle();

      verify(mockView.showLoading()).called(1);
      verify(mockCustomError.sendErrorToCrashlytics(
        "Erro ao realizar login com o Google",
        ErrorCodes.loginGoogleError,
        any,
      )).called(1);
      verify(mockView.showError("Erro ao realizar login com o Google"))
          .called(1);
      verifyNever(mockAppRouter.goToReplace(any));
    });

    test('goToHome should navigate to home', () {
      presenter.goToHome();

      verify(mockAppRouter.goToReplace(any)).called(1);
    });

    test('onOpenScreen should send open screen event', () {
      presenter.onOpenScreen();

      verify(mockRepository.sendOpenScreenEvent()).called(1);
    });

    test('loginFacebook should call loginFacebook on authService', () async {
      await presenter.loginFacebook();

      verify(mockAuthService.loginFacebook()).called(1);
    });
  });
}

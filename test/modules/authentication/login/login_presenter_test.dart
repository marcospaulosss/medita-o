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
    group('Login google', () {
      test('loginGoogle should show loading and handle error', () async {
        when(mockAuthService.loginGoogle())
            .thenAnswer((_) async => (null, mockCustomError));
        when(mockCustomError.sendErrorToCrashlytics(
                message: anyNamed("message"),
                code: anyNamed("code"),
                stackTrace: anyNamed("stackTrace")))
            .thenReturn(CustomError());

        await presenter.loginGoogle();

        verify(mockView.showLoading()).called(1);
        verify(mockView.showError('Erro ao realizar login com o Google'))
            .called(1);
        verifyNever(mockAppRouter.goToReplace(any));
      });

      test('loginGoogle should authenticate user and navigate to home',
          () async {
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
        CustomError error = CustomError();
        error.message = "Erro ao realizar login com o Google";

        when(mockAuthService.loginGoogle())
            .thenAnswer((_) async => (null, null));
        when(mockCustomError.message)
            .thenReturn("Erro ao realizar login com o Google");
        when(mockCustomError.sendErrorToCrashlytics(
                code: anyNamed("code"), stackTrace: anyNamed("stackTrace")))
            .thenReturn(error);

        await presenter.loginGoogle();

        verify(mockView.showLoading()).called(1);
        verify(mockCustomError.sendErrorToCrashlytics(
          message: anyNamed("message"),
          code: anyNamed("code"),
          stackTrace: anyNamed("stackTrace"),
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
        when(mockCustomError.message)
            .thenReturn("Erro ao realizar login com o Google");
        when(mockCustomError.sendErrorToCrashlytics(
                message: anyNamed("message"),
                code: anyNamed("code"),
                stackTrace: anyNamed("stackTrace")))
            .thenReturn(CustomError());

        await presenter.loginGoogle();

        verify(mockView.showLoading()).called(1);
        verify(mockCustomError.sendErrorToCrashlytics(
          message: anyNamed("message"),
          code: anyNamed("code"),
          stackTrace: anyNamed("stackTrace"),
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
        when(mockCustomError.message)
            .thenReturn("Erro ao realizar login com o Google");
        when(mockCustomError.sendErrorToCrashlytics(
                message: anyNamed("message"),
                code: anyNamed("code"),
                stackTrace: anyNamed("stackTrace")))
            .thenReturn(CustomError());

        await presenter.loginGoogle();

        verify(mockView.showLoading()).called(1);
        verify(mockCustomError.sendErrorToCrashlytics(
          message: anyNamed("message"),
          code: anyNamed("code"),
          stackTrace: anyNamed("stackTrace"),
        )).called(1);
        verify(mockView.showError("Erro ao realizar login com o Google"))
            .called(1);
        verifyNever(mockAppRouter.goToReplace(any));
      });
    });

    group('Login Email Password', () {
      test('loginEmailPassword should show error when email is invalid',
          () async {
        await presenter.loginEmailPassword('invalid_email', 'password');

        verify(mockView.showErrorEmailInvalid()).called(1);
      });

      test(
          'loginEmailPassword should show invalid credentials snackbar when unauthorized',
          () async {
        late CustomError customError = CustomError();
        customError.code = ErrorCodes.unauthorized;
        when(mockRepository.authenticateUserByEmailPassword(any))
            .thenAnswer((_) async => customError);

        await presenter.loginEmailPassword('test@test.com', 'password');

        verify(mockView.showInvalidCredentialsSnackBar()).called(1);
      });

      test('loginEmailPassword should show error when there is an error',
          () async {
        late CustomError customError = CustomError();
        customError.code = ErrorCodes.loginEmailPasswordError;
        customError.message = 'Error message';
        when(mockRepository.authenticateUserByEmailPassword(any))
            .thenAnswer((_) async => customError);

        await presenter.loginEmailPassword('test@test.com', 'password');

        verify(mockView.showError('Error message')).called(1);
      });

      test(
          'loginEmailPassword should not show any error when there is no error',
          () async {
        when(mockRepository.authenticateUserByEmailPassword(any))
            .thenAnswer((_) async => null);

        await presenter.loginEmailPassword('test@test.com', 'password');

        verifyNever(mockView.showError(any));
        verifyNever(mockView.showInvalidCredentialsSnackBar());
        verifyNever(mockView.showErrorEmailInvalid());
      });
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

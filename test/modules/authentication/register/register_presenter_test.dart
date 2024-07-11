import 'package:cinco_minutos_meditacao/core/routers/app_router.dart';
import 'package:cinco_minutos_meditacao/core/routers/app_router.gr.dart';
import 'package:cinco_minutos_meditacao/modules/authentication/screens/register/register_contracts.dart';
import 'package:cinco_minutos_meditacao/modules/authentication/screens/register/register_presenter.dart';
import 'package:cinco_minutos_meditacao/shared/clients/models/auth_request.dart';
import 'package:cinco_minutos_meditacao/shared/models/error.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'register_presenter_test.mocks.dart';

@GenerateMocks([RegisterViewContract, CustomError, AppRouter, Repository])
void main() {
  late MockRegisterViewContract mockView;
  late MockCustomError mockCustomError;
  late MockAppRouter mockRouter;
  late MockRepository mockRepository;
  late RegisterPresenter presenter;

  setUp(() {
    mockView = MockRegisterViewContract();
    mockCustomError = MockCustomError();
    mockRouter = MockAppRouter();
    mockRepository = MockRepository();
    presenter = RegisterPresenter(mockCustomError, mockRouter, mockRepository);
    presenter.view = mockView;
  });

  group('RegisterPresenter', () {
    test('goToHome should replace current route with HomeRoute', () {
      presenter.goToHome();

      verify(mockRouter.goToReplace(const HomeRoute())).called(1);
    });

    test('onOpenScreen should send open screen event', () {
      presenter.onOpenScreen();

      verify(mockRepository.sendOpenScreenEvent()).called(1);
    });

    test(
        'register should show snackbar and navigate to login when user is already registered',
        () async {
      final authRequest =
          AuthRequest(email: 'test@test.com', password: 'password');
      CustomError error = CustomError();
      error.code = ErrorCodes.alreadyRegistered;
      when(mockRepository.requestRegister(any)).thenAnswer((_) async => error);

      await presenter.register(authRequest);

      verify(mockView.showInvalidCredentialsSnackBar(
              message: error.getErrorMessage))
          .called(1);
      verify(mockRouter.goToReplace(const LoginRoute())).called(1);
    });

    test('register should show snackbar when there is a bad request', () async {
      final authRequest =
          AuthRequest(email: 'test@test.com', password: 'password');
      final error = CustomError();
      error.message = 'Bad request';
      when(mockRepository.requestRegister(authRequest))
          .thenAnswer((_) async => error);

      await presenter.register(authRequest);

      verify(mockRepository.requestRegister(any)).called(1);
      verify(mockView.showInvalidCredentialsSnackBar(message: error.message!))
          .called(1);
    });

    test(
        'register should navigate to RegisterSuccessRoute when there is no error',
        () async {
      final authRequest =
          AuthRequest(email: 'test@test.com', password: 'password');
      when(mockRepository.requestRegister(authRequest))
          .thenAnswer((_) async => null);

      await presenter.register(authRequest);

      verify(mockRepository.requestRegister(any)).called(1);
      verify(mockRouter.goTo(const RegisterSuccessRoute())).called(1);
    });
  });
}

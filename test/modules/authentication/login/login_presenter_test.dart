import 'dart:io';

import 'package:cinco_minutos_meditacao/core/routers/app_router.dart';
import 'package:cinco_minutos_meditacao/modules/authentication/screens/login/login_contracts.dart';
import 'package:cinco_minutos_meditacao/modules/authentication/screens/login/login_presenter.dart';
import 'package:cinco_minutos_meditacao/shared/services/auth_service.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'login_presenter_test.mocks.dart';

class ObjectTeste {
  const ObjectTeste();
}

@GenerateMocks([AuthService, AppRouter, Repository])
void main() {
  late MockAuthService authService;
  late MockAppRouter router;
  late MockRepository repository;
  late Presenter presenter;

  setUp(() {
    authService = MockAuthService();
    router = MockAppRouter();
    repository = MockRepository();
    presenter = LoginPresenter(authService, router, repository);
  });

  group("Presenter", () {
    test("loginGoogle should return null in object and error", () async {
      when(authService.loginGoogle()).thenAnswer((_) async => (null, null));

      var (response, error) = await presenter.loginGoogle();

      verify(authService.loginGoogle());
      expect(response, null);
      expect(error, null);
    });

    test("loginGoogle should return User object is null and error = 500",
        () async {
      var err = HttpStatus.internalServerError;
      when(authService.loginGoogle()).thenAnswer((_) async => (null, err));

      var (response, error) = await presenter.loginGoogle();

      verify(authService.loginGoogle());
      expect(response, null);
      expect(error, err);
    });

    test("goToHome verify redirect go to home", () async {
      when(router.goToReplace(any)).thenAnswer((_) async => {});

      presenter.goToHome();

      verify(router.goToReplace(any));
    });

    test("onOpenScreen validate send tag analitcs", () {
      when(repository.sendOpenScreenEvent()).thenAnswer((_) async => {});

      presenter.onOpenScreen();

      verify(repository.sendOpenScreenEvent());
    });
  });
}

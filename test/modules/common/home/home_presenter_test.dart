import 'dart:io';

import 'package:cinco_minutos_meditacao/core/routers/app_router.dart';
import 'package:cinco_minutos_meditacao/core/routers/app_router.gr.dart';
import 'package:cinco_minutos_meditacao/modules/common/screens/home/home_contract.dart';
import 'package:cinco_minutos_meditacao/modules/common/screens/home/home_model.dart';
import 'package:cinco_minutos_meditacao/modules/common/screens/home/home_presenter.dart';
import 'package:cinco_minutos_meditacao/modules/common/screens/home/home_repository.dart';
import 'package:cinco_minutos_meditacao/shared/clients/models/responses/meditations_response.dart';
import 'package:cinco_minutos_meditacao/shared/clients/models/responses/user_response.dart';
import 'package:cinco_minutos_meditacao/shared/models/error.dart';
import 'package:cinco_minutos_meditacao/shared/services/auth_service.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'home_presenter_test.mocks.dart';

@GenerateMocks([AuthService, HomeRepository, AppRouter, HomeViewContract])
void main() {
  group("HomePresenter", () {
    late MockHomeViewContract mockView;
    late MockHomeRepository homeRepository;
    late MockAuthService authService;
    late MockAppRouter appRouter;
    late HomePresenter presenter;

    setUp(() {
      mockView = MockHomeViewContract();
      homeRepository = MockHomeRepository();
      authService = MockAuthService();
      appRouter = MockAppRouter();
      presenter = HomePresenter(authService, homeRepository, appRouter);
      presenter.view = mockView;
    });

    test("onOpenScreen", () {
      // Arrange
      when(homeRepository.sendOpenScreenEvent()).thenAnswer((_) async {});

      // Act
      presenter.onOpenScreen();

      // Assert
      verify(homeRepository.sendOpenScreenEvent());
    });

    test("logOut", () {
      // Arrange
      when(authService.logout()).thenAnswer((_) async {});
      when(homeRepository.logOut()).thenAnswer((_) async {});
      when(appRouter.goToReplace(const LoginRoute())).thenAnswer((_) async {});

      // Act
      presenter.logOut();

      // Assert
      verify(authService.logout());
      verify(homeRepository.logOut());
      verify(appRouter.goToReplace(const LoginRoute()));
    });

    test("initPresenter", () async {
      // Arrange
      when(homeRepository.sendOpenScreenEvent()).thenAnswer((_) async {});
      when(homeRepository.requestUser()).thenAnswer((_) async => (
            UserResponse(
                1,
                "name",
                "email",
                "avatar",
                "token",
                "phone",
                "document",
                "password",
                "createdAt",
                'masculino',
                '1983-07-02',
                'São Paulo'),
            null
          ));
      when(homeRepository.requestMeditations())
          .thenAnswer((_) async => (MeditationsResponse(1, 30), null));

      // Act
      await presenter.initPresenter();

      // Assert
      verify(homeRepository.sendOpenScreenEvent());
      verify(homeRepository.requestUser());
      verify(homeRepository.requestMeditations());
    });

    test("initPresenter with error in requestUser", () async {
      // Arrange
      when(homeRepository.sendOpenScreenEvent()).thenAnswer((_) async {});
      when(homeRepository.requestUser())
          .thenAnswer((_) async => (null, CustomError()));
      when(homeRepository.requestMeditations())
          .thenAnswer((_) async => (null, null));

      // Act
      await presenter.initPresenter();

      // Assert
      verify(homeRepository.sendOpenScreenEvent());
      verify(homeRepository.requestUser());
      verify(homeRepository.requestMeditations());
    });

    test("initPresenter with error in getMeditions", () async {
      // Arrange
      when(homeRepository.sendOpenScreenEvent()).thenAnswer((_) async {});
      when(homeRepository.requestUser()).thenAnswer((_) async => (
            UserResponse(
                1,
                "teste",
                "teste@gmail.com",
                "",
                "1",
                '1',
                "https://google.com",
                DateTime.now().toString(),
                DateTime.now().toString(),
                'masculino',
                '1983-07-02',
                'São Paulo'),
            null
          ));
      when(homeRepository.requestMeditations())
          .thenAnswer((_) async => (null, CustomError()));

      // Act
      await presenter.initPresenter();

      // Assert
      verify(homeRepository.sendOpenScreenEvent());
      verify(homeRepository.requestUser());
      verify(homeRepository.requestMeditations());
    });

    test('should call uploadImageProfile and update user profile on success',
        () async {
      final result = File(
          "/Users/marcospaulosousasantos/development/cincominutos-app/assets/images/Layer 1.svg"); // Simula o caminho da imagem retornada pela câmera
      final userResponse = UserResponse(
          1,
          "teste",
          "teste@gmail.com",
          "",
          "1",
          '1',
          "https://google.com",
          DateTime.now().toString(),
          DateTime.now().toString(),
          'masculino',
          '1983-07-02',
          'São Paulo'); // Simula a resposta do usuário

      when(appRouter.goTo(any, onClose: anyNamed('onClose')))
          .thenAnswer((invocation) {
        final onClose =
            invocation.namedArguments[const Symbol('onClose')] as Function;
        onClose(result);
      });
      when(homeRepository.uploadImageProfile(any))
          .thenAnswer((_) async => null);
      when(homeRepository.requestUser())
          .thenAnswer((_) async => (userResponse, null));
      when(mockView.showNormalState(any)).thenAnswer((_) {});

      await presenter.updateImageProfile();

      verify(appRouter.goTo(any, onClose: anyNamed('onClose'))).called(1);
      verify(homeRepository.uploadImageProfile(result)).called(1);
      verify(homeRepository.requestUser()).called(1);
    });

    test('should show error if uploadImageProfile fails', () async {
      final result = File(
          "/Users/marcospaulosousasantos/development/cincominutos-app/assets/images/Layer 1.svg"); // Simula o caminho da imagem retornada pela câmera// Simula o caminho da imagem retornada pela câmera
      final error = CustomError(); // Simula um erro de upload

      when(appRouter.goTo(any, onClose: anyNamed('onClose')))
          .thenAnswer((invocation) {
        final onClose =
            invocation.namedArguments[const Symbol('onClose')] as Function;
        onClose(result);
      });

      when(homeRepository.uploadImageProfile(result))
          .thenAnswer((_) async => error);

      await presenter.updateImageProfile();

      verify(homeRepository.uploadImageProfile(result)).called(1);
      verify(mockView.showError(error.getErrorMessage)).called(1);
    });

    test('should do nothing if result is null', () async {
      when(appRouter.goTo(any, onClose: anyNamed('onClose')))
          .thenAnswer((invocation) {
        final onClose =
            invocation.namedArguments[const Symbol('onClose')] as Function;
        onClose(null);
      });

      await presenter.updateImageProfile();

      verifyNever(homeRepository.uploadImageProfile(any));
      verifyNever(mockView.showError(any));
      verifyNever(mockView.showNormalState(any));
    });

    test(
        'goToMeditateInfo should navigate to MeditateInfoRoute with correct model',
        () {
      final homeModel = HomeModel(
        userResponse: UserResponse(
            1,
            "name",
            "email",
            "avatar",
            "token",
            "phone",
            "document",
            "password",
            "createdAt",
            'masculino',
            '1983-07-02',
            'São Paulo'),
        meditationsResponse: MeditationsResponse(1, 30),
      );

      presenter.goToMeditateInfo(homeModel);

      verify(appRouter.goTo(const MeditateInfoRoute())).called(1);
    });

    test('goToMeditateInfo should handle null userResponse gracefully', () {
      final homeModel = HomeModel(
        userResponse: null,
        meditationsResponse: MeditationsResponse(1, 30),
      );

      presenter.goToMeditateInfo(homeModel);

      verify(appRouter.goTo(const MeditateInfoRoute())).called(1);
    });

    test('goToMeditateInfo should handle null meditationsResponse gracefully',
        () {
      final homeModel = HomeModel(
        userResponse: UserResponse(
            1,
            "name",
            "email",
            "avatar",
            "token",
            "phone",
            "document",
            "password",
            "createdAt",
            'masculino',
            '1983-07-02',
            'São Paulo'),
        meditationsResponse: null,
      );

      presenter.goToMeditateInfo(homeModel);

      verify(appRouter.goTo(const MeditateInfoRoute())).called(1);
    });

    test('goToFiveMinutes should navigate to FiveMinutesRoute', () {
      presenter.goToFiveMinutes();

      verify(appRouter.goTo(const FiveMinutesRoute())).called(1);
    });

    test('goToFiveMinutes should not navigate if router is null', () {
      when(appRouter.goTo(any)).thenReturn(null);

      presenter.goToFiveMinutes();

      verify(appRouter.goTo(any));
    });
  });
}

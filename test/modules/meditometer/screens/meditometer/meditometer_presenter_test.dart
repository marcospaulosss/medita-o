import 'dart:io';

import 'package:cinco_minutos_meditacao/core/environment/manager.dart';
import 'package:cinco_minutos_meditacao/core/routers/app_router.dart';
import 'package:cinco_minutos_meditacao/modules/meditometer/screens/meditometer/meditometer_contract.dart';
import 'package:cinco_minutos_meditacao/modules/meditometer/screens/meditometer/meditometer_presenter.dart';
import 'package:cinco_minutos_meditacao/shared/clients/models/responses/meditations_response.dart';
import 'package:cinco_minutos_meditacao/shared/clients/models/responses/user_response.dart';
import 'package:cinco_minutos_meditacao/shared/models/error.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'meditometer_presenter_test.mocks.dart';

@GenerateMocks(
    [Repository, AppRouter, MeditometerViewContract, EnvironmentManager])
void main() {
  group('MeditometerPresenter', () {
    late MeditometerPresenter presenter;
    late MockRepository repository;
    late MockAppRouter router;
    late EnvironmentManager environmentManager;
    late MockMeditometerViewContract view;

    setUp(() {
      repository = MockRepository();
      router = MockAppRouter();
      view = MockMeditometerViewContract();
      environmentManager = MockEnvironmentManager();
      presenter = MeditometerPresenter(repository, router, environmentManager);
      presenter.view = view;
    });

    test('should send open screen event on open screen', () {
      presenter.onOpenScreen();

      verify(repository.sendOpenScreenEvent()).called(1);
    });

    test('should initialize presenter and show normal state', () async {
      final userResponse = UserResponse(
          1,
          'Test',
          'test@example.com',
          '12345',
          '12345',
          '12345',
          './assets/images/avatar.png',
          '2024-09-28',
          '2024-09-28',
          'Feminino',
          '1983-07-02',
          State(1, 'São Paulo', Country(1, 'Brasil')));
      final meditationsResponse = MeditationsResponse(100, 1);
      when(repository.requestUser())
          .thenAnswer((_) async => (userResponse, null));
      when(repository.requestMeditations())
          .thenAnswer((_) async => (meditationsResponse, null));

      await presenter.initPresenter();

      verify(view.showLoading()).called(1);
      verify(view.showNormalState(any)).called(1);
    });

    test('should show error if request user fails', () async {
      final error = CustomError();
      when(repository.requestUser()).thenAnswer((_) async => (null, error));

      await presenter.initPresenter();

      verify(view.showLoading()).called(1);
      verify(view.showError(error.getErrorMessage)).called(1);
    });

    test('should show error if request meditations fails', () async {
      final userResponse = UserResponse(
          1,
          'Test',
          'test@example.com',
          '12345',
          '12345',
          '12345',
          './assets/images/avatar.png',
          '2024-09-28',
          '2024-09-28',
          'Feminino',
          '1983-07-02',
          State(1, 'São Paulo', Country(1, 'Brasil')));
      final error = CustomError();
      when(repository.requestUser())
          .thenAnswer((_) async => (userResponse, null));
      when(repository.requestMeditations())
          .thenAnswer((_) async => (null, error));

      await presenter.initPresenter();

      verify(view.showLoading()).called(1);
      verify(view.showError(error.getErrorMessage)).called(1);
    });

    test('should update image profile and show normal state', () async {
      final userResponse = UserResponse(
          1,
          'Test',
          'test@example.com',
          '12345',
          '12345',
          '12345',
          './assets/images/avatar.png',
          '2024-09-28',
          '2024-09-28',
          'Feminino',
          '1983-07-02',
          State(1, 'São Paulo', Country(1, 'Brasil')));
      when(repository.uploadImageProfile(any)).thenAnswer((_) async => null);
      when(repository.requestUser())
          .thenAnswer((_) async => (userResponse, null));

      presenter.updateImageProfile();

      verify(router.goTo(any, onClose: anyNamed('onClose'))).called(1);
    });

    test('should show error if update image profile fails', () async {
      final error = CustomError();
      when(router.goTo(any, onClose: anyNamed('onClose')))
          .thenAnswer((invocation) {
        final onClose = invocation.namedArguments[const Symbol('onClose')]
            as Function(dynamic);
        onClose(error);
      });
      when(repository.uploadImageProfile(any)).thenAnswer((_) async => error);
      when(view.showError(any)).thenReturn(null);

      presenter.updateImageProfile();

      verify(router.goTo(any, onClose: anyNamed('onClose'))).called(1);
      verify(view.showError(any)).called(1);
    });

    test('should show error when uploadImageProfile fails', () async {
      const result = 'image_path';
      final customError = CustomError();

      when(router.goTo(any, onClose: anyNamed('onClose')))
          .thenAnswer((invocation) {
        final onClose = invocation.namedArguments[const Symbol('onClose')]
            as Function(dynamic);
        onClose(File(result));
      });

      when(repository.uploadImageProfile(any))
          .thenAnswer((_) async => customError);

      await presenter.updateImageProfile();

      verify(view.showError(customError.getErrorMessage)).called(1);
    });

    test('should show error when uploadImageProfile fails', () async {
      const result = 'image_path';
      final customError = CustomError();

      when(router.goTo(any, onClose: anyNamed('onClose')))
          .thenAnswer((invocation) {
        final onClose = invocation.namedArguments[const Symbol('onClose')]
            as Function(dynamic);
        onClose(File(result));
      });

      when(repository.uploadImageProfile(any))
          .thenAnswer((_) async => customError);

      await presenter.updateImageProfile();

      verify(view.showError(customError.getErrorMessage)).called(1);
    });

    test('should show error when requestUser fails', () async {
      const result = 'image_path';
      final customError = CustomError();

      when(router.goTo(any, onClose: anyNamed('onClose')))
          .thenAnswer((invocation) {
        final onClose = invocation.namedArguments[const Symbol('onClose')]
            as Function(dynamic);
        onClose(File(result));
      });

      when(repository.uploadImageProfile(any)).thenAnswer((_) async => null);
      when(repository.requestUser())
          .thenAnswer((_) async => (null, customError));

      await presenter.updateImageProfile();
    });

    test('should update profile image successfully', () async {
      const result = 'image_path';
      final userResponse = UserResponse(
          1,
          'teste',
          'teste@gmail.com',
          true,
          '1',
          '1',
          'https://google.com.br/image.png',
          DateTime.now().toString(),
          DateTime.now().toString(),
          'Feminino',
          '1983-07-02',
          State(
              1,
              'São Paulo',
              Country(1,
                  'Brasil'))); // Supondo que você tenha uma classe UserResponse

      when(repository.uploadImageProfile(any)).thenAnswer((_) async => null);
      when(repository.requestUser())
          .thenAnswer((_) async => (userResponse, null));
      when(view.showNormalState(any)).thenAnswer((_) {});
      when(router.goTo(any, onClose: anyNamed('onClose')))
          .thenAnswer((invocation) {
        final onClose = invocation.namedArguments[const Symbol('onClose')]
            as Function(dynamic);
        onClose(File(result));
      });

      await presenter.updateImageProfile();

      verify(repository.uploadImageProfile(any)).called(1);
      verify(repository.requestUser()).called(1);
      verify(router.goTo(any, onClose: anyNamed('onClose'))).called(1);
    });

    test('should navigate to about screen', () {
      presenter.goToAbout();

      verify(router.goTo(any)).called(1);
    });
  });
}

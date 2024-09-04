import 'dart:io';

import 'package:cinco_minutos_meditacao/core/routers/app_router.dart';
import 'package:cinco_minutos_meditacao/modules/meditate/screens/meditate_info/meditate_info_contract.dart';
import 'package:cinco_minutos_meditacao/modules/meditate/screens/meditate_info/meditate_info_model.dart';
import 'package:cinco_minutos_meditacao/modules/meditate/screens/meditate_info/meditate_info_presenter.dart';
import 'package:cinco_minutos_meditacao/modules/meditate/screens/meditate_info/meditate_info_repository.dart';
import 'package:cinco_minutos_meditacao/shared/clients/models/responses/meditations_response.dart';
import 'package:cinco_minutos_meditacao/shared/clients/models/responses/user_response.dart';
import 'package:cinco_minutos_meditacao/shared/models/error.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'meditate_info_presenter_test.mocks.dart';

@GenerateMocks([MeditateInfoViewContract, MeditateInfoRepository, AppRouter])
void main() {
  group('MeditateInfoPresenter', () {
    late MeditateInfoPresenter presenter;
    late MockMeditateInfoViewContract view;
    late MockMeditateInfoRepository repository;
    late MockAppRouter router;

    setUp(() {
      view = MockMeditateInfoViewContract();
      repository = MockMeditateInfoRepository();
      router = MockAppRouter();
      presenter = MeditateInfoPresenter(repository, router);
      presenter.view = view;
    });

    test('should call sendOpenScreenEvent when onOpenScreen is called', () {
      presenter.onOpenScreen();
      verify(repository.sendOpenScreenEvent()).called(1);
    });

    group('getMeditionsByUser', () {
      test(
          'should call getMeditionsByUser when initPresenter is called with return null',
          () async {
        final model = MeditateInfoModel();
        when(repository.requestMeditationsByUser())
            .thenAnswer((_) async => (null, null));
        when(repository.requestUser()).thenAnswer((_) async => (null, null));
        when(repository.requestMeditations())
            .thenAnswer((_) async => (null, null));
        await presenter.initPresenter();
        verify(view.showError('null safe')).called(1);
      });

      test(
          'should call getMeditionsByUser when initPresenter is called with return error',
          () async {
        final model = MeditateInfoModel();
        when(repository.requestMeditationsByUser())
            .thenAnswer((_) async => (null, CustomError()));
        when(repository.requestUser()).thenAnswer((_) async => (null, null));
        when(repository.requestMeditations())
            .thenAnswer((_) async => (null, null));

        await presenter.initPresenter();
        verify(view.showError('Erro desconhecido.')).called(1);
      });

      test(
          'should call getMeditionsByUser when initPresenter is called success',
          () async {
        final model = MeditateInfoModel();
        when(repository.requestMeditationsByUser())
            .thenAnswer((_) async => (MeditationsResponse(1, 10), null));
        when(repository.requestUser()).thenAnswer((_) async => (null, null));
        when(repository.requestMeditations())
            .thenAnswer((_) async => (null, null));

        await presenter.initPresenter();
        verify(view.showNormalState(model: anyNamed('model'))).called(1);
      });
    });

    group('updateImageProfile', () {
      test('should update profile image successfully', () async {
        final result = 'image_path';
        final userResponse = UserResponse(
            1,
            'teste',
            'teste@gmail.com',
            true,
            '1',
            '1',
            'https://google.com.br/image.png',
            DateTime.now().toString(),
            DateTime.now()
                .toString()); // Supondo que você tenha uma classe UserResponse

        when(repository.uploadImageProfile(any)).thenAnswer((_) async => null);
        when(repository.requestUser())
            .thenAnswer((_) async => (userResponse, null));
        when(view!.showNormalState(model: anyNamed('model')))
            .thenAnswer((_) {});
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
    });

    test('should show error when uploadImageProfile fails', () async {
      final result = 'image_path';
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
      final result = 'image_path';
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

    test('should do nothing when result is null', () async {
      when(router.goTo(any, onClose: anyNamed('onClose')))
          .thenAnswer((invocation) {
        final onClose = invocation.namedArguments[const Symbol('onClose')]
            as Function(dynamic);
        onClose(null);
      });

      await presenter.updateImageProfile();

      verifyNever(repository.uploadImageProfile(any));
      verifyNever(repository.requestUser());
      verifyNever(view.showError(any));
      verifyNever(view.showNormalState(model: anyNamed('model')));
    });

    test(
        'should call requestUser when initPresenter is called with return error',
        () async {
      final model = MeditateInfoModel();
      when(repository.requestUser())
          .thenAnswer((_) async => (null, CustomError()));
      when(repository.requestMeditations())
          .thenAnswer((_) async => (null, null));
      when(repository.requestMeditationsByUser())
          .thenAnswer((_) async => (null, null));
      await presenter.initPresenter();
      verify(view.showError('Erro desconhecido.')).called(1);
    });

    test(
        'should call requestMeditations when initPresenter is called with return error',
        () async {
      final model = MeditateInfoModel();
      when(repository.requestUser()).thenAnswer((_) async => (null, null));
      when(repository.requestMeditations())
          .thenAnswer((_) async => (null, CustomError()));
      when(repository.requestMeditationsByUser())
          .thenAnswer((_) async => (null, null));
      await presenter.initPresenter();
      verify(view.showError('Erro desconhecido.')).called(1);
    });
  });
}

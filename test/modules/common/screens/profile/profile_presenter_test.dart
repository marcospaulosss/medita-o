import 'dart:io';

import 'package:cinco_minutos_meditacao/core/routers/app_router.dart';
import 'package:cinco_minutos_meditacao/modules/common/screens/profile/profile_contract.dart';
import 'package:cinco_minutos_meditacao/modules/common/screens/profile/profile_presenter.dart';
import 'package:cinco_minutos_meditacao/shared/clients/models/responses/countries_response.dart';
import 'package:cinco_minutos_meditacao/shared/clients/models/responses/states_response.dart';
import 'package:cinco_minutos_meditacao/shared/clients/models/responses/user_response.dart';
import 'package:cinco_minutos_meditacao/shared/models/error.dart';
import 'package:cinco_minutos_meditacao/shared/services/auth_service.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'profile_presenter_test.mocks.dart';

@GenerateMocks([AuthService, Repository, AppRouter, ProfileViewContract])
void main() {
  late ProfilePresenter presenter;
  late MockAuthService mockAuthService;
  late MockRepository mockRepository;
  late MockAppRouter mockAppRouter;
  late MockProfileViewContract mockView;

  setUp(() {
    mockAuthService = MockAuthService();
    mockRepository = MockRepository();
    mockAppRouter = MockAppRouter();
    mockView = MockProfileViewContract();

    presenter = ProfilePresenter(
      mockAuthService,
      mockRepository,
      mockAppRouter,
    )..view = mockView;
  });

  group('ProfilePresenter', () {
    test('onOpenScreen should send open screen event', () {
      presenter.onOpenScreen();
      verify(mockRepository.sendOpenScreenEvent()).called(1);
    });

    test('logOut should call logout methods and navigate to login', () {
      when(mockAuthService.logout()).thenAnswer((_) => Future.value(null));
      when(mockRepository.logOut()).thenReturn(null);
      when(mockAppRouter.goToReplace(any)).thenAnswer((_) {});

      presenter.logOut();

      verify(mockAuthService.logout()).called(1);
      verify(mockRepository.logOut()).called(1);
      verify(mockAppRouter.goToReplace(any)).called(1);
    });

    test('initPresenter should show loading, fetch user, and show normal state',
        () async {
      UserResponse userResponse = UserResponse(
          1,
          'Test',
          'test@test.com',
          'teste',
          'googleId',
          'facebookId',
          'appleId',
          '23/04/2024',
          '23/04/2024',
          'masculino',
          '1983-07-02',
          'São Paulo');
      CountriesResponse countriesResponse =
          CountriesResponse([Countries(1, 'Brazil')]);
      when(mockRepository.requestUser())
          .thenAnswer((_) async => (userResponse, null));
      when(mockRepository.requestGetCountries())
          .thenAnswer((_) async => (countriesResponse, null));

      await presenter.initPresenter();

      verify(mockView.showLoading()).called(1);
      verify(mockRepository.requestUser()).called(1);
      verify(mockRepository.requestGetCountries()).called(1);
      expect(presenter.profileModel.userResponse, equals(userResponse));
      expect(presenter.profileModel.countryResponse, equals(countriesResponse));
      verify(mockView.showNormalState(presenter.profileModel)).called(1);
    });

    test('initPresenter should handle error and show error message', () async {
      final error = CustomError();
      when(mockRepository.requestUser()).thenAnswer((_) async => (null, error));

      await presenter.initPresenter();

      verify(mockView.showLoading()).called(1);
      verify(mockRepository.requestUser()).called(1);
      verify(mockView.showError(error.getErrorMessage)).called(1);
    });

    test(
        'initPresenter should handle error in requestGetCountries and show error message',
        () async {
      final error = CustomError();
      UserResponse userResponse = UserResponse(
          1,
          'Test',
          'test@test.com',
          'teste',
          'googleId',
          'facebookId',
          'appleId',
          '23/04/2024',
          '23/04/2024',
          'masculino',
          '1983-07-02',
          'São Paulo');
      when(mockRepository.requestUser())
          .thenAnswer((_) async => (userResponse, null));
      when(mockRepository.requestGetCountries())
          .thenAnswer((_) async => (null, error));

      await presenter.initPresenter();

      verify(mockView.showLoading()).called(1);
      verify(mockRepository.requestUser()).called(1);
      verify(mockRepository.requestGetCountries()).called(1);
      verify(mockView.showError(error.getErrorMessage)).called(1);
    });

    test('updateImageProfile should handle image update and refresh user data',
        () async {
      final imageFile = File('path/to/image');
      UserResponse userResponse = UserResponse(
          1,
          'Test',
          'test@test.com',
          'teste',
          'googleId',
          'facebookId',
          'appleId',
          '23/04/2024',
          '23/04/2024',
          'masculino',
          '1983-07-02',
          'São Paulo');
      final result = 'image_path';
      when(mockAppRouter.goTo(any, onClose: anyNamed('onClose')))
          .thenAnswer((invocation) {
        final onClose = invocation.namedArguments[const Symbol('onClose')]
            as Function(dynamic);
        onClose(File(result));
      });

      when(mockRepository.uploadImageProfile(any))
          .thenAnswer((_) async => null);
      when(mockRepository.requestUser())
          .thenAnswer((_) async => (userResponse, null));

      await presenter.updateImageProfile();

      verify(mockAppRouter.goTo(any, onClose: anyNamed('onClose'))).called(1);
      // Simula a ação de fechar com um arquivo de imagem como resultado
      verify(mockRepository.uploadImageProfile(any)).called(1);
      verify(mockRepository.requestUser()).called(1);
    });

    test('updateImageProfile should handle errors during image upload',
        () async {
      final error = CustomError();
      final result = 'image_path';

      when(mockAppRouter.goTo(any, onClose: anyNamed('onClose')))
          .thenAnswer((invocation) {
        final onClose = invocation.namedArguments[const Symbol('onClose')]
            as Function(dynamic);
        onClose(File(result));
      });

      when(mockRepository.uploadImageProfile(any))
          .thenAnswer((_) async => error);

      await presenter.updateImageProfile();

      verify(mockAppRouter.goTo(any, onClose: anyNamed('onClose'))).called(1);
      verify(mockRepository.uploadImageProfile(any)).called(1);
      verify(mockView.showError(error.getErrorMessage)).called(1);
    });

    test('updateImageProfile should handle errors during image get', () async {
      final error = CustomError();
      final result = CustomError();

      when(mockAppRouter.goTo(any, onClose: anyNamed('onClose')))
          .thenAnswer((invocation) {
        final onClose = invocation.namedArguments[const Symbol('onClose')]
            as Function(dynamic);
        onClose(error);
      });

      when(mockRepository.uploadImageProfile(any))
          .thenAnswer((_) async => error);

      await presenter.updateImageProfile();

      verify(mockAppRouter.goTo(any, onClose: anyNamed('onClose'))).called(1);
      verify(mockView.showError(error.getErrorMessage)).called(1);
    });

    test('getStates should handle image update and refresh user data',
        () async {
      StatesResponse statesResponse = StatesResponse([States(1, 1, 'Test')]);

      when(mockRepository.requestGetStatesByCountryId(any))
          .thenAnswer((_) async => (statesResponse, null));

      await presenter.getStates(1);

      verify(mockRepository.requestGetStatesByCountryId(any)).called(1);
      verify(mockView.showNormalState(any)).called(1);
    });
  });

  test('getStates should show error message when request fails', () async {
    when(mockRepository.requestGetStatesByCountryId(any))
        .thenAnswer((_) async => (null, CustomError()));

    await presenter.getStates(1);

    verify(mockRepository.requestGetStatesByCountryId(any)).called(1);
    verify(mockView.showError(any)).called(1);
  });
}

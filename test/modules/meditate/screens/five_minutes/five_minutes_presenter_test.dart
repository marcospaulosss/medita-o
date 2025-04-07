import 'package:cinco_minutos_meditacao/core/routers/app_router.dart';
import 'package:cinco_minutos_meditacao/core/routers/app_router.gr.dart';
import 'package:cinco_minutos_meditacao/modules/meditate/screens/five_minutes/five_minutes_contract.dart';
import 'package:cinco_minutos_meditacao/modules/meditate/screens/five_minutes/five_minutes_presenter.dart';
import 'package:cinco_minutos_meditacao/modules/share/screens/meditometer/share_model.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'five_minutes_presenter_test.mocks.dart';

@GenerateMocks([Repository, AppRouter, FiveMinutesViewContract])
void main() {
  group('FiveMinutesPresenter', () {
    late FiveMinutesPresenter presenter;
    late MockRepository repository;
    late MockAppRouter router;
    late MockFiveMinutesViewContract view;

    setUp(() {
      repository = MockRepository();
      router = MockAppRouter();
      view = MockFiveMinutesViewContract();
      presenter = FiveMinutesPresenter(repository, router);
      presenter.view = view;
    });

    test('should send open screen event on open screen', () {
      // Arrange
      when(repository.sendOpenScreenEvent()).thenReturn(null);

      // Act
      presenter.onOpenScreen();

      // Assert
      verify(repository.sendOpenScreenEvent()).called(1);
    });

    test('should navigate to meditate info screen', () {
      // Arrange
      when(router.goTo(const MeditateInfoRoute())).thenReturn(null);

      // Act
      presenter.goToMeditateInfo();

      // Assert
      verify(router.goTo(const MeditateInfoRoute())).called(1);
    });

    test('should submit meditation completed and navigate to share screen', () async {
      // Arrange
      const time = 5;
      when(repository.requestRegisterMeditateCompleted(time))
          .thenAnswer((_) async => null);
      when(router.goTo(any)).thenReturn(null);

      // Act
      await presenter.submitMeditateCompleted(time);

      // Assert
      verify(repository.requestRegisterMeditateCompleted(time)).called(1);
      verify(view?.meditationCompleted()).called(1);
      verify(router.goTo(ShareRoute(
        params: ShareModel(type: ShareType.defaultShare),
      ))).called(1);
    });

    test('should navigate to share screen', () {
      // Arrange
      when(router.goTo(any)).thenReturn(null);

      // Act
      presenter.goToShare();

      // Assert
      verify(router.goTo(ShareRoute(
        params: ShareModel(type: ShareType.defaultShare),
      ))).called(1);
    });
  });
} 
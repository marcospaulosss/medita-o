import 'package:cinco_minutos_meditacao/core/routers/app_router.dart';
import 'package:cinco_minutos_meditacao/modules/meditate/screens/guided_meditation/guided_meditation_contract.dart';
import 'package:cinco_minutos_meditacao/modules/meditate/screens/guided_meditation/guided_meditation_presenter.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'guided_meditation_presenter_test.mocks.dart';

@GenerateMocks([Repository, AppRouter, GuidedMeditationViewContract])
void main() {
  group('GuidedMeditationPresenter', () {
    late GuidedMeditationPresenter presenter;
    late MockRepository repository;
    late MockAppRouter router;
    late MockGuidedMeditationViewContract view;

    setUp(() {
      repository = MockRepository();
      router = MockAppRouter();
      view = MockGuidedMeditationViewContract();
      presenter = GuidedMeditationPresenter(repository, router);
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

    test('should initialize presenter and send open screen event', () async {
      // Arrange
      when(repository.sendOpenScreenEvent()).thenReturn(null);

      // Act
      await presenter.initPresenter();

      // Assert
      verify(repository.sendOpenScreenEvent()).called(1);
    });
  });
}

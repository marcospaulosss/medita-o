import 'package:cinco_minutos_meditacao/core/routers/app_router.dart';
import 'package:cinco_minutos_meditacao/core/routers/app_router.gr.dart';
import 'package:cinco_minutos_meditacao/modules/meditate/screens/guided_meditation_program/guided_meditation_program_contract.dart';
import 'package:cinco_minutos_meditacao/modules/meditate/screens/guided_meditation_program/guided_meditation_program_presenter.dart';
import 'package:cinco_minutos_meditacao/modules/meditate/screens/guided_meditation_program/guided_meditation_program_repository.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'guided_meditation_program_presenter_test.mocks.dart';

@GenerateMocks([
  GuidedMeditationProgramRepository,
  AppRouter,
  GuidedMeditationProgramViewContract
])
void main() {
  group('FiveMinutesPresenter', () {
    late GuidedMeditationProgramPresenter presenter;
    late MockGuidedMeditationProgramRepository repository;
    late MockAppRouter router;

    setUp(() {
      repository = MockGuidedMeditationProgramRepository();
      router = MockAppRouter();
      presenter = GuidedMeditationProgramPresenter(repository, router);
      presenter.view = MockGuidedMeditationProgramViewContract();
    });

    test('should call sendOpenScreenEvent when onOpenScreen is called', () {
      when(repository.sendOpenScreenEvent()).thenAnswer((_) async {});

      presenter.onOpenScreen();

      verify(repository.sendOpenScreenEvent()).called(1);
    });

    test('should call goToMeditateInfo when goToMeditateInfo is called', () {
      presenter.goToGuidedMeditation();

      verify(router.goTo(const GuidedMeditationRoute())).called(1);
    });

    test(
        'should call requestRegisterMeditateCompleted and meditationCompleted when submitMeditateCompleted is called',
        () async {
      when(repository.requestRegisterMeditateCompleted(5))
          .thenAnswer((_) async {});

      await presenter.submitMeditateCompleted(5);

      verify(repository.requestRegisterMeditateCompleted(5)).called(1);
      verify(presenter.view?.meditationCompleted()).called(1);
    });
  });
}

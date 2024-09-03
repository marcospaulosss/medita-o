import 'package:cinco_minutos_meditacao/core/routers/app_router.dart';
import 'package:cinco_minutos_meditacao/modules/meditate/screens/in_your_time/in_your_time_contract.dart';
import 'package:cinco_minutos_meditacao/modules/meditate/screens/in_your_time/in_your_time_presenter.dart';
import 'package:cinco_minutos_meditacao/modules/meditate/screens/in_your_time/in_your_time_repository.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'in_your_time_presenter_test.mocks.dart';

@GenerateMocks([InYourTimeRepository, AppRouter, InYourTimeContract])
void main() {
  group('InYourTimePresenter', () {
    late InYourTimePresenter presenter;
    late MockInYourTimeRepository repository;
    late MockAppRouter router;
    late MockInYourTimeContract view;

    setUp(() {
      repository = MockInYourTimeRepository();
      router = MockAppRouter();
      view = MockInYourTimeContract();
      presenter = InYourTimePresenter(repository, router);
    });

    test('should call sendOpenScreenEvent when onOpenScreen is called', () {
      when(repository.sendOpenScreenEvent()).thenAnswer((_) async {});

      presenter.onOpenScreen();

      verify(repository.sendOpenScreenEvent()).called(1);
    });

    test(
        'submitMeditateCompleted should call requestRegisterMeditateCompleted and meditationCompleted',
        () async {
      when(repository.requestRegisterMeditateCompleted(any))
          .thenAnswer((_) async {});
      when(view.meditationCompleted()).thenAnswer((_) {});

      await presenter.submitMeditateCompleted(5);

      verify(repository.requestRegisterMeditateCompleted(any)).called(1);
    });
  });
}

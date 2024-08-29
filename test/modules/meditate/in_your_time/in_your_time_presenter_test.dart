import 'package:cinco_minutos_meditacao/core/routers/app_router.dart';
import 'package:cinco_minutos_meditacao/modules/meditate/screens/five_minutes/five_minutes_presenter.dart';
import 'package:cinco_minutos_meditacao/modules/meditate/screens/five_minutes/five_minutes_repository.dart';
import 'package:cinco_minutos_meditacao/modules/meditate/screens/in_your_time/in_your_time_presenter.dart';
import 'package:cinco_minutos_meditacao/modules/meditate/screens/in_your_time/in_your_time_repository.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'in_your_time_presenter_test.mocks.dart';

@GenerateMocks([InYourTimeRepository, AppRouter])
void main() {
  group('InYourTimePresenter', () {
    late InYourTimePresenter presenter;
    late MockInYourTimeRepository repository;
    late MockAppRouter router;

    setUp(() {
      repository = MockInYourTimeRepository();
      router = MockAppRouter();
      presenter = InYourTimePresenter(repository, router);
    });

    test('should call sendOpenScreenEvent when onOpenScreen is called', () {
      when(repository.sendOpenScreenEvent()).thenAnswer((_) async {});

      presenter.onOpenScreen();

      verify(repository.sendOpenScreenEvent()).called(1);
    });
  });
}

import 'package:cinco_minutos_meditacao/core/routers/app_router.dart';
import 'package:cinco_minutos_meditacao/modules/meditate/screens/five_minutes/five_minutes_presenter.dart';
import 'package:cinco_minutos_meditacao/modules/meditate/screens/five_minutes/five_minutes_repository.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'five_minutes_presenter_test.mocks.dart';

@GenerateMocks([FiveMinutesRepository, AppRouter])
void main() {
  group('FiveMinutesPresenter', () {
    late FiveMinutesPresenter presenter;
    late MockFiveMinutesRepository repository;
    late MockAppRouter router;

    setUp(() {
      repository = MockFiveMinutesRepository();
      router = MockAppRouter();
      presenter = FiveMinutesPresenter(repository, router);
    });

    test('should call sendOpenScreenEvent when onOpenScreen is called', () {
      when(repository.sendOpenScreenEvent()).thenAnswer((_) async {});

      presenter.onOpenScreen();

      verify(repository.sendOpenScreenEvent()).called(1);
    });
  });
}

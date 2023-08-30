import 'package:cinco_minutos_meditacao/modules/common/screens/home/home_presenter.dart';
import 'package:cinco_minutos_meditacao/modules/common/screens/home/home_repository.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'home_presenter_test.mocks.dart';

@GenerateMocks([HomeRepository])
void main() {
  group("HomePresenter", () {
    late HomeRepository homeRepository;
    late HomePresenter presenter;

    setUp(() {
      homeRepository = MockHomeRepository();
      presenter = HomePresenter(homeRepository);
    });

    test("onOpenScreen", () {
      // Arrange
      when(homeRepository.sendOpenScreenEvent()).thenAnswer((_) async {});

      // Act
      presenter.onOpenScreen();

      // Assert
      verify(homeRepository.sendOpenScreenEvent());
    });
  });
}

import 'package:auto_route/auto_route.dart';
import 'package:cinco_minutos_meditacao/core/routers/app_router.dart';
import 'package:cinco_minutos_meditacao/modules/common/screens/home/home_presenter.dart';
import 'package:cinco_minutos_meditacao/modules/common/screens/home/home_repository.dart';
import 'package:cinco_minutos_meditacao/shared/services/auth_service.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'home_presenter_test.mocks.dart';

@GenerateMocks([AuthService, HomeRepository, AppRouter])
void main() {
  group("HomePresenter", () {
    late HomeRepository homeRepository;
    late AuthService authService;
    late AppRouter appRouter;
    late HomePresenter presenter;

    setUp(() {
      homeRepository = MockHomeRepository();
      authService = MockAuthService();
      appRouter = MockAppRouter();
      presenter = HomePresenter(authService, homeRepository, appRouter);
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

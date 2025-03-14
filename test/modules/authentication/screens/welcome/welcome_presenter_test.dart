import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:cinco_minutos_meditacao/core/routers/app_router.dart';
import 'package:cinco_minutos_meditacao/core/routers/app_router.gr.dart';
import 'package:cinco_minutos_meditacao/modules/authentication/screens/welcome/welcome_contracts.dart';
import 'package:cinco_minutos_meditacao/modules/authentication/screens/welcome/welcome_presenter.dart';
import 'package:cinco_minutos_meditacao/modules/authentication/screens/welcome/welcome_repository.dart';

import 'welcome_presenter_test.mocks.dart';

@GenerateMocks([
  AppRouter,
  Repository,
  WelcomeViewContract,
])
void main() {
  late WelcomePresenter presenter;
  late MockAppRouter mockRouter;
  late MockRepository mockRepository;
  late MockWelcomeViewContract mockView;

  setUp(() {
    mockRouter = MockAppRouter();
    mockRepository = MockRepository();
    mockView = MockWelcomeViewContract();
    presenter = WelcomePresenter(mockRouter, mockRepository);
    presenter.view = mockView;
  });

  group('onOpenScreen', () {
    test('deve chamar sendOpenScreenEvent do repository', () async {
      // Arrange
      when(mockRepository.sendOpenScreenEvent()).thenAnswer((_) async {});

      // Act
      await presenter.onOpenScreen();

      // Assert
      verify(mockRepository.sendOpenScreenEvent()).called(1);
    });
  });

  group('navigateToLogin', () {
    test('deve navegar para HomeRoute quando usuário está logado', () async {
      // Arrange
      when(mockRepository.isLogged()).thenAnswer((_) async => true);
      when(mockRouter.goToReplace(any)).thenAnswer((_) async {});

      // Act
      await presenter.navigateToLogin();

      // Assert
      verify(mockRouter.goToReplace(const HomeRoute())).called(1);
    });

    test('deve navegar para LoginRoute quando usuário não está logado', () async {
      // Arrange
      when(mockRepository.isLogged()).thenAnswer((_) async => false);
      when(mockRouter.goToReplace(any)).thenAnswer((_) async {});

      // Act
      await presenter.navigateToLogin();

      // Assert
      verify(mockRouter.goToReplace(const LoginRoute())).called(1);
    });
  });
} 
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:get_it/get_it.dart';
import 'package:cinco_minutos_meditacao/core/routers/app_router.dart';
import 'package:cinco_minutos_meditacao/core/routers/app_router.gr.dart';
import 'package:cinco_minutos_meditacao/core/analytics/manager.dart';
import 'package:cinco_minutos_meditacao/core/wrappers/secure_storage.dart';
import 'package:cinco_minutos_meditacao/modules/authentication/screens/welcome/welcome_presenter.dart';
import 'package:cinco_minutos_meditacao/modules/authentication/screens/welcome/welcome_repository.dart';
import 'package:cinco_minutos_meditacao/modules/authentication/screens/welcome/welcome_view.dart';
import 'package:cinco_minutos_meditacao/modules/authentication/shared/strings/localization/authentication_strings.dart';

import 'welcome_widget_test.mocks.dart';

@GenerateMocks([
  AppRouter,
  AnalyticsManager,
  SecureStorage,
])
void main() {
  late MockAppRouter mockRouter;
  late MockAnalyticsManager mockAnalyticsManager;
  late MockSecureStorage mockSecureStorage;
  late WelcomeRepository repository;
  late WelcomePresenter presenter;
  final getIt = GetIt.instance;

  setUp(() {
    mockRouter = MockAppRouter();
    mockAnalyticsManager = MockAnalyticsManager();
    mockSecureStorage = MockSecureStorage();
    repository = WelcomeRepository(mockAnalyticsManager, mockSecureStorage);
    presenter = WelcomePresenter(mockRouter, repository);

    // Registra as dependências no GetIt
    if (getIt.isRegistered<WelcomePresenter>()) {
      getIt.unregister<WelcomePresenter>();
    }
    getIt.registerFactory<WelcomePresenter>(() => presenter);
  });

  tearDown(() {
    if (getIt.isRegistered<WelcomePresenter>()) {
      getIt.unregister<WelcomePresenter>();
    }
  });

  Widget createTestableWidget() {
    return const MaterialApp(
      localizationsDelegates: [
        ...AuthenticationStrings.localizationsDelegates,
      ],
      supportedLocales: AuthenticationStrings.supportedLocales,
      home: WelcomeView(),
    );
  }

  group('Tela de boas-vindas - Testes de Widget', () {
    group('Fluxo de usuário logado', () {
      testWidgets('deve navegar para HomeRoute quando usuário está logado',
          (WidgetTester tester) async {
        // Arrange
        when(mockSecureStorage.isLogged).thenAnswer((_) async => true);
        when(mockRouter.goToReplace(any)).thenAnswer((_) async {});

        // Act
        await tester.pumpWidget(createTestableWidget());
        await tester.pumpAndSettle();

        // Verifica se o evento de abertura da tela foi enviado
        verify(mockAnalyticsManager.sendEvent(any)).called(1);

        // Encontra e pressiona o botão
        final button = find.byType(ElevatedButton);
        await tester.tap(button);
        await tester.pumpAndSettle();

        // Assert
        verify(mockSecureStorage.isLogged).called(1);
        verify(mockRouter.goToReplace(const HomeRoute())).called(1);
      });
    });

    group('Fluxo de usuário não logado', () {
      testWidgets('deve navegar para LoginRoute quando usuário não está logado',
          (WidgetTester tester) async {
        // Arrange
        when(mockSecureStorage.isLogged).thenAnswer((_) async => false);
        when(mockRouter.goToReplace(any)).thenAnswer((_) async {});

        // Act
        await tester.pumpWidget(createTestableWidget());
        await tester.pumpAndSettle();

        // Verifica se o evento de abertura da tela foi enviado
        verify(mockAnalyticsManager.sendEvent(any)).called(1);

        // Encontra e pressiona o botão
        final button = find.byType(ElevatedButton);
        await tester.tap(button);
        await tester.pumpAndSettle();

        // Assert
        verify(mockSecureStorage.isLogged).called(1);
        verify(mockRouter.goToReplace(const LoginRoute())).called(1);
      });
    });

    group('Elementos visuais e acessibilidade', () {
      testWidgets('deve renderizar todos os elementos corretamente',
          (WidgetTester tester) async {
        // Act
        await tester.pumpWidget(createTestableWidget());
        await tester.pumpAndSettle();

        // Assert
        expect(find.byType(Image), findsOneWidget);
        expect(find.byType(ElevatedButton), findsOneWidget);
        expect(find.byType(RichText), findsNWidgets(3));
        expect(
          find.bySemanticsLabel('Logo 5 Minutos Eu Medito'),
          findsOneWidget,
        );
      });
    });
  });
} 
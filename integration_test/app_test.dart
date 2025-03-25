import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:get_it/get_it.dart';
import 'package:mockito/mockito.dart';
import 'package:cinco_minutos_meditacao/core/routers/app_router.dart';
import 'package:cinco_minutos_meditacao/core/analytics/manager.dart';
import 'package:cinco_minutos_meditacao/core/wrappers/secure_storage.dart';
import 'package:cinco_minutos_meditacao/modules/authentication/screens/welcome/welcome_presenter.dart';
import 'package:cinco_minutos_meditacao/modules/authentication/screens/welcome/welcome_repository.dart';
import 'package:cinco_minutos_meditacao/modules/authentication/screens/welcome/welcome_view.dart';
import 'package:cinco_minutos_meditacao/modules/authentication/shared/strings/localization/authentication_strings.dart';

class MockAppRouter extends Mock implements AppRouter {}
class MockAnalyticsManager extends Mock implements AnalyticsManager {}
class MockSecureStorage extends Mock implements SecureStorage {
  @override
  Future<bool> get isLogged => Future.value(false);
}

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

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
    return MaterialApp(
      localizationsDelegates: const [
        ...AuthenticationStrings.localizationsDelegates,
      ],
      supportedLocales: AuthenticationStrings.supportedLocales,
      home: const WelcomeView(),
    );
  }

  group('Tela de boas-vindas - Testes de Integração', () {
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

    testWidgets('deve ser possível interagir com o botão',
        (WidgetTester tester) async {
      // Act
      await tester.pumpWidget(createTestableWidget());
      await tester.pumpAndSettle();

      // Encontra e pressiona o botão
      final button = find.byType(ElevatedButton);
      await tester.tap(button);
      await tester.pumpAndSettle();
    });
  });
} 
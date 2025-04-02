import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:get_it/get_it.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cinco_minutos_meditacao/core/routers/app_router.dart';
import 'package:cinco_minutos_meditacao/core/analytics/manager.dart';
import 'package:cinco_minutos_meditacao/core/wrappers/secure_storage.dart';
import 'package:cinco_minutos_meditacao/modules/authentication/screens/welcome/welcome_view.dart';
import 'package:cinco_minutos_meditacao/modules/authentication/screens/welcome/welcome_presenter.dart';
import 'package:cinco_minutos_meditacao/modules/authentication/screens/welcome/welcome_repository.dart';
import 'package:cinco_minutos_meditacao/modules/authentication/shared/strings/localization/authentication_strings.dart';
import 'package:cinco_minutos_meditacao/shared/Theme/app_colors.dart';
import 'package:cinco_minutos_meditacao/core/firebase/firebase_options.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  late AppRouter router;
  late AnalyticsManager analyticsManager;
  late SecureStorage secureStorage;
  late WelcomeRepository repository;
  late WelcomePresenter presenter;
  final getIt = GetIt.instance;

  setUpAll(() async {
    // Inicializa o Firebase com as opções corretas
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
  });

  setUp(() {
    // Inicializa as dependências reais
    router = AppRouter();
    analyticsManager = AnalyticsManager();
    secureStorage = SecureStorage();
    repository = WelcomeRepository(analyticsManager, secureStorage);
    presenter = WelcomePresenter(router, repository);

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
      localizationsDelegates: [
        ...AuthenticationStrings.localizationsDelegates,
      ],
      supportedLocales: AuthenticationStrings.supportedLocales,
      home: const WelcomeView(),
    );
  }

  group('Tela de Boas-vindas - Testes de Integração', () {
    testWidgets('deve renderizar todos os elementos principais corretamente',
        (WidgetTester tester) async {
      // Act
      await tester.pumpWidget(createTestableWidget());
      await tester.pumpAndSettle();

      // Assert
      // Verifica se o logo está presente
      expect(find.bySemanticsLabel('Logo 5 Minutos Eu Medito'), findsOneWidget);
      
      // Verifica se o botão principal está presente
      expect(find.byType(ElevatedButton), findsOneWidget);
      
      // Verifica se os textos estão presentes
      expect(find.byType(RichText), findsNWidgets(3));
    });

    testWidgets('deve ter o estilo visual correto',
        (WidgetTester tester) async {
      // Act
      await tester.pumpWidget(createTestableWidget());
      await tester.pumpAndSettle();

      // Assert
      // Verifica se o botão tem a cor correta
      final button = tester.widget<ElevatedButton>(find.byType(ElevatedButton));
      final backgroundColor = button.style?.backgroundColor?.resolve({});
      expect(backgroundColor, isNotNull);
      expect(backgroundColor!.value, equals(const Color(0xFF7CC5FF).value));
    });

    testWidgets('deve ser possível interagir com o botão de entrada',
        (WidgetTester tester) async {
      // Act
      await tester.pumpWidget(createTestableWidget());
      await tester.pumpAndSettle();

      // Encontra e pressiona o botão
      final button = find.byType(ElevatedButton);
      await tester.tap(button);
      await tester.pumpAndSettle();

      // Assert
      // Aqui você pode adicionar verificações específicas sobre o que deve acontecer
      // após pressionar o botão, como navegação para outra tela
    });

    testWidgets('deve manter o layout responsivo em diferentes tamanhos de tela',
        (WidgetTester tester) async {
      // Act
      await tester.pumpWidget(createTestableWidget());
      await tester.pumpAndSettle();

      // Testa em diferentes tamanhos de tela
      await tester.binding.setSurfaceSize(const Size(375, 812)); // iPhone X
      await tester.pumpAndSettle();
      expect(find.byType(WelcomeView), findsOneWidget);

      await tester.binding.setSurfaceSize(const Size(414, 896)); // iPhone 11
      await tester.pumpAndSettle();
      expect(find.byType(WelcomeView), findsOneWidget);

      await tester.binding.setSurfaceSize(const Size(428, 926)); // iPhone 13 Pro Max
      await tester.pumpAndSettle();
      expect(find.byType(WelcomeView), findsOneWidget);
    });
  });
} 
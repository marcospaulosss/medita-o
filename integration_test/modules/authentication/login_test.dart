import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:get_it/get_it.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:cinco_minutos_meditacao/core/routers/app_router.dart';
import 'package:cinco_minutos_meditacao/core/analytics/manager.dart';
import 'package:cinco_minutos_meditacao/core/wrappers/secure_storage.dart';
import 'package:cinco_minutos_meditacao/modules/authentication/screens/welcome/welcome_view.dart';
import 'package:cinco_minutos_meditacao/modules/authentication/screens/welcome/welcome_presenter.dart';
import 'package:cinco_minutos_meditacao/modules/authentication/screens/welcome/welcome_repository.dart';
import 'package:cinco_minutos_meditacao/modules/authentication/screens/login/login_view.dart';
import 'package:cinco_minutos_meditacao/modules/authentication/screens/login/login_presenter.dart';
import 'package:cinco_minutos_meditacao/modules/authentication/screens/login/login_repository.dart';
import 'package:cinco_minutos_meditacao/modules/authentication/shared/strings/localization/authentication_strings.dart';
import 'package:cinco_minutos_meditacao/shared/Theme/app_colors.dart';
import 'package:cinco_minutos_meditacao/core/firebase/firebase_options.dart';
import 'package:cinco_minutos_meditacao/shared/clients/client_api.dart';
import 'package:cinco_minutos_meditacao/shared/models/error.dart';
import 'package:cinco_minutos_meditacao/shared/services/auth_service.dart';
import 'package:cinco_minutos_meditacao/core/environment/manager.dart';
import 'package:cinco_minutos_meditacao/shared/clients/interceptor.dart';
import 'package:cinco_minutos_meditacao/shared/components/icon_label_button.dart';
import 'package:cinco_minutos_meditacao/shared/components/text_field_input.dart';
import 'package:cinco_minutos_meditacao/shared/components/loading.dart';
import 'package:auto_route/auto_route.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  late AppRouter router;
  late AnalyticsManager analyticsManager;
  late SecureStorage secureStorage;
  late WelcomeRepository welcomeRepository;
  late WelcomePresenter welcomePresenter;
  late LoginRepository loginRepository;
  late LoginPresenter loginPresenter;
  late ClientApi clientApi;
  late CustomError customError;
  late AuthService authService;
  late EnvironmentManager environmentManager;
  late TokenInterceptor tokenInterceptor;
  final getIt = GetIt.instance;

  setUpAll(() async {
    // Inicializa o Firebase com as opções corretas
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );

    // Inicializa o flutter_dotenv
    await dotenv.load(fileName: ".env");
  });

  setUp(() async {
    // Inicializa as dependências reais
    router = AppRouter();
    analyticsManager = AnalyticsManager();
    secureStorage = SecureStorage();
    environmentManager = EnvironmentManager();
    tokenInterceptor = TokenInterceptor(router, secureStorage);
    clientApi = ClientApi(environmentManager, tokenInterceptor);
    customError = CustomError();
    authService = AuthService();
    
    // Welcome
    welcomeRepository = WelcomeRepository(analyticsManager, secureStorage);
    welcomePresenter = WelcomePresenter(router, welcomeRepository);
    
    // Login
    loginRepository = LoginRepository(
      analyticsManager,
      clientApi,
      customError,
      secureStorage,
    );
    loginPresenter = LoginPresenter(
      authService,
      customError,
      router,
      loginRepository,
      environmentManager,
    );

    // Registra as dependências no GetIt
    if (getIt.isRegistered<WelcomePresenter>()) {
      getIt.unregister<WelcomePresenter>();
    }
    if (getIt.isRegistered<LoginPresenter>()) {
      getIt.unregister<LoginPresenter>();
    }
    
    getIt.registerFactory<WelcomePresenter>(() => welcomePresenter);
    getIt.registerFactory<LoginPresenter>(() => loginPresenter);

    // Limpa o storage
    await secureStorage.setAllToNull();
  });

  tearDown(() {
    if (getIt.isRegistered<WelcomePresenter>()) {
      getIt.unregister<WelcomePresenter>();
    }
    if (getIt.isRegistered<LoginPresenter>()) {
      getIt.unregister<LoginPresenter>();
    }
  });

  group('Fluxo de Login - Testes de Integração', () {
    testWidgets('deve navegar da tela de boas-vindas para a tela de login',
        (WidgetTester tester) async {
      // Act
      await tester.pumpWidget(MaterialApp.router(
        localizationsDelegates: const [
          ...AuthenticationStrings.localizationsDelegates,
        ],
        supportedLocales: AuthenticationStrings.supportedLocales,
        routerDelegate: router.delegate(),
        routeInformationParser: router.defaultRouteParser(),
      ));
      await tester.pumpAndSettle();

      // Encontra e pressiona o botão de entrada
      final button = find.byType(ElevatedButton);
      await tester.tap(button);
      await tester.pumpAndSettle();

      // Assert
      expect(find.byType(LoginView), findsOneWidget);
    });

    testWidgets('deve mostrar erro ao tentar fazer login com email inválido',
        (WidgetTester tester) async {
      // Act
      await tester.pumpWidget(const MaterialApp(
        localizationsDelegates: [
          ...AuthenticationStrings.localizationsDelegates,
        ],
        supportedLocales: AuthenticationStrings.supportedLocales,
        home: LoginView(),
      ));
      await tester.pumpAndSettle();

      // Preenche o formulário com email inválido
      await tester.enterText(find.byType(TextFormField).first, 'email_invalido');
      await tester.enterText(find.byType(TextFormField).last, '123456');
      await tester.tap(find.text('Fazer Login'));
      await tester.pumpAndSettle();

      // Assert
      expect(find.text('E-mail inválido'), findsOneWidget);
    });

    testWidgets('deve mostrar erro ao tentar fazer login com senha vazia',
        (WidgetTester tester) async {
      // Act
      await tester.pumpWidget(const MaterialApp(
        localizationsDelegates: [
          ...AuthenticationStrings.localizationsDelegates,
        ],
        supportedLocales: AuthenticationStrings.supportedLocales,
        home: LoginView(),
      ));
      await tester.pumpAndSettle();

      // Preenche apenas o email
      await tester.enterText(find.byType(TextFormField).first, 'test@test.com');
      await tester.enterText(find.byType(TextFormField).last, '');
      await tester.tap(find.text('Fazer Login'));
      await tester.pump();
      await tester.pumpAndSettle();

      // Assert
      expect(find.text('Campo obrigatório'), findsOneWidget);
    });
  });
} 
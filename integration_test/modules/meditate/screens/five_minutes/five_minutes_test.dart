import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:get_it/get_it.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:cinco_minutos_meditacao/core/routers/app_router.dart';
import 'package:cinco_minutos_meditacao/core/analytics/manager.dart';
import 'package:cinco_minutos_meditacao/core/wrappers/secure_storage.dart';
import 'package:cinco_minutos_meditacao/modules/meditate/screens/five_minutes/five_minutes_presenter.dart';
import 'package:cinco_minutos_meditacao/modules/meditate/screens/five_minutes/five_minutes_repository.dart';
import 'package:cinco_minutos_meditacao/modules/meditate/screens/five_minutes/five_minutes_view.dart';
import 'package:cinco_minutos_meditacao/modules/meditate/screens/five_minutes/five_minutes_contract.dart';
import 'package:cinco_minutos_meditacao/shared/clients/client_api.dart';
import 'package:cinco_minutos_meditacao/shared/models/error.dart';
import 'package:cinco_minutos_meditacao/shared/Theme/app_tracks.dart';
import 'package:cinco_minutos_meditacao/modules/meditate/shared/components/player.dart';
import 'package:cinco_minutos_meditacao/modules/meditate/analytics/events.dart';
import 'package:cinco_minutos_meditacao/core/routers/app_router.gr.dart';
import 'package:cinco_minutos_meditacao/modules/meditate/shared/strings/localization/meditate_strings.dart';
import 'package:cinco_minutos_meditacao/core/analytics/event.dart';
import 'package:just_audio/just_audio.dart';

class MockAppRouter extends Mock implements AppRouter {}
class MockAnalyticsManager extends Mock implements AnalyticsManager {
  @override
  void sendEvent(AnalyticsEvent event) {
    super.noSuchMethod(Invocation.method(#sendEvent, [event]));
  }
}
class MockSecureStorage extends Mock implements SecureStorage {
  @override
  Future<String> get userId => Future.value('123');
}
class MockClientApi extends Mock implements ClientApi {}
class MockCustomError extends Mock implements CustomError {}
class MockAudioPlayer extends Mock implements AudioPlayer {
  @override
  bool get playing => false;
  
  @override
  ProcessingState get processingState => ProcessingState.ready;
  
  @override
  Stream<PlayerState> get playerStateStream => Stream.value(PlayerState(false, ProcessingState.ready));
  
  @override
  Stream<Duration> get positionStream => Stream.value(Duration.zero);
  
  @override
  Stream<Duration?> get durationStream => Stream.value(const Duration(minutes: 5));
  
  @override
  Future<Duration?> setAudioSource(AudioSource source, {int? initialIndex, Duration? initialPosition, bool preload = true}) async {
    return const Duration(minutes: 5);
  }
  
  @override
  Future<void> play() async {}
  
  @override
  Future<void> pause() async {}
  
  @override
  Future<void> stop() async {}
  
  @override
  Future<void> dispose() async {}
}

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  late MockAppRouter mockRouter;
  late MockAnalyticsManager mockAnalyticsManager;
  late MockSecureStorage mockSecureStorage;
  late MockClientApi mockClientApi;
  late MockCustomError mockCustomError;
  late MockAudioPlayer mockAudioPlayer;
  late FiveMinutesRepository repository;
  late FiveMinutesPresenter presenter;
  final getIt = GetIt.instance;

  setUp(() {
    mockRouter = MockAppRouter();
    mockAnalyticsManager = MockAnalyticsManager();
    mockSecureStorage = MockSecureStorage();
    mockClientApi = MockClientApi();
    mockCustomError = MockCustomError();
    mockAudioPlayer = MockAudioPlayer();

    repository = FiveMinutesRepository(
      mockAnalyticsManager,
      mockClientApi,
      mockCustomError,
      mockSecureStorage,
    );
    presenter = FiveMinutesPresenter(repository, mockRouter);

    // Registra as dependências no GetIt
    if (getIt.isRegistered<FiveMinutesPresenter>()) {
      getIt.unregister<FiveMinutesPresenter>();
    }
    getIt.registerFactory<FiveMinutesPresenter>(() => presenter);
  });

  tearDown(() {
    if (getIt.isRegistered<FiveMinutesPresenter>()) {
      getIt.unregister<FiveMinutesPresenter>();
    }
  });

  Widget createTestableWidget() {
    return MaterialApp(
      localizationsDelegates: MeditateStrings.localizationsDelegates,
      supportedLocales: MeditateStrings.supportedLocales,
      locale: const Locale('pt'),
      home: const FiveMinutesView(),
    );
  }

  group('Tela de Cinco Minutos - Testes de Integração', () {
    testWidgets('deve renderizar todos os elementos corretamente',
        (WidgetTester tester) async {
      // Act
      await tester.pumpWidget(createTestableWidget());
      await tester.pumpAndSettle();

      // Assert
      expect(find.byType(Player), findsOneWidget);
      expect(find.byIcon(Icons.play_arrow), findsOneWidget);
      expect(find.byIcon(Icons.play_circle_outline), findsOneWidget);
      expect(find.byIcon(Icons.access_time), findsOneWidget);
    });

    testWidgets('deve ser possível interagir com o botão de aprender método',
        (WidgetTester tester) async {
      // Act
      await tester.pumpWidget(createTestableWidget());
      await tester.pumpAndSettle();

      // Encontra e pressiona o botão de aprender método
      final learnMethodButton = find.byIcon(Icons.play_circle_outline);
      await tester.tap(learnMethodButton);
      await tester.pumpAndSettle();

      // Verifica se o método goToMeditateInfo foi chamado
      verify(mockRouter.goTo(const MeditateInfoRoute())).called(1);
    });

    testWidgets('deve ser possível interagir com o botão de lembrar meditar',
        (WidgetTester tester) async {
      // Act
      await tester.pumpWidget(createTestableWidget());
      await tester.pumpAndSettle();

      // Encontra e pressiona o botão de lembrar meditar
      final remindButton = find.byIcon(Icons.access_time);
      await tester.tap(remindButton);
      await tester.pumpAndSettle();
    });
  });
} 
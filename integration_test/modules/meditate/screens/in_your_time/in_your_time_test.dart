import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:get_it/get_it.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:cinco_minutos_meditacao/core/routers/app_router.dart';
import 'package:cinco_minutos_meditacao/core/analytics/manager.dart';
import 'package:cinco_minutos_meditacao/core/wrappers/secure_storage.dart';
import 'package:cinco_minutos_meditacao/modules/meditate/screens/in_your_time/in_your_time_presenter.dart';
import 'package:cinco_minutos_meditacao/modules/meditate/screens/in_your_time/in_your_time_repository.dart';
import 'package:cinco_minutos_meditacao/modules/meditate/screens/in_your_time/in_your_time_view.dart';
import 'package:cinco_minutos_meditacao/modules/meditate/screens/in_your_time/in_your_time_contract.dart';
import 'package:cinco_minutos_meditacao/shared/clients/client_api.dart';
import 'package:cinco_minutos_meditacao/shared/models/error.dart';
import 'package:cinco_minutos_meditacao/shared/Theme/app_tracks.dart';
import 'package:cinco_minutos_meditacao/modules/meditate/shared/components/player.dart';
import 'package:cinco_minutos_meditacao/modules/meditate/shared/components/meditation_method.dart';
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
  late InYourTimeRepository repository;
  late InYourTimePresenter presenter;
  final getIt = GetIt.instance;

  setUp(() {
    mockRouter = MockAppRouter();
    mockAnalyticsManager = MockAnalyticsManager();
    mockSecureStorage = MockSecureStorage();
    mockClientApi = MockClientApi();
    mockCustomError = MockCustomError();
    mockAudioPlayer = MockAudioPlayer();

    repository = InYourTimeRepository(
      mockAnalyticsManager,
      mockClientApi,
      mockCustomError,
      mockSecureStorage,
    );
    presenter = InYourTimePresenter(repository, mockRouter);

    // Registra as dependências no GetIt
    if (getIt.isRegistered<InYourTimePresenter>()) {
      getIt.unregister<InYourTimePresenter>();
    }
    getIt.registerFactory<InYourTimePresenter>(() => presenter);

    // Registra o AudioPlayer mockado
    if (getIt.isRegistered<AudioPlayer>()) {
      getIt.unregister<AudioPlayer>();
    }
    getIt.registerFactory<AudioPlayer>(() => mockAudioPlayer);
  });

  tearDown(() {
    if (getIt.isRegistered<InYourTimePresenter>()) {
      getIt.unregister<InYourTimePresenter>();
    }
    if (getIt.isRegistered<AudioPlayer>()) {
      getIt.unregister<AudioPlayer>();
    }
  });

  Widget createTestableWidget() {
    return MaterialApp(
      localizationsDelegates: MeditateStrings.localizationsDelegates,
      supportedLocales: MeditateStrings.supportedLocales,
      locale: const Locale('pt'),
      home: const InYourTimeView(),
    );
  }

  group('Tela de Meditação no Seu Tempo - Testes de Integração', () {
    testWidgets('deve renderizar todos os elementos corretamente',
        (WidgetTester tester) async {
      // Act
      await tester.pumpWidget(createTestableWidget());
      await tester.pumpAndSettle();

      // Assert
      expect(find.byType(Player), findsOneWidget);
      expect(find.text('Clique no botão para começar'), findsOneWidget);
      expect(find.text('No seu tempo'), findsOneWidget);
      expect(find.text('5 minutos'), findsOneWidget);
      expect(find.text('Lembre-me de meditar'), findsOneWidget);
    });

    testWidgets('deve ser possível interagir com o botão de lembrar meditar',
        (WidgetTester tester) async {
      // Act
      await tester.pumpWidget(createTestableWidget());
      await tester.pumpAndSettle();

      // Encontra e pressiona o botão de lembrar meditar
      final remindButton = find.text('Lembre-me de meditar');
      await tester.tap(remindButton);
      await tester.pumpAndSettle();
    });

    testWidgets('deve ser possível interagir com o botão de aprender método',
        (WidgetTester tester) async {
      // Act
      await tester.pumpWidget(createTestableWidget());
      await tester.pumpAndSettle();

      // Encontra e pressiona o botão de aprender método
      final learnMethodButton = find.text('5 minutos');
      await tester.tap(learnMethodButton);
      await tester.pumpAndSettle();
    });
  });
} 
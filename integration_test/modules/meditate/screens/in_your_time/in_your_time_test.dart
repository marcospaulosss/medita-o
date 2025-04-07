import 'package:auto_route/auto_route.dart' as _i17;
import 'package:cinco_minutos_meditacao/core/routers/app_router.dart';
import 'package:cinco_minutos_meditacao/core/routers/app_router.gr.dart';
import 'package:cinco_minutos_meditacao/modules/meditate/screens/in_your_time/in_your_time_contract.dart';
import 'package:cinco_minutos_meditacao/modules/meditate/screens/in_your_time/in_your_time_presenter.dart';
import 'package:cinco_minutos_meditacao/modules/meditate/screens/in_your_time/in_your_time_view.dart';
import 'package:cinco_minutos_meditacao/modules/share/screens/meditometer/share_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:just_audio/just_audio.dart';
import 'package:cinco_minutos_meditacao/modules/meditate/shared/strings/localization/meditate_strings.dart';

import 'in_your_time_test.mocks.dart';

@GenerateMocks([AppRouter, Repository])
void main() {
  late MockAppRouter mockRouter;
  late MockRepository mockRepository;
  late InYourTimePresenter presenter;
  late AudioPlayer mockAudioPlayer;
  final getIt = GetIt.instance;

  setUp(() {
    mockRouter = MockAppRouter();
    mockRepository = MockRepository();
    mockAudioPlayer = AudioPlayer();
    presenter = InYourTimePresenter(mockRepository, mockRouter);

    if (getIt.isRegistered<InYourTimePresenter>()) {
      getIt.unregister<InYourTimePresenter>();
    }
    getIt.registerFactory<InYourTimePresenter>(() => presenter);

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
    mockAudioPlayer.dispose();
  });

  Widget createTestableWidget() {
    return MaterialApp(
      localizationsDelegates: MeditateStrings.localizationsDelegates,
      supportedLocales: MeditateStrings.supportedLocales,
      home: const InYourTimeView(),
    );
  }

  group('In Your Time Screen', () {
    testWidgets('deve renderizar elementos corretamente',
        (WidgetTester tester) async {
      await tester.pumpWidget(createTestableWidget());
      await tester.pumpAndSettle();

      expect(find.byType(InYourTimeView), findsOneWidget);
    });

    testWidgets('deve navegar para a tela de compartilhamento após concluir a meditação',
        (WidgetTester tester) async {
      // Arrange
      when(mockRepository.requestRegisterMeditateCompleted(5)).thenAnswer((_) async {});
      final expectedRoute = ShareRoute(params: ShareModel(type: ShareType.defaultShare));
      when(mockRouter.goTo(expectedRoute)).thenAnswer((_) {});

      // Act
      await tester.pumpWidget(createTestableWidget());
      await tester.pumpAndSettle();

      // Simula o término da meditação
      await presenter.submitMeditateCompleted(5);
      await tester.pumpAndSettle();

      // Assert
      verify(mockRepository.requestRegisterMeditateCompleted(5)).called(1);
      verify(mockRouter.goTo(expectedRoute)).called(1);
    });
  });
}
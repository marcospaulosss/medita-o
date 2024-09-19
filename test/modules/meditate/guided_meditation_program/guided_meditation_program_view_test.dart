import 'dart:io';

import 'package:cinco_minutos_meditacao/modules/meditate/screens/guided_meditation_program/guided_meditation_program_presenter.dart';
import 'package:cinco_minutos_meditacao/modules/meditate/screens/guided_meditation_program/guided_meditation_program_view.dart';
import 'package:cinco_minutos_meditacao/modules/meditate/shared/components/player.dart';
import 'package:cinco_minutos_meditacao/modules/meditate/shared/strings/localization/meditate_strings.dart';
import 'package:cinco_minutos_meditacao/shared/components/app_background.dart';
import 'package:cinco_minutos_meditacao/shared/strings/localization/shared_strings.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:just_audio/just_audio.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'guided_meditation_program_view_test.mocks.dart';

@GenerateMocks([GuidedMeditationProgramPresenter, AudioPlayer])
void main() {
  dotenv.testLoad(fileInput: File('.env.dev').readAsStringSync());

  final MockGuidedMeditationProgramPresenter presenter =
      MockGuidedMeditationProgramPresenter();
  final GetIt sl = GetIt.instance;
  sl.registerLazySingleton<GuidedMeditationProgramPresenter>(() => presenter);

  group('GuidedMeditationProgramView', () {
    late GuidedMeditationProgramView view;

    setUp(() {
      view = const GuidedMeditationProgramView();
    });

    Widget createWidgetUnderTest() {
      return MaterialApp(
        localizationsDelegates: const [
          MeditateStrings.delegate,
          SharedStrings.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        supportedLocales: const [
          Locale('pt', ''),
        ],
        home: view,
      );
    }

    group('Validate Screen', () {
      testWidgets('Should show GuidedMeditationProgramView screen',
          (tester) async {
        await tester.pumpWidget(createWidgetUnderTest());

        when(presenter.onOpenScreen()).thenAnswer((_) async {});

        await tester.pumpAndSettle();

        verify(presenter.onOpenScreen()).called(1);
        expect(find.byType(AppBackground), findsOneWidget);
        expect(find.byType(Player), findsOneWidget);
        expect(find.textContaining('começar'), findsOneWidget);
        expect(find.text('meditaçao guiada LA JARDINERA'), findsOneWidget);
        expect(find.byIcon(Icons.translate), findsOneWidget);
        expect(find.text('Ver tradução'), findsOneWidget);
        expect(find.byIcon(Icons.help_outline), findsOneWidget);
        expect(find.text('Saiba mais'), findsOneWidget);
      });
    });

    group('Validate Interactions', () {
      testWidgets('Should play audio', (tester) async {
        await tester.pumpWidget(createWidgetUnderTest());

        when(presenter.onOpenScreen()).thenAnswer((_) async {});

        await tester.pumpAndSettle();

        final player = find.byType(Player);
        expect(player, findsOneWidget);

        await tester.tap(find.byIcon(Icons.play_arrow));
        await tester.pumpAndSettle();
      });

      testWidgets('Should go to screem meditate info', (tester) async {
        when(presenter.onOpenScreen()).thenAnswer((_) {});

        await tester.pumpWidget(createWidgetUnderTest());
        await tester.pumpAndSettle();

        final buttonFinder = find.textContaining('Ver tradução');
        await tester.tap(buttonFinder);
      });

      testWidgets('Should go to screem remember meditate', (tester) async {
        when(presenter.onOpenScreen()).thenAnswer((_) {});

        await tester.pumpWidget(createWidgetUnderTest());
        await tester.pumpAndSettle();

        final buttonFinder = find.textContaining('Saiba mais');
        await tester.tap(buttonFinder);
      });
    });

    group("Simulation GuidedMeditationProgramViewState", () {
      testWidgets("Should verify when show error screen", (tester) async {
        when(presenter.onOpenScreen()).thenAnswer((_) {});

        await tester.pumpWidget(createWidgetUnderTest());

        final guidedMeditationProgramViewState =
            tester.state(find.byType(GuidedMeditationProgramView))
                as GuidedMeditationProgramViewState;
        guidedMeditationProgramViewState.showError("teste");
        await tester.pump();

        expect(find.byIcon(Icons.close), findsOneWidget);
        expect(find.text("Tivemos um problema."), findsOneWidget);
        expect(find.textContaining("problema ao carregar"), findsOneWidget);
        expect(find.textContaining("( teste )"), findsOneWidget);
        expect(find.text("Tentar novamente"), findsOneWidget);

        await tester.tap(find.text("Tentar novamente"));
      });

      testWidgets("Should verify when show loading screen", (tester) async {
        when(presenter.onOpenScreen()).thenAnswer((_) {});

        await tester.pumpWidget(createWidgetUnderTest());

        final guidedMeditationProgramViewState =
            tester.state(find.byType(GuidedMeditationProgramView))
                as GuidedMeditationProgramViewState;
        guidedMeditationProgramViewState.showLoading();
        await tester.pump();

        expect(find.byType(Image), findsOneWidget);
        expect(find.textContaining('Carregando'), findsOneWidget);
      });

      testWidgets("Should verify when show normal screen", (tester) async {
        when(presenter.onOpenScreen()).thenAnswer((_) {});

        await tester.pumpWidget(createWidgetUnderTest());

        final guidedMeditationProgramViewState =
            tester.state(find.byType(GuidedMeditationProgramView))
                as GuidedMeditationProgramViewState;
        guidedMeditationProgramViewState.showNormalState();
        await tester.pumpAndSettle();
      });

      testWidgets("Should verify when show normal screen with parameter",
          (tester) async {
        when(presenter.onOpenScreen()).thenAnswer((_) {});

        await tester.pumpWidget(createWidgetUnderTest());

        final guidedMeditationProgramViewState =
            tester.state(find.byType(GuidedMeditationProgramView))
                as GuidedMeditationProgramViewState;
        guidedMeditationProgramViewState.showNormalState();
        await tester.pumpAndSettle();
      });

      testWidgets("Should verify when submit meditate completed",
          (tester) async {
        when(presenter.onOpenScreen()).thenAnswer((_) {});

        await tester.pumpWidget(createWidgetUnderTest());

        final guidedMeditationProgramViewState =
            tester.state(find.byType(GuidedMeditationProgramView))
                as GuidedMeditationProgramViewState;
        guidedMeditationProgramViewState.hasCompleted = true;
        guidedMeditationProgramViewState.submitMeditateComplete();
        await tester.pumpAndSettle();
      });

      testWidgets(
          "Should verify when submit meditate completed and hasComplete is false",
          (tester) async {
        when(presenter.onOpenScreen()).thenAnswer((_) {});

        final mockAudioPlayer = MockAudioPlayer();
        when(mockAudioPlayer.setAudioSource(any)).thenAnswer((_) async {});
        when(mockAudioPlayer.play()).thenAnswer((_) async {});
        when(mockAudioPlayer.pause()).thenAnswer((_) async {});
        when(mockAudioPlayer.processingStateStream).thenAnswer(
          (_) => Stream.value(ProcessingState.ready),
        );
        when(mockAudioPlayer.processingState).thenReturn(ProcessingState.ready);

        await tester.pumpWidget(createWidgetUnderTest());

        final guidedMeditationProgramViewState =
            tester.state(find.byType(GuidedMeditationProgramView))
                as GuidedMeditationProgramViewState;
        guidedMeditationProgramViewState.player = mockAudioPlayer;

        guidedMeditationProgramViewState.meditationCompleted();
        guidedMeditationProgramViewState.submitMeditateComplete();
        guidedMeditationProgramViewState.messageError = "teste";
        await tester.pumpAndSettle();
      });
    });
  });
}

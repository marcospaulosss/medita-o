import 'dart:io';

import 'package:cinco_minutos_meditacao/modules/meditate/screens/in_your_time/in_your_time_presenter.dart';
import 'package:cinco_minutos_meditacao/modules/meditate/screens/in_your_time/in_your_time_view.dart';
import 'package:cinco_minutos_meditacao/modules/meditate/shared/components/player.dart';
import 'package:cinco_minutos_meditacao/modules/meditate/shared/strings/localization/meditate_strings.dart';
import 'package:cinco_minutos_meditacao/shared/components/app_background.dart';
import 'package:cinco_minutos_meditacao/shared/strings/localization/shared_strings.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'in_your_time_view_test.mocks.dart';

@GenerateMocks([InYourTimePresenter])
void main() {
  dotenv.testLoad(fileInput: File('.env.dev').readAsStringSync());

  final MockInYourTimePresenter presenter = MockInYourTimePresenter();
  final GetIt sl = GetIt.instance;
  sl.registerLazySingleton<InYourTimePresenter>(() => presenter);

  group('InYourTimeView', () {
    late InYourTimeView view;

    setUp(() {
      view = const InYourTimeView();
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
      testWidgets('Should show in your time screen', (tester) async {
        await tester.pumpWidget(createWidgetUnderTest());

        when(presenter.onOpenScreen()).thenAnswer((_) async {});

        await tester.pumpAndSettle();

        verify(presenter.onOpenScreen()).called(1);
        expect(find.byType(AppBackground), findsOneWidget);
        expect(find.byType(Player), findsOneWidget);
        expect(find.textContaining('começar'), findsOneWidget);
        expect(find.text('No seu tempo'), findsOneWidget);
        expect(find.text('5 minutos'), findsOneWidget);
        expect(find.byIcon(Icons.arrow_drop_up), findsOneWidget);
        expect(find.byIcon(Icons.arrow_drop_down), findsOneWidget);
        expect(find.byIcon(Icons.access_time), findsOneWidget);
        expect(find.text('Lembre-me de meditar'), findsOneWidget);
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

      testWidgets('Should alter time meditate up', (tester) async {
        await tester.pumpWidget(createWidgetUnderTest());

        when(presenter.onOpenScreen()).thenAnswer((_) async {});

        await tester.pumpAndSettle();

        final player = find.byType(Player);
        expect(player, findsOneWidget);

        await tester.tap(find.byIcon(Icons.arrow_drop_up));
        await tester.pumpAndSettle();

        expect(find.text('10 minutos'), findsOneWidget);
      });

      testWidgets('Should alter time meditate down', (tester) async {
        await tester.pumpWidget(createWidgetUnderTest());

        when(presenter.onOpenScreen()).thenAnswer((_) async {});

        await tester.pumpAndSettle();

        final player = find.byType(Player);
        expect(player, findsOneWidget);

        await tester.tap(find.byIcon(Icons.arrow_drop_up));
        await tester.pumpAndSettle();

        expect(find.text('10 minutos'), findsOneWidget);

        await tester.tap(find.byIcon(Icons.arrow_drop_down));
        await tester.pumpAndSettle();

        expect(find.text('5 minutos'), findsOneWidget);
      });

      testWidgets('Should validate limit minimum 5', (tester) async {
        await tester.pumpWidget(createWidgetUnderTest());

        when(presenter.onOpenScreen()).thenAnswer((_) async {});

        await tester.pumpAndSettle();

        final player = find.byType(Player);
        expect(player, findsOneWidget);

        await tester.tap(find.byIcon(Icons.arrow_drop_down));
        await tester.pumpAndSettle();

        expect(find.text('5 minutos'), findsOneWidget);
      });

      testWidgets('Should validate limit maximum 30', (tester) async {
        await tester.pumpWidget(createWidgetUnderTest());

        when(presenter.onOpenScreen()).thenAnswer((_) async {});

        await tester.pumpAndSettle();

        final player = find.byType(Player);
        expect(player, findsOneWidget);

        await tester.tap(find.byIcon(Icons.arrow_drop_up));
        await tester.pumpAndSettle();
        await tester.tap(find.byIcon(Icons.arrow_drop_up));
        await tester.pumpAndSettle();
        await tester.tap(find.byIcon(Icons.arrow_drop_up));
        await tester.pumpAndSettle();
        await tester.tap(find.byIcon(Icons.arrow_drop_up));
        await tester.pumpAndSettle();
        await tester.tap(find.byIcon(Icons.arrow_drop_up));
        await tester.pumpAndSettle();
        await tester.tap(find.byIcon(Icons.arrow_drop_up));
        await tester.pumpAndSettle();
        await tester.tap(find.byIcon(Icons.arrow_drop_up));
        await tester.pumpAndSettle();

        expect(find.text('30 minutos'), findsOneWidget);
      });
    });

    group("Simuilation InYourTimeViewState", () {
      testWidgets("Should verify when show error screen", (tester) async {
        when(presenter.onOpenScreen()).thenAnswer((_) {});

        await tester.pumpWidget(createWidgetUnderTest());

        final inYourTimeViewState =
            tester.state(find.byType(InYourTimeView)) as InYourTimeViewState;
        inYourTimeViewState.showError("teste");
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

        final inYourTimeViewState =
            tester.state(find.byType(InYourTimeView)) as InYourTimeViewState;
        inYourTimeViewState.showLoading();
        await tester.pump();

        expect(find.byType(Image), findsOneWidget);
        expect(find.textContaining('Carregando'), findsOneWidget);
      });

      testWidgets("Should verify when show normal screen", (tester) async {
        when(presenter.onOpenScreen()).thenAnswer((_) {});

        await tester.pumpWidget(createWidgetUnderTest());

        final inYourTimeViewState =
            tester.state(find.byType(InYourTimeView)) as InYourTimeViewState;
        inYourTimeViewState.showNormalState();
        await tester.pumpAndSettle();
      });

      testWidgets("Should verify when show normal screen with parameter",
          (tester) async {
        when(presenter.onOpenScreen()).thenAnswer((_) {});

        await tester.pumpWidget(createWidgetUnderTest());

        final inYourTimeViewState =
            tester.state(find.byType(InYourTimeView)) as InYourTimeViewState;
        inYourTimeViewState.showNormalState();
        await tester.pumpAndSettle();
      });

      testWidgets(
          "Should verify when submitMeditateComplete screen with parameter",
          (tester) async {
        when(presenter.onOpenScreen()).thenAnswer((_) {});

        await tester.pumpWidget(createWidgetUnderTest());

        final inYourTimeViewState =
            tester.state(find.byType(InYourTimeView)) as InYourTimeViewState;
        inYourTimeViewState.submitMeditateComplete();
        await tester.pumpAndSettle();
      });

      testWidgets(
          "Should verify when submitMeditateComplete and hasCompleted is false screen with parameter",
          (tester) async {
        when(presenter.onOpenScreen()).thenAnswer((_) {});

        await tester.pumpWidget(createWidgetUnderTest());

        final inYourTimeViewState =
            tester.state(find.byType(InYourTimeView)) as InYourTimeViewState;
        inYourTimeViewState.meditationCompleted();
        inYourTimeViewState.submitMeditateComplete();
        await tester.pumpAndSettle();
      });
    });
  });
}

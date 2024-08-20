import 'dart:io';

import 'package:cinco_minutos_meditacao/modules/meditate/screens/five_minutes/five_minutes_presenter.dart';
import 'package:cinco_minutos_meditacao/modules/meditate/screens/five_minutes/five_minutes_view.dart';
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

import 'five_minutes_view_test.mocks.dart';

@GenerateMocks([FiveMinutesPresenter])
void main() {
  dotenv.testLoad(fileInput: File('.env.dev').readAsStringSync());

  final MockFiveMinutesPresenter presenter = MockFiveMinutesPresenter();
  final GetIt sl = GetIt.instance;
  sl.registerLazySingleton<FiveMinutesPresenter>(() => presenter);

  group('FiveMinutesView', () {
    late FiveMinutesView view;

    setUp(() {
      view = const FiveMinutesView();
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
      testWidgets('Should show five minutes screen', (tester) async {
        await tester.pumpWidget(createWidgetUnderTest());

        when(presenter.onOpenScreen()).thenAnswer((_) async {});

        await tester.pumpAndSettle();

        verify(presenter.onOpenScreen()).called(1);
        expect(find.byType(AppBackground), findsOneWidget);
        expect(find.byType(Player), findsOneWidget);
        expect(find.textContaining('começar'), findsOneWidget);
        expect(find.text('5 minutos'), findsOneWidget);
        expect(find.byIcon(Icons.play_circle_outline), findsOneWidget);
        expect(find.text('Aprenda o método        '), findsOneWidget);
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
    });
  });
}

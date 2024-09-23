import 'dart:io';

import 'package:cinco_minutos_meditacao/modules/meditate/screens/guided_meditation/guided_meditation_contract.dart';
import 'package:cinco_minutos_meditacao/modules/meditate/screens/guided_meditation/guided_meditation_presenter.dart';
import 'package:cinco_minutos_meditacao/modules/meditate/screens/guided_meditation/guided_meditation_view.dart';
import 'package:cinco_minutos_meditacao/modules/meditate/shared/strings/localization/meditate_strings.dart';
import 'package:cinco_minutos_meditacao/shared/components/app_background.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'guided_meditation_view_test.mocks.dart';

@GenerateMocks([GuidedMeditationPresenter, GuidedMeditationViewContract])
void main() {
  dotenv.testLoad(fileInput: File('.env.dev').readAsStringSync());

  final MockGuidedMeditationPresenter presenter =
      MockGuidedMeditationPresenter();
  final GetIt sl = GetIt.instance;
  sl.registerLazySingleton<GuidedMeditationPresenter>(() => presenter);

  group('GuidedMeditationView', () {
    late GuidedMeditationView view;

    setUp(() {
      view = const GuidedMeditationView();
    });

    Widget createWidgetUnderTest() {
      return MaterialApp(
        localizationsDelegates: const [
          MeditateStrings.delegate,
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
      testWidgets('Should show GuidedMeditationView screen', (tester) async {
        await tester.pumpWidget(createWidgetUnderTest());

        when(presenter.initPresenter()).thenAnswer((_) async {});

        await tester.pumpAndSettle();

        verify(presenter.initPresenter()).called(1);
        expect(find.byType(AppBackground), findsOneWidget);
        expect(find.textContaining('meditação guiada'), findsOneWidget);
      });
    });
  });
}

import 'package:cinco_minutos_meditacao/modules/meditate/screens/donation/donation_presenter.dart';
import 'package:cinco_minutos_meditacao/modules/meditate/screens/donation/donation_view.dart';
import 'package:cinco_minutos_meditacao/modules/meditate/shared/strings/localization/meditate_strings.dart';
import 'package:cinco_minutos_meditacao/shared/components/app_background.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

import 'donation_view_test.mocks.dart';

@GenerateMocks([DonationPresenter])
void main() {
  final MockDonationPresenter presenter = MockDonationPresenter();
  final GetIt sl = GetIt.instance;
  sl.registerLazySingleton<DonationPresenter>(() => presenter);

  group('DonationView', () {
    late DonationView view;

    setUp(() {
      view = const DonationView();
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
      testWidgets('Should display donation screen components', (tester) async {
        await tester.pumpWidget(createWidgetUnderTest());

        verify(presenter.initPresenter()).called(1);

        expect(find.byType(AppBackground), findsOneWidget);
        expect(find.byType(YoutubePlayer), findsOneWidget);
        expect(find.textContaining('SUA DOAÇÃO'), findsOneWidget);
        expect(find.textContaining('Sem Fronteiras'), findsOneWidget);
        expect(find.textContaining('DOAR'), findsOneWidget);
        expect(find.textContaining('Lorem Ipsum'), findsOneWidget);
      });
    });

    group('Validate Interactions', () {
      testWidgets('Should verify video player interaction', (tester) async {
        await tester.pumpWidget(createWidgetUnderTest());

        final youtubePlayer = find.byType(YoutubePlayer);
        expect(youtubePlayer, findsOneWidget);

        await tester.tap(youtubePlayer, warnIfMissed: false);
      });
    });
  });
}

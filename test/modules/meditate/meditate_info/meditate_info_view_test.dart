import 'dart:io';

import 'package:cinco_minutos_meditacao/modules/meditate/screens/meditate_info/meditate_info_model.dart';
import 'package:cinco_minutos_meditacao/modules/meditate/screens/meditate_info/meditate_info_presenter.dart';
import 'package:cinco_minutos_meditacao/modules/meditate/screens/meditate_info/meditate_info_view.dart';
import 'package:cinco_minutos_meditacao/modules/meditate/shared/components/video_card.dart';
import 'package:cinco_minutos_meditacao/modules/meditate/shared/strings/localization/meditate_strings.dart';
import 'package:cinco_minutos_meditacao/shared/components/Meditometer.dart';
import 'package:cinco_minutos_meditacao/shared/components/app_header.dart';
import 'package:cinco_minutos_meditacao/shared/strings/localization/shared_strings.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'meditate_info_view_test.mocks.dart';

@GenerateMocks([MeditateInfoPresenter])
main() {
  dotenv.testLoad(fileInput: File('.env.dev').readAsStringSync());

  final MockMeditateInfoPresenter presenter = MockMeditateInfoPresenter();
  final GetIt sl = GetIt.instance;
  sl.registerLazySingleton<MeditateInfoPresenter>(() => presenter);

  group('MeditateInfoView', () {
    late MeditateInfoView view;

    setUp(() {
      view = const MeditateInfoView();
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
      testWidgets('Should show meditate info screen', (tester) async {
        await tester.pumpWidget(createWidgetUnderTest());

        when(presenter.initPresenter()).thenAnswer((_) {
          return Future.value();
        });

        await tester.pump();
        verify(presenter.initPresenter()).called(1);

        final meditateInfoViewState = tester
            .state(find.byType(MeditateInfoView)) as MeditateInfoViewState;
        meditateInfoViewState.showNormalState(model: MeditateInfoModel());
        await tester.pumpAndSettle();

        expect(find.byType(MeditateInfoView), findsOneWidget);
        expect(find.byType(AppHeader), findsOneWidget);
        expect(find.text('Aprenda a meditar'), findsNWidgets(2));
        expect(find.byType(VideoCard), findsOneWidget);
        expect(find.byIcon(Icons.play_arrow), findsOneWidget);
        expect(find.text('Método 3 5 3'), findsOneWidget);
        expect(find.byType(Meditometer), findsOneWidget);
      });
    });

    group("Validate Actions", () {
      testWidgets("Should verify function of upload image", (tester) async {
        when(presenter.initPresenter()).thenAnswer((_) {
          return Future.value();
        });
        when(presenter.updateImageProfile()).thenAnswer((_) {
          return Future.value();
        });
        await tester.pumpWidget(createWidgetUnderTest());

        await tester.pump();
        verify(presenter.initPresenter()).called(1);

        final meditateInfoViewState = tester
            .state(find.byType(MeditateInfoView)) as MeditateInfoViewState;
        meditateInfoViewState.showNormalState(model: MeditateInfoModel());
        await tester.pumpAndSettle();

        await tester.tap(find.byIcon(Icons.add));
        await tester.pumpAndSettle();

        verify(presenter.updateImageProfile()).called(1);
      });

      testWidgets("Should verify function of view video youtube",
          (tester) async {
        when(presenter.initPresenter()).thenAnswer((_) {
          return Future.value();
        });
        when(presenter.updateImageProfile()).thenAnswer((_) {
          return Future.value();
        });
        await tester.pumpWidget(createWidgetUnderTest());

        await tester.pump();
        verify(presenter.initPresenter()).called(1);

        final meditateInfoViewState = tester
            .state(find.byType(MeditateInfoView)) as MeditateInfoViewState;
        meditateInfoViewState.showNormalState(model: MeditateInfoModel());
        await tester.pumpAndSettle();

        await tester.tap(find.byIcon(Icons.play_arrow));
        await tester.pumpAndSettle();
      });
    });

    group("Simuilation MeditateInfoViewState", () {
      testWidgets("Should verify when show error screen", (tester) async {
        when(presenter.onOpenScreen()).thenAnswer((_) {});

        await tester.pumpWidget(createWidgetUnderTest());

        final meditateInfoViewState = tester
            .state(find.byType(MeditateInfoView)) as MeditateInfoViewState;
        meditateInfoViewState.showError("teste");
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

        final meditateInfoViewState = tester
            .state(find.byType(MeditateInfoView)) as MeditateInfoViewState;
        meditateInfoViewState.showLoading();
        await tester.pump();

        expect(find.byType(Image), findsOneWidget);
        expect(find.textContaining('Carregando'), findsOneWidget);
      });

      testWidgets("Should verify when show normal screen", (tester) async {
        when(presenter.onOpenScreen()).thenAnswer((_) {});

        await tester.pumpWidget(createWidgetUnderTest());

        final meditateInfoViewState = tester
            .state(find.byType(MeditateInfoView)) as MeditateInfoViewState;
        meditateInfoViewState.showNormalState(model: MeditateInfoModel());
        await tester.pumpAndSettle();
      });

      testWidgets("Should verify when show normal screen with parameter",
          (tester) async {
        when(presenter.onOpenScreen()).thenAnswer((_) {});

        await tester.pumpWidget(createWidgetUnderTest());

        final meditateInfoViewState = tester
            .state(find.byType(MeditateInfoView)) as MeditateInfoViewState;
        meditateInfoViewState.showNormalState(model: MeditateInfoModel());
        await tester.pumpAndSettle();
      });
    });
  });
}

import 'dart:io';

import 'package:cinco_minutos_meditacao/modules/common/screens/home/home_model.dart';
import 'package:cinco_minutos_meditacao/modules/common/screens/home/home_presenter.dart';
import 'package:cinco_minutos_meditacao/modules/common/screens/home/home_view.dart';
import 'package:cinco_minutos_meditacao/modules/common/shared/components/meditate.dart';
import 'package:cinco_minutos_meditacao/modules/common/shared/strings/localization/common_strings.dart';
import 'package:cinco_minutos_meditacao/shared/Theme/app_images.dart';
import 'package:cinco_minutos_meditacao/shared/clients/models/responses/get_banners_response.dart';
import 'package:cinco_minutos_meditacao/shared/clients/models/responses/meditations_response.dart';
import 'package:cinco_minutos_meditacao/shared/clients/models/responses/user_response.dart'
    as user;
import 'package:cinco_minutos_meditacao/shared/components/app_header.dart';
import 'package:cinco_minutos_meditacao/shared/strings/localization/shared_strings.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'home_view_test.mocks.dart';

@GenerateMocks([HomePresenter])
main() async {
  dotenv.testLoad(fileInput: File('.env.dev').readAsStringSync());

  final MockHomePresenter presenter = MockHomePresenter();

  final GetIt sl = GetIt.instance;
  sl.registerLazySingleton<HomePresenter>(() => presenter);

  group("Home", () {
    late HomeView view;

    setUp(() {
      view = const HomeView();
    });

    Widget createWidgetUnderTest() {
      return MaterialApp(
        localizationsDelegates: const [
          CommonStrings.delegate,
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

    group("Validate Screen", () {
      testWidgets("Should show home screen", (tester) async {
        await tester.pumpWidget(createWidgetUnderTest());

        when(presenter.initPresenter()).thenAnswer((_) {
          return Future.value();
        });

        await tester.pump();
        verify(presenter.initPresenter()).called(1);

        final homeViewState =
            tester.state(find.byType(HomeView)) as HomeViewState;
        homeViewState.showNormalState(HomeModel(
          userResponse: user.UserResponse(
            1,
            "Marcos",
            "marcos@gmail.com",
            "",
            "1",
            "1",
            "",
            DateTime.now().toString(),
            DateTime.now().toString(),
            'masculino',
            '1983-07-02',
            user.State(1, 'São Paulo', user.Country(1, 'Brasil')),
          ),
          meditationsResponse: MeditationsResponse(2, 123123),
          bannersResponse: GetBannersResponse(
            Banners(null, null, null, null, null, null),
          ),
        ));
        await tester.pumpAndSettle();

        expect(find.byType(AppHeader), findsOneWidget);
        expect(find.byIcon(Icons.add), findsOneWidget);
        expect(find.textContaining("Marcos"), findsOneWidget);
        expect(find.textContaining('paz', findRichText: true), findsOneWidget);
        expect(
            find.byWidgetPredicate(
              (Widget widget) =>
                  widget is Image &&
                  widget.image is AssetImage &&
                  (widget.image as AssetImage).assetName == AppImages.balloon,
            ),
            findsOneWidget);
        expect(find.byType(Meditate), findsNWidgets(4));
        expect(find.textContaining("Minutos"), findsOneWidget);
        expect(find.textContaining("Aprenda"), findsOneWidget);
        expect(find.textContaining("guiada"), findsOneWidget);
        expect(find.textContaining("tempo"), findsOneWidget);
        expect(
            find.byWidgetPredicate(
              (Widget widget) =>
                  widget is Image &&
                  widget.image is AssetImage &&
                  (widget.image as AssetImage).assetName == AppImages.banner,
            ),
            findsOneWidget);

        expect(find.text("Meditômetro"), findsOneWidget);

        await tester.drag(
            find.byType(SingleChildScrollView), const Offset(0.0, -900));
        await tester.pumpAndSettle();

        expect(find.textContaining("123.123"), findsOneWidget);
        expect(find.textContaining("meditados no mundo", findRichText: true),
            findsOneWidget);
        expect(find.text("PAÍSES ALCANÇADOS"), findsOneWidget);
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

        final homeViewState =
            tester.state(find.byType(HomeView)) as HomeViewState;
        homeViewState.showNormalState(HomeModel(
          userResponse: user.UserResponse(
              1,
              "Marcos",
              "marcos@gmail.com",
              "",
              "1",
              "1",
              "",
              DateTime.now().toString(),
              DateTime.now().toString(),
              'masculino',
              '1983-07-02',
              user.State(1, 'São Paulo', user.Country(1, 'Brasil'))),
          meditationsResponse: MeditationsResponse(2, 123123),
        ));
        await tester.pumpAndSettle();

        await tester.tap(find.byIcon(Icons.add));
        await tester.pumpAndSettle();

        verify(presenter.updateImageProfile()).called(1);
      });

      testWidgets("Should validate o click in card meditate 5 minutes",
          (tester) async {
        when(presenter.initPresenter()).thenAnswer((_) {
          return Future.value();
        });
        when(presenter.goToFiveMinutes()).thenAnswer((_) {});
        await tester.pumpWidget(createWidgetUnderTest());

        await tester.pump();
        verify(presenter.initPresenter()).called(1);

        final homeViewState =
            tester.state(find.byType(HomeView)) as HomeViewState;
        homeViewState.showNormalState(HomeModel(
          userResponse: user.UserResponse(
              1,
              "Marcos",
              "marcos@gmail.com",
              "",
              "1",
              "1",
              "",
              DateTime.now().toString(),
              DateTime.now().toString(),
              'masculino',
              '1983-07-02',
              user.State(1, 'São Paulo', user.Country(1, 'Brasil'))),
          meditationsResponse: MeditationsResponse(2, 123123),
        ));
        await tester.pumpAndSettle();

        await tester.tap(find.byKey(const Key("meditate5Minutes")));
        await tester.pumpAndSettle();

        verify(presenter.goToFiveMinutes()).called(1);
      });

      testWidgets("Should validate o click in card learn method",
          (tester) async {
        when(presenter.initPresenter()).thenAnswer((_) {
          return Future.value();
        });
        when(presenter.goToMeditateInfo(any)).thenAnswer((_) {});
        await tester.pumpWidget(createWidgetUnderTest());

        await tester.pump();
        verify(presenter.initPresenter()).called(1);

        final homeViewState =
            tester.state(find.byType(HomeView)) as HomeViewState;
        homeViewState.showNormalState(HomeModel(
          userResponse: user.UserResponse(
              1,
              "Marcos",
              "marcos@gmail.com",
              "",
              "1",
              "1",
              "",
              DateTime.now().toString(),
              DateTime.now().toString(),
              'masculino',
              '1983-07-02',
              user.State(1, 'São Paulo', user.Country(1, 'Brasil'))),
          meditationsResponse: MeditationsResponse(2, 123123),
        ));
        await tester.pumpAndSettle();

        await tester.tap(find.byKey(const Key("learnMethod")));
        await tester.pumpAndSettle();

        verify(presenter.goToMeditateInfo(any)).called(1);
      });
    });

    group("Simuilation HomeViewState", () {
      testWidgets("Should verify when show error screen", (tester) async {
        when(presenter.onOpenScreen()).thenAnswer((_) {});

        await tester.pumpWidget(createWidgetUnderTest());

        final homeViewState =
            tester.state(find.byType(HomeView)) as HomeViewState;
        homeViewState.showError("teste");
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

        final homeViewState =
            tester.state(find.byType(HomeView)) as HomeViewState;
        homeViewState.showLoading();
        await tester.pump();

        expect(find.byType(Image), findsOneWidget);
        expect(find.textContaining('Carregando'), findsOneWidget);
      });

      testWidgets("Should verify when show normal screen", (tester) async {
        when(presenter.onOpenScreen()).thenAnswer((_) {});

        await tester.pumpWidget(createWidgetUnderTest());

        final homeViewState =
            tester.state(find.byType(HomeView)) as HomeViewState;
        homeViewState.showNormalState(HomeModel(
          userResponse: user.UserResponse(
              1,
              "Marcos",
              "marcos@gmail.com",
              "",
              "1",
              "1",
              "",
              DateTime.now().toString(),
              DateTime.now().toString(),
              'masculino',
              '1983-07-02',
              user.State(1, 'São Paulo', user.Country(1, 'Brasil'))),
          meditationsResponse: MeditationsResponse(2, 123123),
        ));
        await tester.pump();
      });
    });
  });
}

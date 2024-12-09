import 'dart:io';

import 'package:cinco_minutos_meditacao/modules/authentication/shared/strings/localization/authentication_strings.dart';
import 'package:cinco_minutos_meditacao/modules/common/screens/profile/components/form_profile.dart';
import 'package:cinco_minutos_meditacao/modules/common/screens/profile/profile_model.dart';
import 'package:cinco_minutos_meditacao/modules/common/screens/profile/profile_presenter.dart';
import 'package:cinco_minutos_meditacao/modules/common/screens/profile/profile_view.dart';
import 'package:cinco_minutos_meditacao/modules/common/shared/strings/localization/common_strings.dart';
import 'package:cinco_minutos_meditacao/shared/Theme/app_images.dart';
import 'package:cinco_minutos_meditacao/shared/clients/models/responses/countries_response.dart';
import 'package:cinco_minutos_meditacao/shared/clients/models/responses/states_response.dart';
import 'package:cinco_minutos_meditacao/shared/clients/models/responses/user_response.dart'
    as user;
import 'package:cinco_minutos_meditacao/shared/components/app_header.dart';
import 'package:cinco_minutos_meditacao/shared/components/text_field_input.dart';
import 'package:cinco_minutos_meditacao/shared/strings/localization/shared_strings.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'profile_view_test.mocks.dart';

@GenerateMocks([ProfilePresenter])
main() async {
  dotenv.testLoad(fileInput: File('.env.dev').readAsStringSync());

  final ProfilePresenter presenter = MockProfilePresenter();

  final GetIt sl = GetIt.instance;
  sl.registerLazySingleton<ProfilePresenter>(() => presenter);

  group("Profile", () {
    late ProfileView view;

    setUp(() {
      view = const ProfileView();
    });

    Widget createWidgetUnderTest() {
      return MaterialApp(
        localizationsDelegates: const [
          CommonStrings.delegate,
          SharedStrings.delegate,
          AuthenticationStrings.delegate,
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
      testWidgets("Should show profile screen", (tester) async {
        await tester.pumpWidget(createWidgetUnderTest());

        when(presenter.initPresenter()).thenAnswer((_) {
          return Future.value();
        });
        when(presenter.getStates(any))
            .thenAnswer((_) => Future.value(["São Paulo"]));

        await tester.pump();
        verify(presenter.initPresenter()).called(1);

        final profileViewState =
            tester.state(find.byType(ProfileView)) as ProfileViewState;
        profileViewState.showNormalState(ProfileModel(
          userResponse: user.UserResponse(
              1,
              "Marcos Santos",
              "marcos@gmail.com",
              "",
              "1",
              "1",
              "",
              DateTime.now().toString(),
              DateTime.now().toString(),
              'Masculino',
              null,
              user.State(1, 'São Paulo', user.Country(1, 'Brazil'))),
          countryResponse: CountriesResponse([
            Countries(
              1,
              "Brazil",
            ),
            Countries(
              2,
              "PR",
            ),
          ]),
          statesResponse: StatesResponse([
            States(
              1,
              2,
              "São Paulo",
            ),
            States(
              2,
              3,
              "SC",
            ),
          ]),
        ));
        await tester.pumpAndSettle();

        expect(find.byType(AppHeader), findsOneWidget);
        expect(find.byIcon(Icons.add), findsOneWidget);
        expect(find.textContaining("Marcos"), findsNWidgets(2));
        expect(find.textContaining("Santos"), findsOneWidget);
        expect(find.textContaining('paz', findRichText: true), findsOneWidget);
        expect(
            find.byWidgetPredicate(
              (Widget widget) =>
                  widget is Image &&
                  widget.image is AssetImage &&
                  (widget.image as AssetImage).assetName == AppImages.balloon,
            ),
            findsOneWidget);
        expect(find.byType(FormProfile), findsOneWidget);
        expect(find.text("Nome"), findsWidgets);
        expect(find.textContaining("Sobrenome"), findsWidgets);
        expect(find.textContaining("E-mail"), findsOneWidget);
        expect(find.textContaining("Data de Nascimento"), findsOneWidget);
        expect(find.textContaining("Dia"), findsOneWidget);
        expect(find.textContaining("Mês"), findsOneWidget);
        expect(find.textContaining("Ano"), findsOneWidget);

        await tester.drag(
            find.byType(SingleChildScrollView), const Offset(0.0, -900));
        await tester.pumpAndSettle();

        expect(find.text("Gênero"), findsOneWidget);
        expect(find.text("Masculino"), findsOneWidget);
        expect(find.text("Onde Reside"), findsOneWidget);
        expect(find.text("Brazil"), findsOneWidget);
        expect(find.text("Salvar Dados"), findsOneWidget);

        expect(
            find.textContaining("Política de Privacidade", findRichText: true),
            findsOneWidget);
        expect(find.text("SAIR DO APP"), findsOneWidget);
        expect(find.byIcon(Icons.exit_to_app), findsOneWidget);
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

        final profileViewState =
            tester.state(find.byType(ProfileView)) as ProfileViewState;
        profileViewState.showNormalState(ProfileModel(
          userResponse: user.UserResponse(
              1,
              "Marcos Santos",
              "marcos@gmail.com",
              "",
              "1",
              "1",
              "",
              DateTime.now().toString(),
              DateTime.now().toString(),
              'Masculino',
              '1983-07-02',
              user.State(1, 'São Paulo', user.Country(1, 'Brazil'))),
          countryResponse: CountriesResponse([
            Countries(
              1,
              "Brazil",
            ),
            Countries(
              2,
              "PR",
            ),
          ]),
          statesResponse: StatesResponse([
            States(
              1,
              2,
              "São Paulo",
            ),
            States(
              2,
              3,
              "SC",
            ),
          ]),
        ));
        await tester.pumpAndSettle();

        await tester.tap(find.byIcon(Icons.add));
        await tester.pumpAndSettle();

        verify(presenter.updateImageProfile()).called(1);
      });

      testWidgets("Should validate o input text in name, last name and email",
          (tester) async {
        when(presenter.initPresenter()).thenAnswer((_) {
          return Future.value();
        });
        await tester.pumpWidget(createWidgetUnderTest());

        await tester.pump();
        verify(presenter.initPresenter()).called(1);

        final profileViewState =
            tester.state(find.byType(ProfileView)) as ProfileViewState;
        profileViewState.showNormalState(ProfileModel(
          userResponse: user.UserResponse(
              1,
              "Marcos Santos",
              "marcos@gmail.com",
              "",
              "1",
              "1",
              "",
              DateTime.now().toString(),
              DateTime.now().toString(),
              'Masculino',
              '1983-07-02',
              user.State(1, 'São Paulo', user.Country(1, 'Brazil'))),
          countryResponse: CountriesResponse([
            Countries(
              1,
              "Brazil",
            ),
            Countries(
              2,
              "PR",
            ),
          ]),
          statesResponse: StatesResponse([
            States(
              1,
              2,
              "São Paulo",
            ),
            States(
              2,
              3,
              "SC",
            ),
          ]),
        ));
        await tester.pumpAndSettle();

        await tester.enterText(find.byType(TextFieldInput).first, 'Paulo');
        await tester.enterText(find.byType(TextFieldInput).at(1), 'Sousa');
        await tester.enterText(
            find.byType(TextFieldInput).at(2), 'exemplo@gmail.com');
        await tester.pumpAndSettle();

        expect(find.text('Paulo'), findsOneWidget);
        expect(find.text('Sousa'), findsOneWidget);
        expect(find.text('exemplo@gmail.com'), findsOneWidget);
      });

      testWidgets("Should validate o click in birthday", (tester) async {
        when(presenter.initPresenter()).thenAnswer((_) {
          return Future.value();
        });
        await tester.pumpWidget(createWidgetUnderTest());

        await tester.pump();
        verify(presenter.initPresenter()).called(1);

        final profileViewState =
            tester.state(find.byType(ProfileView)) as ProfileViewState;
        profileViewState.showNormalState(ProfileModel(
          userResponse: user.UserResponse(
              1,
              "Marcos Santos",
              "marcos@gmail.com",
              "",
              "1",
              "1",
              "",
              DateTime.now().toString(),
              DateTime.now().toString(),
              'Masculino',
              null,
              user.State(1, 'São Paulo', user.Country(1, 'Brazil'))),
          countryResponse: CountriesResponse([
            Countries(
              1,
              "Brazil",
            ),
            Countries(
              2,
              "PR",
            ),
          ]),
          statesResponse: StatesResponse([
            States(
              1,
              2,
              "São Paulo",
            ),
            States(
              2,
              3,
              "SC",
            ),
          ]),
        ));
        await tester.pumpAndSettle();

        await tester.drag(
            find.byType(SingleChildScrollView), const Offset(0.0, -900));
        await tester.pumpAndSettle();

        await tester.tap(find.text('Dia'));
        await tester.pumpAndSettle();
        await tester.tap(find.text('8'));
        await tester.pumpAndSettle();

        await tester.tap(find.text('Mês'));
        await tester.pumpAndSettle();
        await tester.tap(find.text('Julho'));
        await tester.pumpAndSettle();

        await tester.tap(find.text('Ano'));
        await tester.pumpAndSettle();
        await tester.tap(find.text(DateTime.now().year.toString()));
        await tester.pumpAndSettle();

        expect(find.text('8'), findsOneWidget);
        expect(find.text('Julho'), findsOneWidget);
        expect(find.text(DateTime.now().year.toString()), findsOneWidget);
      });

      testWidgets("Should validate o click in Gender", (tester) async {
        when(presenter.initPresenter()).thenAnswer((_) {
          return Future.value();
        });
        await tester.pumpWidget(createWidgetUnderTest());

        await tester.pump();
        verify(presenter.initPresenter()).called(1);

        final profileViewState =
            tester.state(find.byType(ProfileView)) as ProfileViewState;
        profileViewState.showNormalState(ProfileModel(
          userResponse: user.UserResponse(
              1,
              "Marcos Santos",
              "marcos@gmail.com",
              "",
              "1",
              "1",
              "",
              DateTime.now().toString(),
              DateTime.now().toString(),
              'Feminino',
              '1983-07-02',
              user.State(1, 'São Paulo', user.Country(1, 'Brazil'))),
          countryResponse: CountriesResponse([
            Countries(
              1,
              "Brazil",
            ),
            Countries(
              2,
              "PR",
            ),
          ]),
          statesResponse: StatesResponse([
            States(
              1,
              2,
              "São Paulo",
            ),
            States(
              2,
              3,
              "SC",
            ),
          ]),
        ));
        await tester.pumpAndSettle();

        await tester.drag(
            find.byType(SingleChildScrollView), const Offset(0.0, -900));
        await tester.pumpAndSettle();

        await tester.tap(find.text('Feminino').first);
        await tester.pumpAndSettle();
        await tester.tap(find.text('Masculino'));
        await tester.pumpAndSettle();

        expect(find.text('Masculino'), findsWidgets);
      });

      testWidgets("Should validate o click in where you live", (tester) async {
        when(presenter.initPresenter()).thenAnswer((_) {
          return Future.value();
        });
        await tester.pumpWidget(createWidgetUnderTest());

        await tester.pump();
        verify(presenter.initPresenter()).called(1);

        final profileViewState =
            tester.state(find.byType(ProfileView)) as ProfileViewState;
        profileViewState.showNormalState(ProfileModel(
          userResponse: user.UserResponse(
              1,
              "Marcos Santos",
              "marcos@gmail.com",
              "",
              "1",
              "1",
              "",
              DateTime.now().toString(),
              DateTime.now().toString(),
              'Masculino',
              '1983-07-02',
              user.State(1, 'São Paulo', user.Country(1, 'Brazil'))),
          countryResponse: CountriesResponse([
            Countries(
              1,
              "Brazil",
            ),
            Countries(
              2,
              "PR",
            ),
          ]),
          statesResponse: StatesResponse([
            States(
              1,
              2,
              "São Paulo",
            ),
            States(
              2,
              3,
              "SC",
            ),
          ]),
        ));
        await tester.pumpAndSettle();

        await tester.drag(
            find.byType(SingleChildScrollView), const Offset(0.0, -900));
        await tester.pumpAndSettle();

        await tester.tap(find.text('Brazil').first);
        await tester.pumpAndSettle();
        await tester.tap(find.text('PR').first);
        await tester.pumpAndSettle();

        expect(find.text('PR'), findsWidgets);
      });

      testWidgets("Should validate o click in state", (tester) async {
        when(presenter.initPresenter()).thenAnswer((_) {
          return Future.value();
        });
        await tester.pumpWidget(createWidgetUnderTest());

        await tester.pump();
        verify(presenter.initPresenter()).called(1);

        final profileViewState =
            tester.state(find.byType(ProfileView)) as ProfileViewState;
        profileViewState.showNormalState(ProfileModel(
          userResponse: user.UserResponse(
              1,
              "Marcos Santos",
              "marcos@gmail.com",
              "",
              "1",
              "1",
              "",
              DateTime.now().toString(),
              DateTime.now().toString(),
              'Feminino',
              '1983-07-02',
              user.State(1, 'São Paulo', user.Country(1, 'Brazil'))),
          countryResponse: CountriesResponse([
            Countries(
              1,
              "Brazil",
            ),
            Countries(
              2,
              "PR",
            ),
          ]),
          statesResponse: StatesResponse([
            States(
              1,
              2,
              "São Paulo",
            ),
            States(
              2,
              3,
              "SC",
            ),
          ]),
        ));
        await tester.pumpAndSettle();

        await tester.drag(
            find.byType(SingleChildScrollView), const Offset(0.0, -900));
        await tester.pumpAndSettle();

        await tester.tap(find.text('Feminino'));
        await tester.pumpAndSettle();
        await tester.tap(find.text('Masculino').first);
        await tester.pumpAndSettle();

        expect(find.text('Masculino'), findsWidgets);
      });
    });

    group("Simuilation ProfileViewState", () {
      testWidgets("Should verify when show error screen", (tester) async {
        when(presenter.onOpenScreen()).thenAnswer((_) {});

        await tester.pumpWidget(createWidgetUnderTest());

        final profileViewState =
            tester.state(find.byType(ProfileView)) as ProfileViewState;
        profileViewState.showError("teste");
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

        final profileViewState =
            tester.state(find.byType(ProfileView)) as ProfileViewState;
        profileViewState.showLoading();
        await tester.pump();

        expect(find.byType(Image), findsOneWidget);
        expect(find.textContaining('Carregando'), findsOneWidget);
      });

      testWidgets("Should verify when show normal screen", (tester) async {
        when(presenter.onOpenScreen()).thenAnswer((_) {});

        await tester.pumpWidget(createWidgetUnderTest());

        final profileViewState =
            tester.state(find.byType(ProfileView)) as ProfileViewState;
        profileViewState.showNormalState(ProfileModel(
          userResponse: user.UserResponse(
              1,
              "Marcos Santos",
              "marcos@gmail.com",
              "",
              "1",
              "1",
              "",
              DateTime.now().toString(),
              DateTime.now().toString(),
              'Masculino',
              '1983-07-02',
              user.State(1, 'São Paulo', user.Country(1, 'Brazil'))),
          countryResponse: CountriesResponse([
            Countries(
              1,
              "Brazil",
            ),
            Countries(
              2,
              "PR",
            ),
          ]),
          statesResponse: StatesResponse([
            States(
              1,
              2,
              "São Paulo",
            ),
            States(
              2,
              3,
              "SC",
            ),
          ]),
        ));
        await tester.pump();
      });
    });
  });
}

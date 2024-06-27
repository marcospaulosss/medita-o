import 'dart:io';

import 'package:cinco_minutos_meditacao/core/di/helpers.dart';
import 'package:cinco_minutos_meditacao/modules/authentication/screens/login/login_presenter.dart';
import 'package:cinco_minutos_meditacao/modules/authentication/screens/login/login_view.dart';
import 'package:cinco_minutos_meditacao/modules/authentication/shared/strings/localization/authentication_strings.dart';
import 'package:cinco_minutos_meditacao/shared/components/icon_label_button.dart';
import 'package:cinco_minutos_meditacao/shared/strings/localization/shared_strings.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'login_view_test.mocks.dart';

@GenerateMocks([LoginPresenter])
void main() async {
  dotenv.testLoad(fileInput: File('.env.dev').readAsStringSync());

  group("Login", () {
    final MockLoginPresenter presenter = MockLoginPresenter();
    registerFactory<LoginPresenter>(() => presenter);
    late LoginView loginView;

    setUp(() {
      loginView = const LoginView();
    });

    Widget createWidgetUnderTest() {
      return MaterialApp(
        localizationsDelegates: const [
          AuthenticationStrings.delegate,
          SharedStrings.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        supportedLocales: const [
          Locale('pt', ''),
        ],
        home: loginView,
      );
    }

    group("Validate screen", () {
      testWidgets("Should show login screen", (tester) async {
        when(presenter.onOpenScreen()).thenAnswer((_) {});

        await tester.pumpWidget(createWidgetUnderTest());

        await tester.pump();
        verify(presenter.onOpenScreen()).called(1);

        expect(find.byType(Image), findsOneWidget);
        expect(find.text('E-mail'), findsOneWidget);
        expect(find.text('exemplo@email.com'), findsOneWidget);
        expect(find.text('Senha'), findsOneWidget);
        expect(find.textContaining('********'), findsOneWidget);
        expect(find.byIcon(Icons.visibility_outlined), findsOneWidget);
        expect(find.text('Lembrar senha'), findsOneWidget);
        expect(find.text('Esqueci minha senha'), findsOneWidget);
        expect(find.text('Fazer Login'), findsOneWidget);
        expect(find.textContaining('Criar uma conta', findRichText: true),
            findsOneWidget);

        await tester.pump();
        await tester.drag(find.byType(ListView), const Offset(0.0, -300));
        await tester.pump();

        expect(find.textContaining('Ou entre usando'), findsOneWidget);
        expect(find.byType(SvgPicture), findsNWidgets(2));
        expect(find.text('Sua conta Google'), findsOneWidget);
        expect(find.text('Sua conta Facebook'), findsOneWidget);
      });

      testWidgets("Should verify when show error screen", (tester) async {
        when(presenter.onOpenScreen()).thenAnswer((_) {});

        await tester.pumpWidget(createWidgetUnderTest());

        final loginViewState =
            tester.state(find.byType(LoginView)) as LoginViewState;
        loginViewState.showError("teste");
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

        final loginViewState =
            tester.state(find.byType(LoginView)) as LoginViewState;
        loginViewState.showLoading();
        await tester.pump();

        expect(find.byType(Image), findsOneWidget);
        expect(find.textContaining('Carregando'), findsOneWidget);
      });

      testWidgets('showErrorEmailInvalid should set errorEmailInvalid to true', (tester) async {
        when(presenter.onOpenScreen()).thenAnswer((_) {});

        await tester.pumpWidget(createWidgetUnderTest());

        final loginViewState =
        tester.state(find.byType(LoginView)) as LoginViewState;
        loginViewState.showErrorEmailInvalid();

        expect(loginViewState.errorEmailInvalid, isTrue);
      });

      testWidgets('showInvalidCredentialsSnackBar should show SnackBar', (tester) async {
        when(presenter.onOpenScreen()).thenAnswer((_) {});

        await tester.pumpWidget(createWidgetUnderTest());

        final loginViewState =
        tester.state(find.byType(LoginView)) as LoginViewState;
        loginViewState.showInvalidCredentialsSnackBar();

        await tester.pumpAndSettle();

        expect(find.byType(SnackBar), findsOneWidget);
        expect(find.text('Senha ou email inválidos'), findsOneWidget);
      });
    });

    group("Interaction screen", () {
      testWidgets("Should verify click button login google", (tester) async {
        when(presenter.onOpenScreen()).thenAnswer((_) {});
        when(presenter.loginGoogle()).thenAnswer((_) async => (null, null));

        await tester.pumpWidget(createWidgetUnderTest());

        await tester.pump();
        await tester.drag(find.byType(ListView), const Offset(0.0, -300));
        await tester.pump();

        await tester.tap(find.byType(IconLabelButton).at(1));
        await tester.pumpAndSettle();

        verify(presenter.onOpenScreen()).called(5);
        verify(presenter.loginGoogle()).called(2);
      });

      testWidgets("Should verify click button remember password",
          (tester) async {
        when(presenter.onOpenScreen()).thenAnswer((_) {});

        await tester.pumpWidget(createWidgetUnderTest());

        await tester.pumpAndSettle();

        await tester.tap(find.byIcon(Icons.check));
        await tester.pumpAndSettle();
      });

      testWidgets("Should verify click button forget password", (tester) async {
        when(presenter.onOpenScreen()).thenAnswer((_) {});

        await tester.pumpWidget(createWidgetUnderTest());

        await tester.pumpAndSettle();

        await tester.tap(find.byType(InkWell).first);
        await tester.pumpAndSettle();
      });

      testWidgets("Should verify click button sing in", (tester) async {
        when(presenter.onOpenScreen()).thenAnswer((_) {});

        await tester.pumpWidget(createWidgetUnderTest());

        await tester.pumpAndSettle();

        await tester.tap(find.byType(IconLabelButton));
        await tester.pumpAndSettle();
      });

      testWidgets("Should verify click button meditate Without Login",
          (tester) async {
        when(presenter.onOpenScreen()).thenAnswer((_) {});

        await tester.pumpWidget(createWidgetUnderTest());

        await tester.pumpAndSettle();
        await tester.drag(find.byType(ListView), const Offset(0.0, -300));
        await tester.pump();

        await tester.tap(find.byType(IconLabelButton).at(2));
        await tester.pumpAndSettle();
      });

      testWidgets("Should verify click button meditate create account",
          (tester) async {
        when(presenter.onOpenScreen()).thenAnswer((_) {});

        await tester.pumpWidget(createWidgetUnderTest());

        await tester.pumpAndSettle();
        await tester.drag(find.byType(ListView), const Offset(0.0, -300));
        await tester.pump();

        await tester.tap(find.byType(GestureDetector).at(6));
        await tester.pumpAndSettle();
      });

      testWidgets("Should verify click button IconButton to obscure password",
          (tester) async {
        when(presenter.onOpenScreen()).thenAnswer((_) {});

        await tester.pumpWidget(createWidgetUnderTest());

        await tester.pumpAndSettle();

        await tester.tap(find.byType(IconButton));
        await tester.pumpAndSettle();
      });
    });
  });
}

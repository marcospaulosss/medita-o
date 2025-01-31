import 'dart:io';

import 'package:cinco_minutos_meditacao/core/di/helpers.dart';
import 'package:cinco_minutos_meditacao/modules/authentication/screens/register/register_presenter.dart';
import 'package:cinco_minutos_meditacao/modules/authentication/screens/register/register_view.dart';
import 'package:cinco_minutos_meditacao/modules/authentication/shared/strings/localization/authentication_strings.dart';
import 'package:cinco_minutos_meditacao/shared/strings/localization/shared_strings.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'register_view_test.mocks.dart';

@GenerateMocks([RegisterPresenter])
void main() {
  dotenv.testLoad(fileInput: File('.env.dev').readAsStringSync());

  group("Register", () {
    final MockRegisterPresenter presenter = MockRegisterPresenter();
    registerFactory<RegisterPresenter>(() => presenter);

    late RegisterView view;

    setUp(() {
      view = const RegisterView();
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
        home: view,
      );
    }

    group("Validate Screen", () {
      testWidgets("Should show login screen", (tester) async {
        when(presenter.onOpenScreen()).thenAnswer((_) {});

        await tester.pumpWidget(createWidgetUnderTest());

        await tester.pump();
        verify(presenter.onOpenScreen()).called(1);

        expect(find.byType(Image), findsOneWidget);
        expect(find.text('Nome'), findsWidgets);
        expect(find.text('E-mail'), findsOneWidget);
        expect(find.text('exemplo@email.com'), findsOneWidget);
        expect(find.text('Senha'), findsOneWidget);
        expect(find.textContaining('***********'), findsWidgets);
        expect(find.text('Confirmar Senha'), findsOneWidget);
        expect(find.byIcon(Icons.visibility_outlined), findsWidgets);
        expect(find.text('Lembrar senha'), findsOneWidget);
        expect(find.text('Criar Conta'), findsOneWidget);
        expect(find.byType(TextFormField), findsNWidgets(4));
      });
    });

    group("Validate Interaction Screen", () {
      testWidgets("Should shower error in fields required", (tester) async {
        when(presenter.onOpenScreen()).thenAnswer((_) {});

        await tester.pumpWidget(createWidgetUnderTest());

        await tester.drag(find.byType(ListView), const Offset(0.0, -300));
        await tester.pump();

        await tester.tap(find.text('Criar Conta'));
        await tester.pumpAndSettle();

        verify(presenter.onOpenScreen()).called(1);
        expect(find.text('Campo obrigatório'), findsNWidgets(4));
      });

      testWidgets("Should shower error in fields email invalid",
          (tester) async {
        when(presenter.onOpenScreen()).thenAnswer((_) {});

        await tester.pumpWidget(createWidgetUnderTest());

        await tester.drag(find.byType(ListView), const Offset(0.0, -300));
        await tester.pump();

        await tester.enterText(find.byType(TextFormField).at(1), 'Teste');
        await tester.tap(find.text('Criar Conta'));
        await tester.pumpAndSettle();

        verify(presenter.onOpenScreen()).called(1);
        expect(find.text('E-mail inválido'), findsOneWidget);
      });

      testWidgets(
          "Should shower password visible and invisible in password field",
          (tester) async {
        when(presenter.onOpenScreen()).thenAnswer((_) {});

        await tester.pumpWidget(createWidgetUnderTest());

        await tester.drag(find.byType(ListView), const Offset(0.0, -300));
        await tester.pump();

        await tester.enterText(find.byType(TextFormField).at(2), "123");
        expect(find.textContaining('***'), findsNWidgets(2));
        await tester.tap(find.byIcon(Icons.visibility_outlined).at(0));
        await tester.pumpAndSettle();
        expect(find.textContaining('123'), findsWidgets);
        await tester.tap(find.byIcon(Icons.visibility_off_outlined).at(0));
        await tester.pumpAndSettle();
        expect(find.textContaining('***'), findsNWidgets(2));

        verify(presenter.onOpenScreen()).called(1);
      });

      testWidgets(
          "Should shower password visible and invisible in confirm password field",
          (tester) async {
        when(presenter.onOpenScreen()).thenAnswer((_) {});

        await tester.pumpWidget(createWidgetUnderTest());

        await tester.drag(find.byType(ListView), const Offset(0.0, -300));
        await tester.pump();

        await tester.enterText(find.byType(TextFormField).at(3), "1234");
        expect(find.textContaining('***'), findsNWidgets(2));
        await tester.tap(find.byIcon(Icons.visibility_outlined).at(1));
        await tester.pumpAndSettle();
        expect(find.textContaining('1234'), findsWidgets);
        await tester.tap(find.byIcon(Icons.visibility_off_outlined).at(0));
        await tester.pumpAndSettle();
        expect(find.textContaining('***'), findsNWidgets(2));

        verify(presenter.onOpenScreen()).called(1);
      });

      testWidgets(
          "Should not show error in fields and call presenter to register",
          (tester) async {
        when(presenter.onOpenScreen()).thenAnswer((_) {});
        when(presenter.register(any)).thenAnswer((_) async {
          Future.value();
        });

        await tester.pumpWidget(createWidgetUnderTest());

        await tester.drag(find.byType(ListView), const Offset(0.0, -300));
        await tester.pump();

        await tester.enterText(find.byType(TextFormField).at(0), "teste teste");
        await tester.enterText(
            find.byType(TextFormField).at(1), "teste@gmail.com");
        await tester.enterText(find.byType(TextFormField).at(2), "1234");
        await tester.enterText(find.byType(TextFormField).at(3), "1234");
        await tester.tap(find.text('Criar Conta'));

        verify(presenter.onOpenScreen()).called(1);
        verify(presenter.register(any)).called(1);
      });

      testWidgets(
          "Should show error in fields when password and confirm password are different",
          (tester) async {
        when(presenter.onOpenScreen()).thenAnswer((_) {});
        when(presenter.register(any)).thenAnswer((_) async {
          Future.value();
        });

        await tester.pumpWidget(createWidgetUnderTest());

        await tester.drag(find.byType(ListView), const Offset(0.0, -300));
        await tester.pump();

        await tester.enterText(find.byType(TextFormField).at(0), "teste teste");
        await tester.enterText(
            find.byType(TextFormField).at(1), "teste@gmail.com");
        await tester.enterText(find.byType(TextFormField).at(2), "1234");
        await tester.enterText(find.byType(TextFormField).at(3), "123");
        await tester.tap(find.text('Criar Conta'));
        await tester.pumpAndSettle();

        expect(find.textContaining("Senhas não conferem"), findsOneWidget);
        verify(presenter.onOpenScreen()).called(1);
      });
    });

    group("Simuilation RegisterViewState", () {
      testWidgets("Should verify when show error screen", (tester) async {
        when(presenter.onOpenScreen()).thenAnswer((_) {});

        await tester.pumpWidget(createWidgetUnderTest());

        final registerViewState =
            tester.state(find.byType(RegisterView)) as RegisterViewState;
        registerViewState.showError("teste");
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

        final registerViewState =
            tester.state(find.byType(RegisterView)) as RegisterViewState;
        registerViewState.showLoading();
        await tester.pump();

        expect(find.byType(Image), findsOneWidget);
        expect(find.textContaining('Carregando'), findsOneWidget);
      });

      testWidgets("Should verify when show normal screen", (tester) async {
        when(presenter.onOpenScreen()).thenAnswer((_) {});

        await tester.pumpWidget(createWidgetUnderTest());

        final registerViewState =
            tester.state(find.byType(RegisterView)) as RegisterViewState;
        registerViewState.showNormalState();
        await tester.pump();

        expect(find.byType(Image), findsOneWidget);
        expect(find.text('Nome'), findsWidgets);
        expect(find.text('E-mail'), findsOneWidget);
        expect(find.text('Senha'), findsOneWidget);
      });

      testWidgets("Should verify alert when erro in register", (tester) async {
        when(presenter.onOpenScreen()).thenAnswer((_) {});

        await tester.pumpWidget(createWidgetUnderTest());

        final registerViewState =
            tester.state(find.byType(RegisterView)) as RegisterViewState;
        registerViewState.showInvalidCredentialsSnackBar(message: "test");
        await tester.pumpAndSettle();

        expect(find.text('test'), findsOneWidget);
      });

      testWidgets("Should verify error email invalid", (tester) async {
        when(presenter.onOpenScreen()).thenAnswer((_) {});

        await tester.pumpWidget(createWidgetUnderTest());

        final registerViewState =
            tester.state(find.byType(RegisterView)) as RegisterViewState;
        registerViewState.showErrorEmailInvalid();
        await tester.pump();

        expect(registerViewState.errorEmailInvalid, true);
      });
    });
  });
}

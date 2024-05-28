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

    testWidgets("Should show login screen", (tester) async {
      when(presenter.onOpenScreen()).thenAnswer((_) {});

      await tester.pumpWidget(
        MaterialApp(
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
        ),
      );

      await tester.pump();
      verify(presenter.onOpenScreen()).called(1);
    });

    testWidgets("Should verify click button login google", (tester) async {
      when(presenter.onOpenScreen()).thenAnswer((_) {});
      when(presenter.loginGoogle()).thenAnswer((_) async => (null, null));
      when(presenter.goToHome()).thenAnswer((_) {});

      await tester.pumpWidget(
        MaterialApp(
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
        ),
      );

      await tester.pump();
      await tester.drag(find.byType(ListView), const Offset(0.0, -300));
      await tester.pump();

      await tester.tap(find.byType(IconLabelButton).at(1));
      await tester.pumpAndSettle();

      verify(presenter.onOpenScreen()).called(1);
      verify(presenter.loginGoogle()).called(1);
      verify(presenter.goToHome()).called(1);
    });

    testWidgets("Should verify click button login google with error",
        (tester) async {
      when(presenter.onOpenScreen()).thenAnswer((_) {});
      when(presenter.loginGoogle())
          .thenAnswer((_) async => (null, Exception("error")));

      await tester.pumpWidget(
        MaterialApp(
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
        ),
      );

      await tester.pump();
      await tester.drag(find.byType(ListView), const Offset(0.0, -300));
      await tester.pump();

      await tester.tap(find.byType(IconLabelButton).at(1));
      await tester.pump();

      verify(presenter.loginGoogle()).called(1);
      expect(find.text("Tivemos um problema."), findsOneWidget);
      expect(find.textContaining("tente novamente."), findsOneWidget);
      expect(find.textContaining("tente novamente."), findsOneWidget);
      expect(find.byType(GestureDetector), findsOneWidget);
      expect(find.text("Tentar novamente"), findsOneWidget);
      expect(find.byType(Icon), findsOneWidget);

      await tester.tap(find.byType(GestureDetector));
    });

    testWidgets("Should verify click button remember password", (tester) async {
      when(presenter.onOpenScreen()).thenAnswer((_) {});

      await tester.pumpWidget(
        MaterialApp(
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
        ),
      );

      await tester.pumpAndSettle();

      await tester.tap(find.byIcon(Icons.check));
      await tester.pumpAndSettle();
    });

    testWidgets("Should verify click button forget password", (tester) async {
      when(presenter.onOpenScreen()).thenAnswer((_) {});

      await tester.pumpWidget(
        MaterialApp(
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
        ),
      );

      await tester.pumpAndSettle();

      await tester.tap(find.byType(InkWell).first);
      await tester.pumpAndSettle();
    });

    testWidgets("Should verify click button sing in", (tester) async {
      when(presenter.onOpenScreen()).thenAnswer((_) {});

      await tester.pumpWidget(
        MaterialApp(
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
        ),
      );

      await tester.pumpAndSettle();

      await tester.tap(find.byType(IconLabelButton));
      await tester.pumpAndSettle();
    });

    testWidgets("Should verify click button meditate Without Login",
        (tester) async {
      when(presenter.onOpenScreen()).thenAnswer((_) {});

      await tester.pumpWidget(
        MaterialApp(
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
        ),
      );

      await tester.pumpAndSettle();
      await tester.drag(find.byType(ListView), const Offset(0.0, -300));
      await tester.pump();

      await tester.tap(find.byType(IconLabelButton).at(2));
      await tester.pumpAndSettle();
    });

    testWidgets("Should verify click button meditate create account",
        (tester) async {
      when(presenter.onOpenScreen()).thenAnswer((_) {});

      await tester.pumpWidget(
        MaterialApp(
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
        ),
      );

      await tester.pumpAndSettle();
      await tester.drag(find.byType(ListView), const Offset(0.0, -300));
      await tester.pump();

      await tester.tap(find.byType(GestureDetector).at(6));
      await tester.pumpAndSettle();
    });

    testWidgets("Should verify click button IconButton to obscure password",
        (tester) async {
      when(presenter.onOpenScreen()).thenAnswer((_) {});

      await tester.pumpWidget(
        MaterialApp(
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
        ),
      );

      await tester.pumpAndSettle();

      await tester.tap(find.byType(IconButton));
      await tester.pumpAndSettle();
    });
  });
}

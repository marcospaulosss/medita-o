import 'dart:io';

import 'package:cinco_minutos_meditacao/core/di/helpers.dart';
import 'package:cinco_minutos_meditacao/modules/authentication/screens/login/login_presenter.dart';
import 'package:cinco_minutos_meditacao/modules/authentication/screens/login/login_view.dart';
import 'package:cinco_minutos_meditacao/modules/authentication/shared/strings/localization/authentication_strings.dart';
import 'package:cinco_minutos_meditacao/shared/components/icon_label_button.dart';
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
      await tester.tap(find.byType(IconLabelButton));
      await tester.pumpAndSettle();

      verify(presenter.loginGoogle()).called(1);
      verify(presenter.goToHome()).called(1);
    });

    testWidgets("Should verify click button login google with error",
        (tester) async {
      when(presenter.onOpenScreen()).thenAnswer((_) {});
      when(presenter.loginGoogle())
          .thenAnswer((_) async => (null, Exception("error")));
      when(presenter.goToHome()).thenAnswer((_) {});

      await tester.pumpWidget(
        MaterialApp(
          localizationsDelegates: const [
            AuthenticationStrings.delegate,
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
      await tester.tap(find.byType(IconLabelButton));
      await tester.pumpAndSettle();

      verify(presenter.loginGoogle()).called(1);
      verify(presenter.goToHome()).called(1);
    });
  });
}

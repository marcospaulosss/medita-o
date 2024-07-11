import 'dart:io';

import 'package:cinco_minutos_meditacao/core/di/helpers.dart';
import 'package:cinco_minutos_meditacao/modules/authentication/screens/register_success/register_success_presenter.dart';
import 'package:cinco_minutos_meditacao/modules/authentication/screens/register_success/register_success_view.dart';
import 'package:cinco_minutos_meditacao/modules/authentication/shared/strings/localization/authentication_strings.dart';
import 'package:cinco_minutos_meditacao/shared/components/icon_label_button.dart';
import 'package:cinco_minutos_meditacao/shared/strings/localization/shared_strings.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'register_success_view_test.mocks.dart';

@GenerateMocks([RegisterSuccessPresenter])
void main() {
  dotenv.testLoad(fileInput: File('.env.dev').readAsStringSync());

  group("Register", () {
    final MockRegisterSuccessPresenter presenter =
        MockRegisterSuccessPresenter();
    registerFactory<RegisterSuccessPresenter>(() => presenter);

    late RegisterSuccessView view;

    setUp(() {
      view = const RegisterSuccessView();
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

        await tester.pumpAndSettle();
        await tester.drag(find.byType(ListView), const Offset(0.0, -300));
        await tester.pump();

        verify(presenter.onOpenScreen()).called(1);
        expect(find.byType(Image), findsOneWidget);
        expect(find.byIcon(Icons.check_rounded), findsOneWidget);
        expect(find.text('Conta criada com Sucesso!'), findsOneWidget);
        expect(find.textContaining('Complete seu cadastro', findRichText: true),
            findsOneWidget);
        expect(find.text('Comece a Meditar'), findsOneWidget);
        expect(find.byType(IconLabelButton), findsOneWidget);
      });
    });

    group("Validate Interaction Screen", () {
      testWidgets("Should shower error in fields required", (tester) async {
        when(presenter.onOpenScreen()).thenAnswer((_) {});
        when(presenter.goToHome()).thenAnswer((_) {});

        await tester.pumpWidget(createWidgetUnderTest());

        await tester.drag(find.byType(ListView), const Offset(0.0, -300));
        await tester.pump();

        await tester.tap(find.text('Comece a Meditar'));
        await tester.pumpAndSettle();

        verify(presenter.onOpenScreen()).called(1);
        verify(presenter.goToHome()).called(1);
      });
    });
  });
}

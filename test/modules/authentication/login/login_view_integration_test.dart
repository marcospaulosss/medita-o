import 'package:cinco_minutos_meditacao/core/di/helpers.dart';
import 'package:cinco_minutos_meditacao/modules/authentication/screens/login/login_presenter.dart';
import 'package:cinco_minutos_meditacao/modules/authentication/screens/login/login_view.dart';
import 'package:cinco_minutos_meditacao/modules/authentication/shared/strings/localization/authentication_strings.dart';
import 'package:cinco_minutos_meditacao/shared/strings/localization/shared_strings.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';

import 'login_view_test.mocks.dart';

@GenerateMocks([LoginPresenter])
void main() {
  MockLoginPresenter presenter = MockLoginPresenter();
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

  group('LoginView', () {
    testWidgets('should build correctly', (tester) async {
      await tester.pumpWidget(createWidgetUnderTest());

      await tester.pump();
      expect(find.text('E-mail'), findsOneWidget);
      // await tester.drag(find.byType(ListView), const Offset(0.0, -300));
      // await tester.pump();
    });

    // testWidgets(
    //     'should call presenter.loginGoogle when Google button is tapped',
    //     (tester) async {
    //   when(() => stateController.showNormalState()).thenReturn(null);
    //   when(presenter.loginGoogle).thenAnswer((_) async => {});
    //
    //   await tester.pumpWidget(createWidgetUnderTest());
    //   await tester.tap(find.byKey(const Key('googleButton')));
    //   await tester.pump();
    //
    //   verify(presenter.loginGoogle).called(1);
    // });
    //
    // testWidgets(
    //     'should call presenter.loginFacebook when Facebook button is tapped',
    //     (tester) async {
    //   when(() => stateController.showLoadingState()).thenReturn(null);
    //   when(() => stateController.showNormalState()).thenReturn(null);
    //   when(presenter.loginFacebook).thenAnswer((_) async => {});
    //
    //   await tester.pumpWidget(createWidgetUnderTest());
    //   await tester.tap(find.byKey(const Key('facebookButton')));
    //   await tester.pump();
    //
    //   verify(presenter.loginFacebook).called(1);
    // });
    //
    // testWidgets('should show error state when showError is called',
    //     (tester) async {
    //   when(() => stateController.showErrorState()).thenReturn(null);
    //
    //   await tester.pumpWidget(createWidgetUnderTest());
    //   await tester.pump();
    //
    //   verify(stateController.showErrorState).called(1);
    // });
    //
    // testWidgets('should show loading state when showLoading is called',
    //     (tester) async {
    //   when(() => stateController.showLoadingState()).thenReturn(null);
    //
    //   await tester.pumpWidget(createWidgetUnderTest());
    //   await tester.pump();
    //
    //   verify(stateController.showLoadingState).called(1);
    // });
    //
    // testWidgets('should show normal state when showNormalState is called',
    //     (tester) async {
    //   when(() => stateController.showNormalState()).thenReturn(null);
    //
    //   await tester.pumpWidget(createWidgetUnderTest());
    //   await tester.pump();
    //
    //   verify(stateController.showNormalState).called(1);
    // });
  });
}

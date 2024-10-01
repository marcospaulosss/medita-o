import 'package:cinco_minutos_meditacao/modules/common/shared/strings/localization/common_strings.dart';
import 'package:cinco_minutos_meditacao/modules/meditometer/screens/meditometer/meditometer_model.dart';
import 'package:cinco_minutos_meditacao/modules/meditometer/screens/meditometer/meditometer_presenter.dart';
import 'package:cinco_minutos_meditacao/modules/meditometer/screens/meditometer/meditometer_view.dart';
import 'package:cinco_minutos_meditacao/modules/meditometer/shared/strings/localization/meditometer_strings.dart';
import 'package:cinco_minutos_meditacao/shared/components/app_background.dart';
import 'package:cinco_minutos_meditacao/shared/components/app_header.dart';
import 'package:cinco_minutos_meditacao/shared/components/generic_error_container.dart';
import 'package:cinco_minutos_meditacao/shared/components/loading.dart';
import 'package:cinco_minutos_meditacao/shared/strings/localization/shared_strings.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'meditometer_view_test.mocks.dart';

@GenerateMocks([MeditometerPresenter])
void main() {
  final MockMeditometerPresenter presenter = MockMeditometerPresenter();
  final GetIt sl = GetIt.instance;
  sl.registerLazySingleton<MeditometerPresenter>(() => presenter);

  group('MeditometerView', () {
    late MeditometerView view;

    setUp(() {
      view = const MeditometerView();
    });

    Widget createWidgetUnderTest() {
      return MaterialApp(
        localizationsDelegates: const [
          MeditometerStrings.delegate,
          SharedStrings.delegate,
          CommonStrings.delegate,
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
      testWidgets('Should show meditometer screen', (tester) async {
        await tester.pumpWidget(createWidgetUnderTest());

        when(presenter.initPresenter()).thenAnswer((_) async {});

        await tester.pump();
        verify(presenter.initPresenter()).called(1);

        final meditometerViewState =
            tester.state(find.byType(MeditometerView)) as MeditometerViewState;
        meditometerViewState.showNormalState(MeditometerModel());
        await tester.pumpAndSettle();

        expect(find.byType(MeditometerView), findsOneWidget);
        expect(find.byType(AppBackground), findsOneWidget);
        expect(find.byType(AppHeader), findsOneWidget);
      });
    });

    group("Validate Actions", () {
      testWidgets("Should verify function of update image profile",
          (tester) async {
        when(presenter.initPresenter()).thenAnswer((_) async {});
        when(presenter.updateImageProfile()).thenAnswer((_) async {});

        await tester.pumpWidget(createWidgetUnderTest());

        await tester.pump();
        verify(presenter.initPresenter()).called(1);

        final meditometerViewState =
            tester.state(find.byType(MeditometerView)) as MeditometerViewState;
        meditometerViewState.showNormalState(MeditometerModel());
        await tester.pumpAndSettle();

        // Simulate tapping the update image button
        await tester
            .tap(find.byIcon(Icons.add)); // Adjust the icon to match your UI
        await tester.pumpAndSettle();

        verify(presenter.updateImageProfile()).called(1);
      });

      testWidgets("Should verify function go to more info", (tester) async {
        when(presenter.initPresenter()).thenAnswer((_) async {});
        when(presenter.goToAbout()).thenAnswer((_) async {});

        await tester.pumpWidget(createWidgetUnderTest());

        await tester.pump();
        verify(presenter.initPresenter()).called(1);

        final meditometerViewState =
            tester.state(find.byType(MeditometerView)) as MeditometerViewState;
        meditometerViewState.showNormalState(MeditometerModel());
        await tester.pumpAndSettle();

        // Encontre o Scrollable widget
        final scrollable = find.byType(Scrollable);

        // Encontre o widget que você quer tocar
        final widgetToTap = find.byIcon(Icons.computer);

        // Role até que o widget seja visível
        await tester.scrollUntilVisible(
          widgetToTap,
          500.0, // Quantidade de pixels para rolar de cada vez
          scrollable: scrollable,
        );

        // Simulate tapping the update image button
        await tester.tap(
            find.byIcon(Icons.computer)); // Adjust the icon to match your UI
        await tester.pumpAndSettle();

        verify(presenter.goToAbout()).called(1);
      });
    });

    group("Simulation MeditometerViewState", () {
      testWidgets("Should verify when show error screen", (tester) async {
        when(presenter.initPresenter()).thenAnswer((_) async {});

        await tester.pumpWidget(createWidgetUnderTest());

        final meditometerViewState =
            tester.state(find.byType(MeditometerView)) as MeditometerViewState;
        meditometerViewState.showError("Error message");
        await tester.pump();

        expect(find.byType(GenericErrorContainer), findsOneWidget);
        expect(find.textContaining("Error message"), findsOneWidget);

        await tester.tap(
            find.text("Tentar novamente")); // Adjust the text to match your UI
      });

      testWidgets("Should verify when show loading screen", (tester) async {
        when(presenter.initPresenter()).thenAnswer((_) async {});

        await tester.pumpWidget(createWidgetUnderTest());

        final meditometerViewState =
            tester.state(find.byType(MeditometerView)) as MeditometerViewState;
        meditometerViewState.showLoading();
        await tester.pump();

        expect(find.byType(Loading), findsOneWidget);
      });

      testWidgets("Should verify when show normal screen", (tester) async {
        when(presenter.initPresenter()).thenAnswer((_) async {});

        await tester.pumpWidget(createWidgetUnderTest());

        final meditometerViewState =
            tester.state(find.byType(MeditometerView)) as MeditometerViewState;
        meditometerViewState.showNormalState(MeditometerModel());
        await tester.pumpAndSettle();

        expect(find.byType(AppBackground), findsOneWidget);
      });
    });
  });
}

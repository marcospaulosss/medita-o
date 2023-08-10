import 'package:cinco_minutos_meditacao/core/di/helpers.dart';
import 'package:cinco_minutos_meditacao/modules/common/screens/home/home_presenter.dart';
import 'package:cinco_minutos_meditacao/modules/common/screens/home/home_view.dart';
import 'package:cinco_minutos_meditacao/modules/common/shared/strings/localization/common_strings.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'home_view_test.mocks.dart';

@GenerateMocks([HomePresenter])
void main() {
  group("Home", () {
    late MockHomePresenter presenter;
    late HomeView homeView;

    setUp(() {
      presenter = MockHomePresenter();
      homeView = const HomeView();

      registerFactory<HomePresenter>(() => presenter);
    });

    testWidgets("Should show home screen", (tester) async {
      when(presenter.onOpenScreen()).thenAnswer((_) {});

      await tester.pumpWidget(
        MaterialApp(
          localizationsDelegates: const [
            CommonStrings.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          supportedLocales: const [
            Locale('pt', ''),
          ],
          home: homeView,
        ),
      );

      verify(presenter.onOpenScreen()).called(1);
    });
  });
}

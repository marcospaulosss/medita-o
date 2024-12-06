import 'dart:io';

import 'package:cinco_minutos_meditacao/modules/calendar/screens/calendar/calendar_model.dart';
import 'package:cinco_minutos_meditacao/modules/calendar/screens/calendar/calendar_presenter.dart';
import 'package:cinco_minutos_meditacao/modules/calendar/screens/calendar/calendar_view.dart';
import 'package:cinco_minutos_meditacao/modules/calendar/screens/calendar/componets/calendar_meditation.dart';
import 'package:cinco_minutos_meditacao/modules/calendar/shared/strings/localization/calendar_strings.dart';
import 'package:cinco_minutos_meditacao/modules/common/shared/strings/localization/common_strings.dart';
import 'package:cinco_minutos_meditacao/modules/meditometer/shared/strings/localization/meditometer_strings.dart';
import 'package:cinco_minutos_meditacao/shared/clients/models/responses/meditations_response.dart';
import 'package:cinco_minutos_meditacao/shared/clients/models/responses/month_calendar_response.dart';
import 'package:cinco_minutos_meditacao/shared/clients/models/responses/user_response.dart'
    as user;
import 'package:cinco_minutos_meditacao/shared/clients/models/responses/week_calendar_response.dart';
import 'package:cinco_minutos_meditacao/shared/clients/models/responses/year_calendar_response.dart';
import 'package:cinco_minutos_meditacao/shared/components/app_background.dart';
import 'package:cinco_minutos_meditacao/shared/components/app_header.dart';
import 'package:cinco_minutos_meditacao/shared/strings/localization/shared_strings.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:intl/intl.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'calendar_view_test.mocks.dart';

@GenerateMocks([CalendarPresenter])
void main() {
  dotenv.testLoad(fileInput: File('.env.dev').readAsStringSync());

  final MockCalendarPresenter presenter = MockCalendarPresenter();
  final GetIt sl = GetIt.instance;
  sl.registerLazySingleton<CalendarPresenter>(() => presenter);

  group('CalendarView', () {
    late CalendarView view;

    setUp(() {
      view = const CalendarView();
    });

    Widget createWidgetUnderTest() {
      return MaterialApp(
        localizationsDelegates: const [
          CommonStrings.delegate,
          SharedStrings.delegate,
          CalendarStrings.delegate,
          MeditometerStrings.delegate,
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
      testWidgets('Should show five minutes screen', (tester) async {
        await tester.pumpWidget(createWidgetUnderTest());

        when(presenter.initPresenter()).thenAnswer((_) async {});

        await tester.pumpAndSettle();
        verify(presenter.initPresenter()).called(1);

        final calendarViewState =
            tester.state(find.byType(CalendarView)) as CalendarViewState;
        calendarViewState.showNormalState(CalendarModel());
        await tester.pumpAndSettle();

        expect(find.byType(AppBackground), findsOneWidget);
        expect(find.byType(AppHeader), findsOneWidget);
        expect(find.byType(CalendarMeditation), findsOneWidget);
        expect(find.textContaining("medita, soma seu tempo"), findsOneWidget);
        expect(find.text("Semana"), findsOneWidget);
        expect(find.text("Mês"), findsOneWidget);
        expect(find.text("Ano"), findsOneWidget);
        expect(find.text("Tempo por semana"), findsOneWidget);
        expect(find.text("0"), findsWidgets);
        expect(find.text("Você meditou:"), findsOneWidget);
        expect(find.textContaining("Minutos esta", findRichText: true),
            findsOneWidget);
        expect(find.text("Compartilhar"), findsOneWidget);
      });
    });

    group('Validate Interactions', () {
      CalendarModel model = CalendarModel(
        userResponse: user.UserResponse(
            1,
            'John Doe',
            'john@example.com',
            '2024-10-10',
            '12345',
            '12323',
            '',
            '2024-10-10',
            '2024-10-10',
            'masculino',
            '1983-07-02',
            user.State(1, 'São Paulo', user.Country(1, 'Brasil'))),
        meditationsResponse: MeditationsResponse(100, 1000),
        weekCalendarResponse: WeekCalendarResponse(
          week: {
            '15': {
              'meditations': 15,
              'minutes': 100,
            },
          },
          total: 1,
          totalMinutes: 15,
        ),
        monthCalendarResponse: MonthCalendarResponse(
          month: {
            '15': {
              'meditations': 15,
              'minutes': 100,
            },
          },
          total: 1,
          totalMinutes: 15,
        ),
        yearCalendarResponse: YearCalendarResponse(
          year: {
            '10': {
              'meditations': 1,
              'minutes': 15,
            },
          },
          total: 1,
          totalMinutes: 15,
        ),
        weekCalendar: [15, 0, 0, 0, 0, 0, 0],
        monthCalendar: List.filled(31, 0),
        yearCalendar: List.filled(12, 0),
      );

      testWidgets("Should verify function of update image profile",
          (tester) async {
        when(presenter.initPresenter()).thenAnswer((_) async {});
        when(presenter.updateImageProfile()).thenAnswer((_) async {});

        await tester.pumpWidget(createWidgetUnderTest());

        await tester.pump();
        verify(presenter.initPresenter()).called(1);

        final calendarViewState =
            tester.state(find.byType(CalendarView)) as CalendarViewState;
        calendarViewState.showNormalState(model);
        await tester.pumpAndSettle();

        // Simulate tapping the update image button
        await tester
            .tap(find.byIcon(Icons.add)); // Adjust the icon to match your UI
        await tester.pumpAndSettle();

        verify(presenter.updateImageProfile()).called(1);
      });

      testWidgets('Should show calendar month and your interactions',
          (tester) async {
        await tester.pumpWidget(createWidgetUnderTest());

        when(presenter.initPresenter()).thenAnswer((_) async {});
        when(presenter.getCalendar(any, any)).thenAnswer((_) {
          return Future.value(CalendarModel());
        });

        await tester.pumpAndSettle();
        verify(presenter.initPresenter()).called(1);

        final calendarViewState =
            tester.state(find.byType(CalendarView)) as CalendarViewState;
        calendarViewState.showNormalState(model);
        await tester.pumpAndSettle();

        await tester.tap(find.text("Mês"));
        await tester.pumpAndSettle();

        // Obtém a data atual
        DateTime now = DateTime.now();
        String monthName = DateFormat('MMMM | yy', 'pt_BR').format(now);

        expect(find.text(monthName), findsOneWidget);
        expect(find.byIcon(Icons.chevron_left), findsOneWidget);
        expect(find.byIcon(Icons.chevron_right), findsOneWidget);
        expect(find.text("15"), findsOneWidget);
        expect(find.textContaining("mês", findRichText: true), findsOneWidget);
      });

      testWidgets('Should valida click in next month', (tester) async {
        await tester.pumpWidget(createWidgetUnderTest());

        var copyModel = model;
        copyModel.monthCalendarResponse!.totalMinutes = 31;

        when(presenter.initPresenter()).thenAnswer((_) async {});
        when(presenter.getCalendar(any, any)).thenAnswer((_) {
          return Future.value(copyModel);
        });

        await tester.pumpAndSettle();
        verify(presenter.initPresenter()).called(1);

        final calendarViewState =
            tester.state(find.byType(CalendarView)) as CalendarViewState;
        calendarViewState.showNormalState(model);
        await tester.pumpAndSettle();

        await tester.tap(find.text("Mês"));
        await tester.pumpAndSettle();
        await tester.tap(find.byIcon(Icons.chevron_right));

        // Obtém a data atual
        DateTime now = DateTime.now();
        String monthName = DateFormat('MMMM | yy', 'pt_BR').format(now);

        expect(find.text(monthName), findsOneWidget);
        expect(find.byIcon(Icons.chevron_left), findsOneWidget);
        expect(find.byIcon(Icons.chevron_right), findsOneWidget);
        expect(find.text("28"), findsNWidgets(1));
        expect(find.textContaining("mês", findRichText: true), findsOneWidget);
      });

      testWidgets('Should valida click in previous month', (tester) async {
        await tester.pumpWidget(createWidgetUnderTest());

        var copyModel = model;
        copyModel.monthCalendarResponse!.totalMinutes = 62;

        when(presenter.initPresenter()).thenAnswer((_) async {});
        when(presenter.getCalendar(any, any)).thenAnswer((_) {
          return Future.value(copyModel);
        });

        await tester.pumpAndSettle();
        verify(presenter.initPresenter()).called(1);

        final calendarViewState =
            tester.state(find.byType(CalendarView)) as CalendarViewState;
        calendarViewState.showNormalState(model);
        await tester.pumpAndSettle();

        await tester.tap(find.text("Mês"));
        await tester.pumpAndSettle();
        await tester.tap(find.byIcon(Icons.chevron_left));

        // Obtém a data atual
        DateTime now = DateTime.now();
        String monthName = DateFormat('MMMM | yy', 'pt_BR').format(now);

        expect(find.text(monthName), findsOneWidget);
        expect(find.byIcon(Icons.chevron_left), findsOneWidget);
        expect(find.byIcon(Icons.chevron_right), findsOneWidget);
        expect(find.text("62"), findsOneWidget);
        expect(find.textContaining("mês", findRichText: true), findsOneWidget);
      });

      testWidgets('Should show calendar year and your interactions',
          (tester) async {
        await tester.pumpWidget(createWidgetUnderTest());

        when(presenter.initPresenter()).thenAnswer((_) async {});
        when(presenter.getCalendar(any, any)).thenAnswer((_) {
          return Future.value(model);
        });

        await tester.pumpAndSettle();
        verify(presenter.initPresenter()).called(1);

        final calendarViewState =
            tester.state(find.byType(CalendarView)) as CalendarViewState;
        calendarViewState.showNormalState(model);
        await tester.pumpAndSettle();

        await tester.tap(find.text("Ano"));
        await tester.pumpAndSettle();

        // Obtém a data atual
        DateTime now = DateTime.now();
        String monthName = DateFormat('yyyy', 'pt_BR').format(now);

        expect(find.text(monthName), findsOneWidget);
        expect(find.byIcon(Icons.chevron_left), findsOneWidget);
        expect(find.byIcon(Icons.chevron_right), findsOneWidget);
        expect(find.text("JAN"), findsOneWidget);
        expect(find.text("DEZ"), findsOneWidget);
        expect(find.textContaining("ano", findRichText: true), findsOneWidget);

        await tester.fling(find.byType(SingleChildScrollView).first,
            const Offset(0, -500), 1000);
        await tester.pumpAndSettle();

        expect(find.text("15"), findsOneWidget);
      });

      testWidgets('Should valida click in next year', (tester) async {
        await tester.pumpWidget(createWidgetUnderTest());

        var copyModel = model;
        copyModel.monthCalendarResponse!.totalMinutes = 31;

        when(presenter.initPresenter()).thenAnswer((_) async {});
        when(presenter.getCalendar(any, any)).thenAnswer((_) {
          return Future.value(copyModel);
        });

        await tester.pumpAndSettle();
        verify(presenter.initPresenter()).called(1);

        final calendarViewState =
            tester.state(find.byType(CalendarView)) as CalendarViewState;
        calendarViewState.showNormalState(model);
        await tester.pumpAndSettle();

        await tester.tap(find.text("Ano"));
        await tester.pumpAndSettle();
        await tester.tap(find.byIcon(Icons.chevron_right));
        await tester.pumpAndSettle();

        // Obtém a data atual
        DateTime now = DateTime.now();
        DateTime nextYear = DateTime(now.year + 1, now.month, now.day);
        String monthName = DateFormat('yyyy', 'pt_BR').format(nextYear);

        expect(find.text(monthName), findsOneWidget);
        expect(find.byIcon(Icons.chevron_left), findsOneWidget);
        expect(find.byIcon(Icons.chevron_right), findsOneWidget);
      });

      testWidgets('Should valida click in previous year', (tester) async {
        await tester.pumpWidget(createWidgetUnderTest());

        var copyModel = model;
        copyModel.monthCalendarResponse!.totalMinutes = 62;

        when(presenter.initPresenter()).thenAnswer((_) async {});
        when(presenter.getCalendar(any, any)).thenAnswer((_) {
          return Future.value(copyModel);
        });

        await tester.pumpAndSettle();
        verify(presenter.initPresenter()).called(1);

        final calendarViewState =
            tester.state(find.byType(CalendarView)) as CalendarViewState;
        calendarViewState.showNormalState(model);
        await tester.pumpAndSettle();

        await tester.tap(find.text("Ano"));
        await tester.pumpAndSettle();
        await tester.tap(find.byIcon(Icons.chevron_left));
        await tester.pumpAndSettle();

        // Obtém a data atual
        DateTime now = DateTime.now();
        DateTime nextYear = DateTime(now.year - 1, now.month, now.day);
        String monthName = DateFormat('yyyy', 'pt_BR').format(nextYear);

        expect(find.text(monthName), findsOneWidget);
        expect(find.byIcon(Icons.chevron_left), findsOneWidget);
        expect(find.byIcon(Icons.chevron_right), findsOneWidget);
      });

      testWidgets('Should show calendar week and your interactions',
          (tester) async {
        await tester.pumpWidget(createWidgetUnderTest());

        when(presenter.initPresenter()).thenAnswer((_) async {});
        when(presenter.getCalendar(any, any)).thenAnswer((_) {
          return Future.value(model);
        });

        await tester.pumpAndSettle();
        verify(presenter.initPresenter()).called(1);

        final calendarViewState =
            tester.state(find.byType(CalendarView)) as CalendarViewState;
        calendarViewState.showNormalState(model);
        await tester.pumpAndSettle();

        await tester.tap(find.text("Ano"));
        await tester.pumpAndSettle();
        await tester.tap(find.text("Semana"));
        await tester.pumpAndSettle();

        // Obtém a data atual
        DateTime now = DateTime.now();
        String dayName = DateFormat('dd', 'pt_BR').format(now);

        expect(find.text(dayName), findsOneWidget);
        expect(find.text("Tempo por semana"), findsOneWidget);
        expect(find.byIcon(Icons.chevron_left), findsOneWidget);
        expect(find.byIcon(Icons.chevron_right), findsOneWidget);
        expect(find.text("D"), findsOneWidget);
        expect(find.text("Q"), findsNWidgets(2));
        expect(find.text("0"), findsWidgets);
        expect(find.textContaining("semana", findRichText: true),
            findsNWidgets(2));
      });

      testWidgets('Should valida click in next week', (tester) async {
        await tester.pumpWidget(createWidgetUnderTest());

        var copyModel = model;
        copyModel.monthCalendarResponse!.totalMinutes = 31;

        when(presenter.initPresenter()).thenAnswer((_) async {});
        when(presenter.getCalendar(any, any)).thenAnswer((_) {
          return Future.value(copyModel);
        });

        await tester.pumpAndSettle();
        verify(presenter.initPresenter()).called(1);

        final calendarViewState =
            tester.state(find.byType(CalendarView)) as CalendarViewState;
        calendarViewState.showNormalState(model);
        await tester.pumpAndSettle();

        await tester.tap(find.text("Semana"));
        await tester.pumpAndSettle();
        await tester.tap(find.byIcon(Icons.chevron_right));
        await tester.pumpAndSettle();

        // Obtém a data atual
        DateTime now = DateTime.now();
        DateTime nextYear = DateTime(now.year, now.month, now.day + 7);
        String monthName = DateFormat('dd', 'pt_BR').format(nextYear);

        expect(find.text(monthName), findsWidgets);
        expect(find.byIcon(Icons.chevron_left), findsOneWidget);
        expect(find.byIcon(Icons.chevron_right), findsOneWidget);
      });

      testWidgets('Should valida click in previous week', (tester) async {
        await tester.pumpWidget(createWidgetUnderTest());

        var copyModel = model;
        copyModel.monthCalendarResponse!.totalMinutes = 62;

        when(presenter.initPresenter()).thenAnswer((_) async {});
        when(presenter.getCalendar(any, any)).thenAnswer((_) {
          return Future.value(copyModel);
        });

        await tester.pumpAndSettle();
        verify(presenter.initPresenter()).called(1);

        final calendarViewState =
            tester.state(find.byType(CalendarView)) as CalendarViewState;
        calendarViewState.showNormalState(model);
        await tester.pumpAndSettle();

        await tester.tap(find.text("Semana"));
        await tester.pumpAndSettle();
        await tester.tap(find.byIcon(Icons.chevron_left));
        await tester.pumpAndSettle();

        // Obtém a data atual
        DateTime now = DateTime.now();
        DateTime nextYear = DateTime(now.year, now.month, now.day - 7);
        String monthName = DateFormat('dd', 'pt_BR').format(nextYear);

        expect(find.text(monthName), findsNWidgets(1));
        expect(find.byIcon(Icons.chevron_left), findsOneWidget);
        expect(find.byIcon(Icons.chevron_right), findsOneWidget);
      });
    });

    group("Simulation CalendarViewState", () {
      testWidgets("Should verify when show error screen", (tester) async {
        when(presenter.onOpenScreen()).thenAnswer((_) {});

        await tester.pumpWidget(createWidgetUnderTest());

        final calendarViewState =
            tester.state(find.byType(CalendarView)) as CalendarViewState;
        calendarViewState.showError("teste");
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

        final calendarViewState =
            tester.state(find.byType(CalendarView)) as CalendarViewState;
        calendarViewState.showLoading();
        await tester.pumpAndSettle();

        expect(find.byType(Image), findsOneWidget);
        expect(find.textContaining('Carregando'), findsOneWidget);
      });

      testWidgets("Should verify when show normal screen with parameter",
          (tester) async {
        when(presenter.onOpenScreen()).thenAnswer((_) {});

        await tester.pumpWidget(createWidgetUnderTest());

        final calendarViewState =
            tester.state(find.byType(CalendarView)) as CalendarViewState;
        calendarViewState.showNormalState(CalendarModel());
        await tester.pumpAndSettle();
      });
    });
  });
}

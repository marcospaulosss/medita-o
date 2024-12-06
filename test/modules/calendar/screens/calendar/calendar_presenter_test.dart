import 'dart:io';

import 'package:cinco_minutos_meditacao/core/environment/manager.dart';
import 'package:cinco_minutos_meditacao/core/routers/app_router.dart';
import 'package:cinco_minutos_meditacao/modules/calendar/screens/calendar/calendar_contract.dart';
import 'package:cinco_minutos_meditacao/modules/calendar/screens/calendar/calendar_model.dart';
import 'package:cinco_minutos_meditacao/modules/calendar/screens/calendar/calendar_presenter.dart';
import 'package:cinco_minutos_meditacao/modules/calendar/screens/calendar/calendar_repository.dart';
import 'package:cinco_minutos_meditacao/shared/clients/models/responses/meditations_response.dart';
import 'package:cinco_minutos_meditacao/shared/clients/models/responses/month_calendar_response.dart';
import 'package:cinco_minutos_meditacao/shared/clients/models/responses/user_response.dart';
import 'package:cinco_minutos_meditacao/shared/clients/models/responses/week_calendar_response.dart';
import 'package:cinco_minutos_meditacao/shared/clients/models/responses/year_calendar_response.dart';
import 'package:cinco_minutos_meditacao/shared/models/error.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'calendar_presenter_test.mocks.dart';

@GenerateMocks([
  CalendarViewContract,
  AppRouter,
  CalendarModel,
  CalendarRepository,
  EnvironmentManager
])
void main() {
  late CalendarPresenter presenter;
  late MockCalendarRepository mockRepository;
  late MockAppRouter mockRouter;
  late MockEnvironmentManager mockEnvironmentManager;
  late MockCalendarViewContract mockView;

  setUp(() {
    mockRepository = MockCalendarRepository();
    mockRouter = MockAppRouter();
    mockView = MockCalendarViewContract();
    mockEnvironmentManager = MockEnvironmentManager();

    presenter =
        CalendarPresenter(mockRepository, mockRouter, mockEnvironmentManager);
    presenter.view = mockView;
  });

  group('onOpenScreen', () {
    test('should send open screen event', () {
      // Act
      presenter.onOpenScreen();

      // Assert
      verify(mockRepository.sendOpenScreenEvent()).called(1);
    });
  });

  group('initPresenter', () {
    final userResponse = UserResponse(
        1,
        'John Doe',
        'john@example.com',
        '2024-10-10',
        '12345',
        '12323',
        'path',
        '2024-10-10',
        '2024-10-10',
        'masculino',
        '1983-07-02',
        State(1, 'São Paulo', Country(1, 'Brasil')));
    final meditationsResponse = MeditationsResponse(1000, 5000);
    final weekCalendarResponse = WeekCalendarResponse(week: {
      '2024-10-22': {'minutes': 30},
      '2024-10-23': {'minutes': 45},
    });

    test('should initialize presenter and update view on success', () async {
      // Arrange
      when(mockRepository.requestUser())
          .thenAnswer((_) async => (userResponse, null));
      when(mockRepository.requestMeditations())
          .thenAnswer((_) async => (meditationsResponse, null));
      when(mockRepository.requestCalendarWeek(any))
          .thenAnswer((_) async => (weekCalendarResponse, null));

      // Act
      await presenter.initPresenter();

      // Assert
      verify(mockView.showLoading()).called(1);
      expect(presenter.model.userResponse, equals(userResponse));
      expect(presenter.model.meditationsResponse, equals(meditationsResponse));
      expect(presenter.model.weekCalendar, equals([30, 45]));
      verify(mockView.showNormalState(presenter.model)).called(1);
    });

    test('should show error if requestUser fails', () async {
      // Arrange
      final error = CustomError();
      when(mockRepository.requestUser()).thenAnswer((_) async => (null, error));

      // Act
      await presenter.initPresenter();

      // Assert
      verify(mockView.showError(error.getErrorMessage)).called(1);
    });

    test('should show error if requestMeditations fails', () async {
      // Arrange
      final error = CustomError();
      when(mockRepository.requestUser())
          .thenAnswer((_) async => (userResponse, null));
      when(mockRepository.requestMeditations())
          .thenAnswer((_) async => (null, error));

      // Act
      await presenter.initPresenter();

      // Assert
      verify(mockView.showError(error.getErrorMessage)).called(1);
    });

    test('should show error if requestCalendarWeek fails', () async {
      // Arrange
      final error = CustomError();
      when(mockRepository.requestUser())
          .thenAnswer((_) async => (userResponse, null));
      when(mockRepository.requestMeditations())
          .thenAnswer((_) async => (meditationsResponse, null));
      when(mockRepository.requestCalendarWeek(any))
          .thenAnswer((_) async => (null, error));

      // Act
      await presenter.initPresenter();

      // Assert
      verify(mockView.showError(error.getErrorMessage)).called(1);
    });
  });

  group('updateImageProfile', () {
    test('should handle null result from camera', () async {
      // Arrange
      when(mockRouter.goTo(any, onClose: anyNamed('onClose')))
          .thenAnswer((invocation) async {
        final onClose =
            invocation.namedArguments[const Symbol('onClose')] as Function;
        await onClose(null);
      });

      // Act
      await presenter.updateImageProfile();

      // Assert
      verifyNever(mockView.showError(any));
    });

    test('should show error if result is CustomError', () async {
      // Arrange
      final error = CustomError();
      when(mockRouter.goTo(any, onClose: anyNamed('onClose')))
          .thenAnswer((invocation) async {
        final onClose =
            invocation.namedArguments[const Symbol('onClose')] as Function;
        await onClose(error);
      });

      // Act
      await presenter.updateImageProfile();

      // Assert
      verify(mockView.showError(any)).called(1);
    });

    test('should update user profile on success', () async {
      // Arrange
      final file = File('path/to/file');
      final userResponse = UserResponse(
          1,
          'John Doe',
          'john@example.com',
          '2024-10-10',
          '12345',
          '12323',
          'path',
          '2024-10-10',
          '2024-10-10',
          'masculino',
          '1983-07-02',
          State(1, 'São Paulo', Country(1, 'Brasil')));
      when(mockRouter.goTo(any, onClose: anyNamed('onClose')))
          .thenAnswer((invocation) async {
        final onClose =
            invocation.namedArguments[const Symbol('onClose')] as Function;
        await onClose(file);

        expect(presenter.model.userResponse, equals(userResponse));
        verify(mockView.showNormalState(presenter.model)).called(1);
      });
      when(mockRepository.uploadImageProfile(file))
          .thenAnswer((_) async => null);
      when(mockRepository.requestUser())
          .thenAnswer((_) async => (userResponse, null));

      // Act
      await presenter.updateImageProfile();
    });

    test('should show error if uploadImageProfile fails', () async {
      // Arrange
      final file = File('path/to/file');
      final error = CustomError();
      when(mockRouter.goTo(any, onClose: anyNamed('onClose')))
          .thenAnswer((invocation) async {
        final onClose =
            invocation.namedArguments[const Symbol('onClose')] as Function;
        await onClose(file);
      });
      when(mockRepository.uploadImageProfile(file))
          .thenAnswer((_) async => error);

      // Act
      await presenter.updateImageProfile();

      // Assert
      verify(mockView.showError(error.getErrorMessage)).called(1);
    });

    test('should show error if requestUser fails', () async {
      // Arrange
      final file = File('path/to/file');
      final error = CustomError();
      when(mockRouter.goTo(any, onClose: anyNamed('onClose')))
          .thenAnswer((invocation) async {
        final onClose =
            invocation.namedArguments[const Symbol('onClose')] as Function;
        await onClose(file);

        // Assert
        verify(mockView.showError(error.getErrorMessage)).called(1);
      });
      when(mockRepository.uploadImageProfile(file))
          .thenAnswer((_) async => null);
      when(mockRepository.requestUser()).thenAnswer((_) async => (null, error));

      // Act
      await presenter.updateImageProfile();
    });
  });

  group('getCalendar', () {
    final weekCalendarResponse = WeekCalendarResponse(week: {
      '2024-10-22': {'minutes': 30},
      '2024-10-23': {'minutes': 45},
    });
    final monthCalendarResponse = MonthCalendarResponse(month: {
      '1': {'minutes': 60},
      '2': {'minutes': 90},
    });
    final yearCalendarResponse = YearCalendarResponse(year: {
      '1': {'minutes': 120},
      '2': {'minutes': 150},
    });

    test('should return week calendar for CalendarType.week', () async {
      // Arrange
      when(mockRepository.requestCalendarWeek(any))
          .thenAnswer((_) async => (weekCalendarResponse, null));

      // Act
      final result =
          await presenter.getCalendar('2024-10-22', CalendarType.week);

      // Assert
      expect(result.weekCalendar, equals([30, 45]));
    });

    test('should return month calendar for CalendarType.month', () async {
      // Arrange
      when(mockRepository.requestCalendarMonth(any))
          .thenAnswer((_) async => (monthCalendarResponse, null));

      // Act
      final result = await presenter.getCalendar('2024-10', CalendarType.month);

      // Assert
      expect(
          result.monthCalendar,
          equals([
            60,
            90,
            0,
            0,
            0,
            0,
            0,
            0,
            0,
            0,
            0,
            0,
            0,
            0,
            0,
            0,
            0,
            0,
            0,
            0,
            0,
            0,
            0,
            0,
            0,
            0,
            0,
            0,
            0,
            0,
            0
          ]));
    });

    test('should return year calendar for CalendarType.year', () async {
      // Arrange
      when(mockRepository.requestCalendarYear(any))
          .thenAnswer((_) async => (yearCalendarResponse, null));

      // Act
      final result = await presenter.getCalendar('2024', CalendarType.year);

      // Assert
      expect(result.yearCalendar,
          equals([120, 150, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]));
    });

    test('should show error if requestCalendarWeek fails', () async {
      // Arrange
      final error = CustomError();
      when(mockRepository.requestCalendarWeek(any))
          .thenAnswer((_) async => (null, error));

      // Act
      await presenter.getCalendar('2024-10-22', CalendarType.week);

      // Assert
      verify(mockView.showError(error.getErrorMessage)).called(1);
    });

    test('should show error if requestCalendarMonth fails', () async {
      // Arrange
      final error = CustomError();
      when(mockRepository.requestCalendarMonth(any))
          .thenAnswer((_) async => (null, error));

      // Act
      await presenter.getCalendar('2024-10', CalendarType.month);

      // Assert
      verify(mockView.showError(error.getErrorMessage)).called(1);
    });

    test('should show error if requestCalendarYear fails', () async {
      // Arrange
      final error = CustomError();
      when(mockRepository.requestCalendarYear(any))
          .thenAnswer((_) async => (null, error));

      // Act
      await presenter.getCalendar('2024', CalendarType.year);

      // Assert
      verify(mockView.showError(error.getErrorMessage)).called(1);
    });
  });
}

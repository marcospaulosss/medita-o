import 'package:cinco_minutos_meditacao/shared/clients/models/responses/meditations_response.dart';
import 'package:cinco_minutos_meditacao/shared/clients/models/responses/month_calendar_response.dart';
import 'package:cinco_minutos_meditacao/shared/clients/models/responses/user_response.dart';
import 'package:cinco_minutos_meditacao/shared/clients/models/responses/week_calendar_response.dart';
import 'package:cinco_minutos_meditacao/shared/clients/models/responses/year_calendar_response.dart';

enum CalendarType {
  week,
  month,
  year,
}

class CalendarModel {
  /// Meditações
  MeditationsResponse? meditationsResponse;

  /// Usuário
  UserResponse? userResponse;

  /// Calendário da semana
  WeekCalendarResponse? weekCalendarResponse;

  /// Calendário da semana
  MonthCalendarResponse? monthCalendarResponse;

  /// Calendário da semana
  YearCalendarResponse? yearCalendarResponse;

  /// Calendário da semana
  List<int>? weekCalendar;

  /// Calendário do mes
  List<int>? monthCalendar;

  /// Calendário do ano
  List<int>? yearCalendar;

  /// tipo de visualização do calendário
  CalendarType? calendarType;

  /// - [meditationsResponse] : Meditações
  /// - [userResponse] : Usuário
  /// - [weekCalendarResponse] : Calendário da semana
  /// - [monthCalendarResponse] : Calendário da semana
  /// - [yearCalendarResponse] : Calendário da semana
  /// - [weekCalendar] : Calendário da semana
  /// - [monthCalendar] : Calendário da semana
  /// - [yearCalendar] : Calendário da semana
  /// - [calendarType] : Calendário da semana
  /// construtor
  CalendarModel({
    this.userResponse,
    this.meditationsResponse,
    this.weekCalendarResponse,
    this.monthCalendarResponse,
    this.yearCalendarResponse,
    this.weekCalendar,
    this.monthCalendar,
    this.yearCalendar,
    this.calendarType,
  });
}

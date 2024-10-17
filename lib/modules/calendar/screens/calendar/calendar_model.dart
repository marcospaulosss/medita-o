import 'package:cinco_minutos_meditacao/shared/clients/models/responses/meditations_response.dart';
import 'package:cinco_minutos_meditacao/shared/clients/models/responses/user_response.dart';
import 'package:cinco_minutos_meditacao/shared/clients/models/responses/week_calendar_response.dart';

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
  List<int>? weekCalendar;

  /// Calendário do mes
  List<int>? monthCalendar;

  /// tipo de visualização do calendário
  CalendarType? calendarType;

  /// - [meditationsResponse] : Meditações
  /// - [userResponse] : Usuário
  /// - [weekCalendar] : Calendário da semana
  /// - [monthCalendar] : Calendário da semana
  /// - [calendarType] : Calendário da semana
  /// construtor
  CalendarModel({
    this.userResponse,
    this.meditationsResponse,
    this.weekCalendarResponse,
    this.weekCalendar,
    this.monthCalendar,
    this.calendarType,
  });
}

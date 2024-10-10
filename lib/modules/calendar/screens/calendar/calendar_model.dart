import 'package:cinco_minutos_meditacao/shared/clients/models/responses/meditations_response.dart';
import 'package:cinco_minutos_meditacao/shared/clients/models/responses/user_response.dart';
import 'package:cinco_minutos_meditacao/shared/clients/models/responses/week_calendar_response.dart';

class CalendarModel {
  /// Meditações
  MeditationsResponse? meditationsResponse;

  /// Usuário
  UserResponse? userResponse;

  /// Calendário da semana
  WeekCalendarResponse? weekCalendarResponse;

  /// Calendário da semana
  List<int>? weekCalendar;

  /// - [meditationsResponse] : Meditações
  /// - [userResponse] : Usuário

  /// - [weekCalendar] : Calendário da semana
  /// construtor
  CalendarModel(
      {this.userResponse,
      this.meditationsResponse,
      this.weekCalendarResponse,
      this.weekCalendar});
}

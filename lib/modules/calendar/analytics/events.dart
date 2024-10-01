import 'package:cinco_minutos_meditacao/core/analytics/event.dart';

/// Eventos de analytics do módulo meditação.
abstract class CalendarEvents {
  /// Evento disparado quando a tela de calendário e aberta.
  static AnalyticsEvent get calendarScreenOpened {
    return AnalyticsEvent(name: "abriu_tela_calendario");
  }
}

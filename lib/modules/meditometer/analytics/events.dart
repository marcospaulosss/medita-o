import 'package:cinco_minutos_meditacao/core/analytics/event.dart';

/// Eventos de analytics do módulo meditação.
abstract class MeditometerEvents {
  /// Evento disparado quando a tela do total de meditações.
  static AnalyticsEvent get meditometerScreenOpened {
    return AnalyticsEvent(name: "abriu_tela_meditometro");
  }
}

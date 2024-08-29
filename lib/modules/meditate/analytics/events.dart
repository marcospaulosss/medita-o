import 'package:cinco_minutos_meditacao/core/analytics/event.dart';

/// Eventos de analytics do módulo meditação.
abstract class MeditateEvents {
  /// Evento disparado quando a tela da informações do metodo.
  static AnalyticsEvent get informationMethodScreenOpened {
    return AnalyticsEvent(name: "abriu_tela_informacoes_metodo");
  }

  /// Evento disparado quando a tela da medite 5 minutos.
  static AnalyticsEvent get meditateFiveMinutesScreenOpened {
    return AnalyticsEvent(name: "abriu_tela_medite_5_minutos");
  }

  /// Evento disparado quando a tela da programa no seu tempo.
  static AnalyticsEvent get inYourTimeScreenOpened {
    return AnalyticsEvent(name: "abriu_tela_programa_no_seu_tempo");
  }
}

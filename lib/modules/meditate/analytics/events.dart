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

  /// Evento disparado quando a tela da programa de meditação guiada.
  static AnalyticsEvent get guidedMeditationProgramScreenOpened {
    return AnalyticsEvent(name: "abriu_tela_programa_meditacao_guiada");
  }

  /// Evento disparado quando a tela sobre a meditação guiada.
  static AnalyticsEvent get guidedMeditationAbout {
    return AnalyticsEvent(name: "abriu_tela_saiba_mais_meditacao_guiada");
  }

  /// Evento disparado quando a tela de doação é aberta.
  static AnalyticsEvent get donationScreenOpened {
    return AnalyticsEvent(name: "abriu_tela_doacao");
  }
}

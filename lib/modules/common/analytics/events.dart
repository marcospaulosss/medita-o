import 'package:cinco_minutos_meditacao/core/analytics/event.dart';

/// Eventos de analytics do módulo comum.
abstract class CommonEvents {
  /// Evento disparado quando a tela da home do app é acessada.
  static AnalyticsEvent get homeScreenOpened {
    return AnalyticsEvent(name: "abriu_tela_home");
  }

  /// Evento disparado quando a tela de perfil do app é acessada.
  static AnalyticsEvent get profileScreenOpened {
    return AnalyticsEvent(name: "abriu_tela_perfil");
  }
}

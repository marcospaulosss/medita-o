import 'package:cinco_minutos_meditacao/core/analytics/event.dart';

/// Eventos de analytics do módulo comum.
abstract class CommonEvents {
  /// Evento disparado quando a tela da home do app é acessada.
  static AnalyticsEvent get homeScreenOpened {
    return AnalyticsEvent(name: "abriu tela da home");
  }
}

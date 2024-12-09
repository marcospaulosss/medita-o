import 'package:cinco_minutos_meditacao/core/analytics/event.dart';

/// Eventos de analytics do módulo meditação.
abstract class ShareEvents {
  /// Evento disparado quando a tela do total de meditações.
  static AnalyticsEvent get shareScreenOpened {
    return AnalyticsEvent(name: "abriu_tela_share");
  }
}

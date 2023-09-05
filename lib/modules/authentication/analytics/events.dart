import 'package:cinco_minutos_meditacao/core/analytics/event.dart';

/// Eventos de analytics do módulo de autenticação.
abstract class AuthenticationEvents {
  /// Evento disparado quando a tela de login do app é acessada.
  static AnalyticsEvent get loginScreenOpened {
    return AnalyticsEvent(name: "abriu_tela_login");
  }
}

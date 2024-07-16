import 'package:cinco_minutos_meditacao/core/analytics/event.dart';

/// Eventos de analytics do módulo de autenticação.
abstract class AuthenticationEvents {
  /// Evento disparado quando a tela de login do app é acessada.
  static AnalyticsEvent get loginScreenOpened {
    return AnalyticsEvent(name: "abriu_tela_login");
  }

  /// Evento disparado quando a tela de cadastro do app é acessada.
  static AnalyticsEvent get registerScreenOpened {
    return AnalyticsEvent(name: "abriu_tela_cadastro");
  }

  /// Evento disparado quando a tela de sucesso do cadastro do app é acessada.
  static AnalyticsEvent get registerSuccessScreenOpened {
    return AnalyticsEvent(name: "abriu_tela_sucesso_cadastro");
  }
}

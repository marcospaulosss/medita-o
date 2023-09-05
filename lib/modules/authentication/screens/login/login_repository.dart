import 'package:cinco_minutos_meditacao/core/analytics/manager.dart';
import 'package:cinco_minutos_meditacao/modules/authentication/analytics/events.dart';
import 'package:cinco_minutos_meditacao/modules/authentication/screens/login/login_contracts.dart';

class LoginRepository extends Repository {
  /// Gerenciador de analytics
  final AnalyticsManager _analyticsManager;

  /// - [analyticsManager] : Gerenciador de analytics
  LoginRepository(this._analyticsManager);

  /// Envia o evento de analytics associado a tela de login
  @override
  void sendOpenScreenEvent() {
    _analyticsManager.sendEvent(AuthenticationEvents.loginScreenOpened);
  }
}

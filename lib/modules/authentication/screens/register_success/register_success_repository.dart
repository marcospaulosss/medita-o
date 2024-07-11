import 'package:cinco_minutos_meditacao/core/analytics/manager.dart';
import 'package:cinco_minutos_meditacao/modules/authentication/analytics/events.dart';
import 'package:cinco_minutos_meditacao/modules/authentication/screens/register_success/register_success_contracts.dart';

class RegisterSuccessRepository extends Repository {
  /// Gerenciador de analytics
  final AnalyticsManager _analyticsManager;

  /// - [_analyticsManager] : Gerenciador de analytics
  RegisterSuccessRepository(
    this._analyticsManager,
  );

  /// Envia o evento de analytics associado a tela de login
  @override
  void sendOpenScreenEvent() {
    _analyticsManager
        .sendEvent(AuthenticationEvents.registerSuccessScreenOpened);
  }
}

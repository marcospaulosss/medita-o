import 'package:cinco_minutos_meditacao/core/analytics/manager.dart';
import 'package:cinco_minutos_meditacao/core/wrappers/secure_storage.dart';
import 'package:cinco_minutos_meditacao/modules/common/analytics/events.dart';
import 'package:cinco_minutos_meditacao/modules/common/screens/home/home_contract.dart';

class HomeRepository implements Repository {
  /// Analytics
  final AnalyticsManager _analytics;

  /// Secure Storage
  final SecureStorage _secureStorage;

  /// - [analytics] : Analytics
  /// - [secureStorage] : Secure Storage
  /// construtor
  HomeRepository(this._analytics, this._secureStorage);

  /// envia o evento de tela aberta
  @override
  void sendOpenScreenEvent() {
    _analytics.sendEvent(CommonEvents.homeScreenOpened);
  }

  /// efetua o logout do usuário
  @override
  void logOut() {
    _secureStorage.setIsLogged(false);
  }
}

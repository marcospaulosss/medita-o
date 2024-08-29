import 'package:cinco_minutos_meditacao/core/analytics/manager.dart';
import 'package:cinco_minutos_meditacao/modules/meditate/analytics/events.dart';
import 'package:cinco_minutos_meditacao/modules/meditate/screens/in_your_time/in_your_time_contract.dart';

class InYourTimeRepository implements Repository {
  /// Analytics
  final AnalyticsManager _analytics;

  /// - [analytics] : Analytics
  /// construtor
  InYourTimeRepository(
    this._analytics,
  );

  /// envia o evento de tela aberta
  @override
  void sendOpenScreenEvent() {
    _analytics.sendEvent(MeditateEvents.inYourTimeScreenOpened);
  }
}

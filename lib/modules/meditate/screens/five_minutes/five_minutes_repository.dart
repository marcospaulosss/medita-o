import 'package:cinco_minutos_meditacao/core/analytics/manager.dart';
import 'package:cinco_minutos_meditacao/modules/meditate/analytics/events.dart';

import 'five_minutes_contract.dart';

class FiveMinutesRepository implements Repository {
  /// Analytics
  final AnalyticsManager _analytics;

  /// - [analytics] : Analytics
  /// construtor
  FiveMinutesRepository(
    this._analytics,
  );

  /// envia o evento de tela aberta
  @override
  void sendOpenScreenEvent() {
    _analytics.sendEvent(MeditateEvents.meditateFiveMinutesScreenOpened);
  }
}

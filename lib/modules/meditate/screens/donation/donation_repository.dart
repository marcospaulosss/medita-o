import 'package:cinco_minutos_meditacao/core/analytics/manager.dart';
import 'package:cinco_minutos_meditacao/modules/meditate/analytics/events.dart';

import 'guided_meditation_contract.dart';

class GuidedMeditationRepository implements Repository {
  /// Analytics
  final AnalyticsManager _analytics;

  /// - [analytics] : Analytics
  /// construtor
  GuidedMeditationRepository(this._analytics);

  /// envia o evento de tela aberta
  @override
  void sendOpenScreenEvent() {
    _analytics.sendEvent(MeditateEvents.guidedMeditationAbout);
  }
}

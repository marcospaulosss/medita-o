import 'package:cinco_minutos_meditacao/core/analytics/manager.dart';
import 'package:cinco_minutos_meditacao/modules/meditate/analytics/events.dart';

import 'donation_contract.dart';

class DonationRepository implements Repository {
  /// Analytics
  final AnalyticsManager _analytics;

  /// - [analytics] : Analytics
  /// construtor
  DonationRepository(this._analytics);

  /// envia o evento de tela aberta
  @override
  void sendOpenScreenEvent() {
    _analytics.sendEvent(MeditateEvents.donationScreenOpened);
  }
}

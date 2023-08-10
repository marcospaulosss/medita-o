import 'package:cinco_minutos_meditacao/core/analytics/manager.dart';
import 'package:cinco_minutos_meditacao/modules/common/analytics/events.dart';
import 'package:cinco_minutos_meditacao/modules/common/screens/home/home_contract.dart';

class HomeRepository implements Repository {
  final AnalyticsManager analytics;

  HomeRepository(this.analytics);

  @override
  void sendOpenScreenEvent() {
    analytics.sendEvent(CommonEvents.homeScreenOpened);
  }
}

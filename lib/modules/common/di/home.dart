import 'package:cinco_minutos_meditacao/core/analytics/manager.dart';
import 'package:cinco_minutos_meditacao/core/di/helpers.dart';
import 'package:cinco_minutos_meditacao/modules/common/screens/home/home_presenter.dart';
import 'package:cinco_minutos_meditacao/modules/common/screens/home/home_repository.dart';

abstract class HomeInjector {
  static void setup() {
    registerFactory<HomePresenter>(
        () => HomePresenter(resolve<HomeRepository>()));
    registerFactory<HomeRepository>(
        () => HomeRepository(resolve<AnalyticsManager>()));
  }
}

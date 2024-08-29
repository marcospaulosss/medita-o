import 'package:cinco_minutos_meditacao/core/analytics/manager.dart';
import 'package:cinco_minutos_meditacao/core/di/helpers.dart';
import 'package:cinco_minutos_meditacao/core/routers/app_router.dart';
import 'package:cinco_minutos_meditacao/modules/meditate/screens/in_your_time/in_your_time_presenter.dart';
import 'package:cinco_minutos_meditacao/modules/meditate/screens/in_your_time/in_your_time_repository.dart';

abstract class InYourTimeInjector {
  static void setup() {
    registerFactory<InYourTimePresenter>(
      () => InYourTimePresenter(
        resolve<InYourTimeRepository>(),
        resolve<AppRouter>(),
      ),
    );

    registerFactory<InYourTimeRepository>(
      () => InYourTimeRepository(
        resolve<AnalyticsManager>(),
      ),
    );
  }
}

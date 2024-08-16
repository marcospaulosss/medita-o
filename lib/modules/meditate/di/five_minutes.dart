import 'package:cinco_minutos_meditacao/core/analytics/manager.dart';
import 'package:cinco_minutos_meditacao/core/di/helpers.dart';
import 'package:cinco_minutos_meditacao/core/routers/app_router.dart';
import 'package:cinco_minutos_meditacao/modules/meditate/screens/five_minutes/five_minutes_presenter.dart';
import 'package:cinco_minutos_meditacao/modules/meditate/screens/five_minutes/five_minutes_repository.dart';

abstract class FiveMinutesInjector {
  static void setup() {
    registerFactory<FiveMinutesPresenter>(
      () => FiveMinutesPresenter(
        resolve<FiveMinutesRepository>(),
        resolve<AppRouter>(),
      ),
    );

    registerFactory<FiveMinutesRepository>(
      () => FiveMinutesRepository(
        resolve<AnalyticsManager>(),
      ),
    );
  }
}

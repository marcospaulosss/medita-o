import 'package:cinco_minutos_meditacao/core/analytics/manager.dart';
import 'package:cinco_minutos_meditacao/core/di/helpers.dart';
import 'package:cinco_minutos_meditacao/core/routers/app_router.dart';
import 'package:cinco_minutos_meditacao/modules/meditate/screens/guided_meditation/guided_meditation_presenter.dart';
import 'package:cinco_minutos_meditacao/modules/meditate/screens/guided_meditation/guided_meditation_repository.dart';

abstract class GuidedMeditationInjector {
  static void setup() {
    registerFactory<GuidedMeditationPresenter>(
      () => GuidedMeditationPresenter(
        resolve<GuidedMeditationRepository>(),
        resolve<AppRouter>(),
      ),
    );

    registerFactory<GuidedMeditationRepository>(
      () => GuidedMeditationRepository(
        resolve<AnalyticsManager>(),
      ),
    );
  }
}

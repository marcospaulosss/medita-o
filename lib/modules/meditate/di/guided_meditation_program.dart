import 'package:cinco_minutos_meditacao/core/analytics/manager.dart';
import 'package:cinco_minutos_meditacao/core/di/helpers.dart';
import 'package:cinco_minutos_meditacao/core/routers/app_router.dart';
import 'package:cinco_minutos_meditacao/core/wrappers/secure_storage.dart';
import 'package:cinco_minutos_meditacao/modules/meditate/screens/guided_meditation_program/guided_meditation_program_presenter.dart';
import 'package:cinco_minutos_meditacao/modules/meditate/screens/guided_meditation_program/guided_meditation_program_repository.dart';
import 'package:cinco_minutos_meditacao/shared/clients/client_api.dart';
import 'package:cinco_minutos_meditacao/shared/models/error.dart';

abstract class GuidedMeditationProgramInjector {
  static void setup() {
    registerFactory<GuidedMeditationProgramPresenter>(
      () => GuidedMeditationProgramPresenter(
        resolve<GuidedMeditationProgramRepository>(),
        resolve<AppRouter>(),
      ),
    );

    registerFactory<GuidedMeditationProgramRepository>(
      () => GuidedMeditationProgramRepository(
        resolve<AnalyticsManager>(),
        resolve<ClientApi>(),
        resolve<CustomError>(),
        resolve<SecureStorage>(),
      ),
    );
  }
}

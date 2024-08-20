import 'package:cinco_minutos_meditacao/core/analytics/manager.dart';
import 'package:cinco_minutos_meditacao/core/di/helpers.dart';
import 'package:cinco_minutos_meditacao/core/routers/app_router.dart';
import 'package:cinco_minutos_meditacao/core/wrappers/secure_storage.dart';
import 'package:cinco_minutos_meditacao/modules/meditate/screens/meditate_info/meditate_info_presenter.dart';
import 'package:cinco_minutos_meditacao/modules/meditate/screens/meditate_info/meditate_info_repository.dart';
import 'package:cinco_minutos_meditacao/shared/clients/client_api.dart';
import 'package:cinco_minutos_meditacao/shared/models/error.dart';

abstract class MeditateInfoInjector {
  static void setup() {
    registerFactory<MeditateInfoPresenter>(
      () => MeditateInfoPresenter(
        resolve<MeditateInfoRepository>(),
        resolve<AppRouter>(),
      ),
    );

    registerFactory<MeditateInfoRepository>(
      () => MeditateInfoRepository(
        resolve<AnalyticsManager>(),
        resolve<ClientApi>(),
        resolve<CustomError>(),
        resolve<SecureStorage>(),
      ),
    );
  }
}

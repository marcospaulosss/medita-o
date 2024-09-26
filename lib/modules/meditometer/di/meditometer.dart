import 'package:cinco_minutos_meditacao/core/analytics/manager.dart';
import 'package:cinco_minutos_meditacao/core/di/helpers.dart';
import 'package:cinco_minutos_meditacao/core/routers/app_router.dart';
import 'package:cinco_minutos_meditacao/core/wrappers/secure_storage.dart';
import 'package:cinco_minutos_meditacao/modules/meditometer/screens/meditometer/meditometer_presenter.dart';
import 'package:cinco_minutos_meditacao/modules/meditometer/screens/meditometer/meditometer_repository.dart';
import 'package:cinco_minutos_meditacao/shared/clients/client_api.dart';
import 'package:cinco_minutos_meditacao/shared/models/error.dart';

abstract class MeditometerInjector {
  static void setup() {
    registerFactory<MeditometerPresenter>(
      () => MeditometerPresenter(
        resolve<MeditometerRepository>(),
        resolve<AppRouter>(),
      ),
    );

    registerFactory<MeditometerRepository>(
      () => MeditometerRepository(
        resolve<AnalyticsManager>(),
        resolve<ClientApi>(),
        resolve<CustomError>(),
        resolve<SecureStorage>(),
      ),
    );
  }
}

import 'package:cinco_minutos_meditacao/core/analytics/manager.dart';
import 'package:cinco_minutos_meditacao/core/di/helpers.dart';
import 'package:cinco_minutos_meditacao/core/environment/manager.dart';
import 'package:cinco_minutos_meditacao/core/routers/app_router.dart';
import 'package:cinco_minutos_meditacao/core/wrappers/secure_storage.dart';
import 'package:cinco_minutos_meditacao/modules/share/screens/meditometer/share_presenter.dart';
import 'package:cinco_minutos_meditacao/modules/share/screens/meditometer/share_repository.dart';
import 'package:cinco_minutos_meditacao/shared/clients/client_api.dart';
import 'package:cinco_minutos_meditacao/shared/models/error.dart';

abstract class ShareInjector {
  static void setup() {
    registerFactory<SharePresenter>(
      () => SharePresenter(resolve<ShareRepository>(), resolve<AppRouter>(),
          resolve<EnvironmentManager>()),
    );

    registerFactory<ShareRepository>(
      () => ShareRepository(
        resolve<AnalyticsManager>(),
        resolve<ClientApi>(),
        resolve<CustomError>(),
        resolve<SecureStorage>(),
      ),
    );
  }
}

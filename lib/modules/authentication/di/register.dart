import 'package:cinco_minutos_meditacao/core/analytics/manager.dart';
import 'package:cinco_minutos_meditacao/core/di/helpers.dart';
import 'package:cinco_minutos_meditacao/core/routers/app_router.dart';
import 'package:cinco_minutos_meditacao/core/wrappers/secure_storage.dart';
import 'package:cinco_minutos_meditacao/modules/authentication/screens/register/register_presenter.dart';
import 'package:cinco_minutos_meditacao/modules/authentication/screens/register/register_repository.dart';
import 'package:cinco_minutos_meditacao/shared/clients/client_api.dart';
import 'package:cinco_minutos_meditacao/shared/models/error.dart';

abstract class RegisterInjector {
  static void setup() {
    registerFactory<RegisterPresenter>(
      () => RegisterPresenter(
        resolve<CustomError>(),
        resolve<AppRouter>(),
        resolve<RegisterRepository>(),
      ),
    );

    registerFactory<RegisterRepository>(
      () => RegisterRepository(
        resolve<AnalyticsManager>(),
        resolve<ClientApi>(),
        resolve<CustomError>(),
        resolve<SecureStorage>(),
      ),
    );
  }
}

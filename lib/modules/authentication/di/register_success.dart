import 'package:cinco_minutos_meditacao/core/analytics/manager.dart';
import 'package:cinco_minutos_meditacao/core/di/helpers.dart';
import 'package:cinco_minutos_meditacao/core/routers/app_router.dart';
import 'package:cinco_minutos_meditacao/modules/authentication/screens/register_success/register_success_presenter.dart';
import 'package:cinco_minutos_meditacao/modules/authentication/screens/register_success/register_success_repository.dart';

abstract class RegisterSuccessInjector {
  static void setup() {
    registerFactory<RegisterSuccessPresenter>(
      () => RegisterSuccessPresenter(
        resolve<RegisterSuccessRepository>(),
        resolve<AppRouter>(),
      ),
    );

    registerFactory<RegisterSuccessRepository>(
      () => RegisterSuccessRepository(
        resolve<AnalyticsManager>(),
      ),
    );
  }
}

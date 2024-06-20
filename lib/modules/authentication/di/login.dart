import 'package:cinco_minutos_meditacao/core/analytics/manager.dart';
import 'package:cinco_minutos_meditacao/core/di/helpers.dart';
import 'package:cinco_minutos_meditacao/core/routers/app_router.dart';
import 'package:cinco_minutos_meditacao/core/wrappers/secure_storage.dart';
import 'package:cinco_minutos_meditacao/modules/authentication/screens/login/login_presenter.dart';
import 'package:cinco_minutos_meditacao/modules/authentication/screens/login/login_repository.dart';
import 'package:cinco_minutos_meditacao/shared/clients/social_client_api.dart';
import 'package:cinco_minutos_meditacao/shared/models/error.dart';
import 'package:cinco_minutos_meditacao/shared/services/auth_service.dart';

abstract class LoginInjector {
  static void setup() {
    registerFactory<LoginPresenter>(
      () => LoginPresenter(
        resolve<AuthService>(),
        resolve<CustomError>(),
        resolve<AppRouter>(),
        resolve<LoginRepository>(),
      ),
    );

    registerFactory<LoginRepository>(
      () => LoginRepository(
        resolve<AnalyticsManager>(),
        resolve<SocialClientApi>(),
        resolve<SecureStorage>(),
      ),
    );
  }
}

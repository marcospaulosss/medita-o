import 'package:cinco_minutos_meditacao/core/analytics/manager.dart';
import 'package:cinco_minutos_meditacao/core/di/helpers.dart';
import 'package:cinco_minutos_meditacao/core/routers/app_router.dart';
import 'package:cinco_minutos_meditacao/core/wrappers/secure_storage.dart';
import 'package:cinco_minutos_meditacao/modules/common/screens/profile/profile_presenter.dart';
import 'package:cinco_minutos_meditacao/modules/common/screens/profile/profile_repository.dart';
import 'package:cinco_minutos_meditacao/shared/clients/client_api.dart';
import 'package:cinco_minutos_meditacao/shared/models/error.dart';
import 'package:cinco_minutos_meditacao/shared/services/auth_service.dart';

abstract class ProfileInjector {
  static void setup() {
    registerFactory<ProfilePresenter>(
      () => ProfilePresenter(
        resolve<AuthService>(),
        resolve<ProfileRepository>(),
        resolve<AppRouter>(),
      ),
    );
    registerFactory<ProfileRepository>(
      () => ProfileRepository(
        resolve<AnalyticsManager>(),
        resolve<ClientApi>(),
        resolve<CustomError>(),
        resolve<SecureStorage>(),
      ),
    );
  }
}

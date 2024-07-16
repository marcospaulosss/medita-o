import 'package:cinco_minutos_meditacao/core/analytics/manager.dart';
import 'package:cinco_minutos_meditacao/core/di/helpers.dart';
import 'package:cinco_minutos_meditacao/core/routers/app_router.dart';
import 'package:cinco_minutos_meditacao/core/wrappers/secure_storage.dart';
import 'package:cinco_minutos_meditacao/modules/common/screens/home/home_presenter.dart';
import 'package:cinco_minutos_meditacao/modules/common/screens/home/home_repository.dart';
import 'package:cinco_minutos_meditacao/shared/services/auth_service.dart';

abstract class HomeInjector {
  static void setup() {
    registerFactory<HomePresenter>(
        () => HomePresenter(resolve<AuthService>(),resolve<HomeRepository>(), resolve<AppRouter>()));
    registerFactory<HomeRepository>(
        () => HomeRepository(resolve<AnalyticsManager>(), resolve<SecureStorage>()));
  }
}

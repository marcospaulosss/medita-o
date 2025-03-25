import 'package:cinco_minutos_meditacao/core/analytics/manager.dart';
import 'package:cinco_minutos_meditacao/core/di/helpers.dart';
import 'package:cinco_minutos_meditacao/core/routers/app_router.dart';
import 'package:cinco_minutos_meditacao/core/wrappers/secure_storage.dart';
import 'package:cinco_minutos_meditacao/modules/authentication/screens/welcome/welcome_presenter.dart';
import 'package:cinco_minutos_meditacao/modules/authentication/screens/welcome/welcome_repository.dart';

/// Classe responsável por configurar a injeção de dependências
/// para a tela de boas-vindas.
class WelcomeInjector {
  /// Configura a injeção de dependências para a tela de boas-vindas.
  ///
  /// Registra:
  /// * [WelcomeRepository]
  /// * [WelcomePresenter]
  static void setup() {
    registerFactory<WelcomePresenter>(
      () => WelcomePresenter(
        resolve<AppRouter>(),
        resolve<WelcomeRepository>(),
      ),
    );

    registerFactory<WelcomeRepository>(
      () => WelcomeRepository(
        resolve<AnalyticsManager>(),
        resolve<SecureStorage>(),
      ),
    );
  }
}

import 'package:cinco_minutos_meditacao/core/di/helpers.dart';
import 'package:cinco_minutos_meditacao/core/environment/manager.dart';
import 'package:cinco_minutos_meditacao/shared/clients/social_client_api.dart';

/// Injetor do client do módulo de autenticação.
abstract class AuthenticationClientInjector {
  /// Configura a injeção de dependências do client do módulo de autenticação.
  static void setup() {
    registerFactory<SocialClientApi>(
        () => SocialClientApi(resolve<EnvironmentManager>()));
  }
}

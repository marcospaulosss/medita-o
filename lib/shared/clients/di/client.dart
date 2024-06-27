import 'package:cinco_minutos_meditacao/core/di/helpers.dart';
import 'package:cinco_minutos_meditacao/core/environment/manager.dart';
import 'package:cinco_minutos_meditacao/shared/clients/client_api.dart';

/// Injetor do client do módulo de autenticação.
abstract class ClientInjector {
  /// Configura a injeção de dependências do client.
  static void setup() {
    registerFactory<ClientApi>(
            () => ClientApi(resolve<EnvironmentManager>()));
  }
}


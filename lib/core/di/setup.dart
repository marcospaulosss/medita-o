import 'package:cinco_minutos_meditacao/app.dart';
import 'package:cinco_minutos_meditacao/core/di/helpers.dart';
import 'package:cinco_minutos_meditacao/core/di/singletons.dart' as singletons;
import 'package:cinco_minutos_meditacao/modules/authentication/di/setup.dart'
    as authentication;
import 'package:cinco_minutos_meditacao/modules/common/di/setup.dart' as common;

abstract class DI {
  /// Resolve e retorna a instância do app.
  static App get app => resolve<App>();

  /// Configura a injeção de dependências da aplicação.
  static void setup() {
    singletons.setupInjectors();
    common.setupInjectors();
    authentication.setupInjectors();
  }
}

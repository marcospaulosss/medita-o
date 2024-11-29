import 'package:cinco_minutos_meditacao/app.dart';
import 'package:cinco_minutos_meditacao/core/di/helpers.dart';
import 'package:cinco_minutos_meditacao/core/di/singletons.dart' as singletons;
import 'package:cinco_minutos_meditacao/modules/authentication/di/setup.dart'
    as authentication;
import 'package:cinco_minutos_meditacao/modules/calendar/di/setup.dart'
    as calendar;
import 'package:cinco_minutos_meditacao/modules/common/di/setup.dart' as common;
import 'package:cinco_minutos_meditacao/modules/meditate/di/setup.dart'
    as meditate;
import 'package:cinco_minutos_meditacao/modules/meditometer/di/setup.dart'
    as meditometer;
import 'package:cinco_minutos_meditacao/modules/share/di/setup.dart' as share;

abstract class DI {
  /// Resolve e retorna a instância do app.
  static App get app => resolve<App>();

  /// Configura a injeção de dependências da aplicação.
  static void setup() {
    singletons.setupInjectors();
    common.setupInjectors();
    authentication.setupInjectors();
    meditate.setupInjectors();
    meditometer.setupInjectors();
    calendar.setupInjectors();
    share.setupInjectors();
  }
}

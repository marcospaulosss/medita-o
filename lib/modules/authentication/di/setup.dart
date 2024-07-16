import 'package:cinco_minutos_meditacao/modules/authentication/di/login.dart';
import 'package:cinco_minutos_meditacao/modules/authentication/di/register.dart';
import 'package:cinco_minutos_meditacao/modules/authentication/di/register_success.dart';
import 'package:cinco_minutos_meditacao/shared/clients/di/setup.dart' as clients;

void setupInjectors() {
  clients.setupInjectors();
  LoginInjector.setup();
  RegisterInjector.setup();
  RegisterSuccessInjector.setup();
}

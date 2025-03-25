import 'package:cinco_minutos_meditacao/modules/authentication/di/login.dart';
import 'package:cinco_minutos_meditacao/modules/authentication/di/register.dart';
import 'package:cinco_minutos_meditacao/modules/authentication/di/register_success.dart';
import 'package:cinco_minutos_meditacao/modules/authentication/di/welcome.dart';
import 'package:cinco_minutos_meditacao/shared/clients/di/setup.dart' as clients;

/// Configura a injeção de dependências para o módulo de autenticação.
void setupInjectors() {
  clients.setupInjectors();
  WelcomeInjector.setup();
  LoginInjector.setup();
  RegisterInjector.setup();
  RegisterSuccessInjector.setup();
}

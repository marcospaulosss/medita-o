import 'package:cinco_minutos_meditacao/app.dart';
import 'package:cinco_minutos_meditacao/core/analytics/manager.dart';
import 'package:cinco_minutos_meditacao/core/di/helpers.dart';
import 'package:cinco_minutos_meditacao/core/environment/manager.dart';
import 'package:cinco_minutos_meditacao/core/routers/app_router.dart';
import 'package:cinco_minutos_meditacao/core/wrappers/secure_storage.dart';
import 'package:cinco_minutos_meditacao/shared/clients/interceptor.dart';
import 'package:cinco_minutos_meditacao/shared/models/error.dart';
import 'package:cinco_minutos_meditacao/shared/services/auth_service.dart';

/// Configura a injeção de dependências do core da aplicação.
void setupInjectors() {
  registerSingleton<TokenInterceptor>(
      TokenInterceptor(AppRouter(), SecureStorage()));
  registerSingleton<CustomError>(CustomError());
  registerSingleton<EnvironmentManager>(EnvironmentManager());
  registerSingleton<SecureStorage>(SecureStorage());
  registerSingleton<AuthService>(AuthService());
  registerSingleton<AnalyticsManager>(AnalyticsManager());
  registerSingleton<AppRouter>(AppRouter());
  registerSingleton<App>(const App());
}

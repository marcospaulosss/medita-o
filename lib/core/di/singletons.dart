import 'package:cinco_minutos_meditacao/app.dart';
import 'package:cinco_minutos_meditacao/core/analytics/manager.dart';
import 'package:cinco_minutos_meditacao/core/di/helpers.dart';
import 'package:cinco_minutos_meditacao/core/routers/app_router.dart';

/// Configura a injeção de dependências do core da aplicação.
void setupInjectors() {
  registerSingleton<AnalyticsManager>(AnalyticsManager());
  registerSingleton<AppRouter>(AppRouter());
  registerSingleton<App>(App());
}

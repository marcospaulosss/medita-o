import 'package:auto_route/auto_route.dart';
import 'package:cinco_minutos_meditacao/core/routers/app_router.gr.dart';
import 'package:cinco_minutos_meditacao/core/routers/auth_guard.dart';

@AutoRouterConfig(replaceInRouteName: 'View,Route')
class AppRouter extends $AppRouter {
  @override
  List<AutoRoute> get routes => [
        AutoRoute(page: SplashScreenRoute.page, initial: true),
        AutoRoute(page: HomeRoute.page, guards: [AuthGuard()]),
        AutoRoute(page: LoginRoute.page),
      ];

  /// Navega para a tela inicial do app.
  void goToReplace(PageRouteInfo route) {
    replace(route);
  }
}

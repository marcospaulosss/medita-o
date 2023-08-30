import 'package:auto_route/auto_route.dart';
import 'package:cinco_minutos_meditacao/core/routers/app_router.gr.dart';

@AutoRouterConfig(replaceInRouteName: 'View,Route')
class AppRouter extends $AppRouter {
  @override
  List<AutoRoute> get routes => [
        AutoRoute(page: SplashScreenRoute.page, initial: true),
        AutoRoute(page: HomeRoute.page),
      ];
}

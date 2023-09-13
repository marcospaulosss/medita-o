import 'package:auto_route/auto_route.dart';
import 'package:cinco_minutos_meditacao/core/di/helpers.dart';
import 'package:cinco_minutos_meditacao/core/routers/app_router.gr.dart';
import 'package:cinco_minutos_meditacao/shared/services/auth_service.dart';

class AuthGuard extends AutoRouteGuard {
  final AuthService _authService = resolve<AuthService>();

  @override
  void onNavigation(NavigationResolver resolver, StackRouter router) {
    if (_authService.isAuthenticated) {
      resolver.next(true);
    } else {
      resolver.redirect(const LoginRoute());
    }
  }
}

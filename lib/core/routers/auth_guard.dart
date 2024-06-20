import 'package:auto_route/auto_route.dart';
import 'package:cinco_minutos_meditacao/core/routers/app_router.gr.dart';
import 'package:cinco_minutos_meditacao/core/wrappers/secure_storage.dart';

class AuthGuard extends AutoRouteGuard {
  final SecureStorage _secureStorage = SecureStorage();

  @override
  Future<void> onNavigation(
      NavigationResolver resolver, StackRouter router) async {
    // await _secureStorage.setAllToNull();
    var auth = await _secureStorage.isLogged;
    if (auth) {
      resolver.next(true);
    } else {
      resolver.redirect(LoginRoute());
    }
  }
}

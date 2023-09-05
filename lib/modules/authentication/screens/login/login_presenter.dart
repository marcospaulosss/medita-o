import 'package:cinco_minutos_meditacao/core/routers/app_router.dart';
import 'package:cinco_minutos_meditacao/core/routers/app_router.gr.dart';
import 'package:cinco_minutos_meditacao/modules/authentication/screens/login/login_contracts.dart';
import 'package:cinco_minutos_meditacao/shared/services/auth_service.dart';
import 'package:firebase_auth/firebase_auth.dart';

class LoginPresenter extends Presenter {
  /// Serviço de autenticação
  final AuthService _authService;

  final AppRouter _router;

  /// - [authService] : Serviço de autenticação
  LoginPresenter(this._authService, this._router);

  /// Login utilizando o Google
  @override
  Future<(User?, dynamic)> loginGoogle() async {
    return await _authService.loginGoogle();
  }

  @override
  void goToHome() {
    _router.replace(const HomeRoute());
  }
}

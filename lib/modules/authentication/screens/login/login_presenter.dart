import 'package:cinco_minutos_meditacao/core/routers/app_router.dart';
import 'package:cinco_minutos_meditacao/core/routers/app_router.gr.dart';
import 'package:cinco_minutos_meditacao/modules/authentication/screens/login/login_contracts.dart';
import 'package:cinco_minutos_meditacao/shared/services/auth_service.dart';
import 'package:firebase_auth/firebase_auth.dart';

class LoginPresenter extends Presenter {
  /// Serviço de autenticação
  final AuthService _authService;

  /// Router
  final AppRouter _router;

  /// Repositório
  final Repository _repository;

  /// - [authService] : Serviço de autenticação
  /// - [router] : Router
  /// - [repository] : Repositório
  LoginPresenter(this._authService, this._router, this._repository);

  /// Login utilizando o Google
  @override
  Future<(User?, dynamic)> loginGoogle() async {
    return await _authService.loginGoogle();
  }

  /// Direciona para a tela de home
  @override
  void goToHome() {
    _router.goToReplace(const HomeRoute());
  }

  /// Tageamento de evento de analytics pra a tela de login
  @override
  void onOpenScreen() {
    _repository.sendOpenScreenEvent();
  }
}

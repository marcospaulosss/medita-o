import 'package:cinco_minutos_meditacao/core/routers/app_router.dart';
import 'package:cinco_minutos_meditacao/core/routers/app_router.gr.dart';
import 'package:cinco_minutos_meditacao/modules/authentication/screens/login/login_contracts.dart';
import 'package:cinco_minutos_meditacao/shared/models/error.dart';
import 'package:cinco_minutos_meditacao/shared/services/auth_service.dart';

class LoginPresenter extends Presenter {
  /// View
  @override
  LoginViewContract? view;

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
  Future<void> loginGoogle() async {
    view!.showLoading();
    var (credential, error) = await _authService.loginGoogle();
    if (error != null) {
      view?.showError(error.message);
    }
    if (credential == null || credential.accessToken!.isEmpty) {
      var message = "Erro ao realizar login com o Google";
      CustomError(
        message: message,
        code: ErrorCodes.loginGoogleError,
        stackTrace: StackTrace.current,
      ).sendErrorToCrashlytics();
      view?.showError(message);

      return;
    }

    var err = await _repository.authenticateUserByGoogle(credential);
    if (err != null) {
      view?.showError(err.message);
    }

    goToHome();
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

  /// Login utilizando o Facebook
  @override
  Future<void> loginFacebook() async {
    _authService.loginFacebook();
  }
}

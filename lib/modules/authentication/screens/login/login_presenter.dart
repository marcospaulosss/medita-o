import 'package:cinco_minutos_meditacao/core/environment/manager.dart';
import 'package:cinco_minutos_meditacao/core/routers/app_router.dart';
import 'package:cinco_minutos_meditacao/core/routers/app_router.gr.dart';
import 'package:cinco_minutos_meditacao/modules/authentication/screens/login/login_contracts.dart';
import 'package:cinco_minutos_meditacao/shared/clients/models/requests/auth_request.dart';
import 'package:cinco_minutos_meditacao/shared/models/error.dart';
import 'package:cinco_minutos_meditacao/shared/services/auth_service.dart';
import 'package:url_launcher/url_launcher.dart';

class LoginPresenter extends Presenter {
  /// View
  @override
  LoginViewContract? view;

  /// Serviço de autenticação
  final AuthService _authService;

  /// Erro customizado
  final CustomError _customError;

  /// controle das variáveis de ambiente
  final EnvironmentManager _environmentManager;

  /// Router
  final AppRouter _router;

  /// Repositório
  final Repository _repository;

  /// - [authService] : Serviço de autenticação
  /// - [customError] : Erro customizado
  /// - [environmentManager] : controle das variáveis de ambiente
  /// - [router] : Router
  /// - [repository] : Repositório
  LoginPresenter(this._authService, this._customError, this._router,
      this._repository, this._environmentManager);

  /// Login utilizando o Google
  @override
  Future<void> loginGoogle() async {
    view!.showLoading();
    var (credential, error) = await _authService.loginGoogle();
    if (error != null) {
      view?.showError("Erro ao realizar login com o Google");
      return;
    }
    if (credential == null ||
        credential.accessToken == null ||
        credential.accessToken!.isEmpty) {
      _customError.sendErrorToCrashlytics(
          code: ErrorCodes.loginGoogleError, stackTrace: StackTrace.current);

      view?.showError(_customError.message!);

      return;
    }

    var err = await _repository.authenticateUserByGoogle(credential);
    if (err != null) {
      view?.showError("Erro ao authenticar usuário com o Google no servidor");
      return;
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
    var (credential, error) = await _authService.loginFacebook();
    if (error != null) {
      view?.showError("Erro ao realizar login com o Facebook");
      return;
    }
    if (credential == null || credential.tokenString.isEmpty) {
      _customError.sendErrorToCrashlytics(
          code: ErrorCodes.loginFacebookError, stackTrace: StackTrace.current);

      view?.showError(_customError.message!);

      return;
    }

    var err = await _repository.authenticateUserByFacebook(credential);
    if (err != null) {
      view?.showError(error!.getErrorMessage);
      return;
    }

    goToHome();
  }

  @override
  Future<void> loginEmailPassword(String email, String password) async {
    if (!isValidEmail(email)) {
      view?.showErrorEmailInvalid();
      return Future.value();
    }

    AuthRequest authRequest = AuthRequest(email: email, password: password);
    CustomError? error =
        await _repository.authenticateUserByEmailPassword(authRequest);
    if (error != null) {
      if (error.code == ErrorCodes.unauthorized) {
        view?.showInvalidCredentialsSnackBar();
        return;
      }

      view?.showError(error.message!);
      return;
    }

    goToHome();
  }

  bool isValidEmail(String email) {
    final RegExp emailRegex = RegExp(
      r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$',
    );
    return emailRegex.hasMatch(email);
  }

  @override
  void goToRegister() {
    _router.goTo(const RegisterRoute());
  }

  @override
  Future<void> goToForgotPassword() async {
    if (await canLaunch(_environmentManager.forgotPasswordUrl)) {
      await launch(_environmentManager.forgotPasswordUrl);
    } else {
      _customError.sendErrorToCrashlytics(
          code: ErrorCodes.loginEmailPasswordError,
          stackTrace: StackTrace.current);

      view?.showError(_customError.message!);

      return;
    }
  }
}

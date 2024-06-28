import 'package:cinco_minutos_meditacao/core/routers/app_router.dart';
import 'package:cinco_minutos_meditacao/core/routers/app_router.gr.dart';
import 'package:cinco_minutos_meditacao/modules/authentication/screens/register/register_contracts.dart';
import 'package:cinco_minutos_meditacao/shared/clients/models/auth_request.dart';
import 'package:cinco_minutos_meditacao/shared/models/error.dart';

class RegisterPresenter extends Presenter {
  /// View
  @override
  RegisterViewContract? view;

  /// Erro customizado
  final CustomError _customError;

  /// Router
  final AppRouter _router;

  /// Repositório
  final Repository _repository;

  /// - [router] : Router
  /// - [repository] : Repositório
  RegisterPresenter(
      this._customError, this._router,
      this._repository,
      );

  /// Direciona para a tela de home
  @override
  void goToHome() {
    _router.goToReplace(const HomeRoute());
  }

  /// Tageamento de evento de analytics pra a tela de cadastro
  @override
  void onOpenScreen() {
    _repository.sendOpenScreenEvent();
  }

  @override
  Future<void> register(AuthRequest authRequest) async {
    var error = await _repository.requestRegister(authRequest);
    if (error != null && error.code == ErrorCodes.alreadyRegistered) {
      _router.goToReplace(const LoginRoute());
      return;
    }

    if (error != null && error.code == ErrorCodes.badRequest) {
      view?.showInvalidCredentialsSnackBar(message: error.message!);
      return;
    }
  }
}

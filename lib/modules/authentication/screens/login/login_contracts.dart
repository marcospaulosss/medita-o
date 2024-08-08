import 'package:cinco_minutos_meditacao/shared/clients/models/requests/auth_request.dart';
import 'package:cinco_minutos_meditacao/shared/helpers/view_binding.dart';
import 'package:cinco_minutos_meditacao/shared/models/error.dart';
import 'package:firebase_auth/firebase_auth.dart';

abstract class LoginViewContract {
  /// Exibe tela de erro generica
  void showError(String message);

  /// Exibe tela de carregamento
  void showLoading();

  /// Exibe tela normal
  void showNormalState();

  /// Exibe erro de e-mail inválido
  void showErrorEmailInvalid();

  /// Exibe erro de credenciais inválidas
  void showInvalidCredentialsSnackBar();
}

abstract class Presenter implements ViewBinding<LoginViewContract> {
  /// Tageamento de evento de analytics pra a tela de login
  void onOpenScreen();

  /// Login utilizando o Google
  Future<void> loginGoogle();

  /// Login utilizando o Facebook
  Future<void> loginFacebook();

  /// Login utilizando e-mail e senha
  Future<void> loginEmailPassword(String email, String password);

  /// Direciona para a tela de home
  void goToHome();

  /// Direciona para a tela de registro
  void goToRegister();
}

abstract class Repository {
  /// Envia o evento de analytics associado ao carregamento de login.
  void sendOpenScreenEvent();

  /// Autentica o usuário utilizando o Google
  Future<Object?> authenticateUserByGoogle(AuthCredential credential);

  /// Autentica o usuário utilizando e-mail e senha
  Future<CustomError?> authenticateUserByEmailPassword(AuthRequest authRequest);
}

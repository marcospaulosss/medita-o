import 'package:cinco_minutos_meditacao/shared/helpers/view_binding.dart';
import 'package:firebase_auth/firebase_auth.dart';

abstract class LoginViewContract {
  /// Exibe tela de erro generica
  void showError(String message);

  /// Exibe tela de carregamento
  void showLoading();

  /// Exibe tela normal
  void showNormalState();
}

abstract class Presenter implements ViewBinding<LoginViewContract> {
  /// Tageamento de evento de analytics pra a tela de login
  void onOpenScreen();

  /// Login utilizando o Google
  Future<void> loginGoogle();

  /// Login utilizando o Facebook
  Future<void> loginFacebook();

  /// Direciona para a tela de home
  void goToHome();
}

abstract class Repository {
  /// Envia o evento de analytics associado ao carregamento de login.
  void sendOpenScreenEvent();

  /// Autentica o usuário utilizando o Google
  Future<Object?> authenticateUserByGoogle(AuthCredential credential);
}

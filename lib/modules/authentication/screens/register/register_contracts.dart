import 'package:cinco_minutos_meditacao/shared/clients/models/auth_request.dart';
import 'package:cinco_minutos_meditacao/shared/helpers/view_binding.dart';
import 'package:cinco_minutos_meditacao/shared/models/error.dart';
import 'package:firebase_auth/firebase_auth.dart';

abstract class RegisterViewContract {
  /// Exibe tela de erro generica
  void showError(String message);

  /// Exibe tela de carregamento
  void showLoading();

  /// Exibe tela normal
  void showNormalState();

  /// Exibe erro de e-mail inválido
  void showErrorEmailInvalid();

  /// Exibe erro de credenciais inválidas
  void showInvalidCredentialsSnackBar({String? message});
}

abstract class Presenter implements ViewBinding<RegisterViewContract> {
  /// Tageamento de evento de analytics pra a tela de login
  void onOpenScreen();

  /// Direciona para a tela de home
  void goToHome();

  /// Realiza o registro do usuário
  Future<void> register(AuthRequest authRequest);
}

abstract class Repository {
  /// Envia o evento de analytics associado ao carregamento de cadastro.
  void sendOpenScreenEvent();

  /// Realiza o registro do usuário
  Future<CustomError?> requestRegister(AuthRequest authRequest);
}

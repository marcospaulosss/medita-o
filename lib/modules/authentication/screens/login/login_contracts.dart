import 'package:firebase_auth/firebase_auth.dart';

abstract class Presenter {
  /// Tageamento de evento de analytics pra a tela de login
  void onOpenScreen();

  /// Login utilizando o Google
  Future<(User?, dynamic)> loginGoogle();

  /// Direciona para a tela de home
  void goToHome();
}

abstract class Repository {
  /// Envia o evento de analytics associado ao carregamento de login.
  void sendOpenScreenEvent();
}

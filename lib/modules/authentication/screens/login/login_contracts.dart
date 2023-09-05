import 'package:firebase_auth/firebase_auth.dart';

abstract class Presenter {
  /// Login utilizando o Google
  Future<(User?, dynamic)> loginGoogle();

  /// Direciona para a tela de home
  void goToHome();
}

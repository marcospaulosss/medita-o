abstract class Presenter {
  /// evento disparado ao abrir a tela
  void onOpenScreen();

  /// efetua o logout do usuário
  void logOut();
}

abstract class Repository {
  /// Envia evento de abertura de tela
  void sendOpenScreenEvent();

  /// efetua o logout do usuário
  void logOut();
}

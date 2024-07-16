abstract class Presenter {
  /// Envia o evento de analytics associado ao carregamento da tela de registro de sucesso.
  void onOpenScreen();

  /// Direciona para a tela de home.
  void goToHome();
}

abstract class Repository {
  /// Envia o evento de analytics associado ao carregamento da tela de registro de sucesso.
  void sendOpenScreenEvent();
}

import 'package:cinco_minutos_meditacao/shared/helpers/view_binding.dart';

abstract class InYourTimeContract {
  /// Mostra a tela de carregamento
  void showLoading();

  /// Mostra a tela normal
  void showNormalState();

  /// Mostra a tela de erro
  void showError(String message);
}

abstract class Presenter implements ViewBinding<InYourTimeContract> {
  /// evento disparado ao abrir a tela
  void onOpenScreen();
}

abstract class Repository {
  /// Envia evento de abertura de tela
  void sendOpenScreenEvent();
}

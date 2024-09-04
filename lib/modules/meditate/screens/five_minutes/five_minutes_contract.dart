import 'package:cinco_minutos_meditacao/shared/helpers/view_binding.dart';

abstract class FiveMinutesViewContract {
  /// Mostra a tela de carregamento
  void showLoading();

  /// Mostra a tela normal
  void showNormalState();

  /// Mostra a tela de erro
  void showError(String message);

  /// Altera o estado de encerramento da meditação
  void meditationCompleted();
}

abstract class Presenter implements ViewBinding<FiveMinutesViewContract> {
  /// evento disparado ao abrir a tela
  void onOpenScreen();

  /// Direciona para a tela de informações de como meditar
  void goToMeditateInfo();

  /// Submete a meditação concluída
  void submitMeditateCompleted(int time);
}

abstract class Repository {
  /// Envia evento de abertura de tela
  void sendOpenScreenEvent();

  /// Efetua o registro da meditação concluída
  Future<void> requestRegisterMeditateCompleted(int time);
}

import 'package:cinco_minutos_meditacao/shared/helpers/view_binding.dart';

abstract class InYourTimeContract {
  /// Mostra a tela de carregamento
  void showLoading();

  /// Mostra a tela normal
  void showNormalState();

  /// Mostra a tela de erro
  void showError(String message);

  /// Altera o estado de encerramento da meditação
  void meditationCompleted();
}

abstract class Presenter implements ViewBinding<InYourTimeContract> {
  /// evento disparado ao abrir a tela
  void onOpenScreen();

  /// Submete a meditação concluída
  void submitMeditateCompleted(int time);

  /// Direciona para a tela de compartilhamento após a conclusão da meditação personalizada.
  /// Este método é chamado automaticamente após o registro da meditação concluída,
  /// permitindo que o usuário compartilhe sua conquista nas redes sociais.
  void goToShare();
}

abstract class Repository {
  /// Envia evento de abertura de tela
  void sendOpenScreenEvent();

  /// Efetua o registro da meditação concluída
  Future<void> requestRegisterMeditateCompleted(int time);
}

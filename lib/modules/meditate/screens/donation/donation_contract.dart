import 'package:cinco_minutos_meditacao/shared/helpers/view_binding.dart';

abstract class GuidedMeditationViewContract {}

abstract class Presenter implements ViewBinding<GuidedMeditationViewContract> {
  /// Inicializa o presenter
  void initPresenter();
}

abstract class Repository {
  /// Envia evento de abertura de tela
  void sendOpenScreenEvent();
}

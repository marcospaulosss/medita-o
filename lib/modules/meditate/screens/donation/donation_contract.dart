import 'package:cinco_minutos_meditacao/shared/helpers/view_binding.dart';

abstract class DonationViewContract {}

abstract class Presenter implements ViewBinding<DonationViewContract> {
  /// Inicializa o presenter
  void initPresenter();
}

abstract class Repository {
  /// Envia evento de abertura de tela
  void sendOpenScreenEvent();
}

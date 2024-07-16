import 'package:cinco_minutos_meditacao/shared/clients/models/responses/user_response.dart';
import 'package:cinco_minutos_meditacao/shared/helpers/view_binding.dart';
import 'package:cinco_minutos_meditacao/shared/models/error.dart';

abstract class HomeViewContract {
  /// Mostra a tela de carregamento
  void showLoading();

  /// Mostra a tela normal
  void showNormalState(UserResponse? user);

  /// Mostra a tela de erro
  void showError(String message);
}

abstract class Presenter implements ViewBinding<HomeViewContract> {
  /// Inicializa o presenter
  void initPresenter();

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

  /// Busca informações do usuário
  Future<(UserResponse?, CustomError?)> requestUser();
}

import 'dart:io';

import 'package:cinco_minutos_meditacao/modules/meditometer/screens/meditometer/meditometer_model.dart';
import 'package:cinco_minutos_meditacao/modules/share/screens/meditometer/share_model.dart';
import 'package:cinco_minutos_meditacao/shared/clients/models/responses/meditations_response.dart';
import 'package:cinco_minutos_meditacao/shared/clients/models/responses/user_response.dart';
import 'package:cinco_minutos_meditacao/shared/helpers/view_binding.dart';
import 'package:cinco_minutos_meditacao/shared/models/error.dart';

abstract class ShareViewContract {
  /// Mostra a tela de carregamento
  void showLoading();

  /// Mostra a tela normal
  void showNormalState(ShareModel response);

  /// Mostra a tela de erro
  void showError(String message);
}

abstract class Presenter implements ViewBinding<ShareViewContract> {
  /// Inicializa o presenter
  void initPresenter();

  /// Direciona para a tela de configurações
  Future<void> socialShare();
}

abstract class Repository {
  /// Envia evento de abertura de tela
  void sendOpenScreenEvent();

  /// Busca o token da API
  Future<(String?, CustomError?)> getTokenApi();
}

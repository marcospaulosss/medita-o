import 'dart:io';

import 'package:cinco_minutos_meditacao/modules/meditometer/screens/meditometer/meditometer_model.dart';
import 'package:cinco_minutos_meditacao/shared/clients/models/responses/meditations_response.dart';
import 'package:cinco_minutos_meditacao/shared/clients/models/responses/user_response.dart';
import 'package:cinco_minutos_meditacao/shared/helpers/view_binding.dart';
import 'package:cinco_minutos_meditacao/shared/models/error.dart';

abstract class MeditometerViewContract {
  /// Mostra a tela de carregamento
  void showLoading();

  /// Mostra a tela normal
  void showNormalState(MeditometerModel response);

  /// Mostra a tela de erro
  void showError(String message);
}

abstract class Presenter implements ViewBinding<MeditometerViewContract> {
  /// Inicializa o presenter
  void initPresenter();

  /// Atualiza a imagem de perfil do usuário
  Future<void> updateImageProfile();

  /// Direciona para a tela de sobre o app
  void goToAbout();

  /// Direciona para a tela de configurações
  Future<void> socialShare();
}

abstract class Repository {
  /// Envia evento de abertura de tela
  void sendOpenScreenEvent();

  /// Busca informações do usuário
  Future<(UserResponse?, CustomError?)> requestUser();

  /// Busca a quantidade de meditações realizadas no mundo
  Future<(MeditationsResponse?, CustomError?)> requestMeditations();

  /// Atualiza a imagem de perfil do usuário
  Future<CustomError?> uploadImageProfile(File file);

  /// Busca o token da API
  Future<(String?, CustomError?)> getTokenApi();
}

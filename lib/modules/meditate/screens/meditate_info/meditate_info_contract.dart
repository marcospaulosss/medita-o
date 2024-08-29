import 'dart:io';

import 'package:cinco_minutos_meditacao/modules/meditate/screens/meditate_info/meditate_info_model.dart';
import 'package:cinco_minutos_meditacao/shared/clients/models/responses/meditations_response.dart';
import 'package:cinco_minutos_meditacao/shared/clients/models/responses/user_response.dart';
import 'package:cinco_minutos_meditacao/shared/helpers/view_binding.dart';
import 'package:cinco_minutos_meditacao/shared/models/error.dart';

abstract class MeditateInfoViewContract {
  /// Mostra a tela de carregamento
  void showLoading();

  /// Mostra a tela normal
  void showNormalState({MeditateInfoModel? model});

  /// Mostra a tela de erro
  void showError(String message);
}

abstract class Presenter implements ViewBinding<MeditateInfoViewContract> {
  /// Inicializa o presenter
  void initPresenter();

  /// evento disparado ao abrir a tela
  void onOpenScreen();

  /// Atualiza a imagem de perfil do usuário
  Future<void> updateImageProfile();
}

abstract class Repository {
  /// Envia evento de abertura de tela
  void sendOpenScreenEvent();

  /// Busca informações do usuário
  Future<(UserResponse?, CustomError?)> requestUser();

  /// Atualiza a imagem de perfil do usuário
  Future<CustomError?> uploadImageProfile(File file);

  /// Busca a quantidade de meditações realizadas no mundo
  Future<(MeditationsResponse?, CustomError?)> requestMeditationsByUser();

  /// Busca a quantidade de meditações realizadas no mundo
  Future<(MeditationsResponse?, CustomError?)> requestMeditations();
}

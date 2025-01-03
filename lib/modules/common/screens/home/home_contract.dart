import 'dart:io';

import 'package:cinco_minutos_meditacao/modules/common/screens/home/home_model.dart';
import 'package:cinco_minutos_meditacao/shared/clients/models/responses/get_banners_response.dart';
import 'package:cinco_minutos_meditacao/shared/clients/models/responses/meditations_response.dart';
import 'package:cinco_minutos_meditacao/shared/clients/models/responses/user_response.dart';
import 'package:cinco_minutos_meditacao/shared/helpers/view_binding.dart';
import 'package:cinco_minutos_meditacao/shared/models/error.dart';

abstract class HomeViewContract {
  /// Mostra a tela de carregamento
  void showLoading();

  /// Mostra a tela normal
  void showNormalState(HomeModel model);

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

  /// Atualiza a imagem de perfil do usuário
  Future<void> updateImageProfile();

  /// Direciona para a tela de informações e metodos de meditação
  void goToMeditateInfo(HomeModel model);

  /// Direciona para a tela de meditação de 5 minutos
  void goToFiveMinutes();

  /// Direciona para a tela do In Your Time
  void goToInYourTime();

  /// Direciona para a tela de meditação guiada
  void goToGuidedMeditation();
}

abstract class Repository {
  /// Envia evento de abertura de tela
  void sendOpenScreenEvent();

  /// efetua o logout do usuário
  void logOut();

  /// Busca informações do usuário
  Future<(UserResponse?, CustomError?)> requestUser();

  /// Atualiza a imagem de perfil do usuário
  Future<CustomError?> uploadImageProfile(File file);

  /// Busca a quantidade de meditações realizadas no mundo
  Future<(MeditationsResponse?, CustomError?)> requestMeditations();

  /// Busca os banners
  Future<(GetBannersResponse?, CustomError?)> requestBanners();
}

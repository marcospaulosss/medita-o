import 'dart:io';

import 'package:cinco_minutos_meditacao/modules/common/screens/profile/profile_model.dart';
import 'package:cinco_minutos_meditacao/shared/clients/models/requests/user_request.dart';
import 'package:cinco_minutos_meditacao/shared/clients/models/responses/countries_response.dart';
import 'package:cinco_minutos_meditacao/shared/clients/models/responses/states_response.dart';
import 'package:cinco_minutos_meditacao/shared/clients/models/responses/user_response.dart';
import 'package:cinco_minutos_meditacao/shared/helpers/view_binding.dart';
import 'package:cinco_minutos_meditacao/shared/models/error.dart';

abstract class ProfileViewContract {
  /// Mostra a tela de carregamento
  void showLoading();

  /// Mostra a tela normal
  void showNormalState(ProfileModel model);

  /// Mostra a tela de erro
  void showError(String message);
}

abstract class Presenter implements ViewBinding<ProfileViewContract> {
  /// Inicializa o presenter
  void initPresenter();

  /// evento disparado ao abrir a tela
  void onOpenScreen();

  /// efetua o logout do usuário
  void logOut();

  /// Atualiza a imagem de perfil do usuário
  Future<void> updateImageProfile();

  /// Busca os estados do país selecionado
  Future<List<String>> getStates(countryId);

  /// Atualiza os dados do usuário
  Future<void> updateUser(UserRequest user);
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

  /// Busca os países
  Future<(CountriesResponse?, CustomError?)> requestGetCountries();

  /// Busca os estados do país selecionado
  Future<(StatesResponse?, CustomError?)> requestGetStatesByCountryId(
      int countryId);

  /// Atualiza os dados do usuário
  Future<(UserResponse?, CustomError?)> requestUpdateUser(UserRequest user);
}

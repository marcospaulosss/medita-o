import 'dart:io';

import 'package:cinco_minutos_meditacao/modules/meditate/screens/meditate_info/meditate_info_model.dart';
import 'package:cinco_minutos_meditacao/shared/clients/models/responses/meditations_response.dart';
import 'package:cinco_minutos_meditacao/shared/clients/models/responses/user_response.dart';
import 'package:cinco_minutos_meditacao/shared/helpers/view_binding.dart';
import 'package:cinco_minutos_meditacao/shared/models/error.dart';

abstract class GuidedMeditationViewContract {
  /// Mostra a tela de carregamento
  void showLoading();

  /// Mostra a tela normal
  void showNormalState();

  /// Mostra a tela de erro
  void showError(String message);
}

abstract class Presenter implements ViewBinding<GuidedMeditationViewContract> {
  /// Inicializa o presenter
  void initPresenter();
}

abstract class Repository {
  /// Envia evento de abertura de tela
  void sendOpenScreenEvent();
}

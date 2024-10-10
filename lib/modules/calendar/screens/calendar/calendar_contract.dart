import 'dart:io';

import 'package:cinco_minutos_meditacao/modules/calendar/screens/calendar/calendar_model.dart';
import 'package:cinco_minutos_meditacao/shared/clients/models/responses/meditations_response.dart';
import 'package:cinco_minutos_meditacao/shared/clients/models/responses/user_response.dart';
import 'package:cinco_minutos_meditacao/shared/clients/models/responses/week_calendar_response.dart';
import 'package:cinco_minutos_meditacao/shared/helpers/view_binding.dart';
import 'package:cinco_minutos_meditacao/shared/models/error.dart';

abstract class CalendarViewContract {
  /// Mostra a tela de carregamento
  void showLoading();

  /// Mostra a tela normal
  void showNormalState(CalendarModel response);

  /// Mostra a tela de erro
  void showError(String message);
}

abstract class Presenter implements ViewBinding<CalendarViewContract> {
  /// Inicializa o presenter
  void initPresenter();

  /// Atualiza a imagem de perfil do usuário
  Future<void> updateImageProfile();
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

  /// Busca a quantidade de meditações realizadas na semana
  Future<(WeekCalendarResponse?, CustomError?)> requestCalendarWeek(
      String date);
}

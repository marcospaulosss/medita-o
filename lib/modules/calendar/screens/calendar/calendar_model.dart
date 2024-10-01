import 'package:cinco_minutos_meditacao/shared/clients/models/responses/meditations_response.dart';
import 'package:cinco_minutos_meditacao/shared/clients/models/responses/user_response.dart';

class CalendarModel {
  /// Meditações
  MeditationsResponse? meditationsResponse;

  /// Usuário
  UserResponse? userResponse;

  /// - [meditationsResponse] : Meditações
  /// - [userResponse] : Usuário
  /// construtor
  CalendarModel({this.userResponse, this.meditationsResponse});
}

import 'package:cinco_minutos_meditacao/shared/clients/models/responses/meditations_response.dart';
import 'package:cinco_minutos_meditacao/shared/clients/models/responses/user_response.dart';

class MeditometerModel {
  /// Meditações
  MeditationsResponse? meditationsResponse;

  /// Usuário
  UserResponse? userResponse;

  /// - [meditationsResponse] : Meditações
  /// - [userResponse] : Usuário
  /// construtor
  MeditometerModel({this.userResponse, this.meditationsResponse});
}

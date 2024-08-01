import 'package:cinco_minutos_meditacao/shared/clients/models/responses/meditations_response.dart';
import 'package:cinco_minutos_meditacao/shared/clients/models/responses/user_response.dart';

class MeditateInfoModel {
  /// Meditações
  MeditationsResponse? meditationsResponse;

  /// Meditações
  MeditationsResponse? meditationsByUserResponse;

  /// Usuário
  UserResponse? userResponse;

  /// - [meditationsResponse] : Meditações
  /// - [meditationsByUserResponse] : Meditações
  /// - [userResponse] : Usuário
  /// construtor
  MeditateInfoModel({
    this.userResponse,
    this.meditationsByUserResponse,
    this.meditationsResponse,
  });
}

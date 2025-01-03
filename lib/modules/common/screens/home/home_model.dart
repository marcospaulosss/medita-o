import 'package:cinco_minutos_meditacao/shared/clients/models/responses/get_banners_response.dart';
import 'package:cinco_minutos_meditacao/shared/clients/models/responses/meditations_response.dart';
import 'package:cinco_minutos_meditacao/shared/clients/models/responses/user_response.dart';

class HomeModel {
  /// Meditações
  MeditationsResponse? meditationsResponse;

  /// Usuário
  UserResponse? userResponse;

  /// Banners
  GetBannersResponse? bannersResponse;

  /// - [meditationsResponse] : Meditações
  /// - [userResponse] : Usuário
  /// - [bannersResponse] : Banners
  /// construtor
  HomeModel({
    this.userResponse,
    this.meditationsResponse,
    this.bannersResponse,
  });
}

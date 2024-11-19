import 'package:cinco_minutos_meditacao/shared/clients/models/responses/countries_response.dart';
import 'package:cinco_minutos_meditacao/shared/clients/models/responses/states_response.dart';
import 'package:cinco_minutos_meditacao/shared/clients/models/responses/user_response.dart';

class ProfileModel {
  /// Usuário
  UserResponse? userResponse;

  /// País
  CountriesResponse? countryResponse;

  /// Estados
  StatesResponse? statesResponse;

  /// - [userResponse] : Usuário
  /// - [countryResponse] : País
  /// - [statesResponse] : Estados
  /// construtor
  ProfileModel({this.userResponse, this.countryResponse, this.statesResponse});
}

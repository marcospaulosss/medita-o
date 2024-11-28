import 'package:json_annotation/json_annotation.dart';

/// id : 3
/// name : "Marcos Paulo Sousa Santos"
/// email : "marcospaulo.s.santos@gmail.com"
/// email_verified_at : null
/// google_id : "100784010955358965802"
/// facebook_id : null
/// profile_photo_path : null
/// created_at : "2024-06-11T14:26:42.000000Z"
/// updated_at : "2024-07-11T21:58:35.000000Z"

part 'user_response.g.dart';

@JsonSerializable()
class UserResponse {
  /// id do usuário
  @JsonKey(name: 'id')
  int id;

  /// nome do usuário
  @JsonKey(name: 'name')
  String name;

  /// email do usuário
  @JsonKey(name: 'email')
  String email;

  /// email verificado
  @JsonKey(name: 'email_verified_at')
  dynamic emailVerifiedAt;

  /// id do google
  @JsonKey(name: 'google_id')
  String? googleId;

  /// id do facebook
  @JsonKey(name: 'facebook_id')
  dynamic facebookId;

  /// url da foto de perfil
  @JsonKey(name: 'profile_photo_path')
  String? profilePhotoPath;

  /// data de criação
  @JsonKey(name: 'created_at')
  String? createdAt;

  /// data de atualização
  @JsonKey(name: 'updated_at')
  String? updatedAt;

  /// gênero
  @JsonKey(name: 'genre')
  String? genre;

  /// data de nascimento
  @JsonKey(name: 'birthdate')
  String? birthdate;

  /// cidade
  @JsonKey(name: 'state')
  State? state;

  /// - [id] : id do usuário
  /// - [name] : nome do usuário
  /// - [email] : email do usuário
  /// - [emailVerifiedAt] : email verificado
  /// - [googleId] : id do google
  /// - [facebookId] : id do facebook
  /// - [profilePhotoPath] : url da foto de perfil
  /// - [createdAt] : data de criação
  /// - [updatedAt] : data de atualização
  /// - [genre] : gênero
  /// - [birthdate] : data de nascimento
  /// - [state] : estado
  /// construtor
  UserResponse(
    this.id,
    this.name,
    this.email,
    this.emailVerifiedAt,
    this.googleId,
    this.facebookId,
    this.profilePhotoPath,
    this.createdAt,
    this.updatedAt,
    this.genre,
    this.birthdate,
    this.state,
  );

  factory UserResponse.fromJson(Map<String, dynamic> json) =>
      _$UserResponseFromJson(json);

  Map<String, dynamic> toJson() => _$UserResponseToJson(this);

  /// Retorna o valor adapatado para exibição.
  String adapterGenre() => (genre == 'M') ? 'Masculino' : 'Feminino';
}

@JsonSerializable()
class State {
  /// id do estado
  @JsonKey(name: 'id')
  int id;

  /// nome do estado
  @JsonKey(name: 'name')
  String name;

  /// país
  @JsonKey(name: 'country')
  Country country;

  State(
    this.id,
    this.name,
    this.country,
  );

  factory State.fromJson(Map<String, dynamic> json) => _$StateFromJson(json);

  Map<String, dynamic> toJson() => _$StateToJson(this);
}

@JsonSerializable()
class Country {
  /// id do país
  @JsonKey(name: 'id')
  int id;

  /// nome do país
  @JsonKey(name: 'name')
  String name;

  Country(
    this.id,
    this.name,
  );

  factory Country.fromJson(Map<String, dynamic> json) =>
      _$CountryFromJson(json);

  Map<String, dynamic> toJson() => _$CountryToJson(this);
}

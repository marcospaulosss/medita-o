import 'package:json_annotation/json_annotation.dart';

part 'authenticate_google_response.g.dart';

@JsonSerializable()
class AuthenticateGoogleResponse {
  /// token de autenticação
  @JsonKey(name: 'token')
  String? token;

  /// Usuário autenticado
  @JsonKey(name: 'user')
  User? user;

  /// - [token] : token de autenticação
  /// - [user] : Usuário autenticado
  AuthenticateGoogleResponse(this.token, this.user);

  factory AuthenticateGoogleResponse.fromJson(Map<String, dynamic> json) =>
      _$AuthenticateGoogleResponseFromJson(json);

  Map<String, dynamic> toJson() => _$AuthenticateGoogleResponseToJson(this);
}

@JsonSerializable()
class User {
  /// Identificador do usuário
  @JsonKey(name: 'id')
  int? id;

  /// Nome do usuário
  @JsonKey(name: 'name')
  String? name;

  /// Email do usuário
  @JsonKey(name: 'email')
  String? email;

  /// Data de verificação do email
  @JsonKey(name: 'email_verified_at')
  String? emailVerifiedAt;

  /// Identificador do Google
  @JsonKey(name: 'google_id')
  String? googleId;

  /// Identificador do Facebook
  @JsonKey(name: 'facebook_id')
  String? facebookId;

  /// Caminho da foto de perfil
  @JsonKey(name: 'profile_photo_path')
  String? profilePhotoPath;

  /// Data de criação
  @JsonKey(name: 'created_at')
  String? createdAt;

  /// Data de atualização
  @JsonKey(name: 'updated_at')
  String updatedAt;

  User(
    this.id,
    this.name,
    this.email,
    this.emailVerifiedAt,
    this.googleId,
    this.facebookId,
    this.profilePhotoPath,
    this.createdAt,
    this.updatedAt,
  );

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);

  Map<String, dynamic> toJson() => _$UserToJson(this);
}

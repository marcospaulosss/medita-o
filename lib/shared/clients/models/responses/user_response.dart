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
  dynamic? emailVerifiedAt;

  /// id do google
  @JsonKey(name: 'google_id')
  String? googleId;

  /// id do facebook
  @JsonKey(name: 'facebook_id')
  dynamic? facebookId;

  /// url da foto de perfil
  @JsonKey(name: 'profile_photo_path')
  String? profilePhotoPath;

  /// data de criação
  @JsonKey(name: 'created_at')
  String? createdAt;

  /// data de atualização
  @JsonKey(name: 'updated_at')
  String? updatedAt;

  /// - [id] : id do usuário
  /// - [name] : nome do usuário
  /// - [email] : email do usuário
  /// - [emailVerifiedAt] : email verificado
  /// - [googleId] : id do google
  /// - [facebookId] : id do facebook
  /// - [profilePhotoPath] : url da foto de perfil
  /// - [createdAt] : data de criação
  /// - [updatedAt] : data de atualização
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
      this.updatedAt);

  factory UserResponse.fromJson(Map<String, dynamic> json) =>
      _$UserResponseFromJson(json);

  Map<String, dynamic> toJson() => _$UserResponseToJson(this);
}

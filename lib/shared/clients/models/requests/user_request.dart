import 'package:json_annotation/json_annotation.dart';

part 'user_request.g.dart';

@JsonSerializable()
class UserRequest {
  /// id do usuário
  @JsonKey(name: 'id')
  int id;

  /// nome do usuário
  @JsonKey(name: 'name')
  String name;

  /// email do usuário
  @JsonKey(name: 'email')
  String email;

  /// gênero
  @JsonKey(name: 'genre')
  String? genre;

  /// data de nascimento
  @JsonKey(name: 'birthdate')
  String? birthdate;

  /// cidade
  @JsonKey(name: 'state_id')
  int? state;

  /// - [id] : id do usuário
  /// - [name] : nome do usuário
  /// - [email] : email do usuário
  /// - [genre] : gênero
  /// - [birthdate] : data de nascimento
  /// - [state] : estado
  /// construtor
  UserRequest(
    this.id,
    this.name,
    this.email,
    this.genre,
    this.birthdate,
    this.state,
  );

  factory UserRequest.fromJson(Map<String, dynamic> json) =>
      _$UserRequestFromJson(json);

  Map<String, dynamic> toJson() => _$UserRequestToJson(this);
}


import 'package:json_annotation/json_annotation.dart';

part 'auth_request.g.dart';

@JsonSerializable()
class AuthRequest {
  /// Nome do usuário
  @JsonKey(name: 'name')
  String? name;

  /// Email do usuário
  @JsonKey(name: 'email')
  String email;

  /// Senha do usuário
  @JsonKey(name: 'password')
  String password;

  /// Confirmação de senha
  @JsonKey(name: 'password_confirmation')
  String? passwordConfirmation;

  /// - [name] : Nome do usuário
  /// - [email] : Email do usuário
  /// - [password] : Senha do usuário
  /// - [passwordConfirmation] : Confirmação de senha
  /// constroi um objeto de autenticação
  AuthRequest({this.name, required this.email, required this.password, this.passwordConfirmation});

  factory AuthRequest.fromJson(Map<String, dynamic> json) =>
      _$AuthRequestFromJson(json);

  Map<String, dynamic> toJson() => _$AuthRequestToJson(this);
}
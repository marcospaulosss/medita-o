
import 'package:flutter/foundation.dart';
import 'package:json_annotation/json_annotation.dart';

part 'auth_request.g.dart';

@JsonSerializable()
class AuthRequest {
  /// Email do usuário
  @JsonKey(name: 'email')
  String email;

  /// Senha do usuário
  @JsonKey(name: 'password')
  String password;

  /// - [email] : Email do usuário
  /// - [password] : Senha do usuário
  /// constroi um objeto de autenticação
  AuthRequest(this.email, this.password);

  factory AuthRequest.fromJson(Map<String, dynamic> json) =>
      _$AuthRequestFromJson(json);

  Map<String, dynamic> toJson() => _$AuthRequestToJson(this);
}
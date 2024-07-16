import 'package:json_annotation/json_annotation.dart';

part 'register_response.g.dart';

@JsonSerializable()
class RegisterResponse {
  /// token de autenticação
  @JsonKey(name: 'access_token')
  String? token;

  /// Tipo do token
  @JsonKey(name: 'token_type')
  String? tokenType;

  /// - [token] : token de autenticação
  /// - [tokenType] : Tipo do token
  RegisterResponse(this.token, this.tokenType);

  factory RegisterResponse.fromJson(Map<String, dynamic> json) =>
      _$RegisterResponseFromJson(json);

  Map<String, dynamic> toJson() => _$RegisterResponseToJson(this);
}

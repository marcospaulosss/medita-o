import 'package:json_annotation/json_annotation.dart';

part 'authenticate_google_request.g.dart';

@JsonSerializable(createFactory: false)
class AuthenticateGoogleRequest {
  @JsonKey(name: 'token')
  String? idToken;

  AuthenticateGoogleRequest({required this.idToken});

  Map<String, dynamic> toJson() {
    return _$AuthenticateGoogleRequestToJson(this);
  }
}

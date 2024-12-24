import 'package:json_annotation/json_annotation.dart';

part 'authenticate_facebook_request.g.dart';

@JsonSerializable(createFactory: false)
class AuthenticateFacebookRequest {
  @JsonKey(name: 'token')
  String? idToken;

  AuthenticateFacebookRequest({required this.idToken});

  Map<String, dynamic> toJson() {
    return _$AuthenticateFacebookRequestToJson(this);
  }
}

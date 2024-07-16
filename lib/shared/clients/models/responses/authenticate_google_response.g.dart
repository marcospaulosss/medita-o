// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'authenticate_google_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AuthenticateGoogleResponse _$AuthenticateGoogleResponseFromJson(
        Map<String, dynamic> json) =>
    AuthenticateGoogleResponse(
      json['token'] as String?,
      json['user'] == null
          ? null
          : User.fromJson(json['user'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$AuthenticateGoogleResponseToJson(
        AuthenticateGoogleResponse instance) =>
    <String, dynamic>{
      'token': instance.token,
      'user': instance.user,
    };

User _$UserFromJson(Map<String, dynamic> json) => User(
      (json['id'] as num?)?.toInt(),
      json['name'] as String?,
      json['email'] as String?,
      json['email_verified_at'] as String?,
      json['google_id'] as String?,
      json['facebook_id'] as String?,
      json['profile_photo_path'] as String?,
      json['created_at'] as String?,
      json['updated_at'] as String,
    );

Map<String, dynamic> _$UserToJson(User instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'email': instance.email,
      'email_verified_at': instance.emailVerifiedAt,
      'google_id': instance.googleId,
      'facebook_id': instance.facebookId,
      'profile_photo_path': instance.profilePhotoPath,
      'created_at': instance.createdAt,
      'updated_at': instance.updatedAt,
    };

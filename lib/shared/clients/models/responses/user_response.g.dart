// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserResponse _$UserResponseFromJson(Map<String, dynamic> json) => UserResponse(
      (json['id'] as num).toInt(),
      json['name'] as String,
      json['email'] as String,
      json['email_verified_at'],
      json['google_id'] as String?,
      json['facebook_id'],
      json['profile_photo_path'] as String?,
      json['created_at'] as String?,
      json['updated_at'] as String?,
      json['genre'] as String?,
      json['birthdate'] as String?,
      json['state'] == null
          ? null
          : State.fromJson(json['state'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$UserResponseToJson(UserResponse instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'email': instance.email,
      'email_verified_at': instance.emailVerifiedAt,
      'google_id': instance.googleId,
      'facebook_id': instance.facebookId,
      'profile_photo_path': instance.profilePhotoPath,
      'created_at': instance.createdAt,
      'updated_at': instance.updatedAt,
      'genre': instance.genre,
      'birthdate': instance.birthdate,
      'state': instance.state,
    };

State _$StateFromJson(Map<String, dynamic> json) => State(
      (json['id'] as num).toInt(),
      json['name'] as String,
      Country.fromJson(json['country'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$StateToJson(State instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'country': instance.country,
    };

Country _$CountryFromJson(Map<String, dynamic> json) => Country(
      (json['id'] as num).toInt(),
      json['name'] as String,
    );

Map<String, dynamic> _$CountryToJson(Country instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
    };

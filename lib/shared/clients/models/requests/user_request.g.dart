// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserRequest _$UserRequestFromJson(Map<String, dynamic> json) => UserRequest(
      (json['id'] as num).toInt(),
      json['name'] as String,
      json['email'] as String,
      json['genre'] as String?,
      json['birthdate'] as String?,
      (json['state_id'] as num?)?.toInt(),
    );

Map<String, dynamic> _$UserRequestToJson(UserRequest instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'email': instance.email,
      'genre': instance.genre,
      'birthdate': instance.birthdate,
      'state_id': instance.state,
    };

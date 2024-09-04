// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'create_new_meditations_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CreateNewMeditationsRequest _$CreateNewMeditationsRequestFromJson(
        Map<String, dynamic> json) =>
    CreateNewMeditationsRequest(
      numPeople: (json['num_people'] as num).toInt(),
      minutes: (json['minutes'] as num).toInt(),
      type: json['type'] as String,
      date: json['date'] as String,
    );

Map<String, dynamic> _$CreateNewMeditationsRequestToJson(
        CreateNewMeditationsRequest instance) =>
    <String, dynamic>{
      'num_people': instance.numPeople,
      'minutes': instance.minutes,
      'type': instance.type,
      'date': instance.date,
    };

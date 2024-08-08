// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'meditations_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MeditationsResponse _$MeditationsResponseFromJson(Map<String, dynamic> json) =>
    MeditationsResponse(
      (json['total'] as num).toInt(),
      (json['total_minutes'] as num).toInt(),
    );

Map<String, dynamic> _$MeditationsResponseToJson(
        MeditationsResponse instance) =>
    <String, dynamic>{
      'total': instance.total,
      'total_minutes': instance.totalMinutes,
    };

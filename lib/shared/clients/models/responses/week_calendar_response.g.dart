// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'week_calendar_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

WeekCalendarResponse _$WeekCalendarResponseFromJson(
        Map<String, dynamic> json) =>
    WeekCalendarResponse(
      week: json['week'] as Map<String, dynamic>?,
      total: (json['total'] as num?)?.toInt(),
      totalMinutes: (json['total_minutes'] as num?)?.toInt(),
    );

Map<String, dynamic> _$WeekCalendarResponseToJson(
        WeekCalendarResponse instance) =>
    <String, dynamic>{
      'week': instance.week,
      'total': instance.total,
      'total_minutes': instance.totalMinutes,
    };

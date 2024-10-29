// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'month_calendar_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MonthCalendarResponse _$MonthCalendarResponseFromJson(
        Map<String, dynamic> json) =>
    MonthCalendarResponse(
      month: json['month'],
      total: (json['total'] as num?)?.toInt(),
      totalMinutes: (json['total_minutes'] as num?)?.toInt(),
    );

Map<String, dynamic> _$MonthCalendarResponseToJson(
        MonthCalendarResponse instance) =>
    <String, dynamic>{
      'month': instance.month,
      'total': instance.total,
      'total_minutes': instance.totalMinutes,
    };

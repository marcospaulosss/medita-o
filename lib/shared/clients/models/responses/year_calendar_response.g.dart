// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'year_calendar_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

YearCalendarResponse _$YearCalendarResponseFromJson(
        Map<String, dynamic> json) =>
    YearCalendarResponse(
      year: json['year'],
      total: (json['total'] as num?)?.toInt(),
      totalMinutes: (json['total_minutes'] as num?)?.toInt(),
    );

Map<String, dynamic> _$YearCalendarResponseToJson(
        YearCalendarResponse instance) =>
    <String, dynamic>{
      'year': instance.year,
      'total': instance.total,
      'total_minutes': instance.totalMinutes,
    };

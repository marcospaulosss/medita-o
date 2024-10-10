import 'package:json_annotation/json_annotation.dart';

/// week : {"06":{"meditations":0,"minutes":0},"07":{"meditations":0,"minutes":0},"08":{"meditations":0,"minutes":0},"09":{"meditations":0,"minutes":0},"10":{"meditations":0,"minutes":0},"11":{"meditations":0,"minutes":0},"12":{"meditations":0,"minutes":0}}
/// total : 0
/// total_minutes : 0

part 'week_calendar_response.g.dart';

@JsonSerializable()
class WeekCalendarResponse {
  @JsonKey(name: "week")
  Map<String, dynamic>? week;

  @JsonKey(name: "total")
  int? total;

  @JsonKey(name: "total_minutes")
  int? totalMinutes;

  WeekCalendarResponse({
    this.week,
    this.total,
    this.totalMinutes,
  });

  factory WeekCalendarResponse.fromJson(Map<String, dynamic> json) {
    return _$WeekCalendarResponseFromJson(json);
  }

  Map<String, dynamic> toJson() {
    return _$WeekCalendarResponseToJson(this);
  }
}

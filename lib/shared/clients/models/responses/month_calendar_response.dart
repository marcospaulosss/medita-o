import 'package:json_annotation/json_annotation.dart';

/// week : {"06":{"meditations":0,"minutes":0},"07":{"meditations":0,"minutes":0},"08":{"meditations":0,"minutes":0},"09":{"meditations":0,"minutes":0},"10":{"meditations":0,"minutes":0},"11":{"meditations":0,"minutes":0},"12":{"meditations":0,"minutes":0}}
/// total : 0
/// total_minutes : 0

part 'month_calendar_response.g.dart';

@JsonSerializable()
class MonthCalendarResponse {
  @JsonKey(name: "month")
  Map<String, dynamic>? month;

  @JsonKey(name: "total")
  int? total;

  @JsonKey(name: "total_minutes")
  int? totalMinutes;

  MonthCalendarResponse({
    this.month,
    this.total,
    this.totalMinutes,
  });

  factory MonthCalendarResponse.fromJson(Map<String, dynamic> json) {
    return _$MonthCalendarResponseFromJson(json);
  }

  Map<String, dynamic> toJson() {
    return _$MonthCalendarResponseToJson(this);
  }
}

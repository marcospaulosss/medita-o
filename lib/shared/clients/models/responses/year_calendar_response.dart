import 'package:json_annotation/json_annotation.dart';

part 'year_calendar_response.g.dart';

@JsonSerializable()
class YearCalendarResponse {
  @JsonKey(name: "year")
  dynamic? year;

  @JsonKey(name: "total")
  int? total;

  @JsonKey(name: "total_minutes")
  int? totalMinutes;

  YearCalendarResponse({
    this.year,
    this.total,
    this.totalMinutes,
  });

  factory YearCalendarResponse.fromJson(Map<String, dynamic> json) {
    return _$YearCalendarResponseFromJson(json);
  }

  Map<String, dynamic> toJson() {
    return _$YearCalendarResponseToJson(this);
  }
}

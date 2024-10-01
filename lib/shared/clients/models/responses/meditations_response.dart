import 'package:intl/intl.dart';
import 'package:json_annotation/json_annotation.dart';

/// total : 1
/// total_minutes : 30

part 'meditations_response.g.dart';

@JsonSerializable()
class MeditationsResponse {
  /// total de meditações
  @JsonKey(name: 'total')
  int total;

  /// total de minutos de meditação
  @JsonKey(name: 'total_minutes')
  int totalMinutes;

  MeditationsResponse(this.total, this.totalMinutes);

  factory MeditationsResponse.fromJson(Map<String, dynamic> json) =>
      _$MeditationsResponseFromJson(json);

  Map<String, dynamic> toJson() => _$MeditationsResponseToJson(this);
}

extension MeditationsHelpers on MeditationsResponse {
  String get formattedDecimalPattern =>
      NumberFormat.decimalPattern('pt_BR').format(totalMinutes);
}

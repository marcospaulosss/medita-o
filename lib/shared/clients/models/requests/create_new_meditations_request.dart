import 'package:json_annotation/json_annotation.dart';

part 'create_new_meditations_request.g.dart';

@JsonSerializable()
class CreateNewMeditationsRequest {
  @JsonKey(name: 'num_people')
  int numPeople;

  @JsonKey(name: 'minutes')
  int minutes;

  @JsonKey(name: 'type')
  String type;

  @JsonKey(name: 'date')
  String date;

  /// - [numPeople] : Número de pessoas
  /// - [minutes] : Minutos
  /// - [type] : Tipo
  /// - [date] : Data
  /// constroi um objeto de requisição para criar uma nova meditação
  CreateNewMeditationsRequest({
    required this.numPeople,
    required this.minutes,
    required this.type,
    required this.date,
  });

  factory CreateNewMeditationsRequest.fromJson(Map<String, dynamic> json) =>
      _$CreateNewMeditationsRequestFromJson(json);

  Map<String, dynamic> toJson() => _$CreateNewMeditationsRequestToJson(this);
}

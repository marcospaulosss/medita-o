import 'package:json_annotation/json_annotation.dart';

part 'states_response.g.dart';

@JsonSerializable()
class StatesResponse {
  /// lista de estados
  @JsonKey(name: 'states')
  List<States>? states;

  /// - [states] lista de estados
  StatesResponse(this.states);

  /// converção de json para objeto
  factory StatesResponse.fromJson(Map<String, dynamic> json) =>
      _$StatesResponseFromJson(json);

  /// converção de objeto para json
  Map<String, dynamic> toJson() => _$StatesResponseToJson(this);
}

@JsonSerializable()
class States {
  /// id do estado
  @JsonKey(name: 'id')
  int? id;

  /// id do país
  @JsonKey(name: 'country_id')
  int? countryId;

  /// nome do estado
  @JsonKey(name: 'name')
  String? name;

  States(
    this.id,
    this.countryId,
    this.name,
  );

  /// converção de json para objeto
  factory States.fromJson(Map<String, dynamic> json) => _$StatesFromJson(json);

  /// converção de objeto para json
  Map<String, dynamic> toJson() => _$StatesToJson(this);
}

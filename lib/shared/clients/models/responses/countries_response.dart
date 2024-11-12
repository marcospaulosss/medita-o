import 'package:json_annotation/json_annotation.dart';

part 'countries_response.g.dart';

@JsonSerializable()
class CountriesResponse {
  /// lista de paises
  @JsonKey(name: 'countries')
  List<Countries>? countries;

  /// - [countries] lista de paises
  CountriesResponse(this.countries);

  /// converção de json para objeto
  factory CountriesResponse.fromJson(Map<String, dynamic> json) =>
      _$CountriesResponseFromJson(json);

  /// converção de objeto para json
  Map<String, dynamic> toJson() => _$CountriesResponseToJson(this);
}

@JsonSerializable()
class Countries {
  /// id do pais
  @JsonKey(name: 'id')
  int? id;

  /// nome do pais
  @JsonKey(name: 'name')
  String? name;

  /// - [id] id do pais
  /// - [name] nome do pais
  Countries(this.id, this.name);

  factory Countries.fromJson(Map<String, dynamic> json) =>
      _$CountriesFromJson(json);

  Map<String, dynamic> toJson() => _$CountriesToJson(this);
}

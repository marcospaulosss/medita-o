// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'countries_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CountriesResponse _$CountriesResponseFromJson(Map<String, dynamic> json) =>
    CountriesResponse(
      (json['countries'] as List<dynamic>?)
          ?.map((e) => Countries.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$CountriesResponseToJson(CountriesResponse instance) =>
    <String, dynamic>{
      'countries': instance.countries,
    };

Countries _$CountriesFromJson(Map<String, dynamic> json) => Countries(
      (json['id'] as num?)?.toInt(),
      json['name'] as String?,
    );

Map<String, dynamic> _$CountriesToJson(Countries instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
    };

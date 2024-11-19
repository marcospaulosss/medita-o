// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'states_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

StatesResponse _$StatesResponseFromJson(Map<String, dynamic> json) =>
    StatesResponse(
      (json['states'] as List<dynamic>?)
          ?.map((e) => States.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$StatesResponseToJson(StatesResponse instance) =>
    <String, dynamic>{
      'states': instance.states,
    };

States _$StatesFromJson(Map<String, dynamic> json) => States(
      (json['id'] as num?)?.toInt(),
      (json['country_id'] as num?)?.toInt(),
      json['name'] as String?,
    );

Map<String, dynamic> _$StatesToJson(States instance) => <String, dynamic>{
      'id': instance.id,
      'country_id': instance.countryId,
      'name': instance.name,
    };

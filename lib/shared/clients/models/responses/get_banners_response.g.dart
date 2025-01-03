// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_banners_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GetBannersResponse _$GetBannersResponseFromJson(Map<String, dynamic> json) =>
    GetBannersResponse(
      json['banners'] == null
          ? null
          : Banners.fromJson(json['banners'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$GetBannersResponseToJson(GetBannersResponse instance) =>
    <String, dynamic>{
      'banners': instance.banners,
    };

Banners _$BannersFromJson(Map<String, dynamic> json) => Banners(
      (json['id'] as num?)?.toInt(),
      json['title'] as String?,
      json['image'] as String?,
      json['link'] as String?,
      json['created_at'] as String?,
      json['updated_at'] as String?,
    );

Map<String, dynamic> _$BannersToJson(Banners instance) => <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'image': instance.image,
      'link': instance.link,
      'created_at': instance.createdAt,
      'updated_at': instance.updatedAt,
    };

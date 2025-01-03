import 'package:json_annotation/json_annotation.dart';

part 'get_banners_response.g.dart';

@JsonSerializable()
class GetBannersResponse {
  /// banners
  @JsonKey(name: 'banners')
  Banners? banners;

  /// - [banners] banners
  GetBannersResponse(this.banners);

  /// converção de json para objeto
  factory GetBannersResponse.fromJson(Map<String, dynamic> json) =>
      _$GetBannersResponseFromJson(json);

  /// converção de objeto para json
  Map<String, dynamic> toJson() => _$GetBannersResponseToJson(this);
}

@JsonSerializable()
class Banners {
  /// id do banner
  @JsonKey(name: 'id')
  int? id;

  /// titulo do banner
  @JsonKey(name: 'title')
  String? title;

  /// imagem do banner
  @JsonKey(name: 'image')
  String? image;

  /// link do banner
  @JsonKey(name: 'link')
  String? link;

  /// data de criação
  @JsonKey(name: 'created_at')
  String? createdAt;

  /// data de atualização
  @JsonKey(name: 'updated_at')
  String? updatedAt;

  /// - [id] id do banner
  /// - [title] titulo do banner
  /// - [image] imagem do banner
  /// - [link] link do banner
  /// - [createdAt] data de criação
  /// - [updatedAt] data de atualização
  Banners(
    this.id,
    this.title,
    this.image,
    this.link,
    this.createdAt,
    this.updatedAt,
  );

  /// converção de json para objeto
  factory Banners.fromJson(Map<String, dynamic> json) =>
      _$BannersFromJson(json);

  /// converção de objeto para json
  Map<String, dynamic> toJson() => _$BannersToJson(this);
}

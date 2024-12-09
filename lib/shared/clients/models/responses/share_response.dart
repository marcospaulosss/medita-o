import 'package:json_annotation/json_annotation.dart';

part 'share_response.g.dart';

typedef ShareResponse = List<Share>;

@JsonSerializable()
class Share {
  /// Nome da imagem
  @JsonKey(name: 'name')
  String? name;

  /// Imagem
  @JsonKey(name: 'image')
  String? image;

  Share(
    this.name,
    this.image,
  );

  factory Share.fromJson(Map<String, dynamic> json) => _$ShareFromJson(json);

  Map<String, dynamic> toJson() => _$ShareToJson(this);
}

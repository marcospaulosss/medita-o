import 'package:cinco_minutos_meditacao/shared/clients/models/responses/share_response.dart'
    as share_response;

enum ShareType { defaultShare, week, month, year }

class ShareModel {
  /// lista de imagens
  List<Share>? share;

  /// tipo de compartilhamento
  ShareType? type;

  /// - [share] : lista de imagens
  /// - [type] : tipo de compartilhamento
  /// construtor
  ShareModel({this.share, this.type});
}

class Share {
  /// nome da imagem
  String? imageName;

  /// caminho da imagem
  String? imagePath;

  /// resposta das imagens para compartilhamento
  share_response.Share? share;

  /// - [imageName] : nome da imagem
  /// - [imagePath] : caminho da imagem
  /// - [share] : resposta das imagens para compartilhamento
  /// construtor
  Share({this.imageName, this.imagePath, this.share});
}

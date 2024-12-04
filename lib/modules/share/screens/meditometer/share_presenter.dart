import 'package:cinco_minutos_meditacao/core/environment/manager.dart';
import 'package:cinco_minutos_meditacao/core/routers/app_router.dart';
import 'package:cinco_minutos_meditacao/modules/share/screens/meditometer/share_contract.dart';
import 'package:cinco_minutos_meditacao/modules/share/screens/meditometer/share_model.dart';
import 'package:cinco_minutos_meditacao/shared/helpers/social_share.dart';

class SharePresenter implements Presenter {
  /// View
  @override
  ShareViewContract? view;

  /// Repositório
  final Repository _repository;

  /// Router
  final AppRouter _router;

  /// variável de ambiente
  final EnvironmentManager environmentManager;

  /// - [repository] : Repositório
  /// - [router] : Router
  /// - [environmentManager] : variável de ambiente
  /// construtor
  SharePresenter(this._repository, this._router, this.environmentManager);

  /// Model para contrução da tela
  ShareModel model = ShareModel(share: []);

  /// evento disparado ao abrir a tela
  void onOpenScreen() {
    _repository.sendOpenScreenEvent();
  }

  /// Inicializa o presenter
  @override
  Future<void> initPresenter() async {
    onOpenScreen();

    view!.showLoading();

    await saveImagesShare();

    view!.showNormalState(model);
  }

  /// saveImagesShare - Salva as imagens para compartilhamento
  Future<void> saveImagesShare() async {
    var (response, err) = await _repository.getImages();
    if (err != null) {
      view!.showError(err.getErrorMessage);
      return;
    }
    
    model.share = [];
    for (var element in response!) {
      var (name, filePath, error) = await convertImageAndSaveImage(
          element.name ?? "image.jpg", element.image!);
      if (error != null) {
        view!.showError(error.getErrorMessage);
        return;
      }
      model.share!.add(Share(
        imageName: name,
        imagePath: filePath,
        share: element,
      ));
    }

    view!.showNormalState(model);
  }

  /// socialShare - compartilha a imagem
  @override
  Future<void> socialShare(ShareModel model, int index) async {
    var err = await socialShareImage(
      model.share![index].imageName!,
      model.share![index].imagePath,
    );
    if (err != null) {
      view!.showError(err.getErrorMessage);
      return;
    }
  }
}

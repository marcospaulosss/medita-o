import 'package:cinco_minutos_meditacao/core/environment/manager.dart';
import 'package:cinco_minutos_meditacao/core/routers/app_router.dart';
import 'package:cinco_minutos_meditacao/core/routers/app_router.gr.dart';
import 'package:cinco_minutos_meditacao/modules/meditometer/screens/meditometer/meditometer_contract.dart';
import 'package:cinco_minutos_meditacao/modules/meditometer/screens/meditometer/meditometer_model.dart';
import 'package:cinco_minutos_meditacao/modules/share/screens/meditometer/share_model.dart';
import 'package:cinco_minutos_meditacao/shared/models/error.dart';

class MeditometerPresenter implements Presenter {
  /// View
  @override
  MeditometerViewContract? view;

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
  MeditometerPresenter(this._repository, this._router, this.environmentManager);

  /// Model para contrução da tela
  MeditometerModel model = MeditometerModel();

  /// evento disparado ao abrir a tela
  void onOpenScreen() {
    _repository.sendOpenScreenEvent();
  }

  /// Inicializa o presenter
  @override
  Future<void> initPresenter() async {
    onOpenScreen();

    view!.showLoading();
    var (user, errorUser) = await _repository.requestUser();
    if (errorUser != null) {
      view!.showError(errorUser.getErrorMessage);
      return;
    }

    var (meditations, errorMeditations) =
        await _repository.requestMeditations();
    if (errorMeditations != null) {
      view!.showError(errorMeditations.getErrorMessage);
      return;
    }

    if (user != null && meditations != null) {
      model.userResponse = user;
      model.meditationsResponse = meditations;
      view!.showNormalState(model);
    }
  }

  /// Atualiza a imagem de perfil do usuário
  @override
  Future<void> updateImageProfile() async {
    _router.goTo(CameraRoute(), onClose: (result) async {
      if (result == null) {
        return;
      }

      if (result is CustomError) {
        CustomError err = CustomError();
        err.code = ErrorCodes.cameraError;
        view!.showError(err.getErrorMessage);
        return;
      }

      CustomError? err = await _repository.uploadImageProfile(result);
      if (err != null) {
        view!.showError(err.getErrorMessage);
        return;
      }

      var (user, errorUser) = await _repository.requestUser();
      if (errorUser != null) {
        view!.showError(errorUser.getErrorMessage);
        return;
      }
      model.userResponse = user;
      view!.showNormalState(model);
    });
  }

  /// Direciona para a tela de sobre o app
  @override
  void goToAbout() {
    _router.goTo(const GuidedMeditationRoute());
  }

  /// compartilha a imagem
  @override
  void goToSocialShare() {
    _router.goTo(ShareRoute(params: ShareModel()));
  }
}

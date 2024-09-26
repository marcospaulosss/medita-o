import 'package:cinco_minutos_meditacao/core/routers/app_router.dart';
import 'package:cinco_minutos_meditacao/core/routers/app_router.gr.dart';
import 'package:cinco_minutos_meditacao/modules/meditometer/screens/meditometer/meditometer_contract.dart';
import 'package:cinco_minutos_meditacao/modules/meditometer/screens/meditometer/meditometer_model.dart';
import 'package:cinco_minutos_meditacao/shared/models/error.dart';

class MeditometerPresenter implements Presenter {
  /// View
  @override
  MeditometerViewContract? view;

  /// Repositório
  final Repository _repository;

  /// Router
  final AppRouter _router;

  /// - [repository] : Repositório
  /// - [router] : Router
  /// construtor
  MeditometerPresenter(this._repository, this._router);

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
    _router.goTo(const CameraRoute(), onClose: (result) async {
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

  @override
  void goToAbout() {
    _router.goTo(const GuidedMeditationRoute());
  }
}

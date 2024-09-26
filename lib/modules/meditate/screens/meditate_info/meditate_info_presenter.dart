import 'package:cinco_minutos_meditacao/core/routers/app_router.dart';
import 'package:cinco_minutos_meditacao/core/routers/app_router.gr.dart';
import 'package:cinco_minutos_meditacao/modules/meditate/screens/meditate_info/meditate_info_contract.dart';
import 'package:cinco_minutos_meditacao/modules/meditate/screens/meditate_info/meditate_info_model.dart';
import 'package:cinco_minutos_meditacao/shared/clients/models/responses/meditations_response.dart';
import 'package:cinco_minutos_meditacao/shared/models/error.dart';

class MeditateInfoPresenter implements Presenter {
  /// View
  @override
  MeditateInfoViewContract? view;

  /// Repositório
  final Repository _repository;

  /// Router
  final AppRouter _router;

  /// - [authService] : Serviço de autenticação
  /// - [repository] : Repositório
  /// - [router] : Router
  /// construtor
  MeditateInfoPresenter(this._repository, this._router); //this._authService, );

  /// variável de controle de erro
  bool error = false;

  MeditateInfoModel meditateInfoModel = MeditateInfoModel();

  /// evento disparado ao abrir a tela
  @override
  void onOpenScreen() {
    _repository.sendOpenScreenEvent();
  }

  /// Inicializa o presenter
  @override
  Future<void> initPresenter() async {
    onOpenScreen();

    var (userResponse, err) = await _repository.requestUser();
    if (err != null) {
      view!.showError(err.getErrorMessage);
      return;
    }
    meditateInfoModel.userResponse = userResponse;

    var (meditations, error) = await _repository.requestMeditations();
    if (error != null) {
      view!.showError(error.getErrorMessage);
      return;
    }
    meditateInfoModel.meditationsResponse = meditations;

    meditateInfoModel.meditationsByUserResponse = await getMeditionsByUser();
    if (meditateInfoModel.meditationsByUserResponse == null) return;

    view!.showNormalState(model: meditateInfoModel);
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

      var (user, error) = await _repository.requestUser();
      if (error != null) {
        view!.showError(error.getErrorMessage);
        return;
      }

      meditateInfoModel.userResponse = user;
      view!.showNormalState(model: meditateInfoModel);
    });
  }

  Future<MeditationsResponse?> getMeditionsByUser() async {
    var (meditations, error) = await _repository.requestMeditationsByUser();
    if (error != null || meditations == null) {
      view!.showError(error?.getErrorMessage ?? 'null safe');
      return null;
    }

    return meditations;
  }
}

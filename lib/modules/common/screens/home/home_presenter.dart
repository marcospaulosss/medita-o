import 'package:cinco_minutos_meditacao/core/routers/app_router.dart';
import 'package:cinco_minutos_meditacao/core/routers/app_router.gr.dart';
import 'package:cinco_minutos_meditacao/modules/common/screens/home/home_contract.dart';
import 'package:cinco_minutos_meditacao/modules/common/screens/home/home_model.dart';
import 'package:cinco_minutos_meditacao/shared/clients/models/responses/get_banners_response.dart';
import 'package:cinco_minutos_meditacao/shared/clients/models/responses/meditations_response.dart';
import 'package:cinco_minutos_meditacao/shared/clients/models/responses/user_response.dart';
import 'package:cinco_minutos_meditacao/shared/models/error.dart';
import 'package:cinco_minutos_meditacao/shared/services/auth_service.dart';

class HomePresenter implements Presenter {
  /// View
  @override
  HomeViewContract? view;

  /// Serviço de autenticação
  final AuthService _authService;

  /// Repositório
  final Repository _repository;

  /// Router
  final AppRouter _router;

  /// - [authService] : Serviço de autenticação
  /// - [repository] : Repositório
  /// - [router] : Router
  /// construtor
  HomePresenter(this._authService, this._repository, this._router);

  /// variável de controle de erro
  bool error = false;

  /// Modelo da tela
  HomeModel homeModel = HomeModel();

  /// evento disparado ao abrir a tela
  @override
  void onOpenScreen() {
    _repository.sendOpenScreenEvent();
  }

  /// efetua o logout do usuário
  @override
  void logOut() {
    _authService.logout();
    _repository.logOut();
    _router.goToReplace(const LoginRoute());
  }

  /// Inicializa o presenter
  @override
  Future<void> initPresenter() async {
    onOpenScreen();

    view!.showLoading();
    UserResponse? user = await getMe();
    MeditationsResponse? meditations = await getMeditions();
    GetBannersResponse? banners = await getBanners();

    if (user != null && meditations != null && banners != null) {
      homeModel.userResponse = user;
      homeModel.meditationsResponse = meditations;
      homeModel.bannersResponse = banners;
      view!.showNormalState(homeModel);
    }
  }

  Future<GetBannersResponse?> getBanners() async {
    var (bannerResonse, errBanner) = await _repository.requestBanners();
    if (errBanner != null) {
      view!.showError(errBanner.getErrorMessage);
      return null;
    }

    return bannerResonse;
  }

  /// Busca informações do usuário
  Future<UserResponse?> getMe() async {
    var (user, error) = await _repository.requestUser();
    if (error != null) {
      view!.showError(error.getErrorMessage);
      return null;
    }

    return user;
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

      UserResponse? user = await getMe();
      homeModel.userResponse = user;
      view!.showNormalState(homeModel);
    });
  }

  /// Busca as meditações
  Future<MeditationsResponse?> getMeditions() async {
    var (meditations, error) = await _repository.requestMeditations();
    if (error != null) {
      view!.showError(error.getErrorMessage);
      return null;
    }

    return meditations;
  }

  /// Vai para a tela de informações de meditação
  @override
  void goToMeditateInfo(HomeModel model) {
    _router.goTo(const MeditateInfoRoute());
  }

  /// Vai para a tela de meditação de 5 minutos
  @override
  void goToFiveMinutes() {
    _router.goTo(const FiveMinutesRoute());
  }

  /// Vai para a tela do In Your Time
  @override
  void goToInYourTime() {
    _router.goTo(const InYourTimeRoute());
  }

  @override
  void goToGuidedMeditation() {
    _router.goTo(const GuidedMeditationProgramRoute());
  }
}

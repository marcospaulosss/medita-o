import 'package:cinco_minutos_meditacao/core/routers/app_router.dart';
import 'package:cinco_minutos_meditacao/core/routers/app_router.gr.dart';
import 'package:cinco_minutos_meditacao/modules/common/screens/profile/profile_contract.dart';
import 'package:cinco_minutos_meditacao/modules/common/screens/profile/profile_model.dart';
import 'package:cinco_minutos_meditacao/shared/clients/models/requests/user_request.dart';
import 'package:cinco_minutos_meditacao/shared/clients/models/responses/user_response.dart';
import 'package:cinco_minutos_meditacao/shared/models/error.dart';
import 'package:cinco_minutos_meditacao/shared/services/auth_service.dart';

class ProfilePresenter implements Presenter {
  /// View
  @override
  ProfileViewContract? view;

  /// Serviço de autenticação
  final AuthService _authService;

  /// Repositório
  final Repository _repository;

  /// Router
  final AppRouter _router;

  /// variável de controle de erro
  bool error = false;

  /// Modelo da tela
  final ProfileModel profileModel = ProfileModel();

  /// - [authService] : Serviço de autenticação
  /// - [repository] : Repositório
  /// - [router] : Router
  /// construtor
  ProfilePresenter(
    this._authService,
    this._repository,
    this._router,
  );

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

    view?.showLoading();
    UserResponse? user = await getMe();
    if (user == null) {
      return;
    }

    var (countries, error) = await _repository.requestGetCountries();
    if (error != null) {
      view?.showError(error.getErrorMessage);
      return;
    }

    if (user.city != null) {
      var (states, error) = await _repository
          .requestGetStatesByCountryId(user.city!.state.country.id);
      if (error != null) {
        view?.showError(error.getErrorMessage);
        return;
      }

      profileModel.statesResponse = states;
    }

    profileModel.userResponse = user;
    profileModel.countryResponse = countries;
    view!.showNormalState(profileModel);
  }

  /// Busca informações do usuário
  Future<UserResponse?> getMe() async {
    var (user, error) = await _repository.requestUser();
    if (error != null) {
      view?.showError(error.getErrorMessage);
      return null;
    }

    user?.genre = user.adapterGenre();

    return user;
  }

  /// Atualiza a imagem de perfil do usuário
  @override
  Future<void> updateImageProfile() async {
    _router.goTo(const CameraRoute(), onClose: (result) async {
      if (result == null) return;

      if (result is CustomError) {
        CustomError err = CustomError();
        err.code = ErrorCodes.cameraError;
        view?.showError(result.getErrorMessage);
        return;
      }

      CustomError? err = await _repository.uploadImageProfile(result);
      if (err != null) {
        view?.showError(err.getErrorMessage);
        return;
      }

      UserResponse? user = await getMe();
      profileModel.userResponse = user;
      view?.showNormalState(profileModel);
    });
  }

  @override
  Future<List<String>> getStates(countryId) async {
    var (states, error) =
        await _repository.requestGetStatesByCountryId(countryId);
    if (error != null) {
      view?.showError(error.getErrorMessage);
      return [];
    }

    profileModel.statesResponse = states;

    List<String> statesList =
        states!.states!.map((item) => item.name as String).toList();

    return statesList;
  }

  @override
  Future<void> updateUser(UserRequest user) async {
    view?.showLoading();

    user.genre == 'Masculino' ? user.genre = 'M' : user.genre = 'F';

    var (userResponse, error) = await _repository.requestUpdateUser(user);
    if (error != null) {
      view?.showError(error.getErrorMessage);
      return;
    }

    var (countries, errorContries) = await _repository.requestGetCountries();
    if (errorContries != null) {
      view?.showError(errorContries.getErrorMessage);
      return;
    }

    if (user.city != null) {
      var (states, error) = await _repository
          .requestGetStatesByCountryId(userResponse!.city!.state.country.id);
      if (error != null) {
        view?.showError(error.getErrorMessage);
        return;
      }

      profileModel.statesResponse = states;
    }

    profileModel.userResponse = userResponse;
    profileModel.countryResponse = countries;

    userResponse?.genre = userResponse.adapterGenre();
    profileModel.userResponse = userResponse;
    view!.showNormalState(profileModel);
  }
}

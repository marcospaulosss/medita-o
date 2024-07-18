import 'package:cinco_minutos_meditacao/core/routers/app_router.dart';
import 'package:cinco_minutos_meditacao/core/routers/app_router.gr.dart';
import 'package:cinco_minutos_meditacao/modules/common/screens/home/home_contract.dart';
import 'package:cinco_minutos_meditacao/shared/clients/models/responses/user_response.dart';
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

    if (!error) {
      view!.showNormalState(user);
    }
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

  @override
  Future<void> updateImageProfile() async {
    _router.goTo(const CameraRoute(), onClose: (result) {
      if (result == null) {
        return;
      }

      _repository.uploadImageProfile(result);
    });
  }
}

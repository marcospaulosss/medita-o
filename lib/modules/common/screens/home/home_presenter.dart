import 'package:cinco_minutos_meditacao/core/routers/app_router.dart';
import 'package:cinco_minutos_meditacao/core/routers/app_router.gr.dart';
import 'package:cinco_minutos_meditacao/modules/common/screens/home/home_contract.dart';
import 'package:cinco_minutos_meditacao/shared/services/auth_service.dart';

class HomePresenter implements Presenter {
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
  HomePresenter( this._authService, this._repository, this._router);

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
}

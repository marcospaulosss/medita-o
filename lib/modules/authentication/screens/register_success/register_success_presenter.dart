import 'package:cinco_minutos_meditacao/core/routers/app_router.dart';
import 'package:cinco_minutos_meditacao/core/routers/app_router.gr.dart';
import 'package:cinco_minutos_meditacao/modules/authentication/screens/register_success/register_success_contracts.dart';
import 'package:cinco_minutos_meditacao/modules/authentication/screens/register_success/register_success_repository.dart';

class RegisterSuccessPresenter extends Presenter {
  /// repository
  final RegisterSuccessRepository repository;

  /// Router
  final AppRouter _router;

  /// - [repository] : RegisterSuccessRepository
  /// - [router] : Router
  RegisterSuccessPresenter(
    this.repository,
    this._router,
  );

  /// Direciona para a tela de home
  @override
  void goToHome() {
    _router.goToReplace(const HomeRoute());
  }

  @override
  void onOpenScreen() {
    repository.sendOpenScreenEvent();
  }
}

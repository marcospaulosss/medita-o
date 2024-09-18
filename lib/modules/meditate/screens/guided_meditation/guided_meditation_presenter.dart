import 'package:cinco_minutos_meditacao/core/routers/app_router.dart';
import 'package:cinco_minutos_meditacao/modules/meditate/screens/guided_meditation/guided_meditation_contract.dart';

class GuidedMeditationPresenter implements Presenter {
  /// View
  @override
  GuidedMeditationViewContract? view;

  /// Repositório
  final Repository _repository;

  /// Router
  final AppRouter _router;

  /// - [repository] : Repositório
  /// - [router] : Router
  /// construtor
  GuidedMeditationPresenter(
      this._repository, this._router); //this._authService, );

  /// variável de controle de erro
  bool error = false;

  /// evento disparado ao abrir a tela
  void onOpenScreen() {
    _repository.sendOpenScreenEvent();
  }

  /// Inicializa o presenter
  @override
  Future<void> initPresenter() async {
    onOpenScreen();
  }
}

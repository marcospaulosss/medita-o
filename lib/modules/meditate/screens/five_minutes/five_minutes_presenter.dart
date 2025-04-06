import 'package:cinco_minutos_meditacao/core/routers/app_router.dart';
import 'package:cinco_minutos_meditacao/core/routers/app_router.gr.dart';
import 'package:cinco_minutos_meditacao/modules/meditate/screens/five_minutes/five_minutes_contract.dart';
import 'package:cinco_minutos_meditacao/modules/share/screens/meditometer/share_model.dart';

class FiveMinutesPresenter implements Presenter {
  /// View
  @override
  FiveMinutesViewContract? view;

  /// Repositório
  final Repository _repository;

  /// Router
  final AppRouter _router;

  /// - [repository] : Repositório
  /// - [router] : Router
  /// construtor
  FiveMinutesPresenter(this._repository, this._router);

  /// evento disparado ao abrir a tela
  @override
  void onOpenScreen() {
    _repository.sendOpenScreenEvent();
  }

  /// Direciona para a tela de informações de como meditar
  @override
  void goToMeditateInfo() {
    _router.goTo(const MeditateInfoRoute());
  }

  /// Submete a meditação concluída
  @override
  Future<void> submitMeditateCompleted(int time) async {
    await _repository.requestRegisterMeditateCompleted(time);
    view?.meditationCompleted();
    goToShare();
  }

  /// Direciona para a tela de compartilhamento
  @override
  void goToShare() {
    _router.goTo(ShareRoute(
      params: ShareModel(
        type: ShareType.defaultShare,
      ),
    ));
  }
}

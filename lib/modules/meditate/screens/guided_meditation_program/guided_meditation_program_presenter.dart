import 'package:cinco_minutos_meditacao/core/routers/app_router.dart';
import 'package:cinco_minutos_meditacao/core/routers/app_router.gr.dart';
import 'package:cinco_minutos_meditacao/modules/meditate/screens/guided_meditation_program/guided_meditation_program_contract.dart';
import 'package:cinco_minutos_meditacao/modules/share/screens/meditometer/share_model.dart';

class GuidedMeditationProgramPresenter implements Presenter {
  /// View
  @override
  GuidedMeditationProgramViewContract? view;

  /// Repositório
  final Repository _repository;

  /// Router
  final AppRouter _router;

  /// - [repository] : Repositório
  /// - [router] : Router
  /// construtor
  GuidedMeditationProgramPresenter(this._repository, this._router);

  /// evento disparado ao abrir a tela
  @override
  void onOpenScreen() {
    _repository.sendOpenScreenEvent();
  }

  /// Direciona para a tela de informações de como meditar
  @override
  void goToGuidedMeditation() {
    _router.goTo(const GuidedMeditationRoute());
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

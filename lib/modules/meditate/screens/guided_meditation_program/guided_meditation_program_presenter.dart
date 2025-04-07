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

  /// Submete a meditação concluída e redireciona para a tela de compartilhamento
  /// 
  /// Este método é responsável por:
  /// 1. Registrar a meditação concluída no repositório
  /// 2. Notificar a view sobre a conclusão da meditação
  /// 3. Redirecionar o usuário para a tela de compartilhamento
  @override
  Future<void> submitMeditateCompleted(int time) async {
    await _repository.requestRegisterMeditateCompleted(time);
    view?.meditationCompleted();
    goToShare();
  }

  /// Direciona para a tela de compartilhamento após a conclusão da meditação guiada.
  /// 
  /// Este método navega para a tela de compartilhamento usando o router,
  /// passando um modelo ShareModel com o tipo defaultShare para indicar
  /// que é um compartilhamento padrão de meditação guiada.
  @override
  void goToShare() {
    _router.goTo(ShareRoute(
      params: ShareModel(
        type: ShareType.defaultShare,
      ),
    ));
  }
}

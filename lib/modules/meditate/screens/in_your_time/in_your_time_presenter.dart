import 'package:cinco_minutos_meditacao/core/routers/app_router.dart';
import 'package:cinco_minutos_meditacao/modules/meditate/screens/in_your_time/in_your_time_contract.dart';

class InYourTimePresenter implements Presenter {
  /// View
  @override
  InYourTimeContract? view;

  /// Repositório
  final Repository _repository;

  /// Router
  final AppRouter _router;

  /// - [repository] : Repositório
  /// - [router] : Router
  /// construtor
  InYourTimePresenter(this._repository, this._router);

  /// evento disparado ao abrir a tela
  @override
  void onOpenScreen() {
    _repository.sendOpenScreenEvent();
  }

  @override
  Future<void> submitMeditateCompleted(int time) async {
    await _repository.requestRegisterMeditateCompleted(time);
    view?.meditationCompleted();
  }
}

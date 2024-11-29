import 'package:cinco_minutos_meditacao/core/environment/manager.dart';
import 'package:cinco_minutos_meditacao/core/routers/app_router.dart';
import 'package:cinco_minutos_meditacao/modules/share/screens/meditometer/share_contract.dart';
import 'package:cinco_minutos_meditacao/modules/share/screens/meditometer/share_model.dart';
import 'package:cinco_minutos_meditacao/shared/helpers/social_share.dart';

class SharePresenter implements Presenter {
  /// View
  @override
  ShareViewContract? view;

  /// Repositório
  final Repository _repository;

  /// Router
  final AppRouter _router;

  /// variável de ambiente
  final EnvironmentManager environmentManager;

  /// - [repository] : Repositório
  /// - [router] : Router
  /// - [environmentManager] : variável de ambiente
  /// construtor
  SharePresenter(this._repository, this._router, this.environmentManager);

  /// Model para contrução da tela
  ShareModel model = ShareModel();

  /// evento disparado ao abrir a tela
  void onOpenScreen() {
    _repository.sendOpenScreenEvent();
  }

  /// Inicializa o presenter
  @override
  Future<void> initPresenter() async {
    onOpenScreen();

    view!.showLoading();

    view!.showNormalState(model);
  }

  /// compartilha a imagem
  @override
  Future<void> socialShare() async {
    var (token, err) = await _repository.getTokenApi();
    if (err != null) {
      view!.showError(err.getErrorMessage);
      return;
    }

    socialShareImage("${environmentManager.apiBaseUrl}/share/calendar", token!);
  }
}

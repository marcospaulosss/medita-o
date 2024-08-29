import 'package:cinco_minutos_meditacao/core/routers/app_router.dart';
import 'package:cinco_minutos_meditacao/modules/meditate/screens/five_minutes/five_minutes_contract.dart';

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

  @override
  void goToMeditateInfo() {
    // _router.goTo(MeditateInfoRoute(
    //   model: MeditateInfoModel(
    //     userResponse: UserResponse(
    //       id,
    //       name,
    //       email,
    //       emailVerifiedAt,
    //       googleId,
    //       facebookId,
    //       profilePhotoPath,
    //       createdAt,
    //       updatedAt,
    //     ),
    //     meditationsResponse: model.meditationsResponse,
    //   ),
    // ));
  }
}

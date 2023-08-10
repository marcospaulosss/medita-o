import 'package:cinco_minutos_meditacao/modules/common/screens/home/home_contract.dart';

class HomePresenter implements Presenter {
  final Repository repository;

  HomePresenter(this.repository);

  @override
  void onOpenScreen() {
    repository.sendOpenScreenEvent();
  }
}

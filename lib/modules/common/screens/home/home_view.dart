import 'package:auto_route/auto_route.dart';
import 'package:cinco_minutos_meditacao/core/di/helpers.dart';
import 'package:cinco_minutos_meditacao/modules/common/screens/home/home_contract.dart';
import 'package:cinco_minutos_meditacao/modules/common/screens/home/home_presenter.dart';
import 'package:cinco_minutos_meditacao/modules/common/shared/components/app_header.dart';
import 'package:cinco_minutos_meditacao/shared/clients/models/responses/user_response.dart';
import 'package:cinco_minutos_meditacao/shared/components/app_background.dart';
import 'package:cinco_minutos_meditacao/shared/components/generic_error_container.dart';
import 'package:cinco_minutos_meditacao/shared/components/loading.dart';
import 'package:cinco_minutos_meditacao/shared/helpers/multi_state_container/export.dart';
import 'package:cinco_minutos_meditacao/shared/helpers/view_binding.dart';
import 'package:flutter/material.dart';

@RoutePage()
class HomeView extends StatefulWidget {
  const HomeView({
    super.key,
  });

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> implements HomeViewContract {
  Presenter presenter = resolve<HomePresenter>();

  /// Controlador do estado da tela
  final stateController = MultiStateContainerController();

  /// Mensagem de erro
  late String messageError = "";

  @override
  void initState() {
    stateController.showErrorState();

    presenter.bindView(this);
    presenter.initPresenter();

    super.initState();
  }

  void dispose() {
    presenter.unbindView();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MultiStateContainer(
      controller: stateController,
      normalStateBuilder: (context) => buildScaffold(context),
      loadingStateBuilder: (context) => const Loading(),
      errorStateBuilder: (context) => GenericErrorContainer(
        message: messageError,
      ),
    );
  }

  Widget buildScaffold(BuildContext context) {
    return AppBackground(
      child: const AppHeader(
        nameUser: "Gabriela",
        description1: "Some seu tempo pela paz mundial agora mesmo!",
      ),
    );
  }

  @override
  void showLoading() {
    stateController.showLoadingState();
  }

  @override
  void showNormalState(UserResponse? user) {
    stateController.showNormalState();
  }

  @override
  void showError(String message) {
    messageError = message;
    stateController.showErrorState();
  }
}

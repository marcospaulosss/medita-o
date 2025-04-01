import 'package:auto_route/auto_route.dart';
import 'package:cinco_minutos_meditacao/core/di/helpers.dart';
import 'package:cinco_minutos_meditacao/modules/common/screens/home/home_contract.dart';
import 'package:cinco_minutos_meditacao/modules/common/screens/home/home_model.dart';
import 'package:cinco_minutos_meditacao/modules/common/screens/home/home_presenter.dart';
import 'package:cinco_minutos_meditacao/modules/common/shared/components/meditate.dart';
import 'package:cinco_minutos_meditacao/modules/common/shared/strings/localization/common_strings.dart';
import 'package:cinco_minutos_meditacao/shared/Theme/app_images.dart';
import 'package:cinco_minutos_meditacao/shared/components/Meditometer.dart';
import 'package:cinco_minutos_meditacao/shared/components/app_background.dart';
import 'package:cinco_minutos_meditacao/shared/components/app_header.dart';
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
  State<HomeView> createState() => HomeViewState();
}

@visibleForTesting
class HomeViewState extends State<HomeView> implements HomeViewContract {
  Presenter presenter = resolve<HomePresenter>();

  /// Controlador do estado da tela
  final stateController = MultiStateContainerController();

  /// Mensagem de erro
  late String messageError = "";

  /// Usuário
  late HomeModel model = HomeModel();

  @override
  void initState() {
    presenter.bindView(this);
    presenter.initPresenter();

    super.initState();
  }

  @override
  void dispose() {
    presenter.unbindView();
    stateController.dispose();

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
        onRetry: () => presenter.initPresenter(),
      ),
    );
  }

  Widget buildScaffold(BuildContext context) {
    return AppBackground(
      child: Column(
        children: [
          AppHeader(
            nameUser: model.userResponse!.name.split(" ").first,
            description1: CommonStrings.of(context).homeHeaderDescription1,
            photo: model.userResponse!.profilePhotoPath,
            updateImage: () => presenter.updateImageProfile(),
          ),
          buildBody(context),
        ],
      ),
    );
  }

  /// Corpo da tela
  Padding buildBody(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 61, bottom: 33),
      child: Column(
        children: [
          buildMeditate(context),
          const SizedBox(height: 33),
          model.bannersResponse?.banners?.image != null
              ? Image.network(
                  model.bannersResponse!.banners!.image!,
                  width: 350.0, // Define a largura da imagem
                  height: 115.0, // Define a altura da imagem
                  fit: BoxFit.cover, // Ajusta a imagem para cobrir toda a área
                )
              : Image.asset(
                  AppImages.banner,
                  width: 350.0, // Define a largura da imagem
                  height: 115.0, // Define a altura da imagem
                  fit: BoxFit.cover, // Ajusta a imagem para cobrir toda a área
                ),
          const SizedBox(height: 40),
          Meditometer(meditationsResponse: model.meditationsResponse),
        ],
      ),
    );
  }

  /// Constrói a seção de meditação
  Column buildMeditate(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Meditate(
              key: const Key("meditate5Minutes"),
              title: CommonStrings.of(context).meditate5Minutes,
              onTap: () => presenter.goToFiveMinutes(),
            ),
            const SizedBox(width: 10),
            Meditate(
              key: const Key("learnMethod"),
              title: CommonStrings.of(context).learnMethod,
              onTap: () => presenter.goToMeditateInfo(model),
            ),
          ],
        ),
        const SizedBox(height: 14),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Meditate(
              key: const Key("guidedMeditate"),
              title: CommonStrings.of(context).guidedMeditate,
              onTap: () => presenter.goToGuidedMeditation(),
            ),
            const SizedBox(width: 10),
            Meditate(
              key: const Key("meditateInYourTime"),
              title: CommonStrings.of(context).meditateTime,
              onTap: () => presenter.goToInYourTime(),
            ),
          ],
        ),
      ],
    );
  }

  /// Mostra o estado de carregamento
  @override
  void showLoading() {
    stateController.showLoadingState();
  }

  /// Mostra o estado normal
  @override
  void showNormalState(HomeModel modelResponse) {
    setState(() {
      model = modelResponse;
    });
    stateController.showNormalState();
  }

  /// Mostra o estado de erro
  @override
  void showError(String message) {
    messageError = message;
    stateController.showErrorState();
  }
}

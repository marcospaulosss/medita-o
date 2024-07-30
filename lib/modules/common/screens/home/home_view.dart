import 'package:auto_route/auto_route.dart';
import 'package:cinco_minutos_meditacao/core/di/helpers.dart';
import 'package:cinco_minutos_meditacao/modules/common/screens/home/home_contract.dart';
import 'package:cinco_minutos_meditacao/modules/common/screens/home/home_model.dart';
import 'package:cinco_minutos_meditacao/modules/common/screens/home/home_presenter.dart';
import 'package:cinco_minutos_meditacao/modules/common/shared/components/app_header.dart';
import 'package:cinco_minutos_meditacao/modules/common/shared/components/meditate.dart';
import 'package:cinco_minutos_meditacao/modules/common/shared/strings/localization/common_strings.dart';
import 'package:cinco_minutos_meditacao/shared/Theme/app_colors.dart';
import 'package:cinco_minutos_meditacao/shared/Theme/app_images.dart';
import 'package:cinco_minutos_meditacao/shared/components/app_background.dart';
import 'package:cinco_minutos_meditacao/shared/components/generic_error_container.dart';
import 'package:cinco_minutos_meditacao/shared/components/loading.dart';
import 'package:cinco_minutos_meditacao/shared/helpers/multi_state_container/export.dart';
import 'package:cinco_minutos_meditacao/shared/helpers/view_binding.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

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
      padding: const EdgeInsets.only(top: 61, left: 40, right: 40, bottom: 33),
      child: Column(
        children: [
          buildMeditate(context),
          const SizedBox(height: 33),
          Image.asset(AppImages.banner),
          const SizedBox(height: 40),
          buildMeditometer(),
        ],
      ),
    );
  }

  /// Constrói o meditômetro
  Column buildMeditometer() {
    return Column(
      children: [
        Text(
          CommonStrings.of(context).meditometer,
          style: const TextStyle(
            fontSize: 64,
            fontWeight: FontWeight.w400,
            color: AppColors.steelWoolColor,
            fontFamily: "Blanch",
          ),
        ),
        Container(
          height: 17,
          width: 125,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: AppColors.blueMana,
            borderRadius: BorderRadius.circular(27),
          ),
          child: Text(
            CommonStrings.of(context).realTime,
            style: const TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w400,
              color: AppColors.white,
            ),
          ),
        ),
        Text(
          model.meditationsResponse!.totalMinutes.toString(),
          style: const TextStyle(
            fontSize: 58,
            fontWeight: FontWeight.w900,
            color: AppColors.frankBlue,
          ),
        ),
        RichText(
          text: TextSpan(
            children: [
              const TextSpan(
                text: "milhões ",
                style: TextStyle(
                  fontSize: 11,
                  fontWeight: FontWeight.w700,
                  color: AppColors.frankBlue,
                ),
              ),
              TextSpan(
                text: CommonStrings.of(context).minutesMeditatedWorld,
                style: const TextStyle(
                  fontSize: 11,
                  fontWeight: FontWeight.w400,
                  color: AppColors.frankBlue,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 28),
        Stack(
          alignment: Alignment.center,
          children: [
            Container(
              height: 67,
              width: 288,
              color: AppColors.vividCerulean,
            ),
            SvgPicture.asset(
              AppImages.countries,
              height: 144,
              width: 248,
            ),
            Positioned(
              left: 12,
              top: 53,
              width: 60,
              child: Text(
                CommonStrings.of(context).countriesReached,
                style: const TextStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.w400,
                  color: AppColors.white,
                  fontFamily: "Blanch",
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  /// Constrói a seção de meditação
  Column buildMeditate(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Meditate(
              title: CommonStrings.of(context).meditate5Minutes,
            ),
            const SizedBox(width: 10),
            Meditate(
              title: CommonStrings.of(context).learnMethod,
            ),
          ],
        ),
        const SizedBox(height: 14),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Meditate(
              title: CommonStrings.of(context).guidedMeditate,
            ),
            const SizedBox(width: 10),
            Meditate(
              title: CommonStrings.of(context).meditateTime,
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

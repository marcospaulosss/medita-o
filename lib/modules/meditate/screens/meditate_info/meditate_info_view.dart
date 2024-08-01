import 'package:auto_route/auto_route.dart';
import 'package:cinco_minutos_meditacao/core/di/helpers.dart';
import 'package:cinco_minutos_meditacao/modules/meditate/screens/meditate_info/meditate_info_model.dart';
import 'package:cinco_minutos_meditacao/modules/meditate/screens/meditate_info/meditate_info_presenter.dart';
import 'package:cinco_minutos_meditacao/modules/meditate/shared/components/video_card.dart';
import 'package:cinco_minutos_meditacao/modules/meditate/shared/strings/localization/meditate_strings.dart';
import 'package:cinco_minutos_meditacao/shared/Theme/app_colors.dart';
import 'package:cinco_minutos_meditacao/shared/Theme/app_images.dart';
import 'package:cinco_minutos_meditacao/shared/components/app_background.dart';
import 'package:cinco_minutos_meditacao/shared/components/app_header.dart';
import 'package:cinco_minutos_meditacao/shared/components/generic_error_container.dart';
import 'package:cinco_minutos_meditacao/shared/components/loading.dart';
import 'package:cinco_minutos_meditacao/shared/helpers/multi_state_container/export.dart';
import 'package:cinco_minutos_meditacao/shared/helpers/view_binding.dart';
import 'package:cinco_minutos_meditacao/shared/strings/localization/shared_strings.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'meditate_info_contract.dart';

@RoutePage()
class MeditateInfoView extends StatefulWidget {
  /// Parâmetros da tela
  MeditateInfoModel model;

  /// - [model] : Modelo da tela
  /// Construtor
  MeditateInfoView({
    super.key,
    required this.model,
  });

  @override
  State<MeditateInfoView> createState() => MeditateInfoViewState();
}

@visibleForTesting
class MeditateInfoViewState extends State<MeditateInfoView>
    implements MeditateInfoViewContract {
  /// Presenter
  Presenter presenter = resolve<MeditateInfoPresenter>();

  /// Controlador do estado da tela
  final stateController = MultiStateContainerController();

  /// Mensagem de erro
  late String messageError = "";

  @override
  void initState() {
    presenter.bindView(this);
    presenter.initPresenter(widget.model);

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
        onRetry: () => presenter.initPresenter(widget.model),
      ),
    );
  }

  Widget buildScaffold(BuildContext context) {
    return AppBackground(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AppHeader(
            nameUser: widget.model.userResponse!.name.split(" ").first,
            description1: MeditateStrings.of(context).alreadyAdded,
            description2:
                "${widget.model.meditationsByUserResponse?.totalMinutes ?? 0} ${MeditateStrings.of(context).minutes} ",
            description3: MeditateStrings.of(context).worldPeace,
            photo: widget.model.userResponse!.profilePhotoPath,
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
      padding: EdgeInsets.only(top: 13, left: 40, right: 40, bottom: 33),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            MeditateStrings.of(context).learnMeditate,
            style: const TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.w700,
              color: AppColors.white,
            ),
          ),
          const SizedBox(height: 13),
          VideoCard(
            'https://www.youtube.com/watch?v=s6871xx3LBk&list=PL8WJsGLLbHNuT9ZN3z7kaxfT5OmgeZifh&index=6',
            title: MeditateStrings.of(context).learnMeditate,
          ),
          const SizedBox(height: 30),
          Center(child: buildMeditometer()),
        ],
      ),
    );
  }

  /// Constrói o meditômetro
  Column buildMeditometer() {
    return Column(
      children: [
        Text(
          SharedStrings.of(context).meditometer,
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
            SharedStrings.of(context).realTime,
            style: const TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w400,
              color: AppColors.white,
            ),
          ),
        ),
        Text(
          widget.model.meditationsResponse!.totalMinutes.toString(),
          style: const TextStyle(
            fontSize: 58,
            fontWeight: FontWeight.w900,
            color: AppColors.frankBlue,
          ),
        ),
        RichText(
          text: TextSpan(
            children: [
              TextSpan(
                text: SharedStrings.of(context).millions,
                style: const TextStyle(
                  fontSize: 11,
                  fontWeight: FontWeight.w700,
                  color: AppColors.frankBlue,
                ),
              ),
              TextSpan(
                text: SharedStrings.of(context).minutesMeditatedWorld,
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
                SharedStrings.of(context).countriesReached,
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
  // Column buildMeditate(BuildContext context) {
  //   return Column(
  //     children: [
  //       Row(
  //         mainAxisAlignment: MainAxisAlignment.spaceEvenly,
  //         children: [
  //           Meditate(
  //             title: CommonStrings.of(context).meditate5Minutes,
  //           ),
  //           const SizedBox(width: 10),
  //           Meditate(
  //             title: CommonStrings.of(context).learnMethod,
  //           ),
  //         ],
  //       ),
  //       const SizedBox(height: 14),
  //       Row(
  //         mainAxisAlignment: MainAxisAlignment.spaceEvenly,
  //         children: [
  //           Meditate(
  //             title: CommonStrings.of(context).guidedMeditate,
  //           ),
  //           const SizedBox(width: 10),
  //           Meditate(
  //             title: CommonStrings.of(context).meditateTime,
  //           ),
  //         ],
  //       ),
  //     ],
  //   );
  // }

  /// Mostra o estado de carregamento
  @override
  void showLoading() {
    stateController.showLoadingState();
  }

  /// Mostra o estado normal
  @override
  void showNormalState({MeditateInfoModel? model}) {
    if (model != null) {
      setState(() {
        widget.model = model;
      });
    }

    stateController.showNormalState();
  }

  /// Mostra o estado de erro
  @override
  void showError(String message) {
    messageError = message;
    stateController.showErrorState();
  }
}

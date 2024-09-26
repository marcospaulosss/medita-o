import 'package:auto_route/auto_route.dart';
import 'package:cinco_minutos_meditacao/core/di/helpers.dart';
import 'package:cinco_minutos_meditacao/modules/meditate/screens/meditate_info/meditate_info_model.dart';
import 'package:cinco_minutos_meditacao/modules/meditate/screens/meditate_info/meditate_info_presenter.dart';
import 'package:cinco_minutos_meditacao/modules/meditate/shared/components/video_card.dart';
import 'package:cinco_minutos_meditacao/modules/meditate/shared/strings/localization/meditate_strings.dart';
import 'package:cinco_minutos_meditacao/shared/Theme/app_colors.dart';
import 'package:cinco_minutos_meditacao/shared/clients/models/responses/meditations_response.dart';
import 'package:cinco_minutos_meditacao/shared/components/Meditometer.dart';
import 'package:cinco_minutos_meditacao/shared/components/app_background.dart';
import 'package:cinco_minutos_meditacao/shared/components/app_header.dart';
import 'package:cinco_minutos_meditacao/shared/components/generic_error_container.dart';
import 'package:cinco_minutos_meditacao/shared/components/loading.dart';
import 'package:cinco_minutos_meditacao/shared/helpers/multi_state_container/export.dart';
import 'package:cinco_minutos_meditacao/shared/helpers/view_binding.dart';
import 'package:flutter/material.dart';

import 'meditate_info_contract.dart';

@RoutePage()
class MeditateInfoView extends StatefulWidget {
  /// Construtor
  const MeditateInfoView({
    super.key,
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

  /// Modelo
  MeditateInfoModel? _meditateInfoModel;

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
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AppHeader(
            nameUser:
                _meditateInfoModel!.userResponse?.name.split(" ").first ?? "",
            description1: MeditateStrings.of(context).alreadyAdded,
            description2:
                "${_meditateInfoModel!.meditationsByUserResponse?.formattedDecimalPattern ?? 0} ${MeditateStrings.of(context).minutes} ",
            description3: MeditateStrings.of(context).worldPeace,
            photo: _meditateInfoModel!.userResponse?.profilePhotoPath,
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
            'https://youtu.be/O66_PkUEkOM',
            title: MeditateStrings.of(context).learnMeditate,
          ),
          const SizedBox(height: 30),
          Center(
            child: Meditometer(
              meditationsResponse: _meditateInfoModel!.meditationsResponse,
            ),
          ),
        ],
      ),
    );
  }

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
        _meditateInfoModel = model;
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

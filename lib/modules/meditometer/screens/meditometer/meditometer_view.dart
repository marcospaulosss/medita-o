import 'package:auto_route/auto_route.dart';
import 'package:cinco_minutos_meditacao/core/di/helpers.dart';
import 'package:cinco_minutos_meditacao/modules/common/shared/strings/localization/common_strings.dart';
import 'package:cinco_minutos_meditacao/modules/meditometer/screens/meditometer/meditometer_contract.dart';
import 'package:cinco_minutos_meditacao/modules/meditometer/screens/meditometer/meditometer_model.dart';
import 'package:cinco_minutos_meditacao/modules/meditometer/screens/meditometer/meditometer_presenter.dart';
import 'package:cinco_minutos_meditacao/modules/meditometer/shared/strings/localization/meditometer_strings.dart';
import 'package:cinco_minutos_meditacao/shared/Theme/app_colors.dart';
import 'package:cinco_minutos_meditacao/shared/Theme/app_images.dart';
import 'package:cinco_minutos_meditacao/shared/clients/models/responses/meditations_response.dart';
import 'package:cinco_minutos_meditacao/shared/components/app_background.dart';
import 'package:cinco_minutos_meditacao/shared/components/app_header.dart';
import 'package:cinco_minutos_meditacao/shared/components/generic_error_container.dart';
import 'package:cinco_minutos_meditacao/shared/components/icon_label_button.dart';
import 'package:cinco_minutos_meditacao/shared/components/loading.dart';
import 'package:cinco_minutos_meditacao/shared/helpers/multi_state_container/export.dart';
import 'package:cinco_minutos_meditacao/shared/helpers/view_binding.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

@RoutePage()
class MeditometerView extends StatefulWidget {
  /// Construtor
  const MeditometerView({
    super.key,
  });

  @override
  State<MeditometerView> createState() => MeditometerViewState();
}

@visibleForTesting
class MeditometerViewState extends State<MeditometerView>
    implements MeditometerViewContract {
  /// Presenter
  Presenter presenter = resolve<MeditometerPresenter>();

  /// Controlador do estado da tela
  final stateController = MultiStateContainerController();

  /// Mensagem de erro
  late String messageError = "";

  /// Model para contrução da tela
  late MeditometerModel model = MeditometerModel();

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
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AppHeader(
            nameUser: model.userResponse?.name.split(" ").first ?? "",
            description1: CommonStrings.of(context).homeHeaderDescription1,
            photo: model.userResponse?.profilePhotoPath ?? "",
            updateImage: () => presenter.updateImageProfile(),
          ),
          buildTitle(),
          buildMeditometerCard(),
          buildDescriptionCard(),
        ],
      ),
    );
  }

  Padding buildTitle() {
    return Padding(
      padding:
          const EdgeInsets.only(left: 47.0, top: 10, right: 47, bottom: 20),
      child: Text(
        MeditometerStrings.of(context).meditometerTitle,
        style: const TextStyle(
          color: Colors.white,
          fontSize: 19,
          fontWeight: FontWeight.w400,
        ),
      ),
    );
  }

  Container buildMeditometerCard() {
    return Container(
      padding: const EdgeInsets.only(left: 39.0, right: 38, bottom: 16),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 22.0, vertical: 30),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(22.0),
          boxShadow: [
            buildBoxShadowDefault(),
          ],
        ),
        child: Column(
          children: [
            SvgPicture.asset(
              AppImages.meditometer,
              width: 54,
              height: 54,
            ),
            const SizedBox(height: 8),
            Text(
              MeditometerStrings.of(context).meditometer,
              style: const TextStyle(
                fontSize: 56,
                fontWeight: FontWeight.w400,
                fontFamily: 'Blanch',
                color: AppColors.steelWoolColor,
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 16),
              decoration: BoxDecoration(
                color: AppColors.blueMana,
                borderRadius: BorderRadius.circular(23),
              ),
              child: Text(
                MeditometerStrings.of(context).inRealTime,
                style: const TextStyle(
                  color: AppColors.white,
                  fontWeight: FontWeight.w400,
                  fontSize: 12,
                ),
              ),
            ),
            Text(
              model.meditationsResponse?.formattedDecimalPattern ?? "0",
              style: const TextStyle(
                fontSize: 50,
                color: AppColors.frankBlue,
                fontWeight: FontWeight.w900,
              ),
            ),
            Text(
              MeditometerStrings.of(context).minutesMeditated,
              style: const TextStyle(
                fontSize: 10,
                color: AppColors.frankBlue,
                fontWeight: FontWeight.w400,
              ),
            ),
            const SizedBox(height: 24),
            IconLabelButton(
              onTap: () {},
              decoration: BoxDecoration(
                color: AppColors.germanderSpeedwell,
                borderRadius: BorderRadius.circular(12),
              ),
              icon: const Icon(
                Icons.share_outlined,
                color: AppColors.white,
                size: 25,
              ),
              label: Text(
                MeditometerStrings.of(context).share,
                style: const TextStyle(
                  color: AppColors.white,
                  fontSize: 19,
                  fontWeight: FontWeight.w700,
                ),
              ),
              width: double.infinity,
              height: 43,
              spaceBetween: 4,
            ),
            const SizedBox(height: 16),
            Text(
              MeditometerStrings.of(context).meditometerCardDescription1,
              style: const TextStyle(
                fontSize: 16,
                color: AppColors.steelWoolColor,
                fontWeight: FontWeight.w400,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }

  Padding buildDescriptionCard() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 39.0),
      child: Container(
        padding: const EdgeInsets.all(27.0),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16.0),
          boxShadow: [
            buildBoxShadowDefault(),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            paragraph(),
            const SizedBox(height: 10),
            Text(
              MeditometerStrings.of(context).meditometerParagraph6,
              style: buildTextStyleDefault(),
            ),
            const SizedBox(height: 10),
            Text(
              MeditometerStrings.of(context).meditometerParagraph7,
              style: buildTextStyleDefault(),
            ),
            const SizedBox(height: 10),
            IconLabelButton(
              onTap: () => presenter.goToAbout(),
              decoration: BoxDecoration(
                color: AppColors.germanderSpeedwell,
                borderRadius: BorderRadius.circular(12),
              ),
              icon: const Icon(
                Icons.computer,
                color: AppColors.white,
                size: 14,
              ),
              spaceBetween: 4,
              label: Text(
                MeditometerStrings.of(context).aboutProgram,
                style: const TextStyle(
                  color: AppColors.white,
                  fontSize: 11,
                  fontWeight: FontWeight.w700,
                ),
              ),
              width: 170,
              height: 33,
            ),
          ],
        ),
      ),
    );
  }

  BoxShadow buildBoxShadowDefault() {
    return BoxShadow(
      color: Colors.grey.withOpacity(0.5),
      spreadRadius: 5,
      blurRadius: 7,
      offset: const Offset(0, 3),
    );
  }

  RichText paragraph() {
    return RichText(
      text: TextSpan(
        text: MeditometerStrings.of(context).meditometerParagraph1,
        style: buildTextStyleDefault(),
        children: [
          TextSpan(
            text: MeditometerStrings.of(context).meditometerParagraph2,
            style:
                buildTextStyleDefault().copyWith(fontWeight: FontWeight.w700),
          ),
          TextSpan(
            text: MeditometerStrings.of(context).meditometerParagraph3,
            style: buildTextStyleDefault(),
          ),
          TextSpan(
            text: MeditometerStrings.of(context).meditometerParagraph4,
            style:
                buildTextStyleDefault().copyWith(fontWeight: FontWeight.w700),
          ),
          TextSpan(
            text: MeditometerStrings.of(context).meditometerParagraph5,
            style: buildTextStyleDefault(),
          ),
        ],
      ),
    );
  }

  TextStyle buildTextStyleDefault() {
    return const TextStyle(
      fontSize: 15,
      color: AppColors.steelWoolColor,
      fontWeight: FontWeight.w400,
    );
  }

  /// Mostra o estado de carregamento
  @override
  void showLoading() {
    stateController.showLoadingState();
  }

  /// Mostra o estado normal
  @override
  void showNormalState(MeditometerModel response) {
    setState(() {
      model = response;
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

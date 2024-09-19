import 'package:auto_route/auto_route.dart';
import 'package:cinco_minutos_meditacao/core/di/helpers.dart';
import 'package:cinco_minutos_meditacao/modules/meditate/screens/guided_meditation/guided_meditation_contract.dart';
import 'package:cinco_minutos_meditacao/modules/meditate/screens/guided_meditation/guided_meditation_presenter.dart';
import 'package:cinco_minutos_meditacao/modules/meditate/shared/strings/localization/meditate_strings.dart';
import 'package:cinco_minutos_meditacao/shared/Theme/app_colors.dart';
import 'package:cinco_minutos_meditacao/shared/components/app_background.dart';
import 'package:cinco_minutos_meditacao/shared/components/generic_error_container.dart';
import 'package:cinco_minutos_meditacao/shared/components/loading.dart';
import 'package:cinco_minutos_meditacao/shared/helpers/multi_state_container/export.dart';
import 'package:cinco_minutos_meditacao/shared/helpers/view_binding.dart';
import 'package:flutter/material.dart';

@RoutePage()
class GuidedMeditationView extends StatefulWidget {
  /// Construtor
  const GuidedMeditationView({
    super.key,
  });

  @override
  State<GuidedMeditationView> createState() => GuidedMeditationViewState();
}

@visibleForTesting
class GuidedMeditationViewState extends State<GuidedMeditationView>
    implements GuidedMeditationViewContract {
  /// Presenter
  Presenter presenter = resolve<GuidedMeditationPresenter>();

  /// Controlador do estado da tela
  final stateController = MultiStateContainerController();

  /// Mensagem de erro
  late String messageError = "";

  @override
  void initState() {
    stateController.showNormalState();

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
          buildBody(context),
        ],
      ),
    );
  }

  /// Corpo da tela
  Widget buildBody(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        padding: const EdgeInsets.all(40),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.all(21),
              decoration: BoxDecoration(
                color: AppColors.brilliance2,
                borderRadius: BorderRadius.circular(22),
                boxShadow: const [
                  BoxShadow(
                    color: Colors.black12,
                    blurRadius: 10.0,
                    offset: Offset(0, 5),
                  ),
                ],
              ),
              child: Column(
                children: [
                  Text(
                    MeditateStrings.of(context).aboutGuidedMeditation,
                    style: const TextStyle(
                      fontSize: 52,
                      fontFamily: 'Blanch',
                      fontWeight: FontWeight.w400,
                      color: AppColors.germanderSpeedwell,
                    ),
                  ),
                  const SizedBox(height: 18),
                  Text(
                    MeditateStrings.of(context).titleGuidedMeditation,
                    textAlign: TextAlign.center,
                    style: buildTextStyleDefault(),
                  ),
                  const SizedBox(height: 29),
                  Image.asset(
                    'assets/images/fundation.png',
                    fit: BoxFit.cover,
                  ),
                  const SizedBox(height: 28),
                  Text(
                    MeditateStrings.of(context).descriptionGuidedMeditation,
                    textAlign: TextAlign.center,
                    style: buildTextStyleDefault(),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  TextStyle buildTextStyleDefault() {
    return const TextStyle(
      fontSize: 16,
      fontWeight: FontWeight.w400,
      color: AppColors.steelWoolColor,
      fontFamily: 'Apertura',
    );
  }

  /// Mostra o estado de carregamento
  @override
  void showLoading() {
    stateController.showLoadingState();
  }

  /// Mostra o estado normal
  @override
  void showNormalState() {
    stateController.showNormalState();
  }

  /// Mostra o estado de erro
  @override
  void showError(String message) {
    messageError = message;
    stateController.showErrorState();
  }
}

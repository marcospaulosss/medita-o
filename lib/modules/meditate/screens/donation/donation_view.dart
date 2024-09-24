import 'package:auto_route/auto_route.dart';
import 'package:cinco_minutos_meditacao/core/di/helpers.dart';
import 'package:cinco_minutos_meditacao/modules/meditate/screens/guided_meditation/guided_meditation_contract.dart';
import 'package:cinco_minutos_meditacao/modules/meditate/screens/guided_meditation/guided_meditation_presenter.dart';
import 'package:cinco_minutos_meditacao/modules/meditate/shared/strings/localization/meditate_strings.dart';
import 'package:cinco_minutos_meditacao/shared/Theme/app_colors.dart';
import 'package:cinco_minutos_meditacao/shared/components/app_background.dart';
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

  /// Mensagem de erro
  late String messageError = "";

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
    return buildScaffold(context);
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
}

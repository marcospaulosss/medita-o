import 'package:auto_route/auto_route.dart';
import 'package:cinco_minutos_meditacao/core/di/helpers.dart';
import 'package:cinco_minutos_meditacao/modules/calendar/screens/calendar/calendar_contract.dart';
import 'package:cinco_minutos_meditacao/modules/calendar/screens/calendar/calendar_model.dart';
import 'package:cinco_minutos_meditacao/modules/calendar/screens/calendar/calendar_presenter.dart';
import 'package:cinco_minutos_meditacao/modules/calendar/screens/calendar/componets/calendar_meditation.dart';
import 'package:cinco_minutos_meditacao/modules/calendar/shared/strings/localization/calendar_strings.dart';
import 'package:cinco_minutos_meditacao/modules/common/shared/strings/localization/common_strings.dart';
import 'package:cinco_minutos_meditacao/modules/meditometer/shared/strings/localization/meditometer_strings.dart';
import 'package:cinco_minutos_meditacao/shared/Theme/app_colors.dart';
import 'package:cinco_minutos_meditacao/shared/components/app_background.dart';
import 'package:cinco_minutos_meditacao/shared/components/app_header.dart';
import 'package:cinco_minutos_meditacao/shared/components/generic_error_container.dart';
import 'package:cinco_minutos_meditacao/shared/components/icon_label_button.dart';
import 'package:cinco_minutos_meditacao/shared/components/loading.dart';
import 'package:cinco_minutos_meditacao/shared/helpers/multi_state_container/export.dart';
import 'package:cinco_minutos_meditacao/shared/helpers/view_binding.dart';
import 'package:flutter/material.dart';

@RoutePage()
class CalendarView extends StatefulWidget {
  /// Construtor
  const CalendarView({
    super.key,
  });

  @override
  State<CalendarView> createState() => CalendarViewState();
}

@visibleForTesting
class CalendarViewState extends State<CalendarView>
    implements CalendarViewContract {
  /// Presenter
  Presenter presenter = resolve<CalendarPresenter>();

  /// Controlador do estado da tela
  final stateController = MultiStateContainerController();

  /// Mensagem de erro
  late String messageError = "";

  /// Model para contrução da tela
  late CalendarModel model = CalendarModel();

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
          CalendarMeditation(weekCalendar: model?.weekCalendar ?? []),
          buildMeditometerCard(),
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

  Widget buildMeditometerCard() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 40.0),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 26),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  model.weekCalendarResponse?.totalMinutes.toString() ?? "0",
                  style: const TextStyle(
                    fontSize: 48,
                    fontWeight: FontWeight.bold,
                    color: AppColors.frankBlue,
                  ),
                ),
                const SizedBox(width: 10),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      CalendarStrings.of(context).youMeditated,
                      style: const TextStyle(
                        fontSize: 19,
                        fontWeight: FontWeight.w700,
                        color: AppColors.steelWoolColor,
                      ),
                    ),
                    RichText(
                      text: TextSpan(
                        text: CalendarStrings.of(context).minutes,
                        style: const TextStyle(
                          fontSize: 19,
                          color: AppColors.blueMana,
                        ),
                        children: [
                          TextSpan(
                            text: CalendarStrings.of(context).week,
                            style: const TextStyle(
                              fontSize: 19,
                              fontWeight: FontWeight.bold,
                              color: AppColors.blueMana,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 16),
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

  /// Mostra o estado de carregamento
  @override
  void showLoading() {
    stateController.showLoadingState();
  }

  /// Mostra o estado normal
  @override
  void showNormalState(CalendarModel response) {
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

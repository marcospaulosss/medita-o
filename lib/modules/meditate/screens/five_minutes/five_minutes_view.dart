import 'package:audioplayers/audioplayers.dart';
import 'package:auto_route/auto_route.dart';
import 'package:cinco_minutos_meditacao/modules/meditate/screens/five_minutes/components/meditation_method.dart';
import 'package:cinco_minutos_meditacao/modules/meditate/screens/five_minutes/components/player.dart';
import 'package:cinco_minutos_meditacao/modules/meditate/shared/strings/localization/meditate_strings.dart';
import 'package:cinco_minutos_meditacao/shared/Theme/app_tracks.dart';
import 'package:cinco_minutos_meditacao/shared/components/app_background.dart';
import 'package:cinco_minutos_meditacao/shared/components/generic_error_container.dart';
import 'package:cinco_minutos_meditacao/shared/components/loading.dart';
import 'package:cinco_minutos_meditacao/shared/helpers/multi_state_container/export.dart';
import 'package:flutter/material.dart';

@RoutePage()
class FiveMinutesView extends StatefulWidget {
  /// Construtor
  const FiveMinutesView({
    super.key,
  });

  @override
  State<FiveMinutesView> createState() => FiveMinutesViewState();
}

@visibleForTesting
class FiveMinutesViewState extends State<FiveMinutesView> {
  // implements MeditateInfoViewContract {
  /// Presenter
  // Presenter presenter = resolve<MeditateInfoPresenter>();

  /// Controlador do estado da tela
  final stateController = MultiStateContainerController();

  /// Mensagem de erro
  late String messageError = "";

  late AudioPlayer player = AudioPlayer();

  @override
  void initState() {
    stateController.showNormalState();
    // presenter.bindView(this);
    // presenter.initPresenter(widget.model);

    // Create the audio player.
    player = AudioPlayer();

    // Set the release mode to keep the source after playback has completed.
    player.setReleaseMode(ReleaseMode.stop);

    // Start the player as soon as the app is displayed.
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await player.setSource(AppTracks.trackFive);
      await player.stop();
    });

    super.initState();
  }

  @override
  void dispose() {
    // presenter.unbindView();
    player.dispose();
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
        // onRetry: () => presenter.initPresenter(widget.model),
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
  Padding buildBody(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 113, left: 40, right: 40, bottom: 33),
      child: Column(
        children: [
          Player(player: player),
          const SizedBox(height: 20),
          Text(
            MeditateStrings.of(context).tapStartMeditation,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w400,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 26),
          MeditationMethod(
            iconButton1: MeditationMethodButtonCustom(
              onTap: () {},
              icon: Icons.play_circle_outline,
              label: MeditateStrings.of(context).learnMethod,
            ),
            iconButton2: MeditationMethodButtonCustom(
              onTap: () {},
              icon: Icons.access_time,
              label: MeditateStrings.of(context).remindMeditate,
              type: MeditationMethodButtonType.white,
            ),
            spaceTop: 38,
            title: MeditateStrings.of(context).fiveMinutesTitle,
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

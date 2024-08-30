import 'package:auto_route/auto_route.dart';
import 'package:cinco_minutos_meditacao/core/di/helpers.dart';
import 'package:cinco_minutos_meditacao/modules/meditate/screens/in_your_time/in_your_time_contract.dart';
import 'package:cinco_minutos_meditacao/modules/meditate/screens/in_your_time/in_your_time_presenter.dart';
import 'package:cinco_minutos_meditacao/modules/meditate/shared/components/meditation_method.dart';
import 'package:cinco_minutos_meditacao/modules/meditate/shared/components/player.dart';
import 'package:cinco_minutos_meditacao/modules/meditate/shared/strings/localization/meditate_strings.dart';
import 'package:cinco_minutos_meditacao/shared/Theme/app_tracks.dart';
import 'package:cinco_minutos_meditacao/shared/components/app_background.dart';
import 'package:cinco_minutos_meditacao/shared/components/generic_error_container.dart';
import 'package:cinco_minutos_meditacao/shared/components/loading.dart';
import 'package:cinco_minutos_meditacao/shared/helpers/multi_state_container/export.dart';
import 'package:cinco_minutos_meditacao/shared/helpers/view_binding.dart';
import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';

@RoutePage()
class InYourTimeView extends StatefulWidget {
  /// Construtor
  const InYourTimeView({
    super.key,
  });

  @override
  State<InYourTimeView> createState() => InYourTimeViewState();
}

@visibleForTesting
class InYourTimeViewState extends State<InYourTimeView>
    implements InYourTimeContract {
  /// Presenter
  Presenter presenter = resolve<InYourTimePresenter>();

  /// Controlador do estado da tela
  final stateController = MultiStateContainerController();

  /// Mensagem de erro
  late String messageError = "";

  late AudioPlayer player;

  @override
  void initState() {
    stateController.showNormalState();

    presenter.bindView(this);
    presenter.onOpenScreen();

    // Create the audio player.
    player = AudioPlayer();

    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await getTrack(5);
    });

    super.initState();
  }

  @override
  void dispose() {
    presenter.unbindView();

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
        onRetry: () {},
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
          Player(
            player: player,
            onStop: () async {
              print("funcionando porra");
              if (player.processingState == ProcessingState.idle) {
                // Recarregar o áudio se o player estiver ocioso
                await player
                    .setAudioSource(AudioSource.asset(AppTracks.trackFive));
              }
            },
          ),
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
              onTap: (minutes) => getTrack(minutes),
              icon: Icons.play_circle_outline,
              label: MeditateStrings.of(context).learnMethod,
              type: MeditationMethodButtonType.combo,
            ),
            iconButton2: MeditationMethodButtonCustom(
              onTap: () {},
              icon: Icons.access_time,
              label: MeditateStrings.of(context).remindMeditate,
              type: MeditationMethodButtonType.blue,
            ),
            spaceTop: 8,
            title: MeditateStrings.of(context).inYourTime,
          ),
        ],
      ),
    );
  }

  /// Carrega a trilha
  Future<void> getTrack(int minutes) async {
    String track;
    switch (minutes) {
      case 5:
        track = AppTracks.trackFive;
        break;
      case 10:
        track = AppTracks.trackTen;
        break;
      case 15:
        track = AppTracks.trackFifteen;
        break;
      case 20:
        track = AppTracks.trackTwenty;
        break;
      case 25:
        track = AppTracks.trackTwentyFive;
        break;
      case 30:
        track = AppTracks.trackThirty;
        break;
      default:
        track = AppTracks.trackFive;
    }

    await player.setAudioSource(AudioSource.asset(
      track,
    ));

    setState(() {});
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

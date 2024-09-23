import 'package:auto_route/auto_route.dart';
import 'package:cinco_minutos_meditacao/core/di/helpers.dart';
import 'package:cinco_minutos_meditacao/modules/meditate/screens/guided_meditation_program/guided_meditation_program_contract.dart';
import 'package:cinco_minutos_meditacao/modules/meditate/screens/guided_meditation_program/guided_meditation_program_presenter.dart';
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
class GuidedMeditationProgramView extends StatefulWidget {
  /// Construtor
  const GuidedMeditationProgramView({
    super.key,
  });

  @override
  State<GuidedMeditationProgramView> createState() =>
      GuidedMeditationProgramViewState();
}

@visibleForTesting
class GuidedMeditationProgramViewState
    extends State<GuidedMeditationProgramView>
    implements GuidedMeditationProgramViewContract {
  /// Presenter
  Presenter presenter = resolve<GuidedMeditationProgramPresenter>();

  /// Controlador do estado da tela
  final stateController = MultiStateContainerController();

  /// Mensagem de erro
  late String messageError = "";

  /// Player de áudio
  late AudioPlayer player;

  /// Se a reprodução foi concluída
  bool hasCompleted = false;

  @override
  void initState() {
    stateController.showNormalState();

    presenter.bindView(this);
    presenter.onOpenScreen();

    // Create the audio player.
    player = AudioPlayer();

    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await player
          .setAudioSource(AudioSource.asset(AppTracks.trackGuidedMeditation));
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
            onStop: submitMeditateComplete,
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
              onTap: () {},
              icon: Icons.translate,
              label: MeditateStrings.of(context).seeTranslation,
            ),
            iconButton2: MeditationMethodButtonCustom(
              onTap: () => presenter.goToGuidedMeditation(),
              icon: Icons.help_outline,
              label: MeditateStrings.of(context).learnMore,
              type: MeditationMethodButtonType.white,
            ),
            spaceTop: 21,
            title: MeditateStrings.of(context).guidedMeditationProgramTitle,
            titleSize: 48,
          ),
        ],
      ),
    );
  }

  /// Submete a meditação como concluída
  submitMeditateComplete() async {
    if (player.processingState == ProcessingState.idle) {
      // Recarregar o áudio se o player estiver ocioso
      await player.setAudioSource(AudioSource.asset(AppTracks.trackFive));
    }

    if (!hasCompleted) {
      presenter.submitMeditateCompleted(15);
      hasCompleted = true;
    }
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

  @override
  void meditationCompleted() {
    hasCompleted = false;
  }
}

import 'package:auto_route/auto_route.dart';
import 'package:cinco_minutos_meditacao/core/di/helpers.dart';
import 'package:cinco_minutos_meditacao/modules/meditate/screens/donation/donation_contract.dart';
import 'package:cinco_minutos_meditacao/modules/meditate/screens/donation/donation_presenter.dart';
import 'package:cinco_minutos_meditacao/modules/meditate/shared/strings/localization/meditate_strings.dart';
import 'package:cinco_minutos_meditacao/shared/Theme/app_colors.dart';
import 'package:cinco_minutos_meditacao/shared/components/app_background.dart';
import 'package:cinco_minutos_meditacao/shared/helpers/view_binding.dart';
import 'package:flutter/material.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

@RoutePage()
class DonationView extends StatefulWidget {
  /// Construtor
  const DonationView({
    super.key,
  });

  @override
  State<DonationView> createState() => DonationViewState();
}

@visibleForTesting
class DonationViewState extends State<DonationView>
    implements DonationViewContract {
  /// Presenter
  Presenter presenter = resolve<DonationPresenter>();

  /// Controller do player de vídeo
  late YoutubePlayerController _controller;

  @override
  void initState() {
    presenter.bindView(this);
    presenter.initPresenter();

    _controller = YoutubePlayerController(
      initialVideoId: YoutubePlayer.convertUrlToId(
              "https://www.youtube.com/watch?v=_Rj9FhjHN4M") ??
          '',
      flags: const YoutubePlayerFlags(
        autoPlay: false,
        mute: false,
      ),
    );

    super.initState();
  }

  @override
  void dispose() {
    presenter.unbindView();

    _controller.dispose();

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
                  const SizedBox(height: 31),
                  YoutubePlayer(
                    controller: _controller,
                    showVideoProgressIndicator: true,
                    onReady: () {
                      _controller.addListener(() {});
                    },
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          MeditateStrings.of(context).donationTitle,
                          style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w700,
                            color: AppColors.steelWoolColor,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          MeditateStrings.of(context).donationDescription,
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w400,
                            color: AppColors.steelWoolColor,
                          ),
                        ),
                        const SizedBox(height: 25),
                      ],
                    ),
                  ),
                  Container(
                    width: double.infinity,
                    alignment: Alignment.center,
                    // height: 60,
                    decoration: BoxDecoration(
                      color: AppColors.germanderSpeedwell,
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: Text(
                      MeditateStrings.of(context).donate,
                      style: const TextStyle(
                        fontSize: 52,
                        fontWeight: FontWeight.w400,
                        color: AppColors.white,
                        fontFamily: 'Blanch',
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 16.0),
                    child: Text(
                      MeditateStrings.of(context).donationFooterDescription,
                      style: const TextStyle(
                        fontSize: 7,
                        fontWeight: FontWeight.w400,
                        color: AppColors.steelWoolColor,
                      ),
                      textAlign: TextAlign.justify,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

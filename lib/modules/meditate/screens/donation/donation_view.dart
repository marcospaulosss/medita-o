import 'package:auto_route/auto_route.dart';
import 'package:cinco_minutos_meditacao/core/di/helpers.dart';
import 'package:cinco_minutos_meditacao/modules/meditate/screens/donation/donation_contract.dart';
import 'package:cinco_minutos_meditacao/modules/meditate/screens/donation/donation_presenter.dart';
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

  /// Mensagem de erro
  late String messageError = "";

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
                  const Padding(
                    padding: EdgeInsets.symmetric(vertical: 16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'SUA DOAÇÃO AJUDA A PAZ SER CADA VEZ MAIS MUNDIAL!',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w700,
                            color: AppColors.steelWoolColor,
                          ),
                        ),
                        SizedBox(height: 8),
                        Text(
                          'Todas as doações recebidas ajudam o Instituto Mãos Sem Fronteiras a capacitarem mais voluntários e levarem a paz para cada vez mais pessoas.',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w400,
                            color: AppColors.steelWoolColor,
                          ),
                        ),
                        SizedBox(height: 25),
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
                    child: const Text(
                      "DOAR",
                      style: TextStyle(
                        fontSize: 52,
                        fontWeight: FontWeight.w400,
                        color: AppColors.white,
                        fontFamily: 'Blanch',
                      ),
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.symmetric(vertical: 16.0),
                    child: Text(
                      'Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry\'s standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.',
                      style: TextStyle(
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

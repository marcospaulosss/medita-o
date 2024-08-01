import 'package:cinco_minutos_meditacao/modules/meditate/shared/strings/localization/meditate_strings.dart';
import 'package:cinco_minutos_meditacao/shared/Theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class VideoCard extends StatefulWidget {
  /// url do vídeo
  final String video;

  /// Título do vídeo
  final String? title;

  /// [video] : url do vídeo
  /// [title] : Título do vídeo
  /// Construtor
  const VideoCard(this.video, {this.title, super.key});

  @override
  State<VideoCard> createState() => _VideoCardState();
}

class _VideoCardState extends State<VideoCard> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.only(top: 24),
      decoration: BoxDecoration(
        color: AppColors.antiFlashWhite,
        borderRadius: BorderRadius.circular(22),
        boxShadow: const [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 8,
            spreadRadius: 2,
          ),
        ],
      ),
      child: Column(
        children: [
          buildVideo(),
          buildDescription(),
        ],
      ),
    );
  }

  /// Constrói o vídeo
  Padding buildVideo() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25),
      child: Column(
        children: [
          buildButtons(),
          buildPlay(),
        ],
      ),
    );
  }

  /// Constrói os botões do vídeo
  Row buildButtons() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const Icon(
          Icons.volume_up_outlined,
          color: AppColors.steelWoolColor,
          size: 31,
        ),
        Container(
          width: 23,
          height: 23,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(23),
            border: Border.all(color: AppColors.grayOnix),
          ),
          child: const Icon(
            Icons.close,
            color: AppColors.grayOnix,
            size: 18,
          ),
        ),
      ],
    );
  }

  /// Constrói o botão de play
  Column buildPlay() {
    return Column(
      children: [
        const SizedBox(height: 1),
        GestureDetector(
          onTap: _launchURL,
          child: const CircleAvatar(
            radius: 50,
            backgroundColor: AppColors.germanderSpeedwell,
            child: Icon(Icons.play_arrow, color: AppColors.white, size: 50),
          ),
        ),
        const SizedBox(height: 25),
        Text(
          widget.title ?? '',
          style: const TextStyle(
            fontSize: 19,
            fontWeight: FontWeight.w700,
            color: AppColors.steelWoolColor,
          ),
        ),
        const SizedBox(height: 24),
      ],
    );
  }

  /// Constrói a descrição
  Container buildDescription() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 38),
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(22),
          bottomRight: Radius.circular(22),
        ),
        color: AppColors.white,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            MeditateStrings.of(context).methodTitle,
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w700,
              color: AppColors.frankBlue,
            ),
          ),
          const SizedBox(height: 9),
          Text(
            MeditateStrings.of(context).methodDescriptionPhrase1,
            style: textStyleDefault(),
          ),
          const SizedBox(height: 9),
          RichText(
            text: TextSpan(
              text: MeditateStrings.of(context).methodDescriptionPhrase2,
              style: textStyleDefault(),
              children: [
                TextSpan(
                  text: MeditateStrings.of(context).threeBreaths,
                  style: const TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.w700,
                    color: AppColors.grayOnix,
                  ),
                ),
                TextSpan(
                  text: MeditateStrings.of(context).methodDescriptionPhrase3,
                  style: textStyleDefault(),
                ),
              ],
            ),
          ),
          const SizedBox(height: 9),
          RichText(
            text: TextSpan(
              text: MeditateStrings.of(context).methodDescriptionPhrase4,
              style: textStyleDefault(),
              children: [
                TextSpan(
                  text: MeditateStrings.of(context).fiveMinutes,
                  style: const TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.w700,
                    color: AppColors.grayOnix,
                  ),
                ),
                TextSpan(
                  text: MeditateStrings.of(context).methodDescriptionPhrase5,
                  style: textStyleDefault(),
                ),
                TextSpan(
                  text: MeditateStrings.of(context).threeBreaths,
                  style: const TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.w700,
                    color: AppColors.grayOnix,
                  ),
                ),
                TextSpan(
                  text: MeditateStrings.of(context).methodDescriptionPhrase6,
                  style: textStyleDefault(),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  /// Estilo de texto padrão
  TextStyle textStyleDefault() {
    return const TextStyle(
      fontSize: 16,
      fontWeight: FontWeight.w400,
      color: AppColors.grayOnix,
    );
  }

  /// - metodos da pagina
  ///
  /// - Abre o vídeo
  void _launchURL() async {
    if (await canLaunch(widget.video)) {
      await launch(widget.video);
    } else {
      throw 'Could not launch ${widget.video}';
    }
  }
}

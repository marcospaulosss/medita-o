import 'package:cinco_minutos_meditacao/shared/Theme/app_colors.dart';
import 'package:cinco_minutos_meditacao/shared/Theme/app_images.dart';
import 'package:cinco_minutos_meditacao/shared/clients/models/responses/meditations_response.dart';
import 'package:cinco_minutos_meditacao/shared/strings/localization/shared_strings.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class Meditometer extends StatelessWidget {
  /// Modelo das meditações
  final MeditationsResponse? meditationsResponse;

  /// - [meditationsResponse] : Modelo das meditações
  /// Construtor
  const Meditometer({
    super.key,
    required this.meditationsResponse,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          SharedStrings.of(context).meditometer,
          style: const TextStyle(
            fontSize: 64,
            fontWeight: FontWeight.w400,
            color: AppColors.steelWoolColor,
            fontFamily: "Blanch",
          ),
        ),
        Container(
          height: 17,
          width: 125,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: AppColors.blueMana,
            borderRadius: BorderRadius.circular(27),
          ),
          child: Text(
            SharedStrings.of(context).realTime,
            style: const TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w400,
              color: AppColors.white,
            ),
          ),
        ),
        Text(
          meditationsResponse!.formattedDecimalPattern,
          style: const TextStyle(
            fontSize: 58,
            fontWeight: FontWeight.w900,
            color: AppColors.frankBlue,
          ),
        ),
        RichText(
          text: TextSpan(
            children: [
              TextSpan(
                text: SharedStrings.of(context).millions,
                style: const TextStyle(
                  fontSize: 11,
                  fontWeight: FontWeight.w700,
                  color: AppColors.frankBlue,
                ),
              ),
              TextSpan(
                text: SharedStrings.of(context).minutesMeditatedWorld,
                style: const TextStyle(
                  fontSize: 11,
                  fontWeight: FontWeight.w400,
                  color: AppColors.frankBlue,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 28),
        Stack(
          alignment: Alignment.center,
          children: [
            Container(
              height: 67,
              width: 288,
              color: AppColors.vividCerulean,
            ),
            SvgPicture.asset(
              AppImages.countries,
              height: 144,
              width: 248,
            ),
            Positioned(
              left: 12,
              top: 53,
              width: 60,
              child: Text(
                SharedStrings.of(context).countriesReached,
                style: const TextStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.w400,
                  color: AppColors.white,
                  fontFamily: "Blanch",
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}

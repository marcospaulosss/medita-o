import 'package:cinco_minutos_meditacao/modules/common/shared/strings/localization/common_strings.dart';
import 'package:cinco_minutos_meditacao/shared/Theme/app_colors.dart';
import 'package:cinco_minutos_meditacao/shared/helpers/app_images.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class Meditate extends StatelessWidget {
  /// Título do componente
  final String title;

  /// - [title] Título do componente
  /// construtor
  const Meditate({
    super.key,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 150,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
      ),
      padding: const EdgeInsets.all(15),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w700,
              color: AppColors.dimGray,
            ),
          ),
          const SizedBox(height: 11),
          SvgPicture.asset(AppImages.line),
          const SizedBox(height: 30),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                CommonStrings.of(context).fiveMinutes,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w800,
                  color: AppColors.philippineGray,
                ),
              ),
              const SizedBox(width: 50),
              Container(
                width: 29,
                height: 29,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(50),
                  border: Border.all(
                    color: AppColors.blueMana,
                    width: 1,
                  ),
                ),
                child: const Icon(
                  Icons.play_arrow,
                  color: AppColors.blueMana,
                  size: 20,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

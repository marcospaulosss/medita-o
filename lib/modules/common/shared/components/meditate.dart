import 'package:cinco_minutos_meditacao/modules/common/shared/strings/localization/common_strings.dart';
import 'package:cinco_minutos_meditacao/shared/Theme/app_colors.dart';
import 'package:cinco_minutos_meditacao/shared/Theme/app_images.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class Meditate extends StatelessWidget {
  /// Título do componente
  final String title;

  /// Ação ao clicar no componente
  final Function onTap;

  /// - [title] Título do componente
  /// - [onTap] Ação ao clicar no componente
  /// construtor
  const Meditate({
    super.key,
    required this.title,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => onTap(),
      child: Container(
        height: 150,
        width: 151,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
        ),
        padding: const EdgeInsets.all(15),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Flexible(
              child: Text(
                title,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                  color: AppColors.dimGray,
                ),
              ),
            ),
            const SizedBox(height: 11),
            SvgPicture.asset(AppImages.line),
            const SizedBox(height: 30),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Flexible(
                  child: Text(
                    CommonStrings.of(context).fiveMinutes,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w800,
                      color: AppColors.philippineGray,
                    ),
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
      ),
    );
  }
}

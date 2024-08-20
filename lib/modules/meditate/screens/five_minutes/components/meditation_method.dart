import 'package:cinco_minutos_meditacao/shared/Theme/app_colors.dart';
import 'package:cinco_minutos_meditacao/shared/components/icon_label_button.dart';
import 'package:flutter/material.dart';

/// Tipos de botão
enum MeditationMethodButtonType { blue, white }

class MeditationMethodButtonCustom {
  /// Função de clique
  final Function onTap;

  /// Tipo do botão
  final String label;

  /// Ícone do botão
  final IconData icon;

  /// Tipo do botão
  final MeditationMethodButtonType? type;

  /// - [onTap] Função de clique
  /// - [label] Tipo do botão
  /// - [icon] Ícone do botão
  /// - [type] Tipo do botão
  /// Construtor
  const MeditationMethodButtonCustom({
    required this.onTap,
    required this.label,
    required this.icon,
    this.type = MeditationMethodButtonType.blue,
  });
}

class MeditationMethod extends StatelessWidget {
  /// Primeiro botão com icone e label
  MeditationMethodButtonCustom? iconButton1;

  /// Segundo botão com icone e label
  MeditationMethodButtonCustom? iconButton2;

  /// espaço no topo
  final double spaceTop;

  /// título
  final String title;

  /// - [iconButton1] Primeiro botão com icone e label
  /// - [iconButton2] Segundo botão com icone e label
  /// - [spaceTop] espaço no topo
  /// - [title] título
  /// construtor
  MeditationMethod({
    super.key,
    this.iconButton1,
    this.iconButton2,
    this.spaceTop = 0,
    this.title = "",
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: Colors.white,
      ),
      child: Padding(
        padding:
            EdgeInsets.only(left: 22, top: spaceTop, right: 22, bottom: 29),
        child: Column(
          children: [
            Text(
              title,
              style: const TextStyle(
                fontSize: 52,
                fontWeight: FontWeight.w400,
                fontFamily: "Blanch",
                color: AppColors.germanderSpeedwell,
              ),
            ),
            const SizedBox(height: 11),
            if (iconButton1 != null)
              iconButton1?.type == MeditationMethodButtonType.blue
                  ? buildIconLabelButtonDefault1(
                      iconButton1!.onTap,
                      iconButton1!.label,
                      iconButton1!.icon,
                    )
                  : buildIconLabelButtonDefault2(
                      iconButton1!.onTap,
                      iconButton1!.label,
                      iconButton1!.icon,
                    ),
            const SizedBox(height: 11),
            if (iconButton2 != null)
              iconButton2?.type == MeditationMethodButtonType.blue
                  ? buildIconLabelButtonDefault1(
                      iconButton2!.onTap,
                      iconButton2!.label,
                      iconButton2!.icon,
                    )
                  : buildIconLabelButtonDefault2(
                      iconButton2!.onTap,
                      iconButton2!.label,
                      iconButton2!.icon,
                    ),
          ],
        ),
      ),
    );
  }

  IconLabelButton buildIconLabelButtonDefault2(
      Function onTap, String label, IconData icon) {
    return IconLabelButton(
      onTap: () => onTap(),
      width: double.infinity,
      height: 43,
      decoration: BoxDecoration(
        border: Border.all(
          color: AppColors.germanderSpeedwell,
          width: 1,
        ),
        borderRadius: BorderRadius.circular(12),
        color: AppColors.white,
      ),
      label: Text(
        label,
        style: const TextStyle(
          fontSize: 15,
          fontWeight: FontWeight.w400,
          color: AppColors.germanderSpeedwell,
        ),
      ),
      icon: Icon(
        icon,
        color: AppColors.germanderSpeedwell,
        size: 25,
      ),
      spaceBetween: 7,
    );
  }

  IconLabelButton buildIconLabelButtonDefault1(
      Function onTap, String label, IconData icon) {
    return IconLabelButton(
      onTap: () => onTap(),
      width: double.infinity,
      height: 43,
      decoration: BoxDecoration(
        border: Border.all(
          color: AppColors.germanderSpeedwell,
          width: 1,
        ),
        borderRadius: BorderRadius.circular(12),
        color: AppColors.germanderSpeedwell,
      ),
      label: Text(
        label,
        style: const TextStyle(
          fontSize: 15,
          fontWeight: FontWeight.w400,
          color: AppColors.brilliance2,
        ),
      ),
      icon: Icon(
        icon,
        color: AppColors.brilliance2,
        size: 25,
      ),
      spaceBetween: 7,
    );
  }
}

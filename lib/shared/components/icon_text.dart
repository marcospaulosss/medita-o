import 'package:cinco_minutos_meditacao/shared/Theme/app_colors.dart';
import 'package:flutter/material.dart';

class IconText extends StatelessWidget {
  /// icone
  final Icon icon;

  /// função a ser executada ao clicar no icone
  final Function onTap;

  /// estilo do container
  final BoxDecoration? containerDecoration;

  /// tamanho do container
  final double? containerSize;

  /// espaçamento entre o icone e o texto
  final double? spacing;

  /// texto
  final Text? text;

  /// - [key] : chave do widget
  /// - [icon] : icone
  /// - [onTap] : função a ser executada ao clicar no icone
  /// - [containerDecoration] : estilo do container
  /// - [containerSize] : tamanho do container
  /// - [spacing] : espaçamento entre o icone e o texto\
  /// - [text] : texto
  const IconText({
    super.key,
    required this.icon,
    required this.onTap,
    this.containerDecoration,
    this.containerSize = 30,
    this.spacing = 8,
    this.text,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        GestureDetector(
          onTap: () => onTap(),
          child: Container(
            width: containerSize,
            height: containerSize,
            decoration: containerDecoration ?? buildBoxDecorationDefault,
            child: icon,
          ),
        ),
        SizedBox(width: spacing),
        if (text != null) text!,
      ],
    );
  }

  BoxDecoration get buildBoxDecorationDefault {
    return BoxDecoration(
      border: Border.all(
        color: AppColors.frankBlue,
      ),
      borderRadius: BorderRadius.circular(4),
    );
  }
}

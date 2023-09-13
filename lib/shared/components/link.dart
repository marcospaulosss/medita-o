import 'package:cinco_minutos_meditacao/shared/Theme/app_colors.dart';
import 'package:flutter/material.dart';

class Link extends StatelessWidget {
  /// função a ser executada ao clicar no link
  final Function onTap;

  /// texto
  final String text;

  /// cor do sublinhado
  final Color? underlineColor;

  /// estilo do texto
  final TextStyle? style;

  /// - [key] : chave do widget
  /// - [onTap] : função a ser executada ao clicar no link
  /// - [text] : texto
  /// - [underlineColor] : cor do sublinhado
  /// - [style] : estilo do texto
  const Link({
    super.key,
    required this.onTap,
    required this.text,
    this.underlineColor,
    this.style,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => onTap(),
      child: Text(
        text,
        style: style ?? buildTextStyleDefault,
      ),
    );
  }

  TextStyle get buildTextStyleDefault {
    return TextStyle(
      shadows: [
        Shadow(
            color: underlineColor ?? AppColors.steelWoolColor,
            offset: const Offset(0, -2))
      ],
      color: Colors.transparent,
      decoration: TextDecoration.underline,
      decorationColor: AppColors.steelWoolColor,
      decorationThickness: 1,
      decorationStyle: TextDecorationStyle.dashed,
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

/// Posição do ícone em relação ao texto.
enum Position {
  right,
  left,
}

/// Botão com ícone e texto.
class IconLabelButton extends StatelessWidget {
  /// função de callback para quando o botão for pressionado.
  final Function onTap;

  /// largura do botão.
  final double width;

  /// altura do botão.
  final double height;

  /// decoração do botão.
  final Decoration? decoration;

  /// ícone do botão.
  final Icon? icon;

  /// imagem do botão.
  final SvgPicture? image;

  /// texto do botão.
  final Text? label;

  /// posição do ícone em relação ao texto.
  final Position? position;

  /// espaço entre o ícone e o texto.
  final double? spaceBetween;

  /// - [key] - chave de identificação do widget.
  /// - [onTap] - função de callback para quando o botão for pressionado.
  /// - [width] - largura do botão.
  /// - [height] - altura do botão.
  /// - [decoration] - decoração do botão.
  /// - [icon] - ícone do botão.
  /// - [image] - imagem do botão.
  /// - [label] - texto do botão.
  /// - [position] - posição do ícone em relação ao texto.
  /// - [spaceBetween] - espaço entre o ícone e o texto.
  const IconLabelButton({
    super.key,
    required this.onTap,
    required this.width,
    required this.height,
    this.decoration,
    this.icon,
    this.image,
    this.label,
    this.spaceBetween = 22,
    this.position = Position.left,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => onTap(),
      child: Container(
        width: width,
        height: height,
        alignment: Alignment.center,
        decoration: decoration ?? buildBoxDecoration,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (widgetPicture != null)
              (position == Position.left) ? widgetPicture! : label!,
            if (label != null && widgetPicture != null)
              SizedBox(width: spaceBetween),
            if (label != null)
              (position == Position.left) ? label! : widgetPicture!,
          ],
        ),
      ),
    );
  }

  /// Retorna o widget de imagem ou ícone.
  get widgetPicture {
    if (icon != null) {
      return icon;
    } else if (image != null) {
      return image;
    }

    return null;
  }

  /// Retorna a decoração padrão do botão.
  BoxDecoration get buildBoxDecoration {
    return BoxDecoration(
      border: Border.all(
        color: const Color(0xff2B448C),
        width: 1,
      ),
      borderRadius: BorderRadius.circular(12),
    );
  }
}

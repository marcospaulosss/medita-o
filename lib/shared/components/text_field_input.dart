import 'package:cinco_minutos_meditacao/shared/Theme/app_colors.dart';
import 'package:flutter/material.dart';

class TextFieldInput extends StatelessWidget {
  /// Autofocus do campo de texto
  final bool? autofocus;

  /// Borda do campo de texto
  final OutlineInputBorder? border;

  /// Cor de fundo do campo de texto
  final Color? backgroundColor;

  /// tamanho do input
  final EdgeInsets? contentPadding;

  /// Controlador do campo de texto
  final TextEditingController? controller;

  /// FocusNode do campo de texto
  final FocusNode? focusNode;

  /// Texto de dica do campo de texto
  final String hintText;

  /// Estilo do texto de dica do campo de texto
  final TextStyle? hintStyle;

  /// Tipo de teclado do campo de texto
  final TextInputType? keyboardType;

  /// Label do campo de texto
  final String label;

  /// Estilo do label
  final TextStyle? labelStyle;

  /// Se o campo de texto é obscuro
  final bool? obscureText;

  /// Icone do prefixo do campo de texto
  final Icon? prefixIcon;

  /// Icone do suffix do campo de texto
  final IconButton? suffixIcon;

  /// Estilo do texto
  final TextStyle? style;

  /// Validação do campo de texto
  final String? Function(String?)? validator;

  /// - [key] - Chave de identificação do widget
  /// - [autofocus] - Autofocus do campo de texto
  /// - [border] - Borda do campo de texto
  /// - [backgroundColor] - Cor de fundo do campo de texto
  /// - [contentPadding] - tamanho do input
  /// - [controller] - Controlador do campo de texto
  /// - [focusNode] - FocusNode do campo de texto
  /// - [hintText] - Texto de dica do campo de texto
  /// - [hintStyle] - Estilo do texto de dica do campo de texto
  /// - [keyboardType] - Tipo de teclado do campo de texto
  /// - [label] - Label do campo de texto
  /// - [labelStyle] - Estilo do label
  /// - [obscureText] - Se o campo de texto é obscuro
  /// - [prefixIcon] - Icone do prefixo do campo de texto
  /// - [suffixIcon] - Icone do suffix do campo de texto
  /// - [style] - Estilo do texto
  /// - [validator] - Validação do campo de texto
  const TextFieldInput({
    super.key,
    this.autofocus,
    this.border,
    this.backgroundColor,
    this.contentPadding,
    required this.controller,
    this.focusNode,
    required this.hintText,
    this.hintStyle,
    this.keyboardType,
    required this.label,
    this.labelStyle,
    this.obscureText,
    this.prefixIcon,
    this.suffixIcon,
    this.style,
    this.validator,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: labelStyle ?? buildTextStyleLabel,
        ),
        const SizedBox(height: 5),
        TextFormField(
          controller: controller,
          focusNode: focusNode,
          autofocus: autofocus ?? false,
          decoration: InputDecoration(
            hintText: hintText,
            hintStyle: hintStyle ?? buildHintTextStyle,
            border: border ?? buildOutlineInputBorder,
            contentPadding:
                contentPadding ?? const EdgeInsets.symmetric(vertical: 12.0),
            enabledBorder: border ?? buildOutlineInputBorder,
            focusedBorder: border ?? buildOutlineInputBorder,
            filled: true,
            fillColor: backgroundColor ?? AppColors.brilliance,
            prefixIcon: prefixIcon,
            suffixIcon: suffixIcon,
          ),
          keyboardType: keyboardType ?? TextInputType.name,
          obscureText: obscureText ?? false,
          style: style ?? buildHintTextStyle.copyWith(color: AppColors.black54),
          validator: validator,
        ),
      ],
    );
  }

  OutlineInputBorder get buildOutlineInputBorder {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(12),
      borderSide: const BorderSide(
        color: AppColors.brilliance,
      ),
    );
  }

  TextStyle get buildHintTextStyle {
    return const TextStyle(
      fontSize: 16,
      fontWeight: FontWeight.w400,
      color: AppColors.brainstemGrey,
    );
  }

  TextStyle get buildTextStyleLabel {
    return const TextStyle(
      fontSize: 18,
      fontWeight: FontWeight.w400,
      color: AppColors.frankBlue,
    );
  }
}

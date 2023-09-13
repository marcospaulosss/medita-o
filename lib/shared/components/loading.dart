import 'package:flutter/material.dart';

/// Este arquivo importa os pacotes necessários e define um widget [NewLoadingContainer].
///
/// O widget [NewLoadingContainer] exibe uma animação de carregamento e um texto descritivo.
/// É usado para indicar que o aplicativo está carregando dados no momento.
///
/// O widget recebe um parâmetro [descrição], que é o texto a ser exibido abaixo da animação de carregamento.
/// Se nenhuma [descrição] for fornecida, o texto padrão "Carregando..." é usado.
///
/// O widget é construído usando um [Scaffold] com um widget [Center] como seu corpo.
/// O widget [Center] contém um widget [Column] com dois filhos:
/// um widget [ElevatedImageContainer] exibindo a animação de carregamento e um widget [Texto] exibindo a [descrição].
///
/// O widget [ElevatedImageContainer] recebe um parâmetro [image], que é o caminho para a imagem de animação de carregamento.
///
/// O widget [Text] tem um [fontSize], [fontWeight] e [textColor] fixos.
/// Se o texto [descrição] for muito longo para caber no espaço disponível, ele será truncado com reticências.
///

// ignore: must_be_immutable
class Loading extends StatelessWidget {
  /// Descrição do carregamento.
  final String description;

  /// - [description] Descrição do carregamento.

  /// Construtor.
  const Loading({
    this.description = "Carregando...",
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    const String loadingImage = "assets/images/gifs/circles_menu.gif";
    const double fontSize = 20.0;
    const FontWeight fontWeight = FontWeight.w500;
    const Color textColor = Colors.black;

    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              loadingImage,
              width: 50,
              height: 50,
            ),
            const SizedBox(height: 16),
            Text(
              description,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                  fontSize: fontSize, fontWeight: fontWeight, color: textColor),
            ),
          ],
        ),
      ),
    );
  }
}

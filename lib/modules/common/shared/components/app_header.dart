import 'package:cinco_minutos_meditacao/shared/Theme/app_colors.dart';
import 'package:flutter/material.dart';

class AppHeader extends StatelessWidget {
  /// Nome do usuário
  final String nameUser;

  /// frases que formam a descrição
  final String description1;
  final String description2;
  final String description3;

  /// - [nameUser] Nome do usuário
  /// - [description] frase de descrição
  /// construtor
  const AppHeader({
    super.key,
    this.nameUser = "",
    this.description1 = "",
    this.description2 = "",
    this.description3 = "",
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          height: 131,
          width: double.infinity,
          padding: const EdgeInsets.symmetric(horizontal: 39),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 78.0, top: 30),
                child: Text(
                  "Olá, $nameUser!",
                  style: const TextStyle(
                    fontSize: 23,
                    color: AppColors.white,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
              buildContainerDescription(),
            ],
          ),
        ),
        buildPositionedPhoto(),
        buildPositionedLogo(),
      ],
    );
  }

  /// widiget responsável pela apresentação e posição do logo
  Positioned buildPositionedLogo() {
    return Positioned(
      top: 20,
      right: 30,
      child: Image.asset(
        "assets/images/balão-5min 1.png",
        width: 60,
        height: 87,
      ),
    );
  }

  /// widiget responsável pela apresentação e posição da foto
  Positioned buildPositionedPhoto() {
    return Positioned(
      top: 20,
      left: 30,
      child: Container(
        width: 78,
        height: 78,
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.circular(50),
        ),
        child: const Icon(
          Icons.add,
          color: AppColors.blueNCS,
          size: 30,
        ),
      ),
    );
  }

  /// widiget responsável pela apresentação e posição da descrição
  Container buildContainerDescription() {
    return Container(
      height: 57,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(22),
        color: AppColors.white,
      ),
      child: Container(
        padding: const EdgeInsets.only(left: 50),
        width: 260,
        child: RichText(
          text: TextSpan(
            text: description1,
            style: buildTextStyleDefault(),
            children: [
              TextSpan(
                text: description2,
                style: buildTextStyleDefault()
                    .copyWith(fontWeight: FontWeight.w700),
              ),
              TextSpan(
                text: description3,
                style: buildTextStyleDefault(),
              ),
            ],
          ),
        ),
      ),
    );
  }

  /// estilo de texto padrão
  TextStyle buildTextStyleDefault() {
    return const TextStyle(
      fontSize: 16,
      color: AppColors.steelWoolColor,
      fontWeight: FontWeight.w400,
    );
  }
}

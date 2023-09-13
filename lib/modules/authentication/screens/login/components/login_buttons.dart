import 'package:cinco_minutos_meditacao/modules/authentication/shared/strings/localization/authentication_strings.dart';
import 'package:cinco_minutos_meditacao/shared/Theme/app_colors.dart';
import 'package:cinco_minutos_meditacao/shared/components/icon_label_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class LoginButtons extends StatelessWidget {
  /// função a ser executada ao clicar no botão de login com o Google
  final Function requestLoginGoogle;

  /// - [key] : chave do widget
  /// - [requestLoginGoogle] : função a ser executada ao clicar no botão de login com o Google
  const LoginButtons({super.key, required this.requestLoginGoogle});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        IconLabelButton(
          onTap: requestLoginGoogle,
          width: 350,
          height: 55,
          image: SvgPicture.asset(
            'assets/images/icons/google_logo.svg',
            height: 30,
          ),
          label: Text(
            AuthenticationStrings.of(context).yourGoogleAccount,
            style: buildTextStyleDefault,
          ),
        ),
        const SizedBox(height: 6.42),
        IconLabelButton(
          onTap: () => print("Meditar sem login"),
          width: 350,
          height: 55,
          decoration: BoxDecoration(
            border: Border.all(
              color: AppColors.frankBlue,
              width: 1,
            ),
            borderRadius: BorderRadius.circular(12),
            color: AppColors.frankBlue,
          ),
          label: Text(
            AuthenticationStrings.of(context).meditateWithoutLogin,
            style: const TextStyle(
              fontSize: 19,
              fontWeight: FontWeight.w700,
              color: AppColors.brilliance2,
            ),
          ),
        ),
        const SizedBox(height: 27),
        GestureDetector(
          onTap: () {},
          child: RichText(
            text: TextSpan(
              text: AuthenticationStrings.of(context).createOne,
              style: buildTextStyleDefault,
              children: [
                TextSpan(
                  text: AuthenticationStrings.of(context).account,
                  style: buildTextStyleDefault.copyWith(
                    fontWeight: FontWeight.w700,
                    decoration: TextDecoration.underline,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  TextStyle get buildTextStyleDefault {
    return const TextStyle(
      fontSize: 16,
      fontWeight: FontWeight.w400,
      color: AppColors.frankBlue,
    );
  }
}

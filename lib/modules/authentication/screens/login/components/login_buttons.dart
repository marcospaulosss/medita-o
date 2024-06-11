import 'package:cinco_minutos_meditacao/modules/authentication/shared/strings/localization/authentication_strings.dart';
import 'package:cinco_minutos_meditacao/shared/Theme/app_colors.dart';
import 'package:cinco_minutos_meditacao/shared/components/icon_label_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class LoginButtons extends StatelessWidget {
  /// função a ser executada ao clicar no botão de login com o Google
  final Function requestLoginGoogle;

  /// função a ser executada ao clicar no botão de login com o Facebook
  final Function requestLoginFacebook;

  /// - [key] : chave do widget
  /// - [requestLoginGoogle] : função a ser executada ao clicar no botão de login com o Google
  /// - [requestLoginFacebook] : função a ser executada ao clicar no botão de login com o Facebook
  const LoginButtons({
    super.key,
    required this.requestLoginGoogle,
    required this.requestLoginFacebook,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        IconLabelButton(
          onTap: requestLoginGoogle,
          width: double.infinity,
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
          onTap: requestLoginFacebook,
          width: double.infinity,
          height: 55,
          image: SvgPicture.asset(
            'assets/images/icons/facebook_logo.svg',
            height: 30,
          ),
          label: Text(
            AuthenticationStrings.of(context).yourFacebookAccount,
            style: buildTextStyleDefault,
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

import 'package:cinco_minutos_meditacao/modules/authentication/shared/strings/localization/authentication_strings.dart';
import 'package:cinco_minutos_meditacao/shared/Theme/app_colors.dart';
import 'package:cinco_minutos_meditacao/shared/components/icon_label_button.dart';
import 'package:cinco_minutos_meditacao/shared/components/icon_text.dart';
import 'package:cinco_minutos_meditacao/shared/components/link.dart';
import 'package:flutter/material.dart';

class QuestionsLogin extends StatefulWidget {
  const QuestionsLogin({super.key});

  @override
  State<QuestionsLogin> createState() => _QuestionsLoginState();
}

class _QuestionsLoginState extends State<QuestionsLogin> {
  /// Se o usuário quer lembrar a senha
  bool rememberPassword = true;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 14, right: 14, bottom: 27),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              IconText(
                icon: Icon(
                  Icons.check,
                  size: 28,
                  color: rememberPassword
                      ? AppColors.frankBlue
                      : Colors.transparent,
                  opticalSize: 1,
                ),
                onTap: () {
                  print("Lembrar Senha");
                  setState(() {
                    rememberPassword = !rememberPassword;
                  });
                },
                text: Text(
                  AuthenticationStrings.of(context).rememberPassword,
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                    color: AppColors.frankBlue,
                  ),
                ),
              ),
              Link(
                onTap: () => print("Esqueci minha senha"),
                text: AuthenticationStrings.of(context).forgotPassword,
              ),
            ],
          ),
        ),
        IconLabelButton(
          onTap: () => print("Login normal"),
          width: double.infinity,
          height: 55,
          decoration: BoxDecoration(
            border: Border.all(
              color: AppColors.blueMana,
              width: 1,
            ),
            borderRadius: BorderRadius.circular(12),
            color: AppColors.blueMana,
          ),
          label: Text(
            AuthenticationStrings.of(context).signIn,
            style: const TextStyle(
              fontSize: 19,
              fontWeight: FontWeight.w700,
              color: AppColors.brilliance2,
            ),
          ),
        ),
        const SizedBox(height: 10),
        GestureDetector(
          onTap: () => print("Criar conta"),
          child: RichText(
            text: TextSpan(
              text: AuthenticationStrings.of(context).createOne,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w400,
                color: AppColors.frankBlue,
              ),
              children: [
                TextSpan(
                  text: AuthenticationStrings.of(context).account,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                    color: AppColors.frankBlue,
                    decoration: TextDecoration.underline,
                  ),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 57.65),
      ],
    );
  }
}

import 'package:cinco_minutos_meditacao/modules/authentication/shared/strings/localization/authentication_strings.dart';
import 'package:cinco_minutos_meditacao/shared/Theme/app_colors.dart';
import 'package:cinco_minutos_meditacao/shared/components/text_field_input.dart';
import 'package:flutter/material.dart';

class FormLogin extends StatefulWidget {
  const FormLogin({super.key});

  @override
  State<FormLogin> createState() => _FormLoginState();
}

class _FormLoginState extends State<FormLogin> {
  /// Controlador do campo de texto de e-mail
  final TextEditingController emailController = TextEditingController();

  /// Controlador do campo de texto de senha
  final TextEditingController passwordController = TextEditingController();

  /// Se a senha está oculta
  bool obscurePasswordText = true;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 31, bottom: 18),
      child: Column(
        children: [
          TextFieldInput(
            hintText: AuthenticationStrings.of(context).exampleEmail,
            controller: emailController,
            keyboardType: TextInputType.emailAddress,
            label: AuthenticationStrings.of(context).email,
            prefixIcon: const Icon(
              Icons.email_outlined,
              color: AppColors.brainstemGrey,
              size: 16,
            ),
          ),
          const SizedBox(height: 9),
          TextFieldInput(
            hintText: AuthenticationStrings.of(context).obscurePassword,
            controller: passwordController,
            obscureText: obscurePasswordText,
            keyboardType: TextInputType.none,
            label: AuthenticationStrings.of(context).password,
            prefixIcon: const Icon(
              Icons.lock_open_outlined,
              color: AppColors.brainstemGrey,
              size: 16,
            ),
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w400,
              color: AppColors.brainstemGrey,
            ),
            suffixIcon: IconButton(
              onPressed: () => setState(() {
                obscurePasswordText = !obscurePasswordText;
              }),
              icon: Icon(
                (obscurePasswordText)
                    ? Icons.visibility_outlined
                    : Icons.visibility_off_outlined,
                color: AppColors.frankBlue,
                size: 20,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

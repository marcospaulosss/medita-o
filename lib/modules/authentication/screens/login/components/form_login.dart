import 'package:cinco_minutos_meditacao/modules/authentication/shared/helpers/validators.dart';
import 'package:cinco_minutos_meditacao/modules/authentication/shared/strings/localization/authentication_strings.dart';
import 'package:cinco_minutos_meditacao/shared/Theme/app_colors.dart';
import 'package:cinco_minutos_meditacao/shared/components/icon_label_button.dart';
import 'package:cinco_minutos_meditacao/shared/components/icon_text.dart';
import 'package:cinco_minutos_meditacao/shared/components/link.dart';
import 'package:cinco_minutos_meditacao/shared/components/text_field_input.dart';
import 'package:flutter/material.dart';

/// Formulário de login
class FormLogin extends StatefulWidget {
  /// Mensagem de erro de e-mail inválido
  bool errorEmailInvalid = false;

  /// Função que será chamada ao esquecer a senha
  final Function forgotPassword;

  /// Função que será chamada ao realizar o login
  final Function onLogin;

  /// Função que será chamada ao realizar o registro
  final Function onRegister;

  /// - [key] : Chave de identificação do widget
  /// - [errorEmailInvalid] : Mensagem de erro de e-mail inválido
  /// - [forgotPassword] : Função que será chamada ao esquecer a senha
  /// - [onLogin] : Função que será chamada ao realizar o login
  /// - [onRegister] : Função que será chamada ao realizar o registro
  /// construtor
  FormLogin({
    super.key,
    required this.errorEmailInvalid,
    required this.forgotPassword,
    required this.onLogin,
    required this.onRegister,
  });

  @override
  State<FormLogin> createState() => _FormLoginState();
}

class _FormLoginState extends State<FormLogin> {
  /// Chave do formulário
  final _formKeyLogin = GlobalKey<FormState>();

  /// Controlador do campo de texto de e-mail
  final TextEditingController emailController = TextEditingController();

  /// Controlador do campo de texto de senha
  final TextEditingController passwordController = TextEditingController();

  /// Se a senha está oculta
  bool obscurePasswordText = true;

  /// Se o usuário quer lembrar a senha
  bool rememberPassword = true;

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
    return Form(
      key: _formKeyLogin,
      child: Padding(
        padding: const EdgeInsets.only(top: 31, bottom: 18),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
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
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: const BorderSide(
                  color: AppColors.brainstemGrey,
                  width: 1,
                ),
              ),
              validator: (value) => Validators.email(context, value),
            ),
            const SizedBox(height: 9),
            TextFieldInput(
              hintText: AuthenticationStrings.of(context).obscurePassword,
              controller: passwordController,
              obscureText: obscurePasswordText,
              keyboardType: TextInputType.text,
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
            const SizedBox(height: 20),
            buildQuestionsLogin(),
          ],
        ),
      ),
    );
  }

  Column buildQuestionsLogin() {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 14, right: 14, bottom: 20),
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
              const SizedBox(width: 10),
              Flexible(
                child: Link(
                  onTap: () => widget.forgotPassword(),
                  text: AuthenticationStrings.of(context).forgotPassword,
                ),
              ),
            ],
          ),
        ),
        IconLabelButton(
          onTap: () {
            if (_formKeyLogin.currentState!.validate()) {
              widget.onLogin(emailController.text, passwordController.text);
            }
          },
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
          onTap: () => widget.onRegister(),
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
        const SizedBox(height: 30),
      ],
    );
  }
}

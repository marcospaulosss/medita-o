import 'package:cinco_minutos_meditacao/modules/authentication/shared/helpers/validators.dart';
import 'package:cinco_minutos_meditacao/modules/authentication/shared/strings/localization/authentication_strings.dart';
import 'package:cinco_minutos_meditacao/shared/Theme/app_colors.dart';
import 'package:cinco_minutos_meditacao/shared/components/icon_label_button.dart';
import 'package:cinco_minutos_meditacao/shared/components/icon_text.dart';
import 'package:cinco_minutos_meditacao/shared/components/text_field_input.dart';
import 'package:flutter/material.dart';

class FormRegister extends StatefulWidget {
  /// Função de registro
  Function onRegister;

  /// - [key] : Chave de identificação do widget
  /// - [onRegister] : Mensagem de erro de e-mail inválido
  /// construtor
  FormRegister({super.key, required this.onRegister});

  @override
  State<FormRegister> createState() => _FormRegisterState();
}

class _FormRegisterState extends State<FormRegister> {
  /// Chave do formulário
  final _formKey = GlobalKey<FormState>();

  /// Controlador do campo de texto de e-mail
  final TextEditingController emailController = TextEditingController();

  /// Controlador do campo de texto de nome
  final TextEditingController nameController = TextEditingController();

  /// Controlador do campo de texto de senha
  final TextEditingController passwordController = TextEditingController();

  /// Controlador do campo de texto de repetir senha
  final TextEditingController repeatPasswordController =
      TextEditingController();

  /// Se a senha está oculta
  bool obscurePasswordText = true;

  /// Se a senha está oculta
  bool obscureRepeatPasswordText = true;

  /// Se o usuário quer lembrar a senha
  bool rememberPassword = true;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    emailController.dispose();
    nameController.dispose();
    passwordController.dispose();
    repeatPasswordController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Padding(
        padding: const EdgeInsets.only(top: 21, bottom: 18),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextFieldInput(
              hintText: AuthenticationStrings.of(context).name,
              controller: nameController,
              keyboardType: TextInputType.text,
              label: AuthenticationStrings.of(context).name,
              contentPadding: const EdgeInsets.only(left: 10, right: 10),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: const BorderSide(
                  color: AppColors.brainstemGrey,
                  width: 1,
                ),
              ),
              validator: (value) => Validators.required(context, value),
            ),
            const SizedBox(height: 9),
            TextFieldInput(
              hintText: AuthenticationStrings.of(context).exampleEmail,
              controller: emailController,
              keyboardType: TextInputType.emailAddress,
              label: AuthenticationStrings.of(context).email,
              contentPadding: const EdgeInsets.only(left: 10, right: 10),
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
              contentPadding: const EdgeInsets.only(left: 10, right: 10),
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
              validator: (value) => Validators.required(context, value),
            ),
            const SizedBox(height: 9),
            TextFieldInput(
              hintText: AuthenticationStrings.of(context).obscurePassword,
              controller: repeatPasswordController,
              obscureText: obscureRepeatPasswordText,
              keyboardType: TextInputType.text,
              label: AuthenticationStrings.of(context).confirmPassword,
              contentPadding: const EdgeInsets.only(left: 10, right: 10),
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w400,
                color: AppColors.brainstemGrey,
              ),
              suffixIcon: IconButton(
                onPressed: () => setState(() {
                  obscureRepeatPasswordText = !obscureRepeatPasswordText;
                }),
                icon: Icon(
                  (obscureRepeatPasswordText)
                      ? Icons.visibility_outlined
                      : Icons.visibility_off_outlined,
                  color: AppColors.frankBlue,
                  size: 20,
                ),
              ),
              validator: (value) => Validators.repeatPassword(
                  context, value, passwordController.text),
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
            ],
          ),
        ),
        IconLabelButton(
          onTap: () {
            if (_formKey.currentState!.validate()) {
              widget.onRegister(
                nameController.text,
                emailController.text,
                passwordController.text,
              );
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
            AuthenticationStrings.of(context).createAccount,
            style: const TextStyle(
              fontSize: 19,
              fontWeight: FontWeight.w700,
              color: AppColors.brilliance2,
            ),
          ),
        ),
        const SizedBox(height: 30),
      ],
    );
  }
}

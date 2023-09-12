import 'package:auto_route/annotations.dart';
import 'package:cinco_minutos_meditacao/core/di/helpers.dart';
import 'package:cinco_minutos_meditacao/modules/authentication/screens/login/login_contracts.dart';
import 'package:cinco_minutos_meditacao/modules/authentication/screens/login/login_presenter.dart';
import 'package:cinco_minutos_meditacao/modules/authentication/shared/strings/localization/authentication_strings.dart';
import 'package:cinco_minutos_meditacao/shared/Theme/app_colors.dart';
import 'package:cinco_minutos_meditacao/shared/components/background_default.dart';
import 'package:cinco_minutos_meditacao/shared/components/generic_error_container.dart';
import 'package:cinco_minutos_meditacao/shared/components/icon_label_button.dart';
import 'package:cinco_minutos_meditacao/shared/components/icon_text.dart';
import 'package:cinco_minutos_meditacao/shared/components/link.dart';
import 'package:cinco_minutos_meditacao/shared/components/loading.dart';
import 'package:cinco_minutos_meditacao/shared/components/text_field_input.dart';
import 'package:cinco_minutos_meditacao/shared/helpers/multi_state_container/container.dart';
import 'package:cinco_minutos_meditacao/shared/helpers/multi_state_container/controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

/// Tela responsável pelo login do usuário
/// utilizando o Google
@RoutePage()
class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  /// Presenter da tela de login
  Presenter presenter = resolve<LoginPresenter>();

  /// Controlador do estado da tela
  final stateController = MultiStateContainerController();

  /// Controlador do campo de texto de e-mail
  final TextEditingController emailController = TextEditingController();

  /// Controlador do campo de texto de senha
  final TextEditingController passwordController = TextEditingController();

  /// Se a senha está oculta
  bool obscurePasswordText = true;

  @override
  void initState() {
    stateController.showNormalState();

    presenter.onOpenScreen();

    super.initState();
  }

  @override
  void dispose() {
    stateController.dispose();

    emailController.dispose();
    passwordController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MultiStateContainer(
      controller: stateController,
      normalStateBuilder: (context) => buildScaffold(),
      loadingStateBuilder: (context) => const Loading(),
      errorStateBuilder: (context) => GenericErrorContainer(
        onRetry: () => requestLoginGoogle,
      ),
    );
  }

  Scaffold buildScaffold() {
    return Scaffold(
      body: BackgroundDefault(
        child: SafeArea(
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 40),
            child: Column(
              children: [
                Image.asset("assets/images/balão-5min 1.png",
                    height: 241, width: 166),
                const SizedBox(height: 31),
                TextFieldInput(
                  hintText: 'exemplo@email.com',
                  controller: emailController,
                  keyboardType: TextInputType.emailAddress,
                  label: "E-mail",
                  prefixIcon: const Icon(
                    Icons.email_outlined,
                    color: AppColors.brainstemGrey,
                    size: 16,
                  ),
                ),
                const SizedBox(height: 9),
                TextFieldInput(
                  hintText: '***********',
                  controller: passwordController,
                  obscureText: obscurePasswordText,
                  keyboardType: TextInputType.none,
                  label: "Senha",
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
                          ? Icons.visibility_off_outlined
                          : Icons.visibility_outlined,
                      color: AppColors.frankBlue,
                      size: 20,
                    ),
                  ),
                ),
                const SizedBox(height: 18),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 14),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      IconText(
                        icon: const Icon(
                          Icons.check,
                          size: 28,
                          color: AppColors.frankBlue,
                          opticalSize: 1,
                        ),
                        onTap: () => print("Lembrar Senha"),
                        text: const Text(
                          "Lembrar Senha",
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                            color: AppColors.frankBlue,
                          ),
                        ),
                      ),
                      Link(
                        onTap: () => print("Esqueci minha senha"),
                        text: "Esqueci minha senha",
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 27),
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
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w400,
                      color: Color(0xff2B448C),
                      fontFamily: 'Apertura',
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  /// Solicita o login utilizando o Google
  void requestLoginGoogle() async {
    stateController.showLoadingState();
    var (_, error) = await presenter.loginGoogle();
    if (error != null) {
      stateController.showErrorState();
      return;
    }
    stateController.showNormalState();

    presenter.goToHome();
  }
}

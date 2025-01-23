import 'package:auto_route/annotations.dart';
import 'package:cinco_minutos_meditacao/core/di/helpers.dart';
import 'package:cinco_minutos_meditacao/modules/authentication/screens/login/components/divider_buttons.dart';
import 'package:cinco_minutos_meditacao/modules/authentication/screens/login/components/form_login.dart';
import 'package:cinco_minutos_meditacao/modules/authentication/screens/login/components/login_buttons.dart';
import 'package:cinco_minutos_meditacao/modules/authentication/screens/login/login_contracts.dart';
import 'package:cinco_minutos_meditacao/modules/authentication/screens/login/login_presenter.dart';
import 'package:cinco_minutos_meditacao/shared/Theme/app_images.dart';
import 'package:cinco_minutos_meditacao/shared/components/background_default.dart';
import 'package:cinco_minutos_meditacao/shared/components/generic_error_container.dart';
import 'package:cinco_minutos_meditacao/shared/components/loading.dart';
import 'package:cinco_minutos_meditacao/shared/helpers/multi_state_container/container.dart';
import 'package:cinco_minutos_meditacao/shared/helpers/multi_state_container/controller.dart';
import 'package:cinco_minutos_meditacao/shared/helpers/view_binding.dart';
import 'package:flutter/material.dart';

/// Tela responsável pelo login do usuário
/// utilizando o Google
@RoutePage()
class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => LoginViewState();
}

@visibleForTesting
class LoginViewState extends State<LoginView> implements LoginViewContract {
  /// Presenter da tela de login
  Presenter presenter = resolve<LoginPresenter>();

  /// Controlador do estado da tela
  final stateController = MultiStateContainerController();

  /// Mensagem de erro
  late String messageError = "";

  /// Flag para indicar se o email é inválido
  late bool errorEmailInvalid = false;

  /// Função de retentativa
  Function retry = () {};

  @override
  void initState() {
    presenter.bindView(this);
    presenter.onOpenScreen();

    showNormalState();

    super.initState();
  }

  @override
  void dispose() {
    stateController.dispose();
    presenter.unbindView();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MultiStateContainer(
      controller: stateController,
      normalStateBuilder: (context) => buildScaffold(),
      loadingStateBuilder: (context) => const Loading(),
      errorStateBuilder: (context) => GenericErrorContainer(
        onRetry: () => retry(),
        message: messageError,
      ),
    );
  }

  Scaffold buildScaffold() {
    return Scaffold(
      body: BackgroundDefault(
        child: SafeArea(
          child: Container(
            height: MediaQuery.of(context).size.height,
            padding: const EdgeInsets.symmetric(horizontal: 40),
            child: ListView(
              children: [
                Image.asset(
                  AppImages.balloon,
                  height: 241,
                  width: 166,
                ),
                FormLogin(
                  errorEmailInvalid: errorEmailInvalid,
                  forgotPassword: () => presenter.goToForgotPassword(),
                  onLogin: requestLoginEmailPassword,
                  onRegister: () => goToRegister(),
                ),
                const DividerButtons(),
                LoginButtons(
                  requestLoginGoogle: requestLoginGoogle,
                  requestLoginFacebook: requestLoginFacebook,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void goToRegister() => presenter.goToRegister();

  /// Solicita o login utilizando o Google
  void requestLoginGoogle() async {
    await presenter.loginGoogle();
  }

  /// Solicita o login utilizando o facebook
  void requestLoginFacebook() async {
    await presenter.loginFacebook();
  }

  /// Solicita o login padrão
  void requestLoginEmailPassword(String email, String senha) async {
    setState(() {
      retry = () => requestLoginEmailPassword(email, senha);
    });

    await presenter.loginEmailPassword(email, senha);
  }

  /// Exibe a mensagem de erro
  @override
  void showError(String message) {
    messageError = message;
    stateController.showErrorState();
  }

  /// Exibe a tela de carregamento
  @override
  void showLoading() {
    stateController.showLoadingState();
  }

  /// Exibe a tela normal
  @override
  void showNormalState() {
    stateController.showNormalState();
  }

  /// Exibe a mensagem de erro de email inválido
  @override
  void showErrorEmailInvalid() {
    setState(() {
      errorEmailInvalid = true;
    });
  }

  /// Mostra a snackbar de credenciais inválidas
  @override
  void showInvalidCredentialsSnackBar() {
    const snackBar = SnackBar(
      content: Text('Senha ou email inválidos'),
      backgroundColor: Colors.red,
      behavior: SnackBarBehavior.floating,
      duration: Duration(seconds: 2),
    );

    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}
